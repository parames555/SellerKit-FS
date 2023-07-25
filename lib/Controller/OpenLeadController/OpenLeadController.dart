// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_const_constructors, non_constant_identifier_names

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/DBHelper/DBHelper.dart';
import 'package:sellerkit/Models/StockModels/GetDataModel.dart';
import 'package:sqflite/sqflite.dart';

import '../../Constant/ConstantSapValues.dart';
import '../../DBHelper/DBOperation.dart';
import '../../Models/OpenLeadFilterModel/OpenLeadFilterModel.dart';
import '../../Models/OpenLeadModel.dart/OpenLeadModel.dart';
import '../../Models/PostQueryModel/EnquiriesModel/GetUserModel.dart';
import '../../Models/PostQueryModel/LeadsCheckListModel/GetLeadStatuModel.dart';
import '../../Models/PostQueryModel/LeadsCheckListModel/LeadSavePostModel/GetLeadDetailsL.dart';
import '../../Models/PostQueryModel/LeadsCheckListModel/LeadSavePostModel/GetLeadDetailsQTHModel.dart';
import '../../Models/PostQueryModel/LeadsCheckListModel/LeadSavePostModel/GetLeadDetailsQTL.dart';
import '../../Services/OpenLeadApi/OpenLeadApi.dart';
import '../../Services/PostQueryApi/LeadsApi/CancelLeadWonApi.dart';
import '../../Services/PostQueryApi/LeadsApi/CloseLeadwonApi.dart';
import '../../Services/PostQueryApi/LeadsApi/ForwardLeadUserApi.dart';
import '../../Services/PostQueryApi/LeadsApi/GetLeadDeatilsQTH.dart';
import '../../Services/PostQueryApi/LeadsApi/GetLeadDeatilsQTL.dart';
import '../../Services/PostQueryApi/LeadsApi/GetLeadDetailsL.dart';
import '../../Services/PostQueryApi/LeadsApi/LostSaveLeadApi.dart';
import '../../Services/PostQueryApi/LeadsApi/OpenSaveApi.dart';
import '../../Services/PostQueryApi/LeadsApi/WonSaveApi.dart';

class OpenLeadController extends ChangeNotifier {
  OpenLeadController() {
    callApi();
    getDataOnLoad();
  }
  Config config = Config();
  List<OpenLeadData> openLeadData = [];
  List<OpenLeadData> get getOpenLeadData => openLeadData;

  List<OpenLeadData> openLeadDataF = [];
  List<OpenLeadData> get getOpenLeadDataF => openLeadDataF;

  List<OpenLeadData> filterOpLD = [];
  List<OpenLeadData> get getfilterOpLD => filterOpLD;

  GlobalKey<FormState> searchKey = GlobalKey<FormState>();
  TextEditingController searchcon = TextEditingController();
  List<GlobalKey<FormState>> formkey =
      List.generate(5, (i) => GlobalKey<FormState>());
  List<TextEditingController> mycontroller =
      List.generate(20, (i) => TextEditingController());

  String errorMsg = '';
  String get geterrorMsg => errorMsg;

  int pageChanged = 0;
  PageController pageController = PageController(initialPage: 0);
  clearAllData() async {
    brandData.clear();
    groupProperty.clear();
    groupSegment.clear();
    DivisionData.clear();
    BranchData.clear();
    salesExecutiveData.clear();
    branchManagerData.clear();
    RegionalManagerData.clear();
    notifyListeners();
  }

  List<DistinctColumn> brandData = [];
  List<DistinctColumn> get getBrandData => brandData;
  List<DistinctColumn> groupProperty = [];
  List<DistinctColumn> get getGroupProperty => groupProperty;
  List<DistinctColumn> groupSegment = [];
  List<DistinctColumn> get getgroupSegment => groupSegment;
  List<DistinctColumn> DivisionData = [];
  List<DistinctColumn> get getDivisionData => DivisionData;
  List<DistinctColumn> BranchData = [];
  List<DistinctColumn> get getBranchData => BranchData;
  List<DistinctColumn> salesExecutiveData = [];
  List<DistinctColumn> get getsalesExecutiveData => salesExecutiveData;
  List<DistinctColumn> branchManagerData = [];
  List<DistinctColumn> get getbranchManagerData => branchManagerData;
  List<DistinctColumn> RegionalManagerData = [];
  List<DistinctColumn> get getRegionalManager => RegionalManagerData;
  List<DistinctColumn> viewData = [];
  List<DistinctColumn> get getviewData => viewData;

  callApi() async {
    await OpenLeadApi.getOfferZone().then((value) async {
       final Database db = (await DBHelper.getInstance())!;

      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.openLeadData != null) {
          log("message ${value.openLeadData![0].Branch}");
          openLeadData = value.openLeadData!;
          openLeadDataF = openLeadData;
          await DBOperation.truncateOpenLead(db);
          await DBOperation.insertOpenLead(openLeadData,db).then((value) {
               errorMsg = "";
            notifyListeners();
          });
         // await DBOperation.runQuery(db).then((value) {
         
         // });
        } else if (value.openLeadData == null) {
          errorMsg = "No data found..!!";
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        errorMsg = "Something went wrong..!!";
        notifyListeners();
      } else if (value.stcode == 500) {
        errorMsg = "Something went wrong..!!";
        notifyListeners();
      }
    });
  }

  getviewAll(String colname) async {
    viewData.clear();
       final Database db = (await DBHelper.getInstance())!;

    await DBOperation.getOpenLFtr("$colname",db).then((value) {
      for (int i = 0; i < value.length; i++) {
        viewData.add(DistinctColumn(
            discColumn: value[i]['$colname'].toString(), color: 0));
        notifyListeners();
      }
      secondPageNextBtn();
    });
  }

  bool clearbtn = false;
  getDistinct() async {
    await clearAllData();
       final Database db = (await DBHelper.getInstance())!;

    List<Map<String, Object?>> brandDB = await DBOperation.getOpenLFtr("Brand",db);
    List<Map<String, Object?>> GroupProperty =
        await DBOperation.getOpenLFtr("GroupProperty",db);
    List<Map<String, Object?>> GroupSegment =
        await DBOperation.getOpenLFtr("GroupSegment",db);
    List<Map<String, Object?>> Division =
        await DBOperation.getOpenLFtr("Division",db);
    List<Map<String, Object?>> SalesExecutive =
        await DBOperation.getOpenLFtr("SalesExecutive",db);
    List<Map<String, Object?>> BranchManager =
        await DBOperation.getOpenLFtr("BranchManager",db);
    List<Map<String, Object?>> RegionalManager =
        await DBOperation.getOpenLFtr("RegionalManager",db);
    List<Map<String, Object?>> Branch = await DBOperation.getOpenLFtr("Branch",db);

    await dataget(brandDB, GroupProperty, GroupSegment, Division,
        SalesExecutive, RegionalManager, Branch, BranchManager);
    clearbtn = false;
    notifyListeners();
  }

  Future<void> dataget(
      List<Map<String, Object?>> brandDB,
      GroupProperty,
      GroupSegment,
      Division,
      SalesExecutive,
      RegionalManager,
      Branch,
      BranchManager) async {
    log("brandData ${brandData.length}");
    for (int i = 0; i < brandDB.length; i++) {
      brandData.add(
          DistinctColumn(discColumn: brandDB[i]['Brand'].toString(), color: 0));
      notifyListeners();
    }

    for (int i = 0; i < GroupProperty.length; i++) {
      groupProperty.add(DistinctColumn(
          discColumn: GroupProperty[i]['GroupProperty'].toString(), color: 0));
      notifyListeners();
    }

    for (int i = 0; i < GroupSegment.length; i++) {
      groupSegment.add(DistinctColumn(
          discColumn: GroupSegment[i]['GroupSegment'].toString(), color: 0));
      notifyListeners();
    }

    for (int i = 0; i < Division.length; i++) {
      DivisionData.add(DistinctColumn(
          discColumn: Division[i]['Division'].toString(), color: 0));
      notifyListeners();
    }

    for (int i = 0; i < Branch.length; i++) {
      BranchData.add(
          DistinctColumn(discColumn: Branch[i]['Branch'].toString(), color: 0));
      notifyListeners();
    }

    for (int i = 0; i < SalesExecutive.length; i++) {
      salesExecutiveData.add(DistinctColumn(
          discColumn: SalesExecutive[i]['SalesExecutive'].toString(),
          color: 0));
      notifyListeners();
    }

    for (int i = 0; i < BranchManager.length; i++) {
      branchManagerData.add(DistinctColumn(
          discColumn: BranchManager[i]['BranchManager'].toString(), color: 0));
      notifyListeners();
    }

    for (int i = 0; i < RegionalManager.length; i++) {
      RegionalManagerData.add(DistinctColumn(
          discColumn: RegionalManager[i]['RegionalManager'].toString(),
          color: 0));
      notifyListeners();
    }
    notifyListeners();
  }

  firstPageNextBtn() {
    log("pageChanged: ${pageChanged}");
    if (pageChanged == 0) {
      pageController.animateToPage(++pageChanged,
          duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
    }
    notifyListeners();
  }

  secondPageNextBtn() {
    log("pageChanged: ${pageChanged}");
    if (pageChanged == 1) {
      pageController.animateToPage(++pageChanged,
          duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
    }
    notifyListeners();
  }

  viewBack() {
    log("pageChanged: ${pageChanged}");
    if (pageChanged == 2) {
      pageController.animateToPage(--pageChanged,
          duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
    }
    notifyListeners();
  }

  searchBack() {
    log("pageChanged: ${pageChanged}");
    if (pageChanged == 1) {
      pageController.animateToPage(--pageChanged,
          duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
    }
    notifyListeners();
  }

  DateTime? currentBackPressTime;
  Future<bool> onbackpress() {
    DateTime now = DateTime.now();
    // if (currentBackPressTime == null ||
    //     now.difference(currentBackPressTime!) > Duration(seconds: 1)) {
    //   currentBackPressTime = now;

    if (pageChanged == 1) {
      pageController.animateToPage(--pageChanged,
          duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
    } else if (pageChanged == 2) {
      pageController.animateToPage(--pageChanged,
          duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
    } else if (pageChanged == 0) {
      return Future.value(true);
    }
    //  }
    return Future.value(false);
  }

  /// function with filter in db

  isselectedViewAll(int i) {
    if (viewData[i].color == 0) {
      viewData[i].color = 1;
    } else {
      viewData[i].color = 0;
    }
    notifyListeners();
  }

//barnd
  List<String> isselectedbrand = [];
  List<String> isselectedBrandString = [];
  List<String> selectstringbarndsw = [];

  isselectedBrand(int i) {
    if (brandData[i].color == 0) {
      brandData[i].color = 1;
      addBrand(brandData[i].discColumn!);
    } else {
      brandData[i].color = 0;
      removeBrand(brandData[i].discColumn!);
    }
    notifyListeners();
  }

  addBrand(String brand) {
    isselectedbrand.add("'$brand'");
    print("Brand: " + isselectedbrand.toString());
    getValuesFromDB();
  }

  removeBrand(String brand) {
    isselectedbrand.remove("'$brand'");
       isselectedBrandString.remove("'$brand'");
        selectstringbarndsw.remove(brand);
    getValuesFromDB();
  }

  Future<String> chkSlctdValBrand() {
    isselectedBrandString.clear();
    selectstringbarndsw.clear();
    for (int i = 0; i < brandData.length; i++) {
      if (brandData[i].color == 1) {
        isselectedBrandString.add("'${brandData[i].discColumn}'");
        selectstringbarndsw.add(brandData[i].discColumn!);
      }
    }
    String text = isselectedBrandString
        .toString()
        .replaceAll("[", "")
        .replaceAll("]", "");
    return Future.value(text);
  }

  //hropPrprty
  List<String> isselectedGropProp = [];
  List<String> isselectedGropPropString = [];
  List<String> selectstringGropPropsw = [];

  isselectedGropPropM(int i) {
    if (groupProperty[i].color == 0) {
      groupProperty[i].color = 1;
      addGropProp(groupProperty[i].discColumn!);
    } else {
      groupProperty[i].color = 0;
      removeGropProp(groupProperty[i].discColumn!);
    }
    notifyListeners();
  }

  addGropProp(String brand) {
    isselectedGropProp.add("'$brand'");
    print("isselectedGropProp: " + isselectedGropProp.toString());
    getValuesFromDB();
  }

  removeGropProp(String brand) {
    isselectedGropProp.remove("'$brand'");
      isselectedGropPropString.remove("'$brand'");
        selectstringGropPropsw.remove(brand);
    getValuesFromDB();
  }

  Future<String> chkSlctdValGropProp() {
    isselectedGropPropString.clear();
    selectstringGropPropsw.clear();
    for (int i = 0; i < groupProperty.length; i++) {
      if (groupProperty[i].color == 1) {
        isselectedGropPropString.add("'${groupProperty[i].discColumn}'");
        selectstringGropPropsw.add(groupProperty[i].discColumn!);
      }
    }
    String text = isselectedGropPropString
        .toString()
        .replaceAll("[", "")
        .replaceAll("]", "");
    return Future.value(text);
  }

  //grpseg
  List<String> isselectedGropSegmt = [];
  List<String> isselectedGropSegmtString = [];
  List<String> selectstringGropSegmtsw = [];

  isselectedGropSegmtM(int i) {
    if (groupSegment[i].color == 0) {
      groupSegment[i].color = 1;
      addGropSegmt(groupSegment[i].discColumn!);
    } else {
      groupSegment[i].color = 0;
      removeGropSegmt(groupSegment[i].discColumn!);
    }
    notifyListeners();
  }

  addGropSegmt(String brand) {
    isselectedGropSegmt.add("'$brand'");
    print("isselectedGropSegmt: " + isselectedGropSegmt.toString());
    getValuesFromDB();
  }

  removeGropSegmt(String brand) {
    isselectedGropSegmt.remove("'$brand'");
      isselectedGropSegmtString.remove("'$brand'");
        selectstringGropSegmtsw.remove(brand);
    getValuesFromDB();
  }

  Future<String> chkSlctdValGropSegmt() {
    isselectedGropSegmtString.clear();
    selectstringGropSegmtsw.clear();
    for (int i = 0; i < groupSegment.length; i++) {
      if (groupSegment[i].color == 1) {
        isselectedGropSegmtString.add("'${groupSegment[i].discColumn}'");
        selectstringGropSegmtsw.add(groupSegment[i].discColumn!);
      }
    }
    String text = isselectedGropSegmtString
        .toString()
        .replaceAll("[", "")
        .replaceAll("]", "");
    return Future.value(text);
  }

  //DivisionData
  List<String> isselectedDivision = [];
  List<String> isselectedDivisionString = [];
  List<String> selectstringDivisionsw = [];

  isselectedDivisionM(int i) {
    if (DivisionData[i].color == 0) {
      DivisionData[i].color = 1;
      addDivision(DivisionData[i].discColumn!);
    } else {
      DivisionData[i].color = 0;
      removeDivision(DivisionData[i].discColumn!);
    }
    notifyListeners();
  }

  addDivision(String brand) {
    isselectedDivision.add("'$brand'");
    print("isselectedDivision: " + isselectedDivision.toString());
    getValuesFromDB();
  }

  removeDivision(String brand) {
    isselectedDivision.remove("'$brand'");
  isselectedDivisionString.remove("'$brand'");
        selectstringDivisionsw.remove(brand);
    getValuesFromDB();
  }

  Future<String> chkSlctdValDivision() {
    isselectedDivisionString.clear();
     selectstringDivisionsw.clear();
    for (int i = 0; i < DivisionData.length; i++) {
      if (DivisionData[i].color == 1) {
        isselectedDivisionString.add("'${DivisionData[i].discColumn}'");
        selectstringDivisionsw.add(DivisionData[i].discColumn!);
      }
    }
    String text = isselectedDivisionString
        .toString()
        .replaceAll("[", "")
        .replaceAll("]", "");
    return Future.value(text);
  }

  //Brancjhh
  List<String> isselectedBranch = [];
  List<String> isselectedBranchString = [];
  List<String> isselectedBranchStringsw = [];

  isselectedBranchM(int i) {
    if (BranchData[i].color == 0) {
      BranchData[i].color = 1;
      addBranch(BranchData[i].discColumn!);
    } else {
      BranchData[i].color = 0;
      removeBranch(BranchData[i].discColumn!);
    }
    notifyListeners();
  }

  addBranch(String brand) {
    isselectedBranch.add("'$brand'");
    getValuesFromDB();
  }

  removeBranch(String brand) {
    isselectedBranch.remove("'$brand'");
    isselectedBranchString.remove("'$brand'");
    isselectedBranchStringsw.remove(brand);
    getValuesFromDB();
  }

  Future<String> chkSlctdValBranch() {
    isselectedBranchString.clear();
    isselectedBranchStringsw.clear();
    for (int i = 0; i < BranchData.length; i++) {
      if (BranchData[i].color == 1) {
        isselectedBranchString.add("'${BranchData[i].discColumn}'");
        isselectedBranchStringsw.add(BranchData[i].discColumn!);
      }
    }
    String text = isselectedBranchString
        .toString()
        .replaceAll("[", "")
        .replaceAll("]", "");
    return Future.value(text);
  }

  //Sales Ecet
  List<String> isselectedSalesExe = [];
  List<String> isselectedSalesExeString = [];
  List<String> isselectedSalesExeStringsw = [];

  isselectedSalesExeM(int i) {
    if (salesExecutiveData[i].color == 0) {
      salesExecutiveData[i].color = 1;
      addSalesExe(salesExecutiveData[i].discColumn!);
    } else {
      salesExecutiveData[i].color = 0;
      removeSalesExe(salesExecutiveData[i].discColumn!);
    }
    notifyListeners();
  }

  addSalesExe(String brand) {
    isselectedSalesExe.add("'$brand'");
    getValuesFromDB();
  }

  removeSalesExe(String brand) {
    isselectedSalesExe.remove("'$brand'");
     isselectedSalesExeString.remove("'$brand'");
        isselectedSalesExeStringsw.remove(brand);
    getValuesFromDB();
  }

  Future<String> chkSlctdValSalesExe() {
    isselectedSalesExeString.clear();
    isselectedSalesExeStringsw.clear();
    for (int i = 0; i < salesExecutiveData.length; i++) {
      if (salesExecutiveData[i].color == 1) {
        isselectedSalesExeString.add("'${salesExecutiveData[i].discColumn}'");
        isselectedSalesExeStringsw.add(salesExecutiveData[i].discColumn!);
      }
    }
    String text = isselectedSalesExeString
        .toString()
        .replaceAll("[", "")
        .replaceAll("]", "");
    return Future.value(text);
  }

  //branchmanag
  List<String> isselectedBrnMag = [];
  List<String> isselectedBrnMagString = [];
  List<String> isselectedBrnMagStringsw = [];

  isselectedBrnMagM(int i) {
    if (branchManagerData[i].color == 0) {
      branchManagerData[i].color = 1;
      addBrnMag(branchManagerData[i].discColumn!);
    } else {
      branchManagerData[i].color = 0;
      removeBrnMag(branchManagerData[i].discColumn!);
    }
    notifyListeners();
  }

  addBrnMag(String brand) {
    isselectedBrnMag.add("'$brand'");
    getValuesFromDB();
  }

  removeBrnMag(String brand) {
    isselectedBrnMag.remove("'$brand'");
    isselectedBrnMagString.remove("'$brand'");
        isselectedBrnMagStringsw.remove(brand);
    getValuesFromDB();
  }

  Future<String> chkSlctdValBrnMag() {
    isselectedBrnMagString.clear();
     isselectedBrnMagStringsw.clear();
    for (int i = 0; i < branchManagerData.length; i++) {
      if (branchManagerData[i].color == 1) {
        isselectedBrnMagString.add("'${branchManagerData[i].discColumn}'");
        isselectedBrnMagStringsw.add(branchManagerData[i].discColumn!);
      }
    }
    String text = isselectedBrnMagString
        .toString()
        .replaceAll("[", "")
        .replaceAll("]", "");
    return Future.value(text);
  }

  //REgmanag
  List<String> isselectedRegMag = [];
  List<String> isselectedRegMagString = [];
  List<String> isselectedRegMagStringsw = [];

  Future isselectedRegMagM(int i) async {
    if (RegionalManagerData[i].color == 0) {
      RegionalManagerData[i].color = 1;
      addRegMag(RegionalManagerData[i].discColumn!);
    } else {
      RegionalManagerData[i].color = 0;
      removeRegMag(RegionalManagerData[i].discColumn!);
    }
    notifyListeners();
  }

  Future addRegMag(String brand) async {
    isselectedRegMag.add("'$brand'");
    await getValuesFromDB();
  }

  Future removeRegMag(String brand) async {
    isselectedRegMag.remove("'$brand'");
    isselectedRegMagString.remove("'$brand'");
    isselectedRegMagStringsw.remove(brand);
    await getValuesFromDB();
  }

  Future<String> chkSlctdValRegMag() async {
    isselectedRegMagString.clear();
     isselectedRegMagStringsw.clear();
    for (int i = 0; i < RegionalManagerData.length; i++) {
      if (RegionalManagerData[i].color == 1) {
        isselectedRegMagString.add("'${RegionalManagerData[i].discColumn}'");
        isselectedRegMagStringsw.add(RegionalManagerData[i].discColumn!);
      }
    }
    // if(RegionalManagerData.isEmpty){
    //   isselectedRegMagString.clear();
    //   isselectedRegMagStringsw.clear();
    // }
    String text = isselectedRegMagString
        .toString()
        .replaceAll("[", "")
        .replaceAll("]", "");
    return Future.value(text);
  }

  Future getValuesFromDB() async {
       final Database db = (await DBHelper.getInstance())!;

    String brand = await chkSlctdValBrand();
    String grpProp = await chkSlctdValGropProp();
    String grpseg = await chkSlctdValGropSegmt();
    String division = await chkSlctdValDivision();
    String branch = await chkSlctdValBranch();
    String salesExe = await chkSlctdValSalesExe();
    String branhmag = await chkSlctdValBrnMag();
    String reginmanag = await chkSlctdValRegMag();

    await DBOperation
        .onFilteredOpenLead(
      brand.isEmpty ? "''" : brand,
      grpProp.isEmpty ? "''" : grpProp,
      grpseg.isEmpty ? "''" : grpseg,
      division.isEmpty ? "''" : division,
      branch.isEmpty ? "''" : branch,
      salesExe.isEmpty ? "''" : salesExe,
      branhmag.isEmpty ? "''" : branhmag,
      reginmanag.isEmpty ? "''" : reginmanag,
      brand.isEmpty ? '' : "1",
      grpProp.isEmpty ? '' : "1",
      grpseg.isEmpty ? '' : "1",
      division.isEmpty ? '' : "1",
      branch.isEmpty ? '' : "1",
      salesExe.isEmpty ? '' : "1",
      branhmag.isEmpty ? '' : "1",
      reginmanag.isEmpty ? '' : "1",
      db
    )
        .then((value) async {
      openLeadDataF = value;
      brandData.clear();
      groupProperty.clear();
      groupSegment.clear();
      branchManagerData.clear();
      DivisionData.clear();
      BranchData.clear();
      salesExecutiveData.clear();
      RegionalManagerData.clear();
      brandData = await distinctBrand(value);
      groupProperty = await distinctgropProperty(value);
      groupSegment = await distinctgropSegment(value);
      DivisionData = await distinctDivision(value);
      BranchData = await distinctBranch(value);
      salesExecutiveData = await distinctsalesExecutiveData(value);
      branchManagerData = await distinctBchMang(value);
      RegionalManagerData = await distinctRegMang(value);
      notifyListeners();
    });

    notifyListeners();
  }

  // clear all Data
  Future clearAllDataSelect() async {
    clearbtn == true;
    isselectedbrand.clear();
    isselectedBrandString.clear();
    selectstringbarndsw.clear();
    isselectedGropProp.clear();
    isselectedGropPropString.clear();
    selectstringGropPropsw.clear();
    isselectedGropSegmt.clear();
    isselectedGropSegmtString.clear();
    selectstringGropSegmtsw.clear();
    isselectedDivision.clear();
    isselectedDivisionString.clear();
    selectstringDivisionsw.clear();
    isselectedBranch.clear();
    isselectedBranchString.clear();
    isselectedBranchStringsw.clear();
    isselectedSalesExe.clear();
    isselectedSalesExeString.clear();
    isselectedSalesExeStringsw.clear();
    isselectedBrnMag.clear();
    isselectedBrnMagString.clear();
    isselectedBrnMagStringsw.clear();
    isselectedRegMag.clear();
    isselectedRegMagString.clear();
    isselectedRegMagStringsw.clear();
    brandData.clear();
    groupProperty.clear();
    groupSegment.clear();
    branchManagerData.clear();
    DivisionData.clear();
    BranchData.clear();
    salesExecutiveData.clear();
    RegionalManagerData.clear();
    viewData.clear();
    openLeadDataF = openLeadData;
    await falseAllView();
    await getDistinct();
  }

  falseAllView() async {
    isbrandViewclick = false;
    isgrpPropViewclick = false;
    isgrpSegmViewclick = false;
    isDivisViewclick = false;
    isBrnchViewclick = false;
    isBrnchMangViewclick = false;
    isSalesExecViewclick = false;
    isReginlMangViewclick = false;
  }

  viewListOpnLead() async {
    if (pageChanged == 1) {
      pageController.animateToPage(--pageChanged,
          duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
    }
    notifyListeners();
  }

  Future<List<DistinctColumn>> distinctBrand(List<OpenLeadData> value) async {
    List<DistinctColumn> brand = [];
    var branddata = value.map((e) => e.Brand).toSet().toList();
    for (int i = 0; i < branddata.length; i++) {
      for (int j = 0; j < selectstringbarndsw.length; j++) {
        if (branddata[i] == selectstringbarndsw[j]) {
          brand.add(
              DistinctColumn(discColumn: selectstringbarndsw[j], color: 1));
        }
      }
    }
     if (brand.isEmpty) {
      for (int i = 0; i < branddata.length; i++) {
        if (branddata[i]!.isNotEmpty) {
          brand.add(
                DistinctColumn(discColumn: branddata[i], color: 0));
        }
      }
    }
    return brand;
  }

  Future<List<DistinctColumn>> distinctgropProperty(
      List<OpenLeadData> value) async {
    List<DistinctColumn> gropProperty = [];
    var grpProperty = value.map((e) => e.GroupProperty).toSet().toList();
    for (int i = 0; i < grpProperty.length; i++) {
      for (int j = 0; j < selectstringGropPropsw.length; j++) {
        if (grpProperty[i] == selectstringGropPropsw[j]) {
          gropProperty.add(
              DistinctColumn(discColumn: selectstringGropPropsw[j], color: 1));
        }
      }
    }
    if (gropProperty.isEmpty) {
      for (int i = 0; i < grpProperty.length; i++) {
        if (grpProperty[i]!.isNotEmpty) {
          gropProperty.add(
                DistinctColumn(discColumn: grpProperty[i], color: 0));
        }
      }
    }
    return gropProperty;
  }

  Future<List<DistinctColumn>> distinctgropSegment(
      List<OpenLeadData> value) async {
    List<DistinctColumn> gropSegment = [];
    var grpSegment = value.map((e) => e.GroupSegment).toSet().toList();
    for (int i = 0; i < grpSegment.length; i++) {
      for (int j = 0; j < selectstringGropSegmtsw.length; j++) {
        if (grpSegment[i] == selectstringGropSegmtsw[j]) {
          gropSegment.add(
              DistinctColumn(discColumn: selectstringGropSegmtsw[j], color: 1));
        }
      }
    }
    if (gropSegment.isEmpty) {
      for (int i = 0; i < grpSegment.length; i++) {
        if (grpSegment[i]!.isNotEmpty) {
          gropSegment.add(
                DistinctColumn(discColumn: grpSegment[i], color: 0));
        }
      }
    }
    return gropSegment;
  }

  Future<List<DistinctColumn>> distinctBchMang(List<OpenLeadData> value) async {
    List<DistinctColumn> branchMager = [];
    var disBM = value.map((e) => e.BranchManager).toSet().toList();
    for (int i = 0; i < disBM.length; i++) {
      for (int j = 0; j < isselectedBrnMagStringsw.length; j++) {
        if (disBM[i] == isselectedBrnMagStringsw[j]) {
          branchMager.add(DistinctColumn(
              discColumn: isselectedBrnMagStringsw[j], color: 1));
        }
      }
    }
      if (branchMager.isEmpty) {
      for (int i = 0; i < disBM.length; i++) {
        if (disBM[i]!.isNotEmpty) {
          branchMager.add(
                DistinctColumn(discColumn: disBM[i], color: 0));
        }
      }
    }
    return branchMager;
  }

  Future<List<DistinctColumn>> distinctBranch(List<OpenLeadData> value) async {
    List<DistinctColumn> disBranch = [];
    var distinctBranch = value.map((e) => e.Branch).toSet().toList();
    for (int i = 0; i < distinctBranch.length; i++) {
      for (int j = 0; j < isselectedBranchStringsw.length; j++) {
        if (distinctBranch[i] == isselectedBranchStringsw[j]) {
          disBranch.add(DistinctColumn(
              discColumn: isselectedBranchStringsw[j], color: 1));
        }
      }
    }
            if (disBranch.isEmpty) {
      for (int i = 0; i < distinctBranch.length; i++) {
        if (distinctBranch[i]!.isNotEmpty) {
          disBranch.add(
                DistinctColumn(discColumn: distinctBranch[i], color: 0));
        }
      }
    }
    return disBranch;
  }

  Future<List<DistinctColumn>> distinctDivision(
      List<OpenLeadData> value) async {
    List<DistinctColumn> disDivision = [];
    var distinctDivision = value.map((e) => e.Division).toSet().toList();
    for (int i = 0; i < distinctDivision.length; i++) {
      for (int j = 0; j < selectstringDivisionsw.length; j++) {
        if (distinctDivision[i] == selectstringDivisionsw[j]) {
          disDivision.add(
              DistinctColumn(discColumn: selectstringDivisionsw[j], color: 1));
        }
      }
    }
        if (disDivision.isEmpty) {
      for (int i = 0; i < distinctDivision.length; i++) {
        if (distinctDivision[i]!.isNotEmpty) {
          disDivision.add(
                DistinctColumn(discColumn: distinctDivision[i], color: 0));
        }
      }
    }
    return disDivision;
  }

  Future<List<DistinctColumn>> distinctsalesExecutiveData(
      List<OpenLeadData> value) async {
    List<DistinctColumn> distslExetD = [];
    var distsalExe = value.map((e) => e.SalesExecutive).toSet().toList();
    for (int i = 0; i < distsalExe.length; i++) {
      for (int j = 0; j < isselectedSalesExeStringsw.length; j++) {
        if (distsalExe[i] == isselectedSalesExeStringsw[j]) {
          distslExetD.add(DistinctColumn(
              discColumn: isselectedSalesExeStringsw[j], color: 1));
        }
      }
    }
     if (distslExetD.isEmpty) {
      for (int i = 0; i < distsalExe.length; i++) {
        if (distsalExe[i]!.isNotEmpty) {
          distslExetD
              .add(DistinctColumn(discColumn: distsalExe[i], color: 0));
        }
      }
    }
    return distslExetD;
  }

  Future<List<DistinctColumn>> distinctRegMang(List<OpenLeadData> value) async {
    List<DistinctColumn> distinctRegMang = [];
    var grpdistinctRegMang =
        value.map((e) => e.RegionalManager).toSet().toList();
    for (int i = 0; i < grpdistinctRegMang.length; i++) {
      for (int j = 0; j < isselectedRegMagStringsw.length; j++) {
        if (grpdistinctRegMang[i] == isselectedRegMagStringsw[j]) {
          distinctRegMang.add(DistinctColumn(
              discColumn: isselectedRegMagStringsw[j], color: 1));
        }
      }
    }
    if (distinctRegMang.isEmpty) {
      for (int i = 0; i < grpdistinctRegMang.length; i++) {
        if (grpdistinctRegMang[i]!.isNotEmpty) {
          distinctRegMang
              .add(DistinctColumn(discColumn: grpdistinctRegMang[i], color: 0));
        }
      }
    }
    return distinctRegMang;
  }

// view functions
  bool isbrandViewclick = false;
  bool isgrpPropViewclick = false;
  bool isgrpSegmViewclick = false;
  bool isDivisViewclick = false;
  bool isBrnchViewclick = false;
  bool isBrnchMangViewclick = false;
  bool isSalesExecViewclick = false;
  bool isReginlMangViewclick = false;

  Future<int> mapViewDataToList() async {
    int ins = 0;

    if (isbrandViewclick == true) {
      brandData.clear();
      log("view clear: ${viewData.length}");
      for (int i = 0; i < viewData.length; i++) {
        if (viewData[i].color == 1) {
          brandData.add(DistinctColumn(
              discColumn: viewData[i].discColumn, color: viewData[i].color));
        }
      }
      ins = 1;
    } else if (isgrpPropViewclick == true) {
      groupProperty.clear();
      for (int i = 0; i < viewData.length; i++) {
        if (viewData[i].color == 1) {
          groupProperty.add(DistinctColumn(
              discColumn: viewData[i].discColumn, color: viewData[i].color));
        }
      }
      ins = 1;
    } else if (isgrpSegmViewclick == true) {
      groupSegment.clear();
      for (int i = 0; i < viewData.length; i++) {
        if (viewData[i].color == 1) {
          groupSegment.add(DistinctColumn(
              discColumn: viewData[i].discColumn, color: viewData[i].color));
        }
      }
      ins = 1;
    } else if (isDivisViewclick == true) {
      DivisionData.clear();
      for (int i = 0; i < viewData.length; i++) {
        if (viewData[i].color == 1) {
          DivisionData.add(DistinctColumn(
              discColumn: viewData[i].discColumn, color: viewData[i].color));
        }
      }
      ins = 1;
    } else if (isBrnchViewclick == true) {
      BranchData.clear();
      for (int i = 0; i < viewData.length; i++) {
        if (viewData[i].color == 1) {
          BranchData.add(DistinctColumn(
              discColumn: viewData[i].discColumn, color: viewData[i].color));
        }
      }
      ins = 1;
    } else if (isBrnchMangViewclick == true) {
      branchManagerData.clear();
      for (int i = 0; i < viewData.length; i++) {
        if (viewData[i].color == 1) {
          branchManagerData.add(DistinctColumn(
              discColumn: viewData[i].discColumn, color: viewData[i].color));
        }
      }
      ins = 1;
    } else if (isSalesExecViewclick == true) {
      salesExecutiveData.clear();
      for (int i = 0; i < viewData.length; i++) {
        if (viewData[i].color == 1) {
          salesExecutiveData.add(DistinctColumn(
              discColumn: viewData[i].discColumn, color: viewData[i].color));
        }
      }
      ins = 1;
    } else if (isReginlMangViewclick == true) {
      RegionalManagerData.clear();
      for (int i = 0; i < viewData.length; i++) {
        if (viewData[i].color == 1) {
          RegionalManagerData.add(DistinctColumn(
              discColumn: viewData[i].discColumn, color: viewData[i].color));
        }
      }
      ins = 1;
    }
    notifyListeners();
    return ins;
  }

  viewAllSelected() async {
    await mapViewDataToList().then((value) async {
      await getValuesFromDB();
      falseAllView();
      viewBack();
    });
  }

// on icon search

  validateSearch(BuildContext context) async {
       final Database db = (await DBHelper.getInstance())!;
    if (searchKey.currentState!.validate()) {
      config.disableKeyBoard(context);
      await DBOperation.onSearchOpenLead(searchcon.text,db).then((resul) {
        openLeadDataF = resul;
        searchBack();
        Navigator.pop(context);
        searchcon.clear();
        notifyListeners();
      });
    }
  }

//
  bool isSelectedColum = false;
  bool get getisSelectedColum => isSelectedColum;
  bool isLodingDialog = false;
  bool get getisLodingDialog => isLodingDialog;
  String forwardDialogSuccessMsg = '';
  String get getforwardSuccessMsg => forwardDialogSuccessMsg;
  bool viewDetailsClicked = false;
  bool get getviewDetailsClicked => viewDetailsClicked;
  bool forwardDialogClicked = false;
  bool get getforwardDialogClicked => forwardDialogClicked;
  bool updateFrowardDialog = false;
  bool get getupdateFrowardDialog => updateFrowardDialog;

  changetoFolloweUp() {
    updateFrowardDialog = true;
    notifyListeners();
  }

  String caseStatusSelected = ''; //cl
  String? get getcaseStatusSelected => caseStatusSelected;
  caseStatusSelectBtn(String val) {
    caseStatusSelected = val;
    notifyListeners();
  }

  forwardClicked() {
    forwardDialogClicked = !forwardDialogClicked;
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
        if (value.leadDeatilsLeadData != null) {
          leadDeatilsLData = value.leadDeatilsLeadData!;
          isLodingDialog = false;
          viewDetailsClicked = true;
          notifyListeners();
        } else {
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

  void followUPClicked() {
    viewDetailsClicked = !viewDetailsClicked;
    notifyListeners();
  }

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

  String? followup =
      'How you made the follow up?'; //cl How the follow up has been made
  String? get getfollowup => followup;

  String isSelectedFollowUp = '';
  String get getisSelectedFollowUp => isSelectedFollowUp;

  selectFollowUp(String selected) {
    isSelectedFollowUp = selected;
    notifyListeners();
  }

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

  getDataOnLoad() async {
       final Database db = (await DBHelper.getInstance())!;
    leadStatusOpen = await DBOperation.getLeadStatusOpen(db);
    leadStatusLost = await DBOperation.getLeadStatusLost(db);
    leadStatusWon = await DBOperation.getLeadStatusWon(db);
    userLtData = await DBOperation.getUserList(db);
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
      lostSave(followDocEntry, leadDocEntry, valueChosedReason,
          mycontroller[1].text, isSelectedFollowUp);
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

  WonSave(followDocEntry, String leadDocEntry, status, feedback, followup,
      billwonDate, billreference) async {
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

  lostSave(followDocEntry, String leadDocEntry, reason, feedback,
      followupMode) async {
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
