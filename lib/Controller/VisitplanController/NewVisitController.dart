// ignore_for_file: unnecessary_new
import 'package:intl/intl.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sellerkit/Controller/VisitplanController/NewVisitController.dart';

import '../../Constant/Configuration.dart';
import '../../Constant/ConstantRoutes.dart';
import '../../Models/NewVisitModel/NewVisitModel.dart';
import '../../Widgets/SucessDialagBox.dart';
import 'NewVisitController.dart';

class NewVisitplanController extends ChangeNotifier {
  Config config = new Config();
  init() {
    clearData();
    getDataMethod();
  }

  List<TextEditingController> mycontroller =
      List.generate(15, (i) => TextEditingController());
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  List<ExistingCusData> existCusDataList = [];
  List<ExistingCusData> get getexistCusDataList => existCusDataList;
  List<ExistingCusData> filterexistCusDataList = [];
  bool customerbool = false;
  bool areabool = false;
  bool citybool = false;
  bool pincodebool = false;
  bool statebool = false;

  bool timebool = false;
  bool Datebool = false;

  List<purposeofVisitData> purposeofVisitList = [];
  getDataMethod() {
    existCusDataList = [
      ExistingCusData(
        Customer: "Arun Store",
        Mobile: "1234567890",
        CantactName: "Arun",
        U_Address1: "104 West Street ,",
        U_Address2: "Srirangam,Trichy",
        U_City: "Trichy",
       
        U_Pincode: "6200005",
        U_State: "Tamil Nadu",
        Meeting_Date: "24-01-2023",
        Meeting_Time: "12:00 AM",
        U_Area: "Srirangam",
         PurposOfVisit: "Enquiry Visit",
      ),
      ExistingCusData(
          Customer: "Raja Store",
          Mobile: "9876543210",
          CantactName: "Raja",
          U_Address1: "124 KK Nagar Street ,",
          U_Address2: "Karur main Road,Karur",
          U_City: "Somur",
        
           U_Pincode: "6200024",
          U_State: "Tamil Nadu",
          PurposOfVisit: "New Demo",
          Meeting_Time: "10:20 AM",
           U_Area: "Karur",
          Meeting_Date: "12-03-2023"),
    ];
    purposeofVisitList = [
      purposeofVisitData(purpose: "Courtesy Visit"),
      purposeofVisitData(purpose: "Enquiry Visit"),
      purposeofVisitData(purpose: "Routine Visit"),
      purposeofVisitData(purpose: "Collection"),
      purposeofVisitData(purpose: "Customer Appointment"),
      purposeofVisitData(purpose: "New Demo"),
      purposeofVisitData(purpose: "Complaint Call Visit")
    ];
        filterpurposeofVisitList = purposeofVisitList;

    filterexistCusDataList = existCusDataList;
    print(purposeofVisitList.length.toString());
    notifyListeners();
  }

  clearData() {
    clearbool();
    filterpurposeofVisitList.clear();
    purposeofVisitList.clear();
    existCusDataList.clear();
    filterexistCusDataList.clear();
    mycontroller[0].text = "";
    mycontroller[1].text = "";
    mycontroller[2].text = "";
    mycontroller[3].text = "";
    mycontroller[4].text = "";
    mycontroller[5].text = "";
    mycontroller[6].text = "";
    mycontroller[7].text = "";
    mycontroller[8].text = "";
    mycontroller[9].text = "";
    mycontroller[10].text = "";
    mycontroller[11].text = "";
    notifyListeners();
  }

  clearbool() {
    customerbool = false;
    areabool = false;
    citybool = false;
    pincodebool = false;
    statebool = false;
    timebool = false;
    Datebool = false;
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

  List<purposeofVisitData> filterpurposeofVisitList = [];
  filterListPurposeOfVisit(String v) {
    if (v.isNotEmpty) {
      filterpurposeofVisitList = purposeofVisitList
          .where((e) => e.purpose.toLowerCase().contains(v.toLowerCase())
              // ||
              // e.name!.toLowerCase().contains(v.toLowerCase())
              )
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterpurposeofVisitList = purposeofVisitList;
      notifyListeners();
    }
  }

  iscateSeleted(BuildContext context, String select) {
    mycontroller[9].text = select;
    Navigator.pop(context);
    notifyListeners();
  }

  getExiCustomerData(String Customer) {
    for (int i = 0; i < existCusDataList.length; i++) {
      if (Customer == existCusDataList[i].Customer) {
        mycontroller[0].text = existCusDataList[i].Customer.toString();
        mycontroller[1].text = existCusDataList[i].Mobile.toString();
        mycontroller[2].text = existCusDataList[i].CantactName.toString();
        mycontroller[3].text = existCusDataList[i].U_Address1.toString();
        mycontroller[4].text = existCusDataList[i].U_Address2.toString();
        mycontroller[5].text = existCusDataList[i].U_Area.toString();
        mycontroller[6].text = existCusDataList[i].U_City.toString();
        mycontroller[7].text = existCusDataList[i].U_Pincode.toString();
        mycontroller[8].text = existCusDataList[i].U_State.toString();
        mycontroller[9].text = existCusDataList[i].PurposOfVisit.toString();
        mycontroller[10].text = existCusDataList[i].Meeting_Date.toString();
        mycontroller[11].text = existCusDataList[i].Meeting_Time.toString();
        notifyListeners();
      }
    }
    notifyListeners();
  }

  getExiAreaData(String Customer) {
    for (int i = 0; i < existCusDataList.length; i++) {
      if (Customer == existCusDataList[i].U_Area) {
        mycontroller[0].text = existCusDataList[i].Customer.toString();
        mycontroller[1].text = existCusDataList[i].Mobile.toString();
        mycontroller[2].text = existCusDataList[i].CantactName.toString();
        mycontroller[3].text = existCusDataList[i].U_Address1.toString();
        mycontroller[4].text = existCusDataList[i].U_Address2.toString();
        mycontroller[5].text = existCusDataList[i].U_Area.toString();
        mycontroller[6].text = existCusDataList[i].U_City.toString();
        mycontroller[7].text = existCusDataList[i].U_Pincode.toString();
        mycontroller[8].text = existCusDataList[i].U_State.toString();
        mycontroller[9].text = existCusDataList[i].PurposOfVisit.toString();
        mycontroller[10].text = existCusDataList[i].Meeting_Date.toString();
        mycontroller[11].text = existCusDataList[i].Meeting_Time.toString();
        notifyListeners();
      }
    }
    notifyListeners();
  }

  getExicityData(String Customer) {
    for (int i = 0; i < existCusDataList.length; i++) {
      if (Customer == existCusDataList[i].U_City) {
        mycontroller[0].text = existCusDataList[i].Customer.toString();
        mycontroller[1].text = existCusDataList[i].Mobile.toString();
        mycontroller[2].text = existCusDataList[i].CantactName.toString();
        mycontroller[3].text = existCusDataList[i].U_Address1.toString();
        mycontroller[4].text = existCusDataList[i].U_Address2.toString();
        mycontroller[5].text = existCusDataList[i].U_Area.toString();
        mycontroller[6].text = existCusDataList[i].U_City.toString();
        mycontroller[7].text = existCusDataList[i].U_Pincode.toString();
        mycontroller[8].text = existCusDataList[i].U_State.toString();
        mycontroller[9].text = existCusDataList[i].PurposOfVisit.toString();
        mycontroller[10].text = existCusDataList[i].Meeting_Date.toString();
        mycontroller[11].text = existCusDataList[i].Meeting_Time.toString();
        notifyListeners();
      }
    }
    notifyListeners();
  }

  getExipincodeData(String Customer) {
    for (int i = 0; i < existCusDataList.length; i++) {
      if (Customer == existCusDataList[i].U_Pincode) {
        mycontroller[0].text = existCusDataList[i].Customer.toString();
        mycontroller[1].text = existCusDataList[i].Mobile.toString();
        mycontroller[2].text = existCusDataList[i].CantactName.toString();
        mycontroller[3].text = existCusDataList[i].U_Address1.toString();
        mycontroller[4].text = existCusDataList[i].U_Address2.toString();
        mycontroller[5].text = existCusDataList[i].U_Area.toString();
        mycontroller[6].text = existCusDataList[i].U_City.toString();
        mycontroller[7].text = existCusDataList[i].U_Pincode.toString();
        mycontroller[8].text = existCusDataList[i].U_State.toString();
        mycontroller[9].text = existCusDataList[i].PurposOfVisit.toString();
        mycontroller[10].text = existCusDataList[i].Meeting_Date.toString();
        mycontroller[11].text = existCusDataList[i].Meeting_Time.toString();
        notifyListeners();
      }
    }
    notifyListeners();
  }

  getExistateData(String Customer) {
    for (int i = 0; i < existCusDataList.length; i++) {
      if (Customer == existCusDataList[i].U_State) {
        mycontroller[0].text = existCusDataList[i].Customer.toString();
        mycontroller[1].text = existCusDataList[i].Mobile.toString();
        mycontroller[2].text = existCusDataList[i].CantactName.toString();
        mycontroller[3].text = existCusDataList[i].U_Address1.toString();
        mycontroller[4].text = existCusDataList[i].U_Address2.toString();
        mycontroller[5].text = existCusDataList[i].U_Area.toString();
        mycontroller[6].text = existCusDataList[i].U_City.toString();
        mycontroller[7].text = existCusDataList[i].U_Pincode.toString();
        mycontroller[8].text = existCusDataList[i].U_State.toString();
        mycontroller[9].text = existCusDataList[i].PurposOfVisit.toString();
        mycontroller[10].text = existCusDataList[i].Meeting_Date.toString();
        mycontroller[11].text = existCusDataList[i].Meeting_Time.toString();
        notifyListeners();
      }
    }
    notifyListeners();
  }

  getDate(BuildContext context) async {
    errorTime = "";

    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));
//  firstDate: DateTime.now().subtract(Duration(days: 1)),
//   lastDate: DateTime(2100),
    if (pickedDate != null) {
      mycontroller[11].text = "";
      print(pickedDate);
      var datetype = DateFormat('dd-MM-yyyy').format(pickedDate);
      mycontroller[10].text = datetype;
      // mycontroller[44].text = datetype!;
      // print(datetype);
    } else {
      print("Date is not selected");
    }
    notifyListeners();
  }

  String errorTime = "";
  void selectTime(BuildContext context) async {
    TimeOfDay timee = TimeOfDay.now();
    if (mycontroller[10].text.isNotEmpty) {
      errorTime = "";
      final TimeOfDay? newTime = await showTimePicker(
        context: context,
        initialTime: timee,
      );
      // if (mycontroller[10].text ==
      //     DateFormat('dd-MM-yyyy').format(DateTime.now())) {
      //   print(newTime!.hour);
      //   print(TimeOfDay.now().hour);
      //   print(newTime.minute);
      //   print(TimeOfDay.now().minute);
      //   if (timee.hour < TimeOfDay.now().hour ||
      //       timee.minute < TimeOfDay.now().minute) {
      //     print("error");
      //   } else if (timee.hour >= TimeOfDay.now().hour &&
      //       timee.minute >= TimeOfDay.now().minute) {
      //     print("correct");
      //   }
      // } else {

      if (newTime != null) {
        timee = newTime;
        if (mycontroller[10].text ==
            DateFormat('dd-MM-yyyy').format(DateTime.now())) {
          if (timee.hour < TimeOfDay.now().hour ||
              timee.minute < TimeOfDay.now().minute) {
            errorTime = "Please Choose Correct Time";
            mycontroller[11].text = "";
            notifyListeners();
            print("error");
          } else {
            errorTime = "";
            print("correct11");
            mycontroller[11].text = timee.format(context).toString();
          }
        } else {
          errorTime = "";
          print("correct22");
          timee = newTime;
          mycontroller[11].text = timee.format(context).toString();
        }

        notifyListeners();
      }
      notifyListeners();
    } else {
      mycontroller[11].text = "";
      errorTime = "Please Choose First Date";
      notifyListeners();
    }
    notifyListeners();
  }

  validateSchedule(BuildContext context) async {
    if (formkey.currentState!.validate()) {
      showDialog<dynamic>(
          context: context,
          builder: (_) {
            return SuccessDialogPG(
              heading: 'Response',
              msg: 'Visit Plan Created Successfully..!!',
            );
          }).then((value) {
            Get.offAllNamed(ConstantRoutes.visitplan);
          });
    }
  }
}

class purposeofVisitData {
  String purpose;
  purposeofVisitData({required this.purpose});
}
