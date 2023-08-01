// import 'package:flutter/cupertino.dart';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../Constant/Configuration.dart';
import 'package:intl/intl.dart';

import '../../Constant/ConstantRoutes.dart';
import '../../Widgets/SucessDialagBox.dart';

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
    mycontroller[0].text = "";
    mycontroller[1].text = "";
    mycontroller[2].text = "";
    mycontroller[3].text = "";
    mycontroller[4].text = "";
    mycontroller[5].text = "";
    mycontroller[6].text = "";
    mycontroller[7].text = "";
    mycontroller[8].text = "";
    notifyListeners();
  }

  GlobalKey<FormState> formkey =
      GlobalKey<FormState>(debugLabel: "leave approve");
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

  setReqData(LeaveReqListData? reqDataList) {
    clearData();
    mycontroller[0].text = reqDataList!.empName.toString();
    radioLeavetype = reqDataList.leaveType;
    mycontroller[7].text = reqDataList.reason.toString();
    mycontroller[8].text = reqDataList.managerName.toString();

    if (reqDataList.leaveType == "Permission") {
      mycontroller[4].text = reqDataList.permissionDate.toString();
      mycontroller[5].text = reqDataList.startTime.toString();
      mycontroller[6].text = reqDataList.endTime.toString();
    } else if (reqDataList.leaveType == "Half Day") {
      mycontroller[3].text = reqDataList.halfDayDate.toString();
      radioHalfLeavetype = reqDataList.firstHalf!.isNotEmpty
          ? reqDataList.firstHalf.toString()
          : reqDataList.secondHalf.toString();
    } else if (reqDataList.leaveType == "Full Day") {
      leaveMode = reqDataList.fullDayLeaveMode.toString();
      mycontroller[1].text = reqDataList.startDate.toString();
      mycontroller[2].text = reqDataList.endDate.toString();
    }
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
    filterListOfReq = listOfReq;
    notifyListeners();
  }

  List<LeaveReqListData> filterListOfReq = [];
  List<LeaveReqListData> listOfReq = [
    LeaveReqListData(
        empId: "A0001",
        empName: "Ram Kumar P",
        leaveType: "Permission",
        fullDayLeaveMode: "",
        startDate: "",
        endDate: "",
        halfDayDate: "",
        firstHalf: "",
        secondHalf: "",
        permissionDate: "23-07-2023",
        startTime: "6:40 PM",
        createdDate: "21-Jul-2023 10:12 PM",
        endTime: "7:40 PM",
        reason: "I Going To Marriage Function So Give Permission",
        managerName: "D Karthik"),
    LeaveReqListData(
        empId: "A0002",
        empName: "Lokesh Kumar P",
        leaveType: "Full Day",
        fullDayLeaveMode: "Casual Leave",
        startDate: "01-08-2023",
        endDate: "03-08-2023",
        halfDayDate: "",
        firstHalf: "",
        secondHalf: "",
        permissionDate: "",
        startTime: "",
        createdDate: "30-Jul-2023 08:12 AM",
        endTime: "",
        reason: "I Going To OutSide So Give Permission",
        managerName: "D Karthik"),
    LeaveReqListData(
        empId: "A0003",
        empName: "Vigneshwaran",
        leaveType: "Half Day",
        fullDayLeaveMode: "",
        startDate: "",
        endDate: "",
        halfDayDate: "03-08-2023",
        firstHalf: "First Half",
        secondHalf: "",
        permissionDate: "",
        startTime: "",
        createdDate: "30-Jul-2023 08:12 AM",
        endTime: "",
        reason: "I Have Personal Issue Today So Give Permission Half Day",
        managerName: "D Karthik"),
  ];

  int noOfDays() {
    if (mycontroller[1].text.isNotEmpty && mycontroller[2].text.isNotEmpty) {
      // int difference = DateTime.parse(mycontroller[1].text).difference(DateTime.parse(mycontroller[2].text)).inDays;
      // final date2 = DateTime.parse(mycontroller[2].text);
      String dateString = mycontroller[1].text;

      // Split the date string into day, month, and year parts
      List<String> dateParts = dateString.split("-");
      int day = int.parse(dateParts[0]);
      int month = int.parse(dateParts[1]);
      int year = int.parse(dateParts[2]);

      // Create a DateTime object by parsing the date string
      DateTime dateTime = DateTime(year, month, day);
      //
      String dateString2 = mycontroller[2].text;

      // Split the date string into day, month, and year parts
      List<String> dateParts2 = dateString2.split("-");
      int day2 = int.parse(dateParts2[0]);
      int month2 = int.parse(dateParts2[1]);
      int year2 = int.parse(dateParts2[2]);

      // Create a DateTime object by parsing the date string
      DateTime dateTime2 = DateTime(year2, month2, day2);
      log(dateTime.toString());
      log(dateTime2.toString());

      // int difference = daysBetween(dateTime, dateTime2);
      final difference = dateTime.difference(dateTime2).inDays;

      log("ppp" + difference.toString());
      return difference.abs() + 1;
    } else {
      return 0;
    }
  }

  validateLeaveReq(BuildContext contex, String confirmType) {
    errorTime = "";
    // if (formkey.currentState!.validate()) {
    if (confirmType == "Approved") {
      showDialog<dynamic>(
          context: contex,
          builder: (_) {
            return SuccessDialogPG(
              heading: 'Response',
              msg: 'Leave Approved Registered..!!',
            );
          }).then((value) {
        Get.offAllNamed(ConstantRoutes.leaveApprList);
      });
    } else {
      showDialog<dynamic>(
          context: contex,
          builder: (_) {
            return SuccessDialogPG(
              heading: 'Response',
              msg: 'Leave Rejected Registered..!!',
            );
          }).then((value) {
        Get.offAllNamed(ConstantRoutes.leaveApprList);
      });
    }

    // }
    notifyListeners();
  }
}

class LeaveReqListData {
  String? empId;
  String? empName;
  String? leaveType;
  String? fullDayLeaveMode;
  String? startDate;
  String? endDate;
  String? halfDayDate;
  String? firstHalf;
  String? secondHalf;
  String? permissionDate;
  String? startTime;
  String? endTime;
  String? reason;
  String? managerName;
  String? createdDate;

  LeaveReqListData({
    required this.empId,
    required this.empName,
    required this.leaveType,
    required this.fullDayLeaveMode,
    required this.startDate,
    required this.endDate,
    required this.halfDayDate,
    required this.firstHalf,
    required this.secondHalf,
    required this.permissionDate,
    required this.startTime,
    required this.endTime,
    required this.createdDate,
    required this.reason,
    required this.managerName,
  });
}
