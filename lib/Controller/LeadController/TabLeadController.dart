// ignore_for_file: empty_constructor_bodies, unnecessary_new

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Controller/LeadController/LeadNewController.dart';
import 'package:sellerkit/DBHelper/DBHelper.dart';
import 'package:sellerkit/DBHelper/DBOperation.dart';
import 'package:sellerkit/Models/PostQueryModel/LeadsCheckListModel/GetLeadSummary.dart';
import 'package:sellerkit/Services/PostQueryApi/LeadsApi/CancelLeadWonApi.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Constant/ConstantSapValues.dart';
import '../../Models/PostQueryModel/EnquiriesModel/GetUserModel.dart';
import '../../Models/PostQueryModel/LeadsCheckListModel/GetAllLeadModel.dart';
import '../../Models/PostQueryModel/LeadsCheckListModel/GetLeadStatuModel.dart';
import '../../Models/PostQueryModel/LeadsCheckListModel/LeadSavePostModel/GetLeadDetailsL.dart';
import '../../Models/PostQueryModel/LeadsCheckListModel/LeadSavePostModel/GetLeadDetailsQTHModel.dart';
import '../../Models/PostQueryModel/LeadsCheckListModel/LeadSavePostModel/GetLeadDetailsQTL.dart';
import '../../Pages/OrderBooking/Widgets/FollowDialog.dart';
import '../../Services/PostQueryApi/LeadsApi/CloseLeadwonApi.dart';
import '../../Services/PostQueryApi/LeadsApi/ForwardLeadUserApi.dart';
import '../../Services/PostQueryApi/LeadsApi/GetAllLeads.dart';
import '../../Services/PostQueryApi/LeadsApi/GetLeadDeatilsQTH.dart';
import '../../Services/PostQueryApi/LeadsApi/GetLeadDeatilsQTL.dart';
import '../../Services/PostQueryApi/LeadsApi/GetLeadDetailsL.dart';
import '../../Services/PostQueryApi/LeadsApi/GetLeadSummaryApi.dart';
import '../../Services/PostQueryApi/LeadsApi/LostSaveLeadApi.dart';
import '../../Services/PostQueryApi/LeadsApi/OpenSaveApi.dart';
import '../../Services/PostQueryApi/LeadsApi/WonSaveApi.dart';
import '../EnquiryController/NewEnqController.dart';

class LeadTabController extends ChangeNotifier {

  List<GlobalKey<FormState>> formkey =
      List.generate(3, (i) => GlobalKey<FormState>());
  List<TextEditingController> mycontroller =
      List.generate(20, (i) => TextEditingController());

  Config config = new Config();

  List<GetAllLeadData> leadOpenAllData = [];
  List<GetAllLeadData> get getAllLeadData => leadOpenAllData;
  List<GetAllLeadData> leadClosedAllData = [];
  List<GetAllLeadData> get getleadClosedAllData => leadClosedAllData;
  List<GetAllLeadData> leadLostAllData = [];
  List<GetAllLeadData> get getleadLostAllData => leadLostAllData;
  String leadCheckDataExcep = '';
  String get getLeadCheckDataExcep => leadCheckDataExcep;

  printLogic(){
    log("leadCheckDataExcep: ${leadCheckDataExcep}");
    log("leadSummaryLost: ${leadSummaryLost.length}");
    log("leadSummaryOpen: ${leadSummaryOpen.length}");
    log("leadSummaryWon: ${leadSummaryWon.length}");
    log("leadOpenAllData: ${leadOpenAllData.length}");
    log("leadClosedAllData: ${leadClosedAllData.length}");
    log("leadLostAllData: ${leadLostAllData.length}");
  }

  clearAllListData(){
    leadCheckDataExcep = '';
    leadSummaryOpen.clear();
    leadSummaryWon.clear();
    leadSummaryLost.clear();
    leadOpenAllData.clear();
    leadLostAllData.clear();
    leadClosedAllData.clear();
    notifyListeners();
  }

  refershAfterClosedialog() {
    leadCheckDataExcep = '';
    leadOpenAllData.clear();
    leadClosedAllData.clear();
    leadLostAllData.clear();
    leadSummaryOpen.clear();
    leadSummaryWon.clear();
    leadSummaryLost.clear();
    comeFromEnq = -1;
    viewDetailsdialog = false;
    notifyListeners();
  }

  Future<void> swipeRefreshIndiactor() async {
    // return Future.delayed(Duration.zero,(){
    refershAfterClosedialog();
    callGetAllApi();
    callSummaryApi();

    //});
  }

  callGetAllApi() async {
    await GetAllLeadApi.getData(ConstantValues.slpcode).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.leadcheckdata != null) {
          mapValues(value.leadcheckdata!);
        } else if (value.leadcheckdata == null) {
          leadCheckDataExcep = 'No Leads..!!';
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        leadCheckDataExcep = 'Some thing went wrong..!!';
      } else if (value.stcode == 500) {
        leadCheckDataExcep = 'Some thing went wrong..!!';
      }
      notifyListeners();
    });
  }

  mapValues(List<GetAllLeadData> leadcheckdata) {
    for (int i = 0; i < leadcheckdata.length; i++) {
      if (leadcheckdata[i].Status == "Open") {
        leadOpenAllData.add(GetAllLeadData(
            LeadDocEntry: leadcheckdata[i].LeadDocEntry,
            LeadNum: leadcheckdata[i].LeadNum,
            Mobile: leadcheckdata[i].Mobile,
            CustomerName: leadcheckdata[i].CustomerName,
            DocDate: leadcheckdata[i].DocDate,
            City: leadcheckdata[i].City,
            NextFollowup: leadcheckdata[i].NextFollowup,
            Product: leadcheckdata[i].Product,
            Value: leadcheckdata[i].Value,
            Status: leadcheckdata[i].Status,
            LastUpdateMessage: leadcheckdata[i].LastUpdateMessage,
            LastUpdateTime: leadcheckdata[i].LastUpdateTime,
            FollowupEntry: leadcheckdata[i].FollowupEntry));
      } else if (leadcheckdata[i].Status == "Won") {
        leadClosedAllData.add(GetAllLeadData(
            LeadDocEntry: leadcheckdata[i].LeadDocEntry,
            LeadNum: leadcheckdata[i].LeadNum,
            Mobile: leadcheckdata[i].Mobile,
            CustomerName: leadcheckdata[i].CustomerName,
            DocDate: leadcheckdata[i].DocDate,
            City: leadcheckdata[i].City,
            NextFollowup: leadcheckdata[i].NextFollowup,
            Product: leadcheckdata[i].Product,
            Value: leadcheckdata[i].Value,
            Status: leadcheckdata[i].Status,
            LastUpdateMessage: leadcheckdata[i].LastUpdateMessage,
            LastUpdateTime: leadcheckdata[i].LastUpdateTime,
            FollowupEntry: leadcheckdata[i].FollowupEntry));
      } else if (leadcheckdata[i].Status == "Lost") {
        leadLostAllData.add(GetAllLeadData(
            LeadDocEntry: leadcheckdata[i].LeadDocEntry,
            LeadNum: leadcheckdata[i].LeadNum,
            Mobile: leadcheckdata[i].Mobile,
            CustomerName: leadcheckdata[i].CustomerName,
            DocDate: leadcheckdata[i].DocDate,
            City: leadcheckdata[i].City,
            NextFollowup: leadcheckdata[i].NextFollowup,
            Product: leadcheckdata[i].Product,
            Value: leadcheckdata[i].Value,
            Status: leadcheckdata[i].Status,
            LastUpdateMessage: leadcheckdata[i].LastUpdateMessage,
            LastUpdateTime: leadcheckdata[i].LastUpdateTime,
            FollowupEntry: leadcheckdata[i].FollowupEntry));
      }
    }
  }

  // call summary api
  List<SummaryLeadData> leadSummaryOpen = [];
  List<SummaryLeadData> leadSummaryWon = [];
  List<SummaryLeadData> leadSummaryLost = [];

  List<SummaryLeadData> get getleadSummaryOpen => leadSummaryOpen;
  List<SummaryLeadData> get getleadSummaryWon => leadSummaryWon;
  List<SummaryLeadData> get getleadSummaryLost => leadSummaryLost;

  callSummaryApi() async{
   await GetLeadSummaryApi.getData(ConstantValues.slpcode).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.leadSumarydata != null) {
          mapValuesSummary(value.leadSumarydata!);
        } else if (value.leadSumarydata == null) {
          leadCheckDataExcep = 'No Leads..!!';
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        leadCheckDataExcep = 'Some thing went wrong..!!';
      } else if (value.stcode == 500) {
        leadCheckDataExcep = 'Some thing went wrong..!!';
      }
      notifyListeners();
    });
  }

  mapValuesSummary(List<SummaryLeadData> leadcheckdata) {
    for (int i = 0; i < leadcheckdata.length; i++) {
      if (leadcheckdata[i].Status == "Open") {
        leadSummaryOpen.add(SummaryLeadData(
            Caption: leadcheckdata[i].Caption,
            Target: leadcheckdata[i].Target,
            Value: leadcheckdata[i].Value,
            Status: leadcheckdata[i].Status,
            column: leadcheckdata[i].column));
      } else if (leadcheckdata[i].Status == "Won") {
        leadSummaryWon.add(SummaryLeadData(
            Caption: leadcheckdata[i].Caption,
            Target: leadcheckdata[i].Target,
            Value: leadcheckdata[i].Value,
            Status: leadcheckdata[i].Status,
            column: leadcheckdata[i].column));
      } else if (leadcheckdata[i].Status == "Lost") {
        leadSummaryLost.add(SummaryLeadData(
            Caption: leadcheckdata[i].Caption,
            Target: leadcheckdata[i].Target,
            Value: leadcheckdata[i].Value,
            Status: leadcheckdata[i].Status,
            column: leadcheckdata[i].column));
      }
    }
  }

  /////  for fialog
  String isSelectedFollowUp = '';
  String get getisSelectedFollowUp => isSelectedFollowUp;
  selectFollowUp(String selected) {
    isSelectedFollowUp = selected;
    notifyListeners();
  }

  bool updateFollowUpDialog = false;
  bool get getupdateFollowUpDialog => updateFollowUpDialog;
  bool leadForwarddialog = false;
  bool get getleadForwarddialog => leadForwarddialog;
  bool leadWondialog = false;
  bool get getleadWondialog => leadWondialog;
  bool leadLostdialog = false;
  bool get getleadLostdialog => leadLostdialog;
  bool leadLoadingdialog = false;
  bool get getleadLoadingdialog => leadLoadingdialog;
  bool updateFollowUpdialog = false;
  bool get getupdateFollowUpdialog => updateFollowUpdialog;
  bool viewDetailsdialog = false;
  bool get getviewDetailsdialog => viewDetailsdialog;
  

  printLogic2(){
    log("updateFollowUpDialog: ${updateFollowUpDialog}");
    log("leadForwarddialog: ${leadForwarddialog}");
    log("leadLoadingdialog: ${leadLoadingdialog}");
    log("viewDetailsdialog: ${viewDetailsdialog}");
    log("forwardSuccessMsg: ${forwardSuccessMsg}");
  }

  changetoFolloweUp() {
    updateFollowUpDialog = true;
    notifyListeners();
  }

  String apiFDate = '';
  String nextFD = '';
  String get getnextFD => nextFD;

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

      nextFD = chooseddate;
      notifyListeners();
    });
  }

  String apiWonFDate = '';
  String nextWonFD = '';
  String get getnextWonFD => nextWonFD;
  void showFollowupWonDate(BuildContext context) {
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
      apiWonFDate =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      print(apiWonFDate);

      nextWonFD = chooseddate;
      notifyListeners();
    });
  }

  String apiforwardNextFollowUPDate = '';
  String forwardnextWonFD = '';
  String get getforwardnextWonFD => forwardnextWonFD;
  void showForwardNextDate(BuildContext context) {
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
      apiforwardNextFollowUPDate =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      print(apiforwardNextFollowUPDate);

      forwardnextWonFD = chooseddate;
      notifyListeners();
    });
  }

  resetValuesIS1() async {
       final Database db = (await DBHelper.getInstance())!;
    isSelectedFollowUp = '';
    nextFD = '';
    updateFollowUpDialog = false;
    leadForwarddialog = false;
    leadWondialog = false;
    leadLostdialog = false;
    leadLoadingdialog = false;
    valueChosedReason = null;
    valueChosedStatus = null;
    valueChosedStatusWon = null;
    viewDetailsdialog = false;
    forwardSuccessMsg = '';
    caseStatusSelected = '';
    selectedUserList = '';
    forwardnextWonFD = '';
    hinttextforOpenLead = 'Select Status: ';
    hinttextforWonLead = 'Select Status: ';
    hinttextforLostLead = 'Select Reason';
    feedbackLead = 'Feed back:';
    nextFollowupDate = 'Next Follow up:';
    mycontroller[1].clear();
    mycontroller[0].clear();
    mycontroller[2].clear();
    hinttextforWonLead = "Select Status:";
    hinttextforLostLead = "Select Status:";
    hinttextforOpenLead = "Select Status:";
    orderBillRefer = 'Order/Bill Reference';
    feedbackLead = 'Give your feedback';
    nextFollowupDate = 'Next Follow up:';
    orderBillDate = 'Order/Bill Date:';
    followup = 'How you made the follow up?';
    forwardNextFollowDate = 'Next FollowUp';
    leadOpenSaveClicked = false;
    leadWonSaveClicked = false;
    leadLostSaveClicked = false;
    nextWonFD = '';
    userLtData = await DBOperation.getUserList(db);
    notifyListeners();
  }

  // resetValuesISnot1() async {
  //   isSelectedFollowUp = '';
  //   nextFD = '';
  //   updateFollowUpDialog = false;
  //   leadForwarddialog = false;
  //   leadWondialog = false;
  //   leadLostdialog = false;
  //   leadLoadingdialog = false;
  //   valueChosedReason = null;
  //   valueChosedStatus = null;
  //   valueChosedStatusWon = null;
  //   viewDetailsdialog = true;
  //   forwardSuccessMsg = '';
  //   caseStatusSelected = '';
  //   selectedUserList = '';
  //   forwardnextWonFD = '';
  //   hinttextforOpenLead = 'Select Status: ';
  //   hinttextforWonLead = 'Select Status: ';
  //   hinttextforLostLead = 'Select Reason';
  //   feedbackLead = 'Feed back:';
  //   nextFollowupDate = 'Next Follow up:';
  //   mycontroller[1].clear();
  //   mycontroller[0].clear();
  //   mycontroller[2].clear();
  //   hinttextforWonLead = "Select Status:";
  //   hinttextforLostLead = "Select Status:";
  //   hinttextforOpenLead = "Select Status:";
  //   orderBillRefer = 'Order/Bill Reference';
  //   feedbackLead = 'Give your feedback';
  //   nextFollowupDate = 'Next Follow up:';
  //   orderBillDate = 'Order/Bill Date:';
  //   followup = 'How you made the follow up?';
  //   forwardNextFollowDate = 'Next FollowUp';
  //   leadOpenSaveClicked = false;
  //   leadWonSaveClicked = false;
  //   leadLostSaveClicked = false;
  //   nextWonFD = '';
  //   userLtData = await dbHelper.getUserList();
  //   notifyListeners();
  // }

  // for dialog
  String? valueChosedReason; //cl
  String? get getvalueChosedReason => valueChosedReason;
  String? valueChosedStatus; //cl
  String? get getvalueChosedStatus => valueChosedStatus;
  String? valueChosedStatusWon; //cl
  String? get getvalueChosedStatusWon => valueChosedStatusWon;
  List<String> data = ['', 'a'];

  String? hinttextforOpenLead = 'Select Status: '; //cl
  String? get gethinttextforOpenLead => hinttextforOpenLead;
  String? hinttextforWonLead = 'Select Status: '; //cl
  String? get gethinttextforWonLead => hinttextforWonLead;
  String? hinttextforLostLead = 'Select Reason'; //cl
  String? get gethinttextforLostLead => hinttextforLostLead;
  String? feedbackLead = 'Give your feedback'; //cl Give your feedback
  String? get getfeedbackLead => feedbackLead;
  String? nextFollowupDate = 'Next Follow up:'; //cl
  String? get getnextFollowupDate => nextFollowupDate;
  String? orderBillRefer = 'Order/Bill Reference'; //cl
  String? get getorderBillRefer => orderBillRefer;
  String? orderBillDate = 'Order/Bill Date:'; //cl
  String? get getorderBillDate => orderBillDate;
  String? followup =
      'How you made the follow up?'; //cl How the follow up has been made
  String? get getfollowup => followup;
  String? forwardNextFollowDate = 'Next Follow Up:'; //cl
  String? get getforwardNextFollowDate => forwardNextFollowDate;

  choosedReason(String val) {
    valueChosedReason = val;
    notifyListeners();
  }

  choosedStatus(String val) {
    valueChosedStatus = val;
    notifyListeners();
  }

  choosedStatusWon(String val) {
    valueChosedStatusWon = val;
    notifyListeners();
  }

  String caseStatusSelected = ''; //cl
  String? get getcaseStatusSelected => caseStatusSelected;

  caseStatusSelectBtn(String val) {
    caseStatusSelected = val;
    notifyListeners();
  }

  ///get lead status api
  List<GetLeadStatusData> leadStatusOpen = [];
  List<GetLeadStatusData> leadStatusLost = [];
  List<GetLeadStatusData> leadStatusWon = [];
  List<GetLeadStatusData> get getleadStatusOpen => leadStatusOpen;
  List<GetLeadStatusData> get getleadStatusLost => leadStatusLost;
  List<GetLeadStatusData> get getleadStatusWon => leadStatusWon;

  /// gget user list frpm db

  List<UserListData> userLtData = [];
  List<UserListData> get getuserLtData => userLtData;

  String selectedUserList = '';
  String get getselectedUserList => selectedUserList;

  getLeadStatus() async {
       final Database db = (await DBHelper.getInstance())!;
    leadStatusOpen = await DBOperation.getLeadStatusOpen(db);
    leadStatusLost = await DBOperation.getLeadStatusLost(db);
    leadStatusWon = await DBOperation.getLeadStatusWon(db);
    userLtData = await DBOperation.getUserList(db);
    notifyListeners();
  }

  getSelectedUserSalesEmpId(int i) {
    selectedUserList = userLtData[i].SalesEmpID.toString();
    selectUser(i);
  }

  int? salesEmpIdForward;
  selectUser(int ij) {
    for (int i = 0; i < userLtData.length; i++) {
      if (userLtData[i].SalesEmpID == userLtData[ij].SalesEmpID) {
        userLtData[i].color = 1;
        salesEmpIdForward = userLtData[ij].SalesEmpID;
      } else {
        userLtData[i].color = 0;
      }
    }
    notifyListeners();
  }

  forwardClicked() {
    leadForwarddialog = !leadForwarddialog;
    notifyListeners();
  }

  viweDetailsClicked() {
    viewDetailsdialog = !viewDetailsdialog;
    notifyListeners();
  }
  //callGetLeadDeatilsApi();

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  bool leadOpenSaveClicked = false;
  bool leadWonSaveClicked = false;
  bool leadLostSaveClicked = false;

  clickLeadSaveBtn(String followDocEntry, String leadDocEntry) {
    if (caseStatusSelected == 'Open') {
      leadOpenSaveClicked = true;
      leadWonSaveClicked = false;
      leadLostSaveClicked = false;
      log("followDocEntry: $followDocEntry");
      log("leadDocEntry: $leadDocEntry");

      callRequiredOpen(followDocEntry);
    } else if (caseStatusSelected == 'Won') {
      leadWonSaveClicked = true;
      leadOpenSaveClicked = false;
      leadLostSaveClicked = false;
      callRequiredWon(followDocEntry, leadDocEntry);
    } else if (caseStatusSelected == 'Lost') {
      leadLostSaveClicked = true;
      leadOpenSaveClicked = false;
      leadWonSaveClicked = false;
      callRequiredLost(followDocEntry, leadDocEntry);
    }
  }

  callRequiredOpen(String followDocEntry) {
    int i = 0;
    if (valueChosedStatus == null) {
      i = i + 1;
      hinttextforOpenLead = "Select Status:*";
    } else {
      hinttextforOpenLead = "Select Status:";
    }
    if (mycontroller[1].text.isEmpty) {
      i = i + 1;
      feedbackLead = 'Give your feedback*';
    } else {
      feedbackLead = 'Give your feedback';
    }
    if (nextFD == '') {
      i = i + 1;
      nextFollowupDate = 'Next Follow up:*';
    } else {
      nextFollowupDate = 'Next Follow up:';
    }
    if (isSelectedFollowUp == '') {
      print("4");

      i = i + 1;
      followup = 'How you made the follow up?*';
    } else {
      followup = 'How you made the follow up?';
    }
    hinttextforWonLead = "Select Status:";
    orderBillRefer = 'Order/Bill Reference';
    orderBillDate = 'Order/Bill Date';
    hinttextforLostLead = 'Select Reason:';
    if (i < 1) {
      print("ssssss");
      openSave(
          followDocEntry, valueChosedStatus, mycontroller[1].text, apiFDate);
    }
    notifyListeners();
  }

  callRequiredWon(String followDocEntry, String leadDocEntry) {
    int i = 0;
    if (hinttextforWonLead == null) {
      print("1a");
      i = i + 1;
      hinttextforWonLead = "Select Status:*";
    } else {
      hinttextforWonLead = "Select Status:";
    }
    if (mycontroller[0].text.isEmpty) {
      i = i + 1;
      print("2");

      orderBillRefer = 'Order/Bill Reference*';
    } else {
      orderBillRefer = 'Order/Bill Reference';
    }
    if (nextWonFD == '') {
      print("3");

      i = i + 1;
      orderBillDate = 'Order/Bill Date*';
    } else {
      orderBillDate = 'Order/Bill Date';
    }
    if (isSelectedFollowUp == '') {
      print("4");

      i = i + 1;
      followup = 'ow you made the follow up?*';
    } else {
      followup = 'ow you made the follow up?';
    }
    feedbackLead = 'Give your feedback';
    nextFollowupDate = 'Next Follow up:';
    hinttextforLostLead = 'Select Reason:';
    hinttextforOpenLead = "Select Status:";
    print(i);
    if (i < 1) {
      print("ssssss");
      WonSave(
          followDocEntry,
          leadDocEntry,
          valueChosedStatusWon,
          mycontroller[1].text,
          isSelectedFollowUp,
          apiWonFDate,
          mycontroller[0].text);
    }
    notifyListeners();
  }

  callRequiredLost(String followDocEntry, String leadDocEntry) {
    int i = 0;
    if (mycontroller[1].text.isEmpty) {
      i = i + 1;
      feedbackLead = 'Give your feedback*';
    } else {
      feedbackLead = 'Give your feedback';
    }
    if (valueChosedReason == null) {
      i = i + 1;
      hinttextforLostLead = 'Select Reason:*';
    } else {
      hinttextforLostLead = 'Select Reason:';
    }
    if (isSelectedFollowUp == '') {
      i = i + 1;
      followup = 'How you made the follow up?*';
    } else {
      followup = 'How you made the follow up?';
    }
    hinttextforWonLead = "Select Status:";
    orderBillRefer = 'Order/Bill Reference';
    orderBillDate = 'Order/Bill Date';
    nextFollowupDate = 'Next Follow up:';
    hinttextforOpenLead = "Select Status:";
    if (i < 1) {
      lostSave(followDocEntry, leadDocEntry, valueChosedReason,
        mycontroller[1].text, isSelectedFollowUp);
    }
    notifyListeners();
  }

  validatebtnChanged() {
    if (caseStatusSelected == "Open") {
      if (leadOpenSaveClicked == true) {
        hinttextforOpenLead = "Select Status:*";
        feedbackLead = 'Give your feedback*';
        nextFollowupDate = 'Next Follow up:*';
        followup = 'How you made the follow up?*';
      } else {
        hinttextforOpenLead = "Select Status:";
        feedbackLead = 'Give your feedback';
        nextFollowupDate = 'Next Follow up:';
        followup = 'How you made the follow up?';
      }
    } else {}

    if (caseStatusSelected == "Won") {
      if (leadWonSaveClicked == true) {
        hinttextforWonLead = "Select Status:*";
        orderBillRefer = 'Order/Bill Reference*';
        followup = 'How you made the follow up?*';
      } else {
        hinttextforWonLead = "Select Status:";
        orderBillRefer = 'Order/Bill Reference';
        feedbackLead = 'Give your feedback';
        nextFollowupDate = 'Next Follow up:';
        followup = 'How you made the follow up?';
      }
      nextFD = '';
      nextWonFD = '';
    } else {}

    if (caseStatusSelected == "Lost") {
      if (leadLostSaveClicked == true) {
        feedbackLead = 'Give your feedback*';
        hinttextforLostLead = 'Select Reason:*';
        followup = 'How you made the follow up?*';
      } else {
        feedbackLead = 'Give your feedback';
        hinttextforLostLead = 'Select Reason:';
        followup = 'How you made the follow up?';
      }
      nextFD = '';
      nextWonFD = '';
    } else {}
    notifyListeners();
  }

  ///cal forwardApi
  String forwardSuccessMsg = '';
  String get getforwardSuccessMsg => forwardSuccessMsg;

  forwardApi(String followDocEntry, int salesPersonEmpId) async {
    notifyListeners();
    if (forwardnextWonFD.isEmpty) {
      //selectedUserList
      forwardNextFollowDate = 'Next FollowUp*';
      notifyListeners();
    } else {
      forwardSuccessMsg = '';
      leadLoadingdialog = true;
      ForwardLeadUserData forwardLeadUserData = new ForwardLeadUserData();
      forwardLeadUserData.curentDate = config.currentDateOnly();
      forwardLeadUserData.nextFD = apiforwardNextFollowUPDate;
      forwardLeadUserData.nextUser = salesPersonEmpId;
      await ForwardLeadUserApi.getData(followDocEntry, forwardLeadUserData)
          .then((value) {
        if (value.stCode >= 200 && value.stCode <= 210) {
          forwardSuccessMsg = 'Successfully Forwarded..!!';
          leadLoadingdialog = false;
          notifyListeners();
        } else if (value.stCode >= 400 && value.stCode <= 410) {
          forwardSuccessMsg = value.error!.message!.value!;
          leadLoadingdialog = false;
          notifyListeners();
        } else if (value.stCode == 500) {
          forwardSuccessMsg = 'Some thing went wrong try agin..!!';
          leadLoadingdialog = false;
          notifyListeners();
        }
      });
      checkValues();
    }
  }

  openSave(String followDocEntry, status, feedback, nextFPdate) async {
    forwardSuccessMsg = '';
    leadLoadingdialog = true;
    leadForwarddialog = true;
    updateFollowUpDialog = false;
    ForwardLeadUserDataOpen forwardLeadUserDataOpen =
        new ForwardLeadUserDataOpen();
    forwardLeadUserDataOpen.curentDate = config.currentDateOnly();
    forwardLeadUserDataOpen.ReasonCode = valueChosedStatus;
    forwardLeadUserDataOpen.followupMode = isSelectedFollowUp;
    forwardLeadUserDataOpen.nextFD = nextFPdate;
    forwardLeadUserDataOpen.updatedBy = ConstantValues.slpcode;
    forwardLeadUserDataOpen.feedback = feedback;
    notifyListeners();

    //OpenSaveLeadApi.printjson(followDocEntry,forwardLeadUserDataOpen);
    await OpenSaveLeadApi.getData(followDocEntry, forwardLeadUserDataOpen)
        .then((value) {
      if (value.stCode >= 200 && value.stCode <= 210) {
        forwardSuccessMsg = 'Successfully Saved..!!';
        leadLoadingdialog = false;
        notifyListeners();
      } else if (value.stCode >= 400 && value.stCode <= 410) {
        forwardSuccessMsg = value.error!.message!.value!;
        leadLoadingdialog = false;
        notifyListeners();
      } else if (value.stCode == 500) {
        forwardSuccessMsg = 'Some thing went wrong try agin..!!';
        leadLoadingdialog = false;
        notifyListeners();
      }
    });
    checkValues();
  }

  WonSave(followDocEntry, String leadDocEntry, status, feedback, followup, billwonDate, billreference) async {
    forwardSuccessMsg = '';
    leadLoadingdialog = true;
    leadForwarddialog = true;
    updateFollowUpDialog = false;
    notifyListeners();
    ForwardLeadUserDataWon forwardLeadUserDataWon =
        new ForwardLeadUserDataWon();
    forwardLeadUserDataWon.ReasonCode = status;
    forwardLeadUserDataWon.billDate = billwonDate;
    forwardLeadUserDataWon.billRef = billreference;
    forwardLeadUserDataWon.curentDate = config.currentDateOnly();
    forwardLeadUserDataWon.feedback = feedback;
    forwardLeadUserDataWon.followupMode = followup;
    forwardLeadUserDataWon.nextFD = null;
    forwardLeadUserDataWon.updatedBy = ConstantValues.slpcode;

    //WonSaveLeadApi.prinjson( followDocEntry,forwardLeadUserDataWon);
    await WonSaveLeadApi.getData(followDocEntry, forwardLeadUserDataWon)
        .then((value) {
      if (value.stCode >= 200 && value.stCode <= 210) {
        // forwardSuccessMsg = 'Successfully Saved..!!';
        // leadLoadingdialog = false;
        callCloseApi(leadDocEntry);
      } else if (value.stCode >= 400 && value.stCode <= 410) {
        forwardSuccessMsg = value.error!.message!.value!;
        leadLoadingdialog = false;
        notifyListeners();
      } else if (value.stCode == 500) {
        forwardSuccessMsg = 'Some thing went wrong try agin..!!';
        leadLoadingdialog = false;
        notifyListeners();
      }
    });
    checkValues();
  }

  lostSave(followDocEntry, String leadDocEntry, reason, feedback, followupMode) async {
    forwardSuccessMsg = '';
    leadLoadingdialog = true;
    leadForwarddialog = true;
    updateFollowUpDialog = false;
    notifyListeners();
    ForwardLeadUserDataLost forwardLeadUserDataLost =
        new ForwardLeadUserDataLost();

    forwardLeadUserDataLost.ReasonCode = reason;
    forwardLeadUserDataLost.curentDate = config.currentDateOnly();
    forwardLeadUserDataLost.feedback = feedback;
    forwardLeadUserDataLost.followupMode = followupMode;
    forwardLeadUserDataLost.nextFD = null;
    forwardLeadUserDataLost.updatedBy = ConstantValues.slpcode;

    //LostSaveLeadApi.prinjson(followDocEntry,forwardLeadUserDataLost);

    await LostSaveLeadApi.getData(followDocEntry, forwardLeadUserDataLost)
        .then((value) {
      if (value.stCode >= 200 && value.stCode <= 210) {
        // forwardSuccessMsg = 'Successfully Saved..!!';
        // leadLoadingdialog = false;
        // notifyListeners();
        callCancelApi(leadDocEntry);
      } else if (value.stCode >= 400 && value.stCode <= 410) {
        forwardSuccessMsg = value.error!.message!.value!;
        leadLoadingdialog = false;
        notifyListeners();
      } else if (value.stCode == 500) {
        forwardSuccessMsg = 'Some thing went wrong try agin..!!';
        leadLoadingdialog = false;
        notifyListeners();
      }
    });
    checkValues();
  }

  showMsgDialog() {
    forwardSuccessMsg = 'hello';
    leadLoadingdialog = true;
    leadForwarddialog = true;
    updateFollowUpDialog = false;
    notifyListeners();
  }

  callCloseApi(String leadDocEntry) async {
    await CloseLeadApi.getData(leadDocEntry).then((value) {
      if (value.stCode >= 200 && value.stCode <= 210) {
        forwardSuccessMsg = 'Successfully Saved..!!';
        leadLoadingdialog = false;
        notifyListeners();
      } else if (value.stCode >= 400 && value.stCode <= 490) {
        forwardSuccessMsg = '${value.error!.message}';
        leadLoadingdialog = false;
        notifyListeners();
      } else {
        forwardSuccessMsg = 'Something wemt wrong..!!';
        leadLoadingdialog = false;
        notifyListeners();
      }
    });
  }

  callCancelApi(String leadDocEntry) async {
    await CancelLeadApi.getData(leadDocEntry).then((value) {
      if (value.stCode >= 200 && value.stCode <= 210) {
        forwardSuccessMsg = 'Successfully Saved..!!';
        leadLoadingdialog = false;
        notifyListeners();
      } else if (value.stCode >= 400 && value.stCode <= 490) {
        forwardSuccessMsg = 'Something wemt wrong..!!';
        leadLoadingdialog = false;
        notifyListeners();
      } else {
        forwardSuccessMsg = 'Something wemt wrong..!!';
        leadLoadingdialog = false;
        notifyListeners();
      }
    });
  }

  List<GetLeadDeatilsQTHData> leadDeatilsQTHData = [];
  List<GetLeadDeatilsQTHData> get getleadDeatilsQTHData => leadDeatilsQTHData;

  List<GetLeadDeatilsQTLData> leadDeatilsQTLData = [];
  List<GetLeadDeatilsQTLData> get getleadDeatilsQTLData => leadDeatilsQTLData;

  List<GetLeadDeatilsLData> leadDeatilsLData = [];
  List<GetLeadDeatilsLData> get getleadDeatilsLeadData => leadDeatilsLData;

  callGetLeadDeatilsApi(String leadDocEnt) async {
    forwardSuccessMsg = '';
    leadLoadingdialog = true;
    leadForwarddialog = true;
    updateFollowUpDialog = false;
    notifyListeners();
    await GetLeadQTHApi.getData(leadDocEnt).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        leadDeatilsQTHData = value.leadDeatilsQTHData!;
        // forwardSuccessMsg = 'Successfully Saved..!!';
        // leadLoadingdialog = false;
        // leadForwarddialog = false;
        // updateFollowUpDialog = false;
        // viewDetailsdialog = true;
        // notifyListeners();
      } else if (value.stcode! >= 400 && value.stcode! <= 490) {
        forwardSuccessMsg = 'Something wemt wrong..!!';
        leadLoadingdialog = false;
        notifyListeners();
      } else {
        forwardSuccessMsg = 'Something wemt wrong..!!';
        leadLoadingdialog = false;
        notifyListeners();
      }
    });

    await GetLeadQTLApi.getData(leadDocEnt).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        leadDeatilsQTLData = value.leadDeatilsQTLData!;
        // forwardSuccessMsg = 'Successfully Saved..!!';
        // leadLoadingdialog = false;
        // leadForwarddialog = false;
        // updateFollowUpDialog = false;
        // viewDetailsdialog = true;
        // notifyListeners();
      } else if (value.stcode! >= 400 && value.stcode! <= 490) {
        forwardSuccessMsg = 'Something wemt wrong..!!';
        leadLoadingdialog = false;
        notifyListeners();
      } else {
        forwardSuccessMsg = 'Something wemt wrong..!!';
        leadLoadingdialog = false;
        notifyListeners();
      }
    });

    await GetLeadDetailsLApi.getData(leadDocEnt).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if(value.leadDeatilsLeadData!=null){
        leadDeatilsLData = value.leadDeatilsLeadData!;
        leadLoadingdialog = false;
        leadForwarddialog = false;
        updateFollowUpDialog = false;
        viewDetailsdialog = true;
        notifyListeners();
        }else{
           forwardSuccessMsg = 'Something wemt wrong..!!';
        leadLoadingdialog = false;
        notifyListeners();
        }
        // forwardSuccessMsg = 'Successfully Saved..!!';
      
      } else if (value.stcode! >= 400 && value.stcode! <= 490) {
        forwardSuccessMsg = 'Something wemt wrong..!!';
        leadLoadingdialog = false;
        notifyListeners();
      } else {
        forwardSuccessMsg = 'Something wemt wrong..!!';
        leadLoadingdialog = false;
        notifyListeners();
      }
    });
  }

  ///
 static int comeFromEnq = -1;
 static int isanyExcep = 0;
 static bool  isSameBranch = true;
 bool  get getisSameBranch =>isSameBranch;




  comeFromEnqApi(BuildContext context,String comeFromEnqdata) async {
    forwardSuccessMsg = '';
    leadLoadingdialog = true;
    leadForwarddialog = true;
    updateFollowUpDialog = false;
    viewDetailsdialog = false;
    notifyListeners();
    //printLogic2();
    await GetLeadQTHApi.getData(comeFromEnqdata).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
          if(value.leadDeatilsQTHData != null){
        leadDeatilsQTHData = value.leadDeatilsQTHData!;
        }else{
        isanyExcep = -2;
        forwardSuccessMsg = 'Some internal error..!!';
        leadLoadingdialog = false;
        notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 490) {
        isanyExcep = -2;
        forwardSuccessMsg = 'Something went wrong try again!!';
        leadLoadingdialog = false;
        notifyListeners();
      } else {
        isanyExcep = -2;
        forwardSuccessMsg = 'Something went wrong try again!!';
        leadLoadingdialog = false;
        notifyListeners();
      }
    });

    await GetLeadQTLApi.getData(comeFromEnqdata).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if(value.leadDeatilsQTLData != null){
        leadDeatilsQTLData = value.leadDeatilsQTLData!;
        }
         else{
           isanyExcep = -2;
           forwardSuccessMsg = 'Some internal error..!!';
           leadLoadingdialog = false;
           notifyListeners();
        } 
      } else if (value.stcode! >= 400 && value.stcode! <= 490) {
        isanyExcep = -2;
        forwardSuccessMsg = 'Something went wrong try again!!';
        leadLoadingdialog = false;
        notifyListeners();
      } else {
        isanyExcep = -2;
        forwardSuccessMsg = 'Something went wrong try again!!';
        leadLoadingdialog = false;
        notifyListeners();
      }
    });

    await GetLeadDetailsLApi.getData(comeFromEnqdata).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if(value.leadDeatilsLeadData != null){
          leadDeatilsLData = value.leadDeatilsLeadData!;
          leadLoadingdialog = false;
          leadForwarddialog = false;
          updateFollowUpDialog = false;
          viewDetailsdialog = true;
          notifyListeners();
          
        }
        else{
            isanyExcep = -2;
           forwardSuccessMsg = 'Some internal error..!!';
           leadLoadingdialog = false;
           notifyListeners();
        } 
      } else if (value.stcode! >= 400 && value.stcode! <= 490) {
          isanyExcep = -2;
        forwardSuccessMsg = 'Something went wrong try again!!';
        leadLoadingdialog = false;
        notifyListeners();
      } else {
          isanyExcep = -2;
        forwardSuccessMsg = 'Something went wrong try again!!';
        leadLoadingdialog = false;
        notifyListeners();
      }
    });
    await showLeadDeatilsDialog(context); 
    printLogic2();
  }

  mapValuesToEnq(BuildContext context){
    NewEnqController.comeFromEnq.add(leadDeatilsQTHData[0].CardCode!);
    NewEnqController.comeFromEnq.add(leadDeatilsQTHData[0].CardName!);
    NewEnqController.comeFromEnq.add(leadDeatilsQTHData[0].Address1!);
    NewEnqController.comeFromEnq.add(leadDeatilsQTHData[0].Address2!);
    NewEnqController.comeFromEnq.add(leadDeatilsQTHData[0].Pincode!);
    NewEnqController.comeFromEnq.add(leadDeatilsQTHData[0].City!);
    Navigator.pop(context);
    Get.toNamed(ConstantRoutes.newEnq);
  }

    mapValuesToLead(BuildContext context){
    LeadNewController.dataenq.add(leadDeatilsQTHData[0].CardCode!);
    LeadNewController.dataenq.add(leadDeatilsQTHData[0].CardName!);
    LeadNewController.dataenq.add(leadDeatilsQTHData[0].Address1!);
    LeadNewController.dataenq.add(leadDeatilsQTHData[0].Address2!);
    LeadNewController.dataenq.add(leadDeatilsQTHData[0].Pincode!);
    LeadNewController.dataenq.add(leadDeatilsQTHData[0].City!);
    Navigator.pop(context);
    Get.toNamed(ConstantRoutes.leads);
  }



  showLeadDeatilsDialog(BuildContext context) {
    showDialog<dynamic>(
        context: context,
        builder: (_) {
          updateFollowUpDialog = false;
          // context.read<LeadTabController>().resetValues();
          return FollowDialog(
            index: 0,
          );
        }).then((value) {
      refershAfterClosedialog();
      callGetAllApi();
      callSummaryApi();
    });
  }

  checkValues() {
    print("getupdateFollowUpDialog: " + getupdateFollowUpDialog.toString());
    print("getleadForwarddialog: " + getleadForwarddialog.toString());
    print("getleadLoadingdialog: " + getleadLoadingdialog.toString());
    print("getforwardSuccessMsg: " + getforwardSuccessMsg.toString());
  }
}


/// phone call -> Phone
/// sms/whats => Text
/// store  vist => Visit cj
/// other => Other
