// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Constant/Configuration.dart';
import 'package:intl/intl.dart';

class LeaveApproveContoller extends ChangeNotifier {
  Config config = Config();
  init(BuildContext context) {
    clearData();
    setvalue();
  }

  clearData() {
    radioLeavetype = null;
    radioHalfLeavetype = null;
    leaveMode = null;
    mycontroller[1].text = "";
    mycontroller[2].text = "";
    mycontroller[3].text = "";
    mycontroller[4].text = "";
    mycontroller[5].text = "";
    mycontroller[6].text = "";
    mycontroller[7].text = "";
    notifyListeners();
  }

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  List<TextEditingController> mycontroller =
      List.generate(15, (i) => TextEditingController());
  String? radioLeavetype;
  String? radioHalfLeavetype;

  String? leaveMode;
  resonChoosed(String val) {
    leaveMode = val;
    notifyListeners();
  }

  void StartAndEndDate(BuildContext context, String dayType) {
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
      // apiFDate =
      //     "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      // print(apiFDate);
      if (dayType == "Start Date") {
        mycontroller[1].text = chooseddate;
      } else if (dayType == "End Date") {
        mycontroller[2].text = chooseddate;
      } else if (dayType == "Half Day") {
        mycontroller[3].text = chooseddate;
      } else if (dayType == "Permission") {
        mycontroller[4].text = chooseddate;
      }
      notifyListeners();
    });
  }

  String errorTime = "";
  void selectTime(BuildContext context, String timeType) async {
    // if (mycontroller[10].text.isNotEmpty) {
    errorTime = "";
    if (timeType == "Start Time") {
      TimeOfDay timee = TimeOfDay.now();

      final TimeOfDay? newTime = await showTimePicker(
        context: context,
        initialTime: timee,
      );

      if (newTime != null) {
        timee = newTime;
        if (mycontroller[4].text ==
            DateFormat('dd-MM-yyyy').format(DateTime.now())) {
          if (timee.hour < TimeOfDay.now().hour ||
              timee.minute < TimeOfDay.now().minute) {
            errorTime = "Please Choose Correct Time";
            mycontroller[5].text = "";
            notifyListeners();
            // print("error");
          } else {
            errorTime = "";
            // print("correct11");
            mycontroller[5].text = timee.format(context).toString();
          }
        } else {
          errorTime = "";
          // print("correct22");
          timee = newTime;
          mycontroller[5].text = timee.format(context).toString();
        }

        notifyListeners();
      }
      notifyListeners();
    } else if (timeType == "End Time") {
      if (mycontroller[5].text.isEmpty) {
        errorTime = "Please Choose Start Time";
        mycontroller[6].text = "";
        notifyListeners();
      } else {
        errorTime = "";
        TimeOfDay timee = TimeOfDay.now();
        final TimeOfDay? newTime = await showTimePicker(
          context: context,
          initialTime: timee,
        );

        if (mycontroller[4].text ==
            DateFormat('dd-MM-yyyy').format(DateTime.now())) {
          if (timee.hour < TimeOfDay.now().hour ||
              timee.minute < TimeOfDay.now().minute) {
            errorTime = "Please Choose Correct Time";
            mycontroller[6].text = "";
            notifyListeners();
          } else {
            errorTime = "";
            mycontroller[6].text = timee.format(context).toString();
          }
        } else {
          errorTime = "";
          mycontroller[6].text = timee.format(context).toString();
        }
      }
    } else {
      mycontroller[11].text = "";
      errorTime = "Please Choose First Date";
      notifyListeners();
    }
    notifyListeners();
  }

  setvalue() {
    mycontroller[0].text = "Arun Kumar";
    mycontroller[8].text = "D.Karthik";
    notifyListeners();
  }

  List<LeaveReqListData> listOfReq = [
    LeaveReqListData(
        empId: "empId",
        empName: "empName",
        leaveType: "Permission",
        leaveMode: "",
        startDate: "",
        endStart: "",
        halfDayDate: "",
        firstHalf: "",
        secondHalf: "",
        permissionDate: "23-07-2023",
        startTime: "6:40 PM",
        endTime: "7:40 PM"),
  ];
}

class LeaveReqListData {
  String? empId;
  String? empName;
  String? leaveType;
  String? leaveMode;
  String? startDate;
  String? endStart;
  String? halfDayDate;
  String? firstHalf;
  String? secondHalf;
  String? permissionDate;
  String? startTime;
  String? endTime;

  LeaveReqListData({
    required this.empId,
    required this.empName,
    required this.leaveType,
    required this.leaveMode,
    required this.startDate,
    required this.endStart,
    required this.halfDayDate,
    required this.firstHalf,
    required this.secondHalf,
    required this.permissionDate,
    required this.startTime,
    required this.endTime,
  });
}
