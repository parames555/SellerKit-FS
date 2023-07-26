// ignore_for_file: unnecessary_new, prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_brace_in_string_interps, unnecessary_string_interpolations

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/DBHelper/DBHelper.dart';
import 'package:sellerkit/DBHelper/DBOperation.dart';
import 'package:sellerkit/Models/PostQueryModel/EnquiriesModel/ResonModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Constant/Configuration.dart';
import '../../Constant/ConstantRoutes.dart';
import '../../Models/PostQueryModel/EnquiriesModel/EnquiriesModel.dart';
import '../../Models/PostQueryModel/EnquiriesModel/GetUserModel.dart';
import '../../Models/PostQueryModel/LeadsCheckListModel/LeadSavePostModel/GetLeadDetailsQTHModel.dart';
import '../../Pages/Enquiries/EnquiriesUser/Widgets/OpenUserDialog.dart';
import '../../Pages/Enquiries/EnquiriesUser/Widgets/WarningDialog.dart';
import '../../Services/PostQueryApi/EnquiriesApi/AssignedToUserApi.dart';
import '../../Services/PostQueryApi/EnquiriesApi/CheckEnqPrevDeatils.dart';
import '../../Services/PostQueryApi/EnquiriesApi/EnquiriesApi.dart';
import '../../Services/PostQueryApi/EnquiriesApi/ResonApi.dart';
import '../../Services/PostQueryApi/EnquiriesApi/UpdateEnq.dart';
import '../../Services/PostQueryApi/LeadsApi/GetLeadDeatilsQTH.dart';
import '../LeadController/LeadNewController.dart';
import 'NewEnqController.dart';

class EnquiryUserContoller extends ChangeNotifier {
  Config config = new Config();
  List<TextEditingController> mycontroller =
      List.generate(15, (i) => TextEditingController());
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  String errorMsg = '';
  bool exception = false;
  bool get getException => exception;
  String get getErrorMsg => errorMsg;

  String eMsgUList = '';
  bool exceptionUList = false;
  bool get getexceptionUList => exceptionUList;
  String get geteMsgUList => eMsgUList;

  bool datagotByApi = false;
  bool get getdatagotByApi => datagotByApi;

  List<EnquiriesData> openEnqData = [];
  List<EnquiriesData> closedEnqdata = [];
  List<EnquiriesData> lostEnqUserdata = [];

  List<EnquiriesData> get getopenEnqData => openEnqData;
  List<EnquiriesData> get getclosedEnqdata => closedEnqdata;
  List<EnquiriesData> get getlostEnqUserdata => lostEnqUserdata;

  //for alert dialog
  bool assignto = false;
  bool get getassignto => assignto;

  List<UserListData> userLtData = [];
  List<UserListData> get getuserLtData => userLtData;

  int? getUserKey;

  String assignedToApiActResp = '';
  String get getassignedToApiActResp => assignedToApiActResp;

  String assignedToApiActRespMsg = '';
  String get getassignedToApiActRespMsg => assignedToApiActRespMsg;

  bool assigntoApical = false;
  bool get getassigntoApiCall => assigntoApical;

  //status update

  bool statusUpdate = false;
  bool get getstatusUpdate => statusUpdate;

  bool statusUpdateLoading = false;
  bool get getstatusUpdateLoading => statusUpdateLoading;

  bool isAnotherBranchEnq = false;
  bool get getisAnotherBranchEnq => isAnotherBranchEnq;

  String statusUpdateApiResp = '';
  String get getstatusUpdateApiResp => statusUpdateApiResp;

  String statusUpdateApiRespMsg = '';
  String get getstatusUpdateApiRespMsg => statusUpdateApiRespMsg;

  String? valueChosedReason;
  String? get getvalueChosedReason => valueChosedReason;

  List<String> reasonMaster = ["purchased", "lost"];

  List<String> get getreasonMaster => reasonMaster;

  List<ResonData> resonData = [];
  List<ResonData> get getresonData => resonData;

  String? apidate;

  showSuccessDia() {
    statusUpdate = true;
    statusUpdateApiResp = 'abcd';
  }

  Future<void> swipeRefreshIndicator() async {
    datagotByApi = false;
    notifyListeners();
    callApi();
    callUserListApi();
    callResonApi();
  }

  callApi() async {
    exception = false;
    datagotByApi = false;
    notifyListeners();
    await EnquiryApi.getData("${ConstantValues.slpcode}").then((value) {//
      openEnqData.clear();
      closedEnqdata.clear();
      lostEnqUserdata.clear();
      notifyListeners();
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.itemdata != null) {
          exception = false;
          datagotByApi = true;
          //assignedEnqData = value.itemdata!;
          for (int i = 0; i < value.itemdata!.length; i++) {
            if (value.itemdata![i].Slp_Status_Tab == 'Open') {
              openEnqData.add(EnquiriesData(
                  Mgr_UserName: value.itemdata![i].Mgr_UserName,
                  EnqID: value.itemdata![i].EnqID,
                  CardCode: value.itemdata![i].CardCode,
                  Status: value.itemdata![i].Status,
                  CardName: value.itemdata![i].CardName,
                  AssignedTo_User: value.itemdata![i].AssignedTo_User,
                  EnqDate: value.itemdata![i].EnqDate,
                  Followup: value.itemdata![i].Followup,
                  Mgr_UserCode: value.itemdata![i].Mgr_UserCode,
                  AssignedTo_UserName: value.itemdata![i].AssignedTo_UserName,
                  EnqType: value.itemdata![i].EnqType,
                  Lookingfor: value.itemdata![i].Lookingfor,
                  PotentialValue: value.itemdata![i].PotentialValue,
                  Address_Line_1: value.itemdata![i].Address_Line_1,
                  Address_Line_2: value.itemdata![i].Address_Line_2,
                  Pincode: value.itemdata![i].Pincode,
                  City: value.itemdata![i].City,
                  State: value.itemdata![i].State,
                  Country: value.itemdata![i].Country,
                  Manager_Status_Tab: value.itemdata![i].Manager_Status_Tab,
                  Slp_Status_Tab: value.itemdata![i].Slp_Status_Tab));
            }
            if (value.itemdata![i].Slp_Status_Tab == 'Closed') {
              closedEnqdata.add(EnquiriesData(
                  Mgr_UserName: value.itemdata![i].Mgr_UserName,
                  EnqID: value.itemdata![i].EnqID,
                  CardCode: value.itemdata![i].CardCode,
                  Status: value.itemdata![i].Status,
                  CardName: value.itemdata![i].CardName,
                  AssignedTo_User: value.itemdata![i].AssignedTo_User,
                  EnqDate: value.itemdata![i].EnqDate,
                  Followup: value.itemdata![i].Followup,
                  Mgr_UserCode: value.itemdata![i].Mgr_UserCode,
                  AssignedTo_UserName: value.itemdata![i].AssignedTo_UserName,
                  EnqType: value.itemdata![i].EnqType,
                  Lookingfor: value.itemdata![i].Lookingfor,
                  PotentialValue: value.itemdata![i].PotentialValue,
                  Address_Line_1: value.itemdata![i].Address_Line_1,
                  Address_Line_2: value.itemdata![i].Address_Line_2,
                  Pincode: value.itemdata![i].Pincode,
                  City: value.itemdata![i].City,
                  State: value.itemdata![i].State,
                  Country: value.itemdata![i].Country,
                  Manager_Status_Tab: value.itemdata![i].Manager_Status_Tab,
                  Slp_Status_Tab: value.itemdata![i].Slp_Status_Tab));
            }
            if (value.itemdata![i].Slp_Status_Tab == 'Lost') {
              lostEnqUserdata.add(EnquiriesData(
                  Mgr_UserName: value.itemdata![i].Mgr_UserName,
                  EnqID: value.itemdata![i].EnqID,
                  CardCode: value.itemdata![i].CardCode,
                  Status: value.itemdata![i].Status,
                  CardName: value.itemdata![i].CardName,
                  AssignedTo_User: value.itemdata![i].AssignedTo_User,
                  EnqDate: value.itemdata![i].EnqDate,
                  Followup: value.itemdata![i].Followup,
                  Mgr_UserCode: value.itemdata![i].Mgr_UserCode,
                  AssignedTo_UserName: value.itemdata![i].AssignedTo_UserName,
                  EnqType: value.itemdata![i].EnqType,
                  Lookingfor: value.itemdata![i].Lookingfor,
                  PotentialValue: value.itemdata![i].PotentialValue,
                  Address_Line_1: value.itemdata![i].Address_Line_1,
                  Address_Line_2: value.itemdata![i].Address_Line_2,
                  Pincode: value.itemdata![i].Pincode,
                  City: value.itemdata![i].City,
                  State: value.itemdata![i].State,
                  Country: value.itemdata![i].Country,
                  Manager_Status_Tab: value.itemdata![i].Manager_Status_Tab,
                  Slp_Status_Tab: value.itemdata![i].Slp_Status_Tab));
            }
          }
          notifyListeners();
        } else if (value.itemdata == null) {
          datagotByApi = false;
          exception = true;
          errorMsg = 'No data found..!!';
          notifyListeners();
        }
        notifyListeners();
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        datagotByApi = false;
        exception = true;
        errorMsg = 'Some thing went wrong.!';
        notifyListeners();
      } else if (value.stcode == 500) {
        datagotByApi = false;
        exception = true;
        errorMsg = 'Some thing went wrong..!';
        notifyListeners();
      }
    });
  }

  callPrevEnqDatilsApi(BuildContext context, int enqData) async {
    print("EnqPrevDetailsApi");
    await EnqPrevDetailsApi.getData(enqData).then((value) {//
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.itemdata != null) {
          openEnqData.clear();
          closedEnqdata.clear();
          lostEnqUserdata.clear();
          exception = false;
          datagotByApi = true;
          isAlreadyenqOpen = false;
          //assignedEnqData = value.itemdata!;
          for (int i = 0; i < value.itemdata!.length; i++) {
            if (value.itemdata![i].Slp_Status_Tab == 'Open') {
              openEnqData.add(EnquiriesData(
                  Mgr_UserName: value.itemdata![i].Mgr_UserName,
                  EnqID: value.itemdata![i].EnqID,
                  CardCode: value.itemdata![i].CardCode,
                  Status: value.itemdata![i].Status,
                  CardName: value.itemdata![i].CardName,
                  AssignedTo_User: value.itemdata![i].AssignedTo_User,
                  EnqDate: value.itemdata![i].EnqDate,
                  Followup: value.itemdata![i].Followup,
                  Mgr_UserCode: value.itemdata![i].Mgr_UserCode,
                  AssignedTo_UserName: value.itemdata![i].AssignedTo_UserName,
                  EnqType: value.itemdata![i].EnqType,
                  Lookingfor: value.itemdata![i].Lookingfor,
                  PotentialValue: value.itemdata![i].PotentialValue,
                  Address_Line_1: value.itemdata![i].Address_Line_1,
                  Address_Line_2: value.itemdata![i].Address_Line_2,
                  Pincode: value.itemdata![i].Pincode,
                  City: value.itemdata![i].City,
                  State: value.itemdata![i].State,
                  Country: value.itemdata![i].Country,
                  Manager_Status_Tab: value.itemdata![i].Manager_Status_Tab,
                  Slp_Status_Tab: value.itemdata![i].Slp_Status_Tab));
            }
            if (value.itemdata![i].Slp_Status_Tab == 'Closed') {
              closedEnqdata.add(EnquiriesData(
                  Mgr_UserName: value.itemdata![i].Mgr_UserName,
                  EnqID: value.itemdata![i].EnqID,
                  CardCode: value.itemdata![i].CardCode,
                  Status: value.itemdata![i].Status,
                  CardName: value.itemdata![i].CardName,
                  AssignedTo_User: value.itemdata![i].AssignedTo_User,
                  EnqDate: value.itemdata![i].EnqDate,
                  Followup: value.itemdata![i].Followup,
                  Mgr_UserCode: value.itemdata![i].Mgr_UserCode,
                  AssignedTo_UserName: value.itemdata![i].AssignedTo_UserName,
                  EnqType: value.itemdata![i].EnqType,
                  Lookingfor: value.itemdata![i].Lookingfor,
                  PotentialValue: value.itemdata![i].PotentialValue,
                  Address_Line_1: value.itemdata![i].Address_Line_1,
                  Address_Line_2: value.itemdata![i].Address_Line_2,
                  Pincode: value.itemdata![i].Pincode,
                  City: value.itemdata![i].City,
                  State: value.itemdata![i].State,
                  Country: value.itemdata![i].Country,
                  Manager_Status_Tab: value.itemdata![i].Manager_Status_Tab,
                  Slp_Status_Tab: value.itemdata![i].Slp_Status_Tab));
            }
            if (value.itemdata![i].Slp_Status_Tab == 'Lost') {
              lostEnqUserdata.add(EnquiriesData(
                  Mgr_UserName: value.itemdata![i].Mgr_UserName,
                  EnqID: value.itemdata![i].EnqID,
                  CardCode: value.itemdata![i].CardCode,
                  Status: value.itemdata![i].Status,
                  CardName: value.itemdata![i].CardName,
                  AssignedTo_User: value.itemdata![i].AssignedTo_User,
                  EnqDate: value.itemdata![i].EnqDate,
                  Followup: value.itemdata![i].Followup,
                  Mgr_UserCode: value.itemdata![i].Mgr_UserCode,
                  AssignedTo_UserName: value.itemdata![i].AssignedTo_UserName,
                  EnqType: value.itemdata![i].EnqType,
                  Lookingfor: value.itemdata![i].Lookingfor,
                  PotentialValue: value.itemdata![i].PotentialValue,
                  Address_Line_1: value.itemdata![i].Address_Line_1,
                  Address_Line_2: value.itemdata![i].Address_Line_2,
                  Pincode: value.itemdata![i].Pincode,
                  City: value.itemdata![i].City,
                  State: value.itemdata![i].State,
                  Country: value.itemdata![i].Country,
                  Manager_Status_Tab: value.itemdata![i].Manager_Status_Tab,
                  Slp_Status_Tab: value.itemdata![i].Slp_Status_Tab));
            }
          }
          if (value.itemdata![0].User_Branch ==
              value.itemdata![0].Current_Branch) {
            // callDialog(context,0);
            // value.itemdata![0].
            isAnotherBranchEnq = false;
            typeOfDataCusBranch = 'this';
            alertDialogOpenLeadOREnq(context, typeOfDataCus);
          } else {
            isAnotherBranchEnq = true;
            typeOfDataCusBranch = value.itemdata![0].Current_Branch!;
            alertDialogOpenLeadOREnq(context, typeOfDataCus);
          }
          notifyListeners();
        } else if (value.itemdata == null) {
          isAlreadyenqOpen = false;
          datagotByApi = false;
          exception = true;
          errorMsg = 'No data found..!!';
          notifyListeners();
        }
        notifyListeners();
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        isAlreadyenqOpen = false;
        datagotByApi = false;
        exception = true;
        errorMsg = 'Some thing went wrong.!';
        notifyListeners();
      } else if (value.stcode == 500) {
        isAlreadyenqOpen = false;
        datagotByApi = false;
        exception = true;
        errorMsg = 'Some thing went wrong..!';
        notifyListeners();
      }
    });
  }

  mapValuesToLead(int ind) {
    LeadNewController.dataenq.add(openEnqData[ind].CardCode!);
    LeadNewController.dataenq.add(openEnqData[ind].CardName!);
    LeadNewController.dataenq.add(openEnqData[ind].Address_Line_1!);
    LeadNewController.dataenq.add(openEnqData[ind].Address_Line_2!);
    LeadNewController.dataenq.add(openEnqData[ind].Pincode!);
    LeadNewController.dataenq.add(openEnqData[ind].City!); //isSelectedCsTag
    LeadNewController.dataenq.add(openEnqData[ind].EnqID.toString());
    LeadNewController.dataenq.add("");

    //openEnqData[].
    LeadNewController.isComeFromEnq = true;
    notifyListeners();
    Get.toNamed(ConstantRoutes.leads);
  }

  mapValuesToEnq() {
    log("openEnqData[0].CardCode!: ${openEnqData.length}");
    NewEnqController.comeFromEnq.clear();
    NewEnqController.comeFromEnq.add(openEnqData[0].CardCode!);
    NewEnqController.comeFromEnq.add(openEnqData[0].CardName!);
    NewEnqController.comeFromEnq.add(openEnqData[0].Address_Line_1!);
    NewEnqController.comeFromEnq.add(openEnqData[0].Address_Line_2!);
    NewEnqController.comeFromEnq.add(openEnqData[0].Pincode!);
    NewEnqController.comeFromEnq.add(openEnqData[0].City!);
    notifyListeners();
    Get.toNamed(ConstantRoutes.newEnq);
  }

  callDialog(BuildContext context, i) {
    showDialog<dynamic>(
        context: context,
        builder: (_) {
          assignto = false;
          resetUserSelection();
          return AssignedToDialogUser(
            indx: i,
          );
        }).then((value) {
      resetAll(context);
    });
  }

  void alertDialogOpenLeadOREnq(BuildContext context, typeOfDataCus) {
    showDialog<dynamic>(
        context: context,
        builder: (_) {
          assignto = false;
          return WarningDialog();
        }).then((value) {
      //resetAll(context);
    });
  }

  /// for lead other branch
  ///
  callOtherLead(String docentry) {
    //call SK_GET_LEAD_DETAILS_QTH this appi and load the data in new lead
    GetLeadQTHApi.getData(docentry).then((value) {// lead
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.leadDeatilsQTHData != null) {
          mapValuesToLead2(value.leadDeatilsQTHData!);
        } else {
          //   customerapicLoading = false;
          //   isanyExcep = -2;
          // forwardSuccessMsg = 'Some internal error..!!';
          // leadLoadingdialog = false;
          // notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 490) {
        //customerapicLoading = false;
        //   isanyExcep = -2;
        // forwardSuccessMsg = 'Something went wrong try again!!';
        // leadLoadingdialog = false;
        // notifyListeners();
      } else {
        //customerapicLoading = false;
        //   isanyExcep = -2;
        // forwardSuccessMsg = 'Something went wrong try again!!';
        // leadLoadingdialog = false;
        // notifyListeners();
      }
    });
  }

  mapValuesToLead2(List<GetLeadDeatilsQTHData> leadDeatilsQTHDat) {
    LeadNewController.dataenq.add(leadDeatilsQTHDat[0].CardCode!);
    LeadNewController.dataenq.add(leadDeatilsQTHDat[0].CardName!);
    LeadNewController.dataenq.add(leadDeatilsQTHDat[0].Address1!);
    LeadNewController.dataenq.add(leadDeatilsQTHDat[0].Address2!);
    LeadNewController.dataenq.add(leadDeatilsQTHDat[0].Pincode!);
    LeadNewController.dataenq.add(leadDeatilsQTHDat[0].City!);
    notifyListeners();
    // Get.toNamed(ConstantRoutes.leads);
  }

  checkDialogCon() {
    log("isAnotherBranchEnq: " + isAnotherBranchEnq.toString());
    log("statusUpdateApiResp: " + statusUpdateApiResp.toString());
    log("statusUpdateLoading: " + statusUpdateLoading.toString());
    log("statusUpdate: " + statusUpdate.toString());
    log("assignedToApiActResp: " + assignedToApiActResp.toString());
    log("assigntoApical: " + assigntoApical.toString());
    log("assignto: " + assignto.toString());
  }

  showSpecificDialog() {
    assignto = false;
    assigntoApical = false;
    assignedToApiActResp = '';
    statusUpdate = true;
    statusUpdateLoading = false;
    statusUpdateApiResp = 'hello';
    isAnotherBranchEnq == false;
  }

  callUserListApi() async {
    // GetUserApi.getData("${ConstantValues.sapUserID}").then((value) {
    //   if (value.stcode! >= 200 && value.stcode! <= 210) {
    //     if (value.userLtData != null) {
    //       eMsgUList = '';
    //       exceptionUList = false;
    //       userLtData = value.userLtData!;
    //       notifyListeners();
    //     } else if (value.userLtData == null) {
    //       eMsgUList = 'No Data...!!';
    //       exceptionUList = true;
    //       notifyListeners();
    //     }
    //     notifyListeners();
    //   } else if (value.stcode! >= 400 && value.stcode! <= 410) {
    //     eMsgUList = 'Some thing went wrong..try again!!';
    //     exceptionUList = true;
    //     notifyListeners();
    //   } else if (value.stcode == 500) {
    //     eMsgUList = 'Some thing went wrong..try again!!';
    //     exceptionUList = true;
    //     notifyListeners();
    //   }
    // });
   final Database db = (await DBHelper.getInstance())!;
    userLtData = await DBOperation.getUserList(db);
    exceptionUList = false;
    notifyListeners();
  }

//alert dialog actions
  int? selectedIdxFUser = null;
  selectUser(int ij) {
    for (int i = 0; i < userLtData.length; i++) {
      if (userLtData[i].SalesEmpID == userLtData[ij].SalesEmpID) {
        userLtData[i].color = 1;
        getUserKey = userLtData[ij].SalesEmpID;
      } else {
        userLtData[i].color = 0;
      }
    }
    notifyListeners();
  }

  selectReason(int ir) {
    for (int i = 0; i < resonData.length; i++) {
      if (resonData[i].CODE == resonData[ir].CODE) {
        resonData[i].color = 1;
        valueChosedReason = resonData[ir].CODE;
      } else {
        resonData[i].color = 0;
      }
    }
    notifyListeners();
  }

  resetUserSelection() {
    getUserKey = null;
    assignto = false;
    assigntoApical = false;
    assignedToApiActResp = '';
    assignedToApiActRespMsg = '';
    statusUpdateLoading = false;
    statusUpdate = false;
    statusUpdateApiResp = '';
    statusUpdateApiRespMsg = '';
    mycontroller[0].clear();
    valueChosedReason = null;
    apidate = null;
    for (int i = 0; i < userLtData.length; i++) {
      userLtData[i].color = 0;
    }
    for (int i = 0; i < resonData.length; i++) {
      resonData[i].color = 0;
    }
    getUserKey = null;
    //notifyListeners();
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  callAsignedToApi(String enqID, String userkey, BuildContext context) {
    assigntoApical = true;
    notifyListeners();
    AssignedToUserApi.getData(enqID, userkey).then((value) { //
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.userLtData != null) {
          assigntoApical = false;
          assignedToApiActResp = value.userLtData![0].actionResponce!;
          assignedToApiActRespMsg = value.userLtData![0].actionResponseMessage!;
          // print("assignedToApiActResp: "+assignedToApiActResp);
          // print("value.userLtData![0].actionResponce!: "+value.userLtData![0].actionResponce!);
          notifyListeners();
          disabledialog(context);
        } else if (value.userLtData == null) {
          assigntoApical = false;
          assignedToApiActResp = 'Something went wrog..!!';
          assignedToApiActRespMsg = 'Try agin..!!';
          notifyListeners();
          disabledialog(context);
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        assigntoApical = false;
        assignedToApiActResp = 'Something went wrog...!!';
        assignedToApiActRespMsg = 'Try agin...!!';
        notifyListeners();
        disabledialog(context);
      } else if (value.stcode == 500) {
        assigntoApical = false;
        assignedToApiActResp = 'Something went wrog...!!';
        assignedToApiActRespMsg = 'Try agin....!!';
        notifyListeners();
        disabledialog(context);
      }
    });
  }

  disabledialog(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      // Navigator.pop(context);
    });
  }

  static bool isAlreadyenqOpen = false;
  bool get getisAlreadyenqOpen => isAlreadyenqOpen;
  static int enqDataprev = 0;
  static String typeOfDataCus = '';
  static String typeOfDataCusBranch = '';

  resetAll(BuildContext context) {
    //NewEnqController.comeFromEnq.clear();
    isAnotherBranchEnq = false;
    //isAlreadyenqOpen = false;
     //log("EnquiryUserContoller.enqDataprev: ${EnquiryUserContoller.enqDataprev}");
    if (isAlreadyenqOpen == false) {
     // log("EnquiryUserContoller.5555: ${EnquiryUserContoller.enqDataprev}");
      callApi();
    } else {
      if (typeOfDataCus == 'Enquiry') {
       //  log("EnquiryUserContoller.22222: ${EnquiryUserContoller.enqDataprev}");
        callPrevEnqDatilsApi(context, enqDataprev);
      } else {
        if (typeOfDataCusBranch == 'this') {
        //  log("EnquiryUserContoller.33333: ${EnquiryUserContoller.enqDataprev}");
          isAlreadyenqOpen = false;
          alertDialogOpenLeadOREnq(context, typeOfDataCus);
        } else {
         // log("EnquiryUserContoller.4444: ${EnquiryUserContoller.enqDataprev}");
          // print("Other bra
          // nch");
          // callOtherLead(enqDataprev.toString());
          isAlreadyenqOpen = false;
          alertDialogOpenLeadOREnq(context, typeOfDataCus);
        }
      }
    }
  }

  resetdocEntry() {
    enqDataprev = 0;
  }

  /// staus update functions

  callResonApi() async {
    await ResonApi.getData("${ConstantValues.slpcode}").then((value) {//
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.userLtData != null) {
          resonData = value.userLtData!;
          notifyListeners();
        } else if (value.userLtData == null) {
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        notifyListeners();
      } else if (value.stcode == 500) {
        notifyListeners();
      }
    });
  }

  resonChoosed(String res) {
    valueChosedReason = res;
    notifyListeners();
  }

  void showDate(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    ).then((value) {
      if (value == null) {
        return;
      }
      String chooseddate = value.toString();
      var date = DateTime.parse(chooseddate);
      chooseddate = "";
      chooseddate =
          "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
      apidate =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      print(apidate);

      mycontroller[0].text = chooseddate;
      notifyListeners();
    });
  }

  calllApiss(BuildContext context) {
    statusUpdateLoading = true;
    notifyListeners();
    Future.delayed(Duration(seconds: 2), () {
      statusUpdateLoading = false;
      statusUpdateApiResp = 'Failure..!!'; //'Success';//'Failure..!!';//
      notifyListeners();
      Future.delayed(Duration(seconds: 1), () {
        if (statusUpdateApiResp.toLowerCase().contains("success")) {
          disabledialog(context);
        } else if (statusUpdateApiResp.toLowerCase().contains("fail")) {
          print("fffff");
          statusUpdate = true;
          statusUpdateApiResp = '';
          notifyListeners();
        }
      });
    });
  }

  callUpdateEnqApi(BuildContext context, String enqID) { //
    statusUpdateLoading = true;
    notifyListeners();
    UpdateEnqApi.getData(enqID, valueChosedReason, apidate).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        statusUpdateLoading = false;
        if (value.userLtData != null) {
          statusUpdateApiResp =
              value.userLtData![0].actionResponce!; //'Failure..!!';
          statusUpdateApiRespMsg = value.userLtData![0].actionResponseMessage!;
          notifyListeners();

          Future.delayed(Duration(seconds: 1), () {
            if (statusUpdateApiResp.toLowerCase().contains("success")) {
              disabledialog(context);
            } else if (statusUpdateApiResp.toLowerCase().contains("Fail")) {
              statusUpdate = true;
              statusUpdateApiResp = '';
              statusUpdateApiRespMsg = '';
              notifyListeners();
            }
          });
        } else if (value.userLtData == null) {
          statusUpdate = true;
          statusUpdateApiResp = 'Somthing went wrong..!!'; //'Failure..!!';
          statusUpdateApiRespMsg = value.message; //'Try again..!!';
          notifyListeners();
          Future.delayed(Duration(seconds: 1), () {
            statusUpdate = true;
            statusUpdateApiResp = '';
            statusUpdateApiRespMsg = '';
            notifyListeners();
          });
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        statusUpdate = true;
        statusUpdateApiResp = 'Somthing went wrong...!!'; //'Failure..!!';
        statusUpdateApiRespMsg = 'Try again..!!';
        notifyListeners();
        Future.delayed(Duration(seconds: 1), () {
          statusUpdate = true;
          statusUpdateApiResp = '';
          statusUpdateApiRespMsg = '';
          notifyListeners();
        });
      } else if (value.stcode == 500) {
        statusUpdate = true;
        statusUpdateApiResp = 'Somthing went wrong...!!'; //'Failure..!!';
        statusUpdateApiRespMsg = 'Try again...!!';
        notifyListeners();
        Future.delayed(Duration(seconds: 1), () {
          statusUpdate = true;
          statusUpdateApiResp = '';
          statusUpdateApiRespMsg = '';
          notifyListeners();
        });
      }
    });
  }
}
