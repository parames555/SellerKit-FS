// ignore_for_file: unnecessary_new, unnecessary_string_interpolations, prefer_interpolation_to_compose_strings

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/DBHelper/DBHelper.dart';
import 'package:sellerkit/DBHelper/DBOperation.dart';
import 'package:sqflite/sqflite.dart';
import '../../Constant/ConstantSapValues.dart';
import '../../DBModel/ItemMasertDBModel.dart';
import '../../Models/AddEnqModel/AddEnqModel.dart';
import '../../Models/PostQueryModel/EnquiriesModel/CheckEnqCusDetailsModel.dart';
import '../../Models/PostQueryModel/EnquiriesModel/EnqRefferesModel.dart';
import '../../Models/PostQueryModel/EnquiriesModel/EnqTypeModel.dart';
import '../../Models/PostQueryModel/EnquiriesModel/GetCustomerDetailsModel.dart';
import '../../Models/PostQueryModel/EnquiriesModel/GetUserModel.dart';
import '../../Services/PostQueryApi/EnquiriesApi/CheckEnqCutomerDeatils.dart';
import '../../Services/PostQueryApi/EnquiriesApi/EnqPatchExistCusApi.dart';
import '../../Services/PostQueryApi/EnquiriesApi/GetCustomerDetails.dart';
import '../../Services/PostQueryApi/EnquiriesApi/PostEnq.dart';
import '../../Services/ServiceLayerApi/CreatNewCus/CreateNewCustApi.dart';
import '../../Widgets/AlertDilog.dart';
import 'EnquiryMngController.dart';
import 'EnquiryUserContoller.dart';

class NewEnqController extends ChangeNotifier {
  final formkey = GlobalKey<FormState>();
  List<TextEditingController> mycontroller =
      List.generate(20, (i) => TextEditingController());

  Config config = new Config();

  String isSelectedenquirytype = '';
  String get getisSelectedenquirytype => isSelectedenquirytype;

  String isSelectedenquiryReffers = '';
  String get getisSelectedenquiryReffers => isSelectedenquiryReffers;

  String isSelectedCsTag = '';
  String get getisSelectedCsTag => isSelectedCsTag;

   List<UserListData> userLtData = [];
  List<UserListData> get getuserLtData => userLtData;

  selectEnqMeida(String selected, int enqtypecode) {
    isSelectedenquirytype = selected;
    EnqTypeCode = enqtypecode;
    notifyListeners();
  }

  selectEnqReffers(String selected, String refercode) {
    isSelectedenquiryReffers = selected;
    EnqRefer = refercode;
    notifyListeners();
  }

  selectCsTag(String selected) {
    if (isSelectedCsTag == selected) {
      isSelectedCsTag = '';
    } else {
      isSelectedCsTag = selected;
    }
    notifyListeners();
  }



// List<GetCustomerData> itemdata =[];

// List<GetCustomerData> get getitemdata =>itemdata;
  bool customerapicalled = false;
  bool get getcustomerapicalled => customerapicalled;

  bool customerapicLoading = false;
  bool get getcustomerapicLoading => customerapicLoading;

  String exceptionOnApiCall = '';
  String get getexceptionOnApiCall => exceptionOnApiCall;

  List<EnquiryTypeData> enqList = [];
  List<EnquiryTypeData> get getEnqList => enqList;

  List<ItemMasterDBModel> category = [];
  List<ItemMasterDBModel> get getcategory => category;

  List<EnqRefferesData> enqReffList = [];
  List<EnqRefferesData> get getenqReffList => enqReffList;

  bool visibleEnqType = false;
  bool get getvisibleEnqType => visibleEnqType;

  bool visibleRefferal = false;
  bool get getvisibleRefferal => visibleRefferal;

  bool oldcutomer = false;
  bool get getoldcutomer => oldcutomer;

  int? EnqTypeCode;

  String? EnqRefer;

  bool isloadingBtn = false;

  bool get getisloadingBtn => isloadingBtn;


  getUserAssingData()async{
   final Database db = (await DBHelper.getInstance())!;

     userLtData = await DBOperation.getUserList(db);
     notifyListeners();
  }

    int? selectedIdxFUser = null;
    int? getslpID;
  selectUser(int ij) {
    for (int i = 0; i < userLtData.length; i++) {
      if (userLtData[i].SalesEmpID == userLtData[ij].SalesEmpID) {
        userLtData[i].color = 1;
        getslpID = userLtData[ij].SalesEmpID;
        selectedIdxFUser = ij;
      } else {
        userLtData[i].color = 0;
      }
    }
    notifyListeners();
  }

    selectedAssignedUser(){
    mycontroller[8].text = userLtData[selectedIdxFUser!].UserName!;
    notifyListeners();
  }

  List<CheckEnqDetailsData>? checkEnqDetailsData = [];
  callCheckEnqDetailsApi(String mob) {
    //fs
    customerapicLoading = true;
    notifyListeners();
    CheckEnqDetailsApi.getData(ConstantValues.slpcode, mob).then((value) { //
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.checkEnqDetailsData != null) {
          if (value.checkEnqDetailsData![0].Type == 'Enquiry') {
            if (ConstantValues.sapUserType != 'Manager') {
              callEnqUserPage(value);
            } else {
              callEnqMgrPage(value);
            }
          } else if (value.checkEnqDetailsData![0].Type == 'Lead') {
            log("LEadssssssssssssss");
            if (ConstantValues.sapUserType != 'Manager') {
              callLeadUsrPage(value);
            } else {
              callLeadMgrPage(value);
            }
          }
        } else if (value.checkEnqDetailsData == null &&
            value.message != "Success") {
          customerapicLoading = false;
          exceptionOnApiCall = value.message;
          notifyListeners();
        } else if (value.checkEnqDetailsData == null) {
          callApi();
        }
        notifyListeners();
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        customerapicLoading = false;
        exceptionOnApiCall = 'Some thing went wrong try again!!';
        notifyListeners();
      } else if (value.stcode == 500) {
        customerapicLoading = false;
        exceptionOnApiCall = 'Some thing went wrong try again!!';
        notifyListeners();
      }
    });
  }

  callEnqUserPage(CheckEnqDetailsModel value) {
    log("datata111: " + ConstantValues.sapUserType.toString());
    EnquiryUserContoller.isAlreadyenqOpen = true;
    EnquiryUserContoller.enqDataprev = value.checkEnqDetailsData![0].DocEntry!;
    EnquiryUserContoller.typeOfDataCus = value.checkEnqDetailsData![0].Type!;
    // log("status: "+value.checkEnqDetailsData![0].DocEntry.toString());
    Get.back();
    notifyListeners();
  }

  callEnqMgrPage(CheckEnqDetailsModel value) {
    log("datata: " + ConstantValues.sapUserType.toString());
    EnquiryMangerContoller.isAlreadyenqOpen = true;
    EnquiryMangerContoller.enqDataprev =
        value.checkEnqDetailsData![0].DocEntry!;
    EnquiryMangerContoller.typeOfDataCus = value.checkEnqDetailsData![0].Type!;
    Get.back();
    notifyListeners();
  }

  callLeadMgrPage(CheckEnqDetailsModel value) {
    EnquiryMangerContoller.isAlreadyenqOpen = true;
    EnquiryMangerContoller.enqDataprev =
        value.checkEnqDetailsData![0].DocEntry!;
    EnquiryMangerContoller.typeOfDataCus = value.checkEnqDetailsData![0].Type!;
    EnquiryMangerContoller.typeOfDataCusBranch =
        (value.checkEnqDetailsData![0].Current_Branch.toString() ==
                value.checkEnqDetailsData![0].User_Branch.toString()
            ? "this"
            : value.checkEnqDetailsData![0].Current_Branch!);
    //  print("branch: "+EnquiryUserContoller.typeOfDataCusBranch);
    if (EnquiryMangerContoller.typeOfDataCusBranch == 'this') {
      Get.back();
      notifyListeners();
    } else {
      Get.back();
      notifyListeners();
    }
  }

  callLeadUsrPage(CheckEnqDetailsModel value) {
    EnquiryUserContoller.isAlreadyenqOpen = true;
    EnquiryUserContoller.enqDataprev = value.checkEnqDetailsData![0].DocEntry!;
    EnquiryUserContoller.typeOfDataCus = value.checkEnqDetailsData![0].Type!;
    EnquiryUserContoller.typeOfDataCusBranch =
        (value.checkEnqDetailsData![0].Current_Branch.toString() ==
                value.checkEnqDetailsData![0].User_Branch.toString()
            ? "this"
            : value.checkEnqDetailsData![0].Current_Branch!);
    //  print("branch: "+EnquiryUserContoller.typeOfDataCusBranch);
    if (EnquiryUserContoller.typeOfDataCusBranch == 'this') {
      Get.back();
      notifyListeners();
    } else {
      Get.back();
      notifyListeners();
    }
  }

  callApi() {//
    //fs
    customerapicLoading = true;
    notifyListeners();
    GetCutomerDetailsApi.getData(
            mycontroller[0].text, "${ConstantValues.slpcode}")
        .then((value) { //
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.itemdata != null) {
          mapValues(value.itemdata!);
          oldcutomer = true;
        } else if (value.itemdata == null) {
          oldcutomer = false;
          customerapicLoading = false;
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        customerapicLoading = false;
        exceptionOnApiCall = 'Some thing went wrong try again!!';
        notifyListeners();
      } else if (value.stcode == 500) {
        customerapicLoading = false;
        exceptionOnApiCall = 'Some thing went wrong try again!!';
        notifyListeners();
      }
    });
  }

  mapValues(List<GetCustomerData> itemdata) {
    mycontroller[0].text = itemdata[0].CardCode!;
    mycontroller[1].text = itemdata[0].CardName!;
    mycontroller[2].text = itemdata[0].Street!;
    mycontroller[3].text = itemdata[0].Block!;
    mycontroller[4].text = itemdata[0].ZipCode!;
    mycontroller[5].text = itemdata[0].City!;
    customerapicLoading = false;
    isSelectedCsTag = itemdata[0].tags!;
    notifyListeners();
  }

  static List<String> comeFromEnq = [];

  mapValuesFormEnq() {
    // print("lennnnnnn comeFromEnq: ${comeFromEnq.length}");
    if (comeFromEnq.isNotEmpty) {
      mycontroller[0].text = comeFromEnq[0];
      mycontroller[1].text = comeFromEnq[1];
      mycontroller[2].text = comeFromEnq[2];
      mycontroller[3].text = comeFromEnq[3];
      mycontroller[4].text = comeFromEnq[4];
      mycontroller[5].text = comeFromEnq[5];
      customerapicLoading = false;
      oldcutomer = true;
      comeFromEnq.clear();
      notifyListeners();
    }
  }

  clearAllData() {
    mycontroller[0].clear();
    mycontroller[1].clear();
    mycontroller[2].clear();
    mycontroller[3].clear();
    mycontroller[4].clear();
    mycontroller[5].clear();
    mycontroller[6].clear();
    mycontroller[7].clear();
    mycontroller[8].clear();
    isSelectedenquirytype = '';
    isSelectedenquiryReffers = '';
    customerapicalled = false;
    oldcutomer = false;
    customerapicLoading = false;
    exceptionOnApiCall = '';
    isSelectedCsTag = '';
    notifyListeners();
  }

  getEnqType() async {
   final Database db = (await DBHelper.getInstance())!;

    enqList = await DBOperation.getEnqData(db);
    notifyListeners();
  }

  getEnqRefferes() async {
   final Database db = (await DBHelper.getInstance())!;

    enqReffList = await DBOperation.getEnqRefferes(db);
    notifyListeners();
  }

  getDivisionValue() async {
   final Database db = (await DBHelper.getInstance())!;

    category = await DBOperation.getFavData("category",db);
    notifyListeners();
  }

  iscateSeleted(BuildContext context, String select) {
    mycontroller[7].text = select;
    Navigator.pop(context);
    notifyListeners();
  }

  callAddEnq(BuildContext context) {
    if (formkey.currentState!.validate()) {
      visibleEnqType = false;
      visibleRefferal = false;
      notifyListeners();
      PatchExCus patch = new PatchExCus();
      patch.CardCode = mycontroller[0].text;
      patch.CardName = mycontroller[1].text;
      //  patch.CardType =  mycontroller[2].text;
      patch.U_Address1 = mycontroller[2].text;
      patch.U_Address2 = mycontroller[3].text;
      patch.U_Pincode = mycontroller[4].text;
      patch.U_City = mycontroller[5].text;
      patch.U_Type = isSelectedCsTag;
      //  patch.U_Country =  mycontroller[6].text;
      // print("email: "+mycontroller[6].text);
      patch.U_EMail = mycontroller[6].text;
      // print("emailll: "+patch.U_EMail.toString());
      if (oldcutomer == true) {
        //fs
        isloadingBtn = true;
        notifyListeners();
        callPacthEnq(patch, context);
      } else {
        isloadingBtn = true;
        notifyListeners();
        callNewCus(patch, context);
      }
    }
    if (isSelectedenquirytype.isEmpty) {
      visibleEnqType = true;
      notifyListeners();
    }
    if (isSelectedenquiryReffers.isEmpty) {
      visibleRefferal = true;
      notifyListeners();
    }
  }

  callPacthEnq(PatchExCus patch, BuildContext context) {//
    //fs
    EnqPatchExistCustApi.getData("${ConstantValues.slpcode}", patch)
        .then((value) { //
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.userLtData != null) {
          callPostEnq(context);
        } else {
          isloadingBtn = false;
          notifyListeners();
          callAlertDialog2(context, '${value.message}\nTry again..!!');
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        isloadingBtn = false;
        notifyListeners();
        callAlertDialog2(context, 'Some thing wrong..!!\nTry again..!!');
      } else if (value.stcode! >= 500) {
        isloadingBtn = false;
        notifyListeners();
        callAlertDialog2(context, 'Some thing wrong..!!\nTry again..!!');
      }
    });
  }

  callNewCus(PatchExCus patch, BuildContext context) {
    NewCustCretApi.getData("${ConstantValues.slpcode}", patch).then((value) { //
      //fs
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        callPostEnq(context);
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        isloadingBtn = false;
        notifyListeners();
        callAlertDialog2(context,
            'Some thing wrong..!!\n${value.error!.message!.value!}..!!');
      } else if (value.stcode! >= 500) {
        isloadingBtn = false;
        notifyListeners();
        callAlertDialog2(context, 'Some thing wrong..!!\nTry again..!!');
      }
    });
  }

  callPostEnq(BuildContext context) {
    PostEnq postEnq = new PostEnq();
    postEnq.CardCode = mycontroller[0].text;
    postEnq.U_Lookingfor = mycontroller[7].text;
    postEnq.U_EnqRefer = EnqRefer;
    postEnq.ActivityType = EnqTypeCode;
    postEnq.assignedtoslpCode = getslpID;
    log("message ${ postEnq.assignedtoslpCode} , ${getslpID}");
    EnqPostApi.getData("${ConstantValues.slpcode}", postEnq).then((value) {
      //fs
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        isloadingBtn = false;
        notifyListeners();
        callAlertDialog(context, 'Successfully Enquiry Created..!!');
        //  Future.delayed(Duration(seconds: 2),(){
        // Navigator.pop(context);
        // clearAllData();
        // });

      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        isloadingBtn = false;
        notifyListeners();
        callAlertDialog2(
            context, 'Some thing wrong..!!\n${value.error!.message!.value!}');
        // config.msgDialog(context, "Some thing wrong..!!", value.error!.message!.value!);
      } else if (value.stcode! >= 500) {
        isloadingBtn = false;
        notifyListeners();
        callAlertDialog2(context, 'Some thing wrong..!!\nTry again..!!');
        //config.msgDialog(context, "Some thing wrong..!!", "Try again..!!");
      }
    });
    print("Posttt...");
  }

  callAlertDialog(BuildContext context, String mesg) {
    showDialog<dynamic>(
        context: context,
        builder: (_) {
          return AlertMsg(
            msg: '$mesg',
          );
        }).then((value) {
      clearAllData();
    });
  }

    callAlertDialog2(BuildContext context, String mesg) {
    showDialog<dynamic>(
        context: context,
        builder: (_) {
          return AlertMsg(
            msg: '$mesg',
          );
        }).then((value) {
    });
  }

    callAlertDialogError(BuildContext context, String mesg) {
    showDialog<dynamic>(
        context: context,
        builder: (_) {
          return AlertMsg(
            msg: '$mesg',
          );
        }).then((value) {
    });
  }
}
