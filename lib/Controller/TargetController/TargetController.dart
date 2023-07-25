import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sellerkit/Models/TargetModel/TargetModel.dart';
import 'package:sellerkit/Models/TargetModel/TargetTableModel.dart';
import 'package:sellerkit/Services/TargetApi/TargetApi/TargetApi.dart';
import 'package:sellerkit/Services/TargetApi/TargetApi/TargetTableApi.dart';

class TargetTabController extends ChangeNotifier {
  TargetTabController() {
    callGetTargetTableApi();
  }

  bool isloading = true;
  bool get getisloading => isloading;
  List<TargetTableData> targetMonthTableData = [];
  List<TargetTableData> get getMonthTableData => targetMonthTableData;

  List<TargetTableData> targetTodayTableData = [];
  List<TargetTableData> get getTodaydTableData => targetTodayTableData;

  List<TargetTableData> targetDeatilsData = [];
  List<TargetTableData> get getTargetDeatilsData => targetDeatilsData;

  String targetCheckDataExcep = '';
  String get getLeadCheckDataExcep => targetCheckDataExcep;

  List<TargetData> targetMonthData = [];
  List<TargetData> get getMonthdData => targetMonthData;

  List<TargetData> targetTodayData = [];
  List<TargetData> get getTodaydData => targetTodayData;

  int processvalue = 0;
  int get getprocessvalue => processvalue;

  logData() {
    log('targetCheckDataExcep: $targetCheckDataExcep');
    log('isloading: $isloading');
  }

  callGetTargetTableApi() async {
    notifyListeners();
    await GetTargetTableApi.getData().then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.targetcheckdata != null) {
          mapTableValues(value.targetcheckdata!);
        } else if (value.targetcheckdata == null) {
          targetCheckDataExcep = 'No Target Data in table Api..!!';
          isloading = false;
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        isloading = false;
        targetCheckDataExcep = 'Some thing went wrong in Table Api..!!';
      } else if (value.stcode == 500) {
        if (value.exception == 'No route to host') {
          targetCheckDataExcep = 'Check your Internet Connection...!!';
          isloading = false;
        } else {
          targetCheckDataExcep = 'Something went wrong try again ...!!';
          isloading = false;
        }
      }
      notifyListeners();
    });

    await GetTargetApi.getData().then((value) {
      isloading = false;
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.targetdata != null) {
          mapValues(value.targetdata!);
        } else if (value.targetdata == null) {
          targetCheckDataExcep = 'No Target Data in Target Api..!!';

          // isloading = false;
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        targetCheckDataExcep = 'Some thing went wrong in Target Api..!!';

        // isloading = false;
      } else if (value.stcode == 500) {
        if (value.exception == 'No route to host') {
          targetCheckDataExcep = 'Check your Internet Connection...!!';
          // isloading = false;
        } else {
          targetCheckDataExcep = 'Something went wrong try again...!!';
          // isloading = false;
        }
      }

      notifyListeners();
    });
  }

  mapTableValues(List<TargetTableData> targettdata) {
    notifyListeners();

    for (int i = 0; i < targettdata.length; i++) {
      if (targettdata[i].tPeriod == "Month") {
        targetMonthTableData.add(TargetTableData(
            segment: targettdata[i].segment,
            target: targettdata[i].target,
            ach: targettdata[i].ach,
            tPeriod: targettdata[i].tPeriod,
            achieved: targettdata[i].achieved));
      } else if (targettdata[i].tPeriod == "Today") {
        targetTodayTableData.add(TargetTableData(
            segment: targettdata[i].segment,
            target: targettdata[i].target,
            ach: targettdata[i].ach,
            tPeriod: targettdata[i].tPeriod,
            achieved: targettdata[i].achieved));
      }
    }
    notifyListeners();
  }

  int? groupValueSelected = 0;
  int? get getgroupValueSelected => groupValueSelected;
  groupSelectvalue(int i) {
    groupValueSelected = i;
    notifyListeners();
  }

  mapValues(List<TargetData> targetvalues) {
    notifyListeners();
    for (int i = 0; i < targetvalues.length; i++) {
      if (targetvalues[i].tPeriod == "Month") {
        targetMonthData.add(TargetData(
          tPeriod: targetvalues[i].tPeriod,
          kPI1MainValue: targetvalues[i].kPI1MainValue,
          kPI1SubValue: targetvalues[i].kPI1SubValue,
          kPI1Title: targetvalues[i].kPI1Title,
          kPI2MainValue: targetvalues[i].kPI2MainValue,
          kPI2SubValue: targetvalues[i].kPI2SubValue,
          kPI2Title: targetvalues[i].kPI2Title,
          kPI3MainValue: targetvalues[i].kPI3MainValue,
          kPI3SubValue: targetvalues[i].kPI3SubValue,
          kPI3Title: targetvalues[i].kPI3Title,
          kPI4MainValue: targetvalues[i].kPI4MainValue,
          kPI4SubValue: targetvalues[i].kPI4SubValue,
          kPI4Title: targetvalues[i].kPI4Title,
        ));
      } else if (targetvalues[i].tPeriod == "Today") {
        targetTodayData.add(TargetData(
          tPeriod: targetvalues[i].tPeriod,
          kPI1MainValue: targetvalues[i].kPI1MainValue,
          kPI1SubValue: targetvalues[i].kPI1SubValue,
          kPI1Title: targetvalues[i].kPI1Title,
          kPI2MainValue: targetvalues[i].kPI2MainValue,
          kPI2SubValue: targetvalues[i].kPI2SubValue,
          kPI2Title: targetvalues[i].kPI2Title,
          kPI3MainValue: targetvalues[i].kPI3MainValue,
          kPI3SubValue: targetvalues[i].kPI3SubValue,
          kPI3Title: targetvalues[i].kPI3Title,
          kPI4MainValue: targetvalues[i].kPI4MainValue,
          kPI4SubValue: targetvalues[i].kPI4SubValue,
          kPI4Title: targetvalues[i].kPI4Title,
        ));
      }
    }
    isloading = false;

    notifyListeners();
  }

  clearTargetListData() {
    targetCheckDataExcep = '';
    targetTodayTableData.clear();
    targetMonthTableData.clear();
    targetTodayData.clear();
    targetMonthData.clear();
    isloading = true;
    notifyListeners();
  }

  // void updateList(int index) {
  //   targetTodayTableData.remove(index);
  //   notifyListeners();
  // }
}
