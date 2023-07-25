// ignore_for_file: prefer_const_constructors, prefer_is_empty, unnecessary_new, unnecessary_string_interpolations, avoid_print, prefer_interpolation_to_compose_strings
import 'dart:convert';
import 'dart:developer';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/DBHelper/DBHelper.dart';
import 'package:sellerkit/Models/PostQueryModel/LeadsCheckListModel/LeadSavePostModel/LeadSavePostModel.dart';
import 'package:sellerkit/Pages/OrderBooking/Screens/LeadSuccessPage.dart';
import 'package:sellerkit/Services/PostQueryApi/LeadsApi/LeadCheckPostApi.dart';
import 'package:sellerkit/Services/PostQueryApi/LeadsApi/SaveLeadApi.dart';
import 'package:sqflite/sqflite.dart';
import '../../Constant/ConstantRoutes.dart';
import '../../Constant/ConstantSapValues.dart';
import '../../DBHelper/DBOperation.dart';
import '../../DBModel/ItemMasertDBModel.dart';
import '../../Models/AddEnqModel/AddEnqModel.dart';
import '../../Models/NewVisitModel/NewVisitModel.dart';
import '../../Models/PostQueryModel/EnquiriesModel/CheckEnqCusDetailsModel.dart';
import '../../Models/PostQueryModel/EnquiriesModel/EnqRefferesModel.dart';
import '../../Models/PostQueryModel/EnquiriesModel/EnqTypeModel.dart';
import '../../Models/PostQueryModel/EnquiriesModel/GetCustomerDetailsModel.dart';
import '../../Models/PostQueryModel/LeadsCheckListModel/GetLeadCheckListModel.dart';
import '../../Pages/OrderBooking/Widgets/LeadWarningDialog.dart';
import '../../Services/PostQueryApi/EnquiriesApi/CheckEnqCutomerDeatils.dart';
import '../../Services/PostQueryApi/EnquiriesApi/GetCustomerDetails.dart';
import '../../Services/PostQueryApi/LeadsApi/LeadCheckListApi.dart';
import '../../Services/PostQueryApi/LeadsApi/LeadFollowupApi.dart';
import '../../Services/RabbitMqPush/RabbitmqApi.dart';
import '../../Services/ServiceLayerApi/CreatNewCus/CreateNewCustApi.dart';
import '../../Widgets/AlertDilog.dart';
import '../EnquiryController/EnquiryMngController.dart';
import '../EnquiryController/EnquiryUserContoller.dart';
import 'TabLeadController.dart';
import 'dart:io';

class LeadNewController extends ChangeNotifier {
  int pageChanged = 0;
  PageController pageController = PageController(initialPage: 0);
  LeadNewController() {
    clearAllData();
    getdataFromDb();
    getEnqRefferes();
    callLeadCheckApi();
  }

  refreshh() {
    clearAllData();
    getdataFromDb();
    getEnqRefferes();
    callLeadCheckApi();
  }

  List<GlobalKey<FormState>> formkey =
      new List.generate(3, (i) => new GlobalKey<FormState>(debugLabel: "Lead"));
  List<TextEditingController> mycontroller =
      List.generate(30, (i) => TextEditingController());

  Config config = new Config();

  String isSelectedGender = '';
  String get getisSelectedGender => isSelectedGender;

  String isSelectedAge = '';
  String get getisSelectedAge => isSelectedAge;

  String isSelectedcomeas = '';
  String get getisSelectedcomeas => isSelectedcomeas;

  String isSelectedAdvertisement = '';
  String get getisSelectedAdvertisement => isSelectedAdvertisement;

  String isSelectedCsTag = '';
  String get getisSelectedCsTag => isSelectedCsTag;

  bool showItemList = true;
  bool get getshowItemList => showItemList;

  bool isUpdateClicked = false;

  bool validateGender = false;
  bool validateAge = false;
  bool validateComas = false;
  bool validateCsTag = false;

  bool get getvalidateGender => validateGender;
  bool get getvalidateAge => validateAge;
  bool get getvalidateComas => validateComas;
  bool get getvalidateCsTag => validateCsTag;

  // List<ProductDetails> productDetails = [];
  // List<ProductDetails> get getProduct => productDetails;

  List<DocumentLines> productDetails = [];
  List<DocumentLines> get getProduct => productDetails;

  List<ItemMasterDBModel> allProductDetails = [];
  List<ItemMasterDBModel> filterProductDetails = [];

  List<ItemMasterDBModel> get getAllProductDetails => allProductDetails;

  String? selectedItemCode;
  String? get getselectedItemCode => selectedItemCode;

  String? selectedItemName;
  String? get getselectedItemName => selectedItemName;

  double? unitPrice;
  int? quantity;
  double total = 0.00;

  List<EnquiryTypeData> enqList = [];
  List<EnquiryTypeData> get getEnqList => enqList;

  String isSelectedenquirytype = '';
  String get getisSelectedenquirytype => isSelectedenquirytype;

  bool visibleEnqType = false;
  bool get getvisibleEnqType => visibleEnqType;

  List<EnqRefferesData> enqReffList = [];
  List<EnqRefferesData> get getenqReffList => enqReffList;

  String isSelectedenquiryReffers = '';
  String get getisSelectedenquiryReffers => isSelectedenquiryReffers;
  String? EnqRefer;

  bool visibleRefferal = false;
  bool get getvisibleRefferal => visibleRefferal;

  static bool isComeFromEnq = false;

  int? enqID;

  selectEnqReffers(String selected, String refercode) {
    isSelectedenquiryReffers = selected;
    EnqRefer = refercode;
    notifyListeners();
  }

  getEnqRefferes() async {
    final Database db = (await DBHelper.getInstance())!;
    enqReffList = await DBOperation.getEnqRefferes(db);
    notifyListeners();
  }

  int? EnqTypeCode;
  selectEnqMeida(String selected, int enqtypecode) {
    isSelectedenquirytype = selected;
    EnqTypeCode = enqtypecode;
    notifyListeners();
  }

  getEnqType() async {
    final Database db = (await DBHelper.getInstance())!;
    enqList = await DBOperation.getEnqData(db);
    notifyListeners();
  }

  getdataFromDb() async {
    final Database db = (await DBHelper.getInstance())!;
    allProductDetails = await DBOperation.getAllProducts(db);
    filterProductDetails = allProductDetails;
  }

  changeVisible() {
    showItemList = !showItemList;
    notifyListeners();
  }

  selectGender(String selected) {
    isSelectedGender = selected;
    notifyListeners();
  }

  selectage(String selected) {
    isSelectedAge = selected;
    notifyListeners();
  }

  selectComeas(String selected) {
    isSelectedcomeas = selected;
    notifyListeners();
  }

  selectAdvertisement(String selected) {
    isSelectedAdvertisement = selected;
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

  String? taxRate;
  String? taxCode;

  addProductDetails(BuildContext context) {
    if (formkey[1].currentState!.validate()) {
      productDetails.add(DocumentLines(
        ItemCode: selectedItemCode,
        ItemDescription: selectedItemName,
        Quantity: double.parse(quantity.toString()),
        LineTotal: total,
        Price: unitPrice,
        TaxCode: "notax",
        TaxLiable: "tNO",
      ));
      showItemList = false;
      mycontroller[12].clear();
      Navigator.pop(context);
      isUpdateClicked = false;
      notifyListeners();
    }
  }

  updateProductDetails(BuildContext context, int i) {
    if (formkey[1].currentState!.validate()) {
      productDetails[i].Quantity = double.parse(quantity.toString());
      productDetails[i].Price = unitPrice;
      productDetails[i].LineTotal = total;
      showItemList = false;
      Navigator.pop(context);
      isUpdateClicked = false;
    }
  }

  resetItems(int i) {
    unitPrice = 0.00;
    quantity = 0;
    total = 0.00;
    mycontroller[10].text = allProductDetails[i].slpPrice!.toStringAsFixed(2);
    //.clear();
    mycontroller[11].clear();
  }

  filterList(String v) {
    if (v.isNotEmpty) {
      allProductDetails = filterProductDetails
          .where((e) =>
              e.itemCode!.toLowerCase().contains(v.toLowerCase()) ||
              e.itemName.toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      allProductDetails = filterProductDetails;
      notifyListeners();
    }
  }

  ///call customer api

  bool customerapicLoading = false;
  bool get getcustomerapicLoading => customerapicLoading;
  bool customerapicalled = false;
  bool get getcustomerapicalled => customerapicalled;
  bool oldcutomer = false;
  String exceptionOnApiCall = '';
  String get getexceptionOnApiCall => exceptionOnApiCall;
  callApi() {
    customerapicLoading = true;
    notifyListeners();
    GetCutomerDetailsApi.getData(
            mycontroller[0].text, "${ConstantValues.slpcode}")
        .then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.itemdata != null) {
          //  itemdata = value.itemdata!;
          mapValues(value.itemdata!);
          oldcutomer = true;
        } else if (value.itemdata == null) {
          oldcutomer = false;
          customerapicLoading = false;
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        customerapicLoading = false;
        exceptionOnApiCall = 'Some thing went wrong..!!';
        notifyListeners();
      } else if (value.stcode == 500) {
        customerapicLoading = false;
        exceptionOnApiCall = 'Some thing went wrong..!!';
        notifyListeners();
      }
      //  print("olddd cusss : "+oldcutomer.toString());
    });
  }

  callCheckEnqDetailsApi(
    BuildContext context,
  ) {
    customerapicLoading = true;
    notifyListeners();
    CheckEnqDetailsApi.getData(ConstantValues.slpcode, mycontroller[0].text)
        .then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.checkEnqDetailsData != null) {
          checkEnqDetailsData = value.checkEnqDetailsData!;
          //  log("data DocEntry: ${value.checkEnqDetailsData![0].DocEntry}");
          // log("data Type!: ${value.checkEnqDetailsData![0].Type!}");

          if (value.checkEnqDetailsData![0].Type == 'Enquiry') {
            callEnqPageSB(context, value.checkEnqDetailsData!);
          } else if (value.checkEnqDetailsData![0].Type == 'Lead') {
            typeOfLeadOrEnq = value.checkEnqDetailsData![0].Type!;

            if (value.checkEnqDetailsData![0].Current_Branch ==
                value.checkEnqDetailsData![0].User_Branch) {
              branchOfLeadOrEnq = 'this';
              //   log("111111");
              // callLeadPageSB(context,value.checkEnqDetailsData!);
              alertDialogOpenLeadOREnq(context);
            } else {
              //  log("22222");
              branchOfLeadOrEnq = value.checkEnqDetailsData![0].Current_Branch!;
              // callLeadPageNSB(context,value.checkEnqDetailsData!);
              alertDialogOpenLeadOREnq(context);
            }
          }
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

  List<CheckEnqDetailsData> checkEnqDetailsData = [];
  callLeadPageSB(
    BuildContext context,
  ) {
    LeadTabController.comeFromEnq = checkEnqDetailsData[0].DocEntry!;
    LeadTabController.isSameBranch = true;
    Navigator.pop(context);
    Get.offAllNamed(ConstantRoutes.leadstab);
    notifyListeners();
  }

  static String typeOfLeadOrEnq = '';
  static String branchOfLeadOrEnq = '';

  callLeadPageNSB(BuildContext context) {
    LeadTabController.comeFromEnq = checkEnqDetailsData[0].DocEntry!;
    LeadTabController.isSameBranch = false;
    //  Navigator.pop(context);
    //  callApi();
    //  customerapicLoading = false;
    //  exceptionOnApiCall = '';
    //  mycontroller[0].clear();
    Navigator.pop(context);
    Get.offAllNamed(ConstantRoutes.leadstab);
    notifyListeners();
  }

  cancelDialog(BuildContext context) {
    exceptionOnApiCall = '';
    customerapicLoading = false;
    mycontroller[0].clear();
    notifyListeners();
    Navigator.pop(context);
  }

  void alertDialogOpenLeadOREnq(BuildContext context) {
    showDialog<dynamic>(
        context: context,
        builder: (_) {
          return LeadWarningDialog();
        }).then((value) {});
  }

  static List<String> dataenq = [];
  mapValues(List<GetCustomerData> itemdata) {
    //  mycontroller[0].text = itemdata[0].CardCode!;
    mycontroller[1].text = itemdata[0].CardName!;
    mycontroller[2].text = itemdata[0].Street!;
    mycontroller[3].text = itemdata[0].Block!;
    mycontroller[4].text = itemdata[0].ZipCode!;
    mycontroller[5].text = itemdata[0].City!;
    customerapicLoading = false;
    isSelectedCsTag = itemdata[0].tags!;
    notifyListeners();
  }

  checkComeFromEnq() {
    clearAllData();

    if (dataenq.length > 0) {
      // print("datatatatata: .....");
      mapValues3();
    }
  }

  mapValues3() {
    mycontroller[0].text = dataenq[0];
    mycontroller[1].text = dataenq[1];
    mycontroller[2].text = dataenq[2];
    mycontroller[3].text = dataenq[3];
    mycontroller[4].text = dataenq[4];
    mycontroller[5].text = dataenq[5];
    enqID = int.parse(dataenq[6]);
    isSelectedCsTag = dataenq[7];
    customerapicLoading = false;
    dataenq.clear();
    notifyListeners();
    // log("enq: ${enqID}");
    // log("isSelectedCsTag: ${isSelectedCsTag}");
  }

  callEnqPageSB(
      BuildContext context, List<CheckEnqDetailsData> checkEnqDetailsData) {
    if (ConstantValues.sapUserType == 'Manager') {
      gotoMrgPage(context);
    } else {
      gotoUserPage(context);
    }
  }

  gotoUserPage(BuildContext context) {
    EnquiryUserContoller.isAlreadyenqOpen = true;
    EnquiryUserContoller.enqDataprev = checkEnqDetailsData[0].DocEntry!;
    EnquiryUserContoller.typeOfDataCus = checkEnqDetailsData[0].Type!;
    customerapicLoading = false;
    exceptionOnApiCall = '';
    mycontroller[0].clear();
    Navigator.pop(context);
    Get.toNamed(ConstantRoutes.enquiriesUser);
    notifyListeners();
  }

  gotoMrgPage(BuildContext context) {
    EnquiryMangerContoller.isAlreadyenqOpen = true;
    EnquiryMangerContoller.enqDataprev = checkEnqDetailsData[0].DocEntry!;
    EnquiryMangerContoller.typeOfDataCus = checkEnqDetailsData[0].Type!;
    customerapicLoading = false;
    exceptionOnApiCall = '';
    mycontroller[0].clear();
    Navigator.pop(context);
    Get.toNamed(ConstantRoutes.enquiriesManager);
    notifyListeners();
  }

  callEnqPageNSB(
      BuildContext context, List<CheckEnqDetailsData> checkEnqDetailsData) {
    EnquiryUserContoller.isAlreadyenqOpen = true;
    EnquiryUserContoller.enqDataprev = checkEnqDetailsData[0].DocEntry!;
    EnquiryUserContoller.typeOfDataCus = checkEnqDetailsData[0].Type!;
    customerapicLoading = false;
    exceptionOnApiCall = '';
    mycontroller[0].clear();
    Navigator.pop(context);
    Get.toNamed(ConstantRoutes.enquiriesUser);
    notifyListeners();
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
    mycontroller[9].clear();
    mycontroller[10].clear();
    mycontroller[11].clear();
    mycontroller[12].clear();
    mycontroller[13].clear();
    mycontroller[14].clear();
    mycontroller[15].clear();
    isSelectedenquirytype = '';
    isSelectedAge = '';
    isSelectedcomeas = '';
    isSelectedGender = '';
    isSelectedAdvertisement = '';
    isSelectedenquiryReffers = '';
    EnqRefer = null;
    customerapicalled = false;
    oldcutomer = false;
    customerapicLoading = false;
    productDetails.clear();
    exceptionOnApiCall = '';
    pageChanged = 0;
    showItemList = true;
    isSelectedCsTag = '';
    // isComeFromEnq = false;s
    isloadingBtn = false;
    enqID = null;
    resetListSelection();
    notifyListeners();
  }

  String apiFDate = '';
  void showFollowupDate(BuildContext context) {
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
      apiFDate =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      print(apiFDate);

      mycontroller[13].text = chooseddate;
      notifyListeners();
    });
  }

  String apiNdate = '';
  void showPurchaseDate(BuildContext context) {
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
      apiNdate =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      print(apiNdate);

      mycontroller[14].text = chooseddate;
      notifyListeners();
    });
  }

  //lead check list Api
  List<LeadCheckData> leadcheckdatas = [];
  List<LeadCheckData> get getleadcheckdatas => leadcheckdatas;
  String LeadCheckDataExcep = '';
  String get getLeadCheckDataExcep => LeadCheckDataExcep;

  callLeadCheckApi() {
    GetLeadCheckListApi.getData('${ConstantValues.slpcode}').then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.leadcheckdata != null) {
          leadcheckdatas = value.leadcheckdata!;
        } else if (value.leadcheckdata == null) {
          LeadCheckDataExcep = 'Lead check data not found..!!';
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        LeadCheckDataExcep = 'Some thing went wrong..!!';
      } else if (value.stcode == 500) {
        LeadCheckDataExcep = 'Some thing went wrong..!!';
      }
    });
  }

  LeadcheckListClicked(bool? v, int i) {
    leadcheckdatas[i].ischecked = v;
    notifyListeners();
  }

  resetListSelection() {
    for (int i = 0; i < leadcheckdatas.length; i++) {
      leadcheckdatas[i].ischecked = false;
    }
  }

//save all values tp server

  saveToServer(BuildContext context) {
    String date = config.currentDateOnly();
    PatchExCus patch = new PatchExCus();
    patch.CardCode = mycontroller[0].text;
    patch.CardName = mycontroller[1].text;
    //patch.CardType =  mycontroller[2].text;
    patch.U_Address1 = mycontroller[2].text;
    patch.U_Address2 = mycontroller[3].text;
    patch.U_Pincode = mycontroller[4].text;
    patch.U_City = mycontroller[5].text;
    //patch.U_Country =  mycontroller[6].text;
    patch.U_EMail = mycontroller[7].text;
    patch.U_Type = isSelectedCsTag;

    PostLead postLead = new PostLead();
    postLead.DocType = "dDocument_Items";
    postLead.CardCode = mycontroller[0].text;
    postLead.CardName = mycontroller[1].text;
    postLead.DocDate = date;
    postLead.U_sk_Address1 = mycontroller[2].text;
    postLead.U_sk_Address2 = mycontroller[3].text;
    postLead.U_sk_Pincode = mycontroller[4].text;
    postLead.U_sk_City = mycontroller[5].text;
    postLead.U_sk_alternatemobile = mycontroller[6].text;
    postLead.U_sk_email = mycontroller[7].text;
    postLead.U_sk_headcount = mycontroller[8].text;
    postLead.U_sk_budget = mycontroller[9].text;
    postLead.U_sk_gender = isSelectedGender;
    postLead.U_sk_Agegroup = isSelectedAge;
    postLead.U_sk_cameas = isSelectedcomeas;
    postLead.U_sk_Referals = isSelectedenquiryReffers;
    postLead.U_sk_NextFollowDt = apiFDate;
    postLead.U_sk_planofpurchase = apiNdate;
    postLead.docLine = productDetails;
    postLead.slpCode = ConstantValues.slpcode; //enqID
    postLead.enqID = enqID;

    // RaabitMQApi.getData(patch).then((value) {
    //      if (value.stcode! >= 200 && value.stcode! <= 210) {
    //       print("${value.message}");
    //   } else if (value.stcode! >= 400 && value.stcode! <= 410) {
    //      isloadingBtn = false;
    //     notifyListeners();
    //      showLeadDeatilsDialog(context, " Some thing wrong Try agin..!!");
    //   } else if (value.stcode! >= 500) {
    //     isloadingBtn = false;
    //     notifyListeners();
    //      showLeadDeatilsDialog(context, " Some thing wrong Try agin..!!");
    //   }
    // });

    if (isComeFromEnq == true) {
      oldcutomer = true;
    }

    if (oldcutomer == true) {
      isloadingBtn = true;
      notifyListeners();
      callLeadSavePostApi(context, postLead);
    } else {
      isloadingBtn = true;
      notifyListeners();
      callNewCus(context, patch, postLead);
    }
  }

  //call save lead api
  late LeadSavePostModal successRes;
  LeadSavePostModal get getsuccessRes => successRes;

  callLeadSavePostApi(BuildContext context, PostLead postLead) {
    //fs
    print(ConstantValues.sapUserType);
    LeadSavePostApi.getData(ConstantValues.sapUserType, postLead).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        successRes = value;
        LeadSuccessPageState.getsuccessRes = value;
        log("docno : " + successRes.DocNo.toString());
        notifyListeners();
        callCheckListApi(context, value.DocEntry!);
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        isloadingBtn = false;
        notifyListeners();
        showLeadDeatilsDialog(context, value.error!.message!.value!);
      } else if (value.stcode! >= 500) {
        isloadingBtn = false;
        notifyListeners();
        showLeadDeatilsDialog(context, " Some thing wrong Try agin..!!");
      }
    });
  }

  // call save apis

  bool isloadingBtn = false;
  bool get getisloadingBtn => isloadingBtn;
  callNewCus(BuildContext context, PatchExCus? patch, PostLead? postLead) {
    NewCustCretApi.getData(ConstantValues.sapUserType, patch!, postLead!)
        .then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        callLeadSavePostApi(context, postLead);
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        isloadingBtn = false;
        notifyListeners();
        showLeadDeatilsDialog(context, value.error!.message!.value!);
        // config.msgDialog(
        //     context, "Some thing wrong..!!", value.error!.message!.value!);
      } else if (value.stcode! >= 500) {
        isloadingBtn = false;
        notifyListeners();
        showLeadDeatilsDialog(
          context,
          "Some thing wrong..!!",
        );
        // config.msgDialog(context, "Some thing wrong..!!", "Try agin..!!");
      }
    });
  }

  //
  callCheckListApi(BuildContext context, int docEntry) {
    //  LeadCheckPostApi.printData(leadcheckdatas, docEntry);
    String date = config.currentDateOnly();
    LeadCheckPostApi.getData(
            ConstantValues.sapUserType, leadcheckdatas, docEntry)
        .then((value) {
      if (value >= 200 && value <= 210) {
        LeadFollowupApiData leadFollowupApiData = new LeadFollowupApiData();
        leadFollowupApiData.date = date;
        leadFollowupApiData.nextFollowUp = apiFDate;
        callFollowupLead(context, leadFollowupApiData, docEntry);
        //  isloadingBtn = false;
        //  notifyListeners();
        //  Get.toNamed(ConstantRoutes.successLead);

        //  config.msgDialog(  --old
        //  context, "Success..!!", "Lead Successfully created..!!");
      } else if (value >= 400 && value <= 410) {
        isloadingBtn = false;
        notifyListeners();
        showLeadDeatilsDialog(
          context,
          "Some thing wrong..!!",
        );
        // config.msgDialog(context, "Some thing wrong..!!","Try agin..!!");
      } else if (value >= 500) {
        isloadingBtn = false;
        notifyListeners();
        showLeadDeatilsDialog(
          context,
          "Some thing wrong..!!",
        );
        //config.msgDialog(context, "Some thing wrong..!!", "Try agin..!!");
      }
    });
  }

  bool remswitch = true;
  switchremainder(bool val) {
    remswitch = val;
    notifyListeners();
  }

  // Followup Lead

  callFollowupLead(
    BuildContext context,
    LeadFollowupApiData leadFollowupApiData,
    int docEntry,
  ) {
    //fs
    LeadFollowupApi.getData(
            ConstantValues.slpcode, leadFollowupApiData, docEntry)
        .then((value) {
      if (value >= 200 && value <= 210) {
        isloadingBtn = false;
        isComeFromEnq = false;
        enqID = null;
        notifyListeners();
        Get.toNamed(ConstantRoutes.successLead);
        //  Future.delayed(Duration(seconds: 2),(){
        //  // Navigator.pop(context);
        //   Get.offAllNamed(ConstantRoutes.leadstab);
        //  });

        //  config.msgDialog(  --old
        //  context, "Success..!!", "Lead Successfully created..!!");
      } else if (value >= 400 && value <= 410) {
        isloadingBtn = false;
        notifyListeners();
        showLeadDeatilsDialog(
          context,
          "Some thing wrong..!!",
        );
        //config.msgDialog(context, "Some thing wrong..!!","Try agin..!!");
      } else if (value >= 500) {
        isloadingBtn = false;
        notifyListeners();
        showLeadDeatilsDialog(
          context,
          "Some thing wrong..!!",
        );
        //config.msgDialog(context, "Some thing wrong..!!", "Try agin..!!");
      }
    });
  }

  //for success page

  //next btns

  firstPageNextBtn() {
    int passed = 0;
    log("pageChanged: ${pageChanged}");
    // if (isSelectedGender.isEmpty) {
    //   passed = passed + 1;
    //   validateGender = true;
    // }
    // if (isSelectedAge.isEmpty) {
    //   passed = passed + 1;
    //   validateAge = true;
    // }
    // if (isSelectedcomeas.isEmpty) {
    //   print("object");
    //   passed = passed + 1;
    //   validateComas = true;
    // }
    if (formkey[0].currentState!.validate()) {
      print("passed: $passed");
      if (passed == 0) {
        pageController.animateToPage(++pageChanged,
            duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
        resetValidate();
      }
    }
    notifyListeners();
  }

  seconPageBtnClicked() {
    if (productDetails.length > 0) {
      pageController.animateToPage(++pageChanged,
          duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
    } else {
      Get.snackbar("Field Empty", "Choose products..!!",
          backgroundColor: Colors.red);
    }
  }

  thirPageBtnClicked(BuildContext context) {
    int passed = 0;
    // if (files.isEmpty) {
    //   fileValidation = true;
    //   notifyListeners();
    // }
    if (formkey[1].currentState!.validate()) {
      if (passed == 0 && files.isNotEmpty) {
        // LeadSavePostApi.printData(postLead);
        saveToServer(context);
      }
    }
    if (isSelectedenquiryReffers.isEmpty) {
      visibleRefferal = true;
    }
    notifyListeners();
  }

  showLeadDeatilsDialog(BuildContext context, String msg) {
    showDialog<dynamic>(
        context: context,
        builder: (_) {
          return AlertMsg(msg: msg);
        });
  }

  resetValidate() {
    validateGender = false;
    validateAge = false;
    validateComas = false;
    notifyListeners();
  }

  resetValidateThird() {
    visibleRefferal = false;
    notifyListeners();
  }

  showBottomSheetInsert(BuildContext context, int i) {
    final theme = Theme.of(context);
    selectedItemName = allProductDetails[i].itemName.toString();
    selectedItemCode = allProductDetails[i].itemCode.toString();
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: Form(
            key: formkey[1],
            child: Container(
              child: Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Container(
                      // width: Screens.width(context)*0.8,
                      child: Text(allProductDetails[i].itemCode.toString(),
                          style: theme.textTheme.bodyText1
                              ?.copyWith(color: theme.primaryColor)),
                    ),
                    Container(
                      // width: Screens.width(context)*0.7,
                      // color: Colors.red,
                      child: Text(allProductDetails[i].itemName.toString(),
                          style: theme.textTheme.bodyText1
                              ?.copyWith() //color: theme.primaryColor
                          ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      // width: 270,
                      // height: 40,
                      child: new TextFormField(
                        controller: mycontroller[10],
                        onChanged: (val) {
                          if (val.length > 0) {
                            if (mycontroller[10].text.length > 0 &&
                                mycontroller[11].text.length > 0) {
                              unitPrice = double.parse(mycontroller[10].text);
                              quantity = int.parse(mycontroller[11].text);
                              total = unitPrice! * quantity!;
                              print(total);
                            }
                          }
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "ENTER UNIT PRICE";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: 15),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          labelText: "Unit Price",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      // width: 270,
                      // height: 40,
                      child: new TextFormField(
                        controller: mycontroller[11],
                        onChanged: (val) {
                          if (val.length > 0) {
                            if (mycontroller[10].text.length > 0 &&
                                mycontroller[11].text.length > 0) {
                              unitPrice = double.parse(mycontroller[10].text);
                              quantity = int.parse(mycontroller[11].text);
                              total = unitPrice! * quantity!;
                              print(total);
                            }
                          }
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "ENTER QUANTITY";
                          }
                          return null;
                        },
                        // readOnly: isDescriptionSelected == "TRANSPORTCHARGES"
                        //     ? true
                        //     : false,
                        keyboardType: TextInputType.number,
                        //inputFormatters: [FilteringTextInputFormatter.digitsOnly,],
                        style: TextStyle(fontSize: 15),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          labelText: "quantity",
                        ),
                      ),
                    ),
                    //  ),
                    SizedBox(
                      height: 15,
                    ),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: Text("Total: $total")),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("cancel")),
                        isUpdateClicked == false
                            ? ElevatedButton(
                                onPressed: () {
                                  mycontroller[12].clear();
                                  addProductDetails(context);
                                },
                                child: Text("ok"))
                            : ElevatedButton(
                                onPressed: () {
                                  updateProductDetails(context, i);
                                },
                                child: Text("Update")),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }

  //New Code
  //
  //
  //
  bool customerbool = false;
  bool areabool = false;
  bool citybool = false;
  bool pincodebool = false;
  bool statebool = false;
  List<ExistingCusData> existCusDataList = [];
  List<ExistingCusData> get getexistCusDataList => existCusDataList;
  List<ExistingCusData> filterexistCusDataList = [];
  List<customerTags> cusReffList = [];
  List<customerTags> get getcusReffList => cusReffList;
  clearData() {
    clearbool();

    existCusDataList.clear();
    filterexistCusDataList.clear();
    mycontroller[16].text = "";
    mycontroller[0].text = "";
    mycontroller[1].text = "";
    mycontroller[2].text = "";
    mycontroller[3].text = "";
    mycontroller[17].text = "";
    mycontroller[5].text = "";
    mycontroller[4].text = "";
    mycontroller[18].text = "";
    mycontroller[6].text = "";
    mycontroller[7].text = "";
    mycontroller[25].text = "";
    notifyListeners();
  }

  clearbool() {
    customerbool = false;
    areabool = false;
    citybool = false;
    pincodebool = false;
    statebool = false;

    notifyListeners();
  }

  getDataMethod() {
    cusReffList = [
      customerTags(tagname: "Doctor", tagid: "1"),
      customerTags(tagname: "Doctor", tagid: "1"),
      customerTags(tagname: "Doctor", tagid: "1"),
      customerTags(tagname: "Doctor", tagid: "1"),
      customerTags(tagname: "Doctor", tagid: "1"),
    ];
    existCusDataList = [
      ExistingCusData(
          Customer: "Arun Store",
          Mobile: "1234567890",
          CantactName: "Arun",
          U_Address1: "104 West Street ,",
          U_Address2: "Srirangam,Trichy",
          U_City: "Trichy",
          U_Area: "Srirangam",
          PurposOfVisit: "Enquiry Visit",
          Meeting_Time: "12:00 AM",
          U_Pincode: "6200005",
          U_State: "Tamil Nadu",
          Meeting_Date: "24-01-2023",
          AlterMobile: "9876543477",
          Email: "arun88@gmail.com",
          GST: "98KJNNBVGN78NBNL"),
      ExistingCusData(
          Customer: "Raja Store",
          Mobile: "9876543210",
          CantactName: "Raja",
          U_Address1: "124 KK Nagar Street ,",
          U_Address2: "Karur main Road,Karur",
          U_City: "Somur",
          U_Area: "Karur",
          PurposOfVisit: "New Demo",
          Meeting_Time: "10:20 AM",
          U_Pincode: "6200024",
          U_State: "Tamil Nadu",
          Meeting_Date: "12-03-2023",
          AlterMobile: "9876543477",
          Email: "arun88@gmail.com",
          GST: "98KJNNBVGN78NBNL"),
    ];

    filterexistCusDataList = existCusDataList;

    notifyListeners();
  }

  filterListcustomer(String v) {
    if (v.isNotEmpty) {
      filterexistCusDataList = existCusDataList
          .where((e) => e.Customer!.toLowerCase().contains(v.toLowerCase())
              // ||
              // e.name!.toLowerCase().contains(v.toLowerCase())
              )
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterexistCusDataList = existCusDataList;
      notifyListeners();
    }
  }

  filterListArea(String v) {
    if (v.isNotEmpty) {
      filterexistCusDataList = existCusDataList
          .where((e) => e.U_Area!.toLowerCase().contains(v.toLowerCase())
              // ||
              // e.name!.toLowerCase().contains(v.toLowerCase())
              )
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterexistCusDataList = existCusDataList;
      notifyListeners();
    }
  }

  filterListCity(String v) {
    if (v.isNotEmpty) {
      filterexistCusDataList = existCusDataList
          .where((e) => e.U_City!.toLowerCase().contains(v.toLowerCase())
              // ||
              // e.name!.toLowerCase().contains(v.toLowerCase())
              )
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterexistCusDataList = existCusDataList;
      notifyListeners();
    }
  }

  filterListPincode(String v) {
    if (v.isNotEmpty) {
      filterexistCusDataList = existCusDataList
          .where((e) => e.U_Pincode!.toLowerCase().contains(v.toLowerCase())
              // ||
              // e.name!.toLowerCase().contains(v.toLowerCase())
              )
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterexistCusDataList = existCusDataList;
      notifyListeners();
    }
  }

  filterListState(String v) {
    if (v.isNotEmpty) {
      filterexistCusDataList = existCusDataList
          .where((e) => e.U_State!.toLowerCase().contains(v.toLowerCase())
              // ||
              // e.name!.toLowerCase().contains(v.toLowerCase())
              )
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterexistCusDataList = existCusDataList;
      notifyListeners();
    }
  }

  getExiCustomerData(String Customer) {
    for (int i = 0; i < existCusDataList.length; i++) {
      if (Customer == existCusDataList[i].Customer) {
        mycontroller[16].text = existCusDataList[i].Customer.toString();
        mycontroller[0].text = existCusDataList[i].Mobile.toString();
        mycontroller[1].text = existCusDataList[i].CantactName.toString();
        mycontroller[2].text = existCusDataList[i].U_Address1.toString();
        mycontroller[3].text = existCusDataList[i].U_Address2.toString();
        mycontroller[17].text = existCusDataList[i].U_Area.toString();
        mycontroller[5].text = existCusDataList[i].U_City.toString();
        mycontroller[4].text = existCusDataList[i].U_Pincode.toString();
        mycontroller[18].text = existCusDataList[i].U_State.toString();
        mycontroller[6].text = existCusDataList[i].AlterMobile.toString();
        mycontroller[7].text = existCusDataList[i].Email.toString();
        mycontroller[25].text = existCusDataList[i].GST.toString();
        notifyListeners();
      }
    }
    notifyListeners();
  }

  FilePickerResult? result;
  //  filesz = [];
  List<File> files = [];
  bool? fileValidation = false;

  List<FilesData> filedata = [];
  List<String> filelink = [];
  List<String> fileException = [];
  List images = [
    "assets/PDFimg.png",
    "assets/txt.png",
    "assets/xls.png",
    "assets/img.jpg"
  ];
  void showtoast() {
    Fluttertoast.showToast(
        msg: "More than Four Document Not Allowed..",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14.0);
  }

  selectattachment() async {
    log(files.length.toString());

    result = await FilePicker.platform.pickFiles(allowMultiple: true);
    notifyListeners();

    if (result != null) {
      filedata.clear();

      List<File> filesz = result!.paths.map((path) => File(path!)).toList();
      
      if (filesz.length != 0) {
        for (int i = 0; i < filesz.length; i++) {
          // createAString();

          if (files.length <= 4) {
            // showtoast();
            files.add(filesz[i]);
            // log("Files Lenght :::::" + files.length.toString());
            List<int> intdata = filesz[i].readAsBytesSync();
            filedata.add(FilesData(
                fileBytes: base64Encode(intdata),
                fileName: filesz[i].path.split('/').last));
                    notifyListeners();

            // return null;
          } else {
            showtoast();
          }
        }
      }
       notifyListeners();

    }    notifyListeners();

  }

  Future imagetoBinary(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    files.add(File(image.path));
    filedata.clear();
    notifyListeners();

    if (files.length <= 3) {
      for (int i = 0; i < files.length; i++) {
        List<int> intdata = files[i].readAsBytesSync();
        filedata.add(FilesData(
            fileBytes: base64Encode(intdata),
            fileName: files[i].path.split('/').last));
        notifyListeners();
      }
      log("filesz lenghthhhhh::::::" + filedata.length.toString());

      // return null;
    } else {
      log("filesz lenghthhhhh::::::" + filedata.length.toString());
      showtoast();
    }
    log("camera fileslength" + files.length.toString());
    showtoast();

    notifyListeners();

  }

  bool value = false;


  
  converttoShipping(bool value) {
    if (value == true) {
      mycontroller[19].text = mycontroller[2].text.toString();
      mycontroller[20].text = mycontroller[3].text.toString();
      mycontroller[21].text = mycontroller[17].text.toString();
      mycontroller[22].text = mycontroller[5].text.toString();
      mycontroller[23].text = mycontroller[4].text.toString();
      mycontroller[24].text = mycontroller[18].text.toString();
      notifyListeners();
    } else {
      mycontroller[19].text = "";
      mycontroller[20].text = "";
      mycontroller[21].text = "";
      mycontroller[22].text = "";
      mycontroller[23].text = "";
      mycontroller[24].text = "";
      notifyListeners();
    }
  }

  getTotalOrderAmount() {
    double? LineTotal = 0.00;
    for (int i = 0; i < productDetails.length; i++) {
      LineTotal = LineTotal! + productDetails[i].LineTotal!;
    }
    return LineTotal!.toStringAsFixed(2);
  }
}

class customerTags {
  String? tagname;

  String? tagid;
  // String shipCity;
  // String shipstate;
  // String shipPincode;
  // String shipCountry;
  customerTags({
    this.tagid,
    this.tagname,

    // required this.shipCity,
    //required this.shipAddress,

    // required this.shipCountry,
    // required this.shipPincode,
    // required this.shipstate
  });
}

class ProductDetails {
  String? itemcode;
  String? itemName;
  int? qty;
  double? unitPrice;
  double? total;

  ProductDetails(
      {required this.itemName,
      required this.itemcode,
      required this.qty,
      required this.unitPrice,
      required this.total});
}

class FilesData {
  String fileBytes;
  String fileName;

  FilesData({required this.fileBytes, required this.fileName});
}
