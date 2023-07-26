// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sellerkit/DBHelper/DBOperation.dart';
import 'package:sqflite/sqflite.dart';
import '../../Constant/Configuration.dart';
import '../../Constant/ConstantSapValues.dart';
import '../../DBHelper/DBHelper.dart';
import '../../Models/PostQueryModel/EnquiriesModel/GetUserModel.dart';
import '../../Models/PostQueryModel/FollowUPModel.dart/FollowUPKPIModel.dart';
import '../../Models/PostQueryModel/FollowUPModel.dart/FollowUPModel.dart';
import '../../Models/PostQueryModel/LeadsCheckListModel/GetLeadStatuModel.dart';
import '../../Models/PostQueryModel/LeadsCheckListModel/LeadSavePostModel/GetLeadDetailsL.dart';
import '../../Models/PostQueryModel/LeadsCheckListModel/LeadSavePostModel/GetLeadDetailsQTHModel.dart';
import '../../Models/PostQueryModel/LeadsCheckListModel/LeadSavePostModel/GetLeadDetailsQTL.dart';
import '../../Services/PostQueryApi/FollowUPApi.dart/FollowUPKpiapi.dart';
import '../../Services/PostQueryApi/FollowUPApi.dart/FollowUPListApi.dart';
import '../../Services/PostQueryApi/LeadsApi/CancelLeadWonApi.dart';
import '../../Services/PostQueryApi/LeadsApi/CloseLeadwonApi.dart';
import '../../Services/PostQueryApi/LeadsApi/ForwardLeadUserApi.dart';
import '../../Services/PostQueryApi/LeadsApi/GetLeadDeatilsQTH.dart';
import '../../Services/PostQueryApi/LeadsApi/GetLeadDeatilsQTL.dart';
import '../../Services/PostQueryApi/LeadsApi/GetLeadDetailsL.dart';
import '../../Services/PostQueryApi/LeadsApi/LostSaveLeadApi.dart';
import '../../Services/PostQueryApi/LeadsApi/OpenSaveApi.dart';
import '../../Services/PostQueryApi/LeadsApi/WonSaveApi.dart';

class FollowupController extends ChangeNotifier{

  FollowupController(){
     callFollowUPApi();
       getDataOnLoad();
  }

  Config config = new Config();
  bool isLoading = true;
  bool get getisLoading => isLoading;

  List<GlobalKey<FormState>> formkey = List.generate(3, (i) => GlobalKey<FormState>());
  List<TextEditingController> mycontroller =  List.generate(20, (i) => TextEditingController());

  String excepMsg = '';
  String get getexcepMsg => excepMsg;

  List<FollowUPListData> fupODueListData = [];
  List<FollowUPListData> get getfupListData => fupODueListData;

  List<FollowUPListData> fupUpcmListData = [];
  List<FollowUPListData> get getfupUpcmListData => fupUpcmListData;

  List<FollowUPKPIData> followUPKPIOverDue=[];
  List<FollowUPKPIData> get getfollowUPKPIOverDue=>followUPKPIOverDue;


  callFollowUPApi() async{
  await  FollowUPListApi.getData(ConstantValues.slpcode).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.followUPListData != null) {
          mapValuesFUP((value.followUPListData!));
        } else if (value.followUPListData == null) {
          excepMsg = 'Something went wrong try again...!!';
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        excepMsg = 'Something went wrong try again...!!';
      } else if (value.stcode == 500) {
        if (value.exception == 'No route to host') {
          excepMsg = 'Check your Internet Connection...!!';
        } else {
          excepMsg = 'Something went wrong try again...!!';
        }
      }
    });

    FollowUPKPIApi.getData().then((value) {
      isLoading = false;
        if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.followUPKPIData != null) {
          followUPKPIOverDue = value.followUPKPIData!;
        } else if (value.followUPKPIData == null) {
          excepMsg = 'Something went wrong try again...!!';
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        excepMsg = 'Something went wrong try again...!!';
      } else if (value.stcode == 500) {
        if (value.exception == 'No route to host') {
          excepMsg = 'Check your Internet Connection...!!';
        } else {
          excepMsg = 'Something went wrong try again...!!';
        }
      }
      notifyListeners();
    });
  }

  clearData() {
    isLoading = true;
    excepMsg = '';
    notifyListeners();
  }

  mapValuesFUP(List<FollowUPListData> followUPListData){
    for(int i=0; i<followUPListData.length; i++){
      if(followUPListData[i].Followup_Due_Type == 'Overdue'){
        fupODueListData.add(FollowUPListData(
          FollowupDate: followUPListData[i].FollowupDate, 
          LeadDocEntry: followUPListData[i].LeadDocEntry, 
          LeadDocNum: followUPListData[i].LeadDocNum, 
          FollowupEntry: followUPListData[i].FollowupEntry, 
          Phone: followUPListData[i].Phone, Customer: followUPListData[i].Customer, 
          CretedDate: followUPListData[i].CretedDate, LastFollowupDate: followUPListData[i].LastFollowupDate, 
          DocTotal: followUPListData[i].DocTotal, Quantity: followUPListData[i].Quantity, Product: followUPListData[i].Product, 
          LastFollowupStatus: followUPListData[i].LastFollowupStatus, 
          LastFollowup_Feedback: followUPListData[i].LastFollowup_Feedback, 
          CustomerInitialIcon: followUPListData[i].CustomerInitialIcon, 
          Followup_Due_Type: followUPListData[i].Followup_Due_Type));
      }
      else if(followUPListData[i].Followup_Due_Type == 'Upcoming')
      {
        fupUpcmListData.add(
          FollowUPListData(
          FollowupDate: followUPListData[i].FollowupDate, 
          LeadDocEntry: followUPListData[i].LeadDocEntry, 
          LeadDocNum: followUPListData[i].LeadDocNum, 
          FollowupEntry: followUPListData[i].FollowupEntry, 
          Phone: followUPListData[i].Phone, Customer: followUPListData[i].Customer, 
          CretedDate: followUPListData[i].CretedDate, LastFollowupDate: followUPListData[i].LastFollowupDate, 
          DocTotal: followUPListData[i].DocTotal, Quantity: followUPListData[i].Quantity, Product: followUPListData[i].Product, 
          LastFollowupStatus: followUPListData[i].LastFollowupStatus, 
          LastFollowup_Feedback: followUPListData[i].LastFollowup_Feedback, 
          CustomerInitialIcon: followUPListData[i].CustomerInitialIcon, 
          Followup_Due_Type: followUPListData[i].Followup_Due_Type)
        );
      }
    }
  }
 

/// follow up dialog controlls
 
 bool isLodingDialog = false;
 bool get getisLodingDialog => isLodingDialog;
 String forwardDialogSuccessMsg = '';
 String get getforwardSuccessMsg => forwardDialogSuccessMsg;
 bool viewDetailsClicked = false;
 bool get getviewDetailsClicked =>viewDetailsClicked;
 bool forwardDialogClicked = false;
 bool get getforwardDialogClicked =>forwardDialogClicked;
  bool updateFrowardDialog = false;
 bool get getupdateFrowardDialog =>updateFrowardDialog;

void followUPClicked(){
  viewDetailsClicked = !viewDetailsClicked;
  notifyListeners();
 }


//view details api called

  List<GetLeadDeatilsQTHData> leadDeatilsQTHData = [];
  List<GetLeadDeatilsQTHData> get getleadDeatilsQTHData => leadDeatilsQTHData;

  List<GetLeadDeatilsQTLData> leadDeatilsQTLData = [];
  List<GetLeadDeatilsQTLData> get getleadDeatilsQTLData => leadDeatilsQTLData;

  List<GetLeadDeatilsLData> leadDeatilsLData = [];
  List<GetLeadDeatilsLData> get getleadDeatilsLeadData => leadDeatilsLData;

    callGetLeadDeatilsApi(String leadDocEnt) async {
    forwardDialogSuccessMsg = '';
    isLodingDialog = true;
    notifyListeners();
    await GetLeadQTHApi.getData(leadDocEnt).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        leadDeatilsQTHData = value.leadDeatilsQTHData!;
      } else if (value.stcode! >= 400 && value.stcode! <= 490) {
        forwardDialogSuccessMsg = 'Something wemt wrong..!!';
        isLodingDialog = false;
        notifyListeners();
      } else {
        forwardDialogSuccessMsg = 'Something wemt wrong..!!';
        isLodingDialog = false;
        notifyListeners();
      }
    });

    await GetLeadQTLApi.getData(leadDocEnt).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        leadDeatilsQTLData = value.leadDeatilsQTLData!;
      } else if (value.stcode! >= 400 && value.stcode! <= 490) {
        forwardDialogSuccessMsg = 'Something wemt wrong..!!';
        isLodingDialog = false;
        notifyListeners();
      } else {
        forwardDialogSuccessMsg = 'Something wemt wrong..!!';
        isLodingDialog = false;
        notifyListeners();
      }
    });

    await GetLeadDetailsLApi.getData(leadDocEnt).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if(value.leadDeatilsLeadData!=null){
        leadDeatilsLData = value.leadDeatilsLeadData!;
        isLodingDialog = false;
        viewDetailsClicked = true;
        notifyListeners();
        }else{
           forwardDialogSuccessMsg = 'Something wemt wrong..!!';
        isLodingDialog = false;
        notifyListeners();
        }
        // forwardSuccessMsg = 'Successfully Saved..!!';
      
      } else if (value.stcode! >= 400 && value.stcode! <= 490) {
        forwardDialogSuccessMsg = 'Something wemt wrong..!!';
        isLodingDialog = false;
        notifyListeners();
      } else {
        forwardDialogSuccessMsg = 'Something wemt wrong..!!';
        isLodingDialog = false;
        notifyListeners();
      }
    });
  } 
/// forward dialog

  String? forwardNextFollowDate = 'Next Follow Up:'; //cl
  String? get getforwardNextFollowDate => forwardNextFollowDate;
  String forwardnextWonFD = '';
  String get getforwardnextWonFD => forwardnextWonFD;
  List<UserListData> userLtData = [];
  List<UserListData> get getuserLtData => userLtData;
  String apiforwardNextFollowUPDate = '';
  String selectedUserList = '';
  String get getselectedUserList => selectedUserList;
 
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
    forwardDialogClicked = !forwardDialogClicked;
    notifyListeners();
  }

  getDataOnLoad()async{
   final Database db = (await DBHelper.getInstance())!;

    leadStatusOpen = await DBOperation.getLeadStatusOpen(db);
    leadStatusLost = await DBOperation.getLeadStatusLost(db);
    leadStatusWon = await DBOperation.getLeadStatusWon(db);
    userLtData = await DBOperation.getUserList(db);
  }

    forwardApi(String followDocEntry, int salesPersonEmpId) async {
    notifyListeners();
    if (forwardnextWonFD.isEmpty) {
      forwardNextFollowDate = 'Next FollowUp*';
      notifyListeners();
    } else {
      forwardDialogSuccessMsg = '';
      isLodingDialog = true;
      viewDetailsClicked = false;
      updateFrowardDialog = false;
      forwardDialogClicked = false;
      notifyListeners();
      ForwardLeadUserData forwardLeadUserData = new ForwardLeadUserData();
      forwardLeadUserData.curentDate = config.currentDateOnly();
      forwardLeadUserData.nextFD = apiforwardNextFollowUPDate;
      forwardLeadUserData.nextUser = salesPersonEmpId;

      //   ForwardLeadUserApi.printn(followDocEntry, forwardLeadUserData);
      // Future.delayed(Duration(seconds: 3),(){
      // forwardDialogSuccessMsg = 'Done..!!';
      // isLodingDialog = false;
      // });
      await ForwardLeadUserApi.getData(followDocEntry, forwardLeadUserData)
          .then((value) {
        if (value.stCode >= 200 && value.stCode <= 210) {
          forwardDialogSuccessMsg = 'Successfully Forwarded..!!';
          isLodingDialog = false;
          notifyListeners();
        } else if (value.stCode >= 400 && value.stCode <= 410) {
          forwardDialogSuccessMsg = value.error!.message!.value!;
          isLodingDialog = false;
          notifyListeners();
        } else if (value.stCode == 500) {
          forwardDialogSuccessMsg = 'Some thing went wrong try agin..!!';
          isLodingDialog = false;
          notifyListeners();
        }
      });
     // checkValues();
    }
  }

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


  /// update dialog won lost open
  
  String? followup = 'How you made the follow up?'; //cl How the follow up has been made
  String? get getfollowup => followup;
  String caseStatusSelected = ''; //cl
  String? get getcaseStatusSelected => caseStatusSelected;

  String isSelectedFollowUp = '';
  String get getisSelectedFollowUp => isSelectedFollowUp;

  bool leadOpenSaveClicked = false;
  bool leadWonSaveClicked = false;
  bool leadLostSaveClicked = false;

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
  String apiFDate = '';
  String nextFD = '';
  String nextWonFD = '';
  String get getnextFD => nextFD;

  String? valueChosedReason; //cl
  String? get getvalueChosedReason => valueChosedReason;
  String? valueChosedStatus; //cl
  String? get getvalueChosedStatus => valueChosedStatus;
  String? valueChosedStatusWon; //cl
  String? get getvalueChosedStatusWon => valueChosedStatusWon;

  List<GetLeadStatusData> leadStatusOpen = [];
  List<GetLeadStatusData> leadStatusLost = [];
  List<GetLeadStatusData> leadStatusWon = [];
  List<GetLeadStatusData> get getleadStatusOpen => leadStatusOpen;
  List<GetLeadStatusData> get getleadStatusLost => leadStatusLost;
  List<GetLeadStatusData> get getleadStatusWon => leadStatusWon;

    changetoFolloweUp() {
    updateFrowardDialog = true;
    notifyListeners();
  }

  selectFollowUp(String selected) {
    isSelectedFollowUp = selected;
    notifyListeners();
  }

   caseStatusSelectBtn(String val) {
    caseStatusSelected = val;
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

    String apiWonFDate = '';
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

    clickLeadSaveBtn(String followDocEntry, String leadDocEntry) {
    if (caseStatusSelected == 'Open') {
      leadOpenSaveClicked = true;
      leadWonSaveClicked = false;
      leadLostSaveClicked = false;
    
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
    lostSave(followDocEntry, leadDocEntry, valueChosedReason,mycontroller[1].text, isSelectedFollowUp);
    }
    notifyListeners();
  }

    openSave(String followDocEntry, status, feedback, nextFPdate) async {
    forwardDialogSuccessMsg = '';
      isLodingDialog = true;
      viewDetailsClicked = false;
      updateFrowardDialog = false;
      forwardDialogClicked = false;
      notifyListeners();
    ForwardLeadUserDataOpen forwardLeadUserDataOpen =
        new ForwardLeadUserDataOpen();
    forwardLeadUserDataOpen.curentDate = config.currentDateOnly();
    forwardLeadUserDataOpen.ReasonCode = valueChosedStatus;
    forwardLeadUserDataOpen.followupMode = isSelectedFollowUp;
    forwardLeadUserDataOpen.nextFD = nextFPdate;
    forwardLeadUserDataOpen.updatedBy = ConstantValues.slpcode;
    forwardLeadUserDataOpen.feedback = feedback;
    notifyListeners();
    // OpenSaveLeadApi.printjson(followDocEntry, forwardLeadUserDataOpen);

    // Future.delayed(Duration(seconds: 3),(){
    //      forwardDialogSuccessMsg = 'Done..!!';
    //   isLodingDialog = false;
    //   viewDetailsClicked = false;
    //   updateFrowardDialog = false;
    //   forwardDialogClicked = false;
    // });
    await OpenSaveLeadApi.getData(followDocEntry, forwardLeadUserDataOpen)
        .then((value) {
      if (value.stCode >= 200 && value.stCode <= 210) {
        forwardDialogSuccessMsg = 'Successfully Saved..!!';
      isLodingDialog = false;
        notifyListeners();
      } else if (value.stCode >= 400 && value.stCode <= 410) {
        forwardDialogSuccessMsg = value.error!.message!.value!;
        isLodingDialog = false;
        notifyListeners();
      } else if (value.stCode == 500) {
        forwardDialogSuccessMsg = 'Some thing went wrong try agin..!!';
        isLodingDialog = false;
        notifyListeners();
      }
    });
  }


   WonSave(followDocEntry, String leadDocEntry, status, feedback, followup, billwonDate, billreference) async {
     forwardDialogSuccessMsg = '';
      isLodingDialog = true;
      viewDetailsClicked = false;
      updateFrowardDialog = false;
      forwardDialogClicked = false;
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

   // WonSaveLeadApi.prinjson( followDocEntry,forwardLeadUserDataWon);
    await WonSaveLeadApi.getData(followDocEntry, forwardLeadUserDataWon)
        .then((value) {
      if (value.stCode >= 200 && value.stCode <= 210) {
        callCloseApi(leadDocEntry);
      } else if (value.stCode >= 400 && value.stCode <= 410) {
        forwardDialogSuccessMsg = value.error!.message!.value!;
        isLodingDialog = false;
        notifyListeners();
      } else if (value.stCode == 500) {
        forwardDialogSuccessMsg = 'Some thing went wrong try agin..!!';
        isLodingDialog = false;
        notifyListeners();
      }
    });
  }

   lostSave(followDocEntry, String leadDocEntry, reason, feedback, followupMode) async {
    forwardDialogSuccessMsg = '';
      isLodingDialog = true;
      viewDetailsClicked = false;
      updateFrowardDialog = false;
      forwardDialogClicked = false;
      notifyListeners();
    ForwardLeadUserDataLost forwardLeadUserDataLost =
        new ForwardLeadUserDataLost();

    forwardLeadUserDataLost.ReasonCode = reason;
    forwardLeadUserDataLost.curentDate = config.currentDateOnly();
    forwardLeadUserDataLost.feedback = feedback;
    forwardLeadUserDataLost.followupMode = followupMode;
    forwardLeadUserDataLost.nextFD = null;
    forwardLeadUserDataLost.updatedBy = ConstantValues.slpcode;

   // LostSaveLeadApi.prinjson(followDocEntry,forwardLeadUserDataLost);
    await LostSaveLeadApi.getData(followDocEntry, forwardLeadUserDataLost)
        .then((value) {
      if (value.stCode >= 200 && value.stCode <= 210) {
        callCancelApi(leadDocEntry);
      } else if (value.stCode >= 400 && value.stCode <= 410) {
        forwardDialogSuccessMsg = value.error!.message!.value!;
        isLodingDialog = false;
        notifyListeners();
      } else if (value.stCode == 500) {
        forwardDialogSuccessMsg = 'Some thing went wrong try agin..!!';
        isLodingDialog = false;
        notifyListeners();
      }
    });
  }


    callCloseApi(String leadDocEntry) async {
    await CloseLeadApi.getData(leadDocEntry).then((value) {
      if (value.stCode >= 200 && value.stCode <= 210) {
        forwardDialogSuccessMsg = 'Successfully Saved..!!';
        isLodingDialog = false;
        notifyListeners();
      } else if (value.stCode >= 400 && value.stCode <= 490) {
        forwardDialogSuccessMsg = '${value.error!.message}';
        isLodingDialog = false;
        notifyListeners();
      } else {
        forwardDialogSuccessMsg = 'Something wemt wrong..!!';
        isLodingDialog = false;
        notifyListeners();
      }
    });
  }

  callCancelApi(String leadDocEntry) async {
    await CancelLeadApi.getData(leadDocEntry).then((value) {
      if (value.stCode >= 200 && value.stCode <= 210) {
        forwardDialogSuccessMsg = 'Successfully Saved..!!';
        isLodingDialog = false;
        notifyListeners();
      } else if (value.stCode >= 400 && value.stCode <= 490) {
        forwardDialogSuccessMsg = 'Something wemt wrong..!!';
        isLodingDialog = false;
        notifyListeners();
      } else {
        forwardDialogSuccessMsg = 'Something wemt wrong..!!';
        isLodingDialog = false;
        notifyListeners();
      }
    });
  }

}