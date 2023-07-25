// ignore_for_file: camel_case_types

import 'package:flutter/cupertino.dart';

import '../../Constant/Configuration.dart';
import '../../Models/VisitPlanModel/VisitPlanModel.dart';

class VisitplanController extends ChangeNotifier {
  Config config = new Config();

  List<VisitPlanData> openVisitData = [];
  List<VisitPlanData> closedVisitdata = [];
  List<VisitPlanData> missedVisitUserdata = [];

  List<VisitPlanData> get getopenVisitData => openVisitData;
  List<VisitPlanData> get getclosedVisitdata => closedVisitdata;
  List<VisitPlanData> get getmissedVisitUserdata => missedVisitUserdata;

  List<VisitPlanData> visitLists = [];

  init() {
    clearAll();
    getData();
    spilitData();
  }

  getData() {
    visitLists = [
      VisitPlanData(
        customer: "Raja",
        datetime: "21-Jul-2023 2:11PM",
        purpose: "Courtesy Visit",
        area: "Saibaba Colony Coimbatore",
        product: "Looking For Table/Chair",
        type: "Open",
        Mobile: "1234567890",
        CantactName: "Arun",
        U_Address1: "104 West Street ,",
        U_Address2: "Srirangam,Trichy",
        U_City: "Trichy",
        U_Pincode: "6200005",
        U_State: "Tamil Nadu",
      ),
      VisitPlanData(
        customer: "Raja",
        datetime: "24-Jun-2023 4:23PM",
        purpose: "Enquiry Visit",
        area: "Saibaba Colony Coimbatore",
        product: "Looking For Table/Chair",
        type: "Closed",
        Mobile: "9876543210",
        CantactName: "Raja",
        U_Address1: "124 KK Nagar Street ,",
        U_Address2: "Karur main Road,Karur",
        U_City: "Somur",
        U_Pincode: "6200024",
        U_State: "Tamil Nadu",
      ),
      VisitPlanData(
        customer: "Raja",
        datetime: "21-May-2023-4:23PM",
        purpose: "Customer Appointment",
        area: "Saibaba Colony Coimbatore",
        product: "Looking For Table/Chair",
        type: "Missed",
        Mobile: "9876543210",
        CantactName: "Raja",
        U_Address1: "124 KK Nagar Street ,",
        U_Address2: "Karur main Road,Karur",
        U_City: "Somur",
        U_Pincode: "6200024",
        U_State: "Tamil Nadu",
      )
    ];
    notifyListeners();
  }

  clearAll() {
    dropdownvalue = "";
    testlistData.clear();
    visitLists.clear();
    openVisitData.clear();
    closedVisitdata.clear();
    missedVisitUserdata.clear();
  }

  String? dropdownvalue;

  spilitData() {
    for (int i = 0; i < visitLists.length; i++) {
      if (visitLists[i].type == "Open") {
        openVisitData.add(VisitPlanData(
          customer: visitLists[i].customer,
          datetime: visitLists[i].datetime,
          purpose: visitLists[i].purpose,
          area: visitLists[i].area,
          product: visitLists[i].product,
          type: visitLists[i].type,
          Mobile: visitLists[i].Mobile,
          CantactName: visitLists[i].CantactName,
          U_Address1: visitLists[i].U_Address1,
          U_Address2: visitLists[i].U_Address2,
          U_City: visitLists[i].U_City,
          U_Pincode: visitLists[i].Pincode,
          U_State: visitLists[i].State,
        ));
      }
      if (visitLists[i].type == "Closed") {
        closedVisitdata.add(VisitPlanData(
          customer: visitLists[i].customer,
          datetime: visitLists[i].datetime,
          purpose: visitLists[i].purpose,
          area: visitLists[i].area,
          product: visitLists[i].product,
          type: visitLists[i].type,
          Mobile: visitLists[i].Mobile,
          CantactName: visitLists[i].CantactName,
          U_Address1: visitLists[i].U_Address1,
          U_Address2: visitLists[i].U_Address2,
          U_City: visitLists[i].U_City,
          U_Pincode: visitLists[i].Pincode,
          U_State: visitLists[i].State,
        ));
      }
      if (visitLists[i].type == "Missed") {
        missedVisitUserdata.add(VisitPlanData(
          customer: visitLists[i].customer,
          datetime: visitLists[i].datetime,
          purpose: visitLists[i].purpose,
          area: visitLists[i].area,
          product: visitLists[i].product,
          type: visitLists[i].type,
          Mobile: visitLists[i].Mobile,
          CantactName: visitLists[i].CantactName,
          U_Address1: visitLists[i].U_Address1,
          U_Address2: visitLists[i].U_Address2,
          U_City: visitLists[i].U_City,
          U_Pincode: visitLists[i].Pincode,
          U_State: visitLists[i].State,
        ));
      }
    }
    notifyListeners();
  }

  List<test> testlistData = [
    //   "raja1",
    //   "raja12",
    //   "raja13",
    //  "raja123",
    test(customername: "ramu1", tagid: "19"),
    test(customername: "ramu12", tagid: "192"),
    test(customername: "ramu13", tagid: "193"),
    test(customername: "ramu123", tagid: "1923"),
  ];
}

class visitplanDataList {
  String? customer;
  String? datetime;
  String? purpose;
  String? area;
  String? product;
  String? type;

  visitplanDataList({
    required this.customer,
    required this.datetime,
    required this.purpose,
    required this.area,
    required this.product,
    required this.type,
  });
}

class test {
  String? customername;

  String? tagid;
  // String shipCity;
  // String shipstate;
  // String shipPincode;
  // String shipCountry;
  test({
    this.tagid,
    this.customername,

    // required this.shipCity,
    //required this.shipAddress,

    // required this.shipCountry,
    // required this.shipPincode,
    // required this.shipstate
  });
}
