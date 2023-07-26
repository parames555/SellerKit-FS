// ignore_for_file: unused_import

import 'dart:async';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sellerkit/Models/AccountsModel/AccountsModel.dart';
import 'package:sqflite/sqflite.dart';
import '../../Constant/ConstantRoutes.dart';
import '../../Constant/Helper.dart';
import '../../Constant/Screen.dart';
import '../../DBHelper/DBHelper.dart';
import '../../DBHelper/DBOperation.dart';
import '../../Models/PostQueryModel/EnquiriesModel/EnqRefferesModel.dart';
import '../../Services/AccountsApi/AccountsApi.dart';

class AccountsContoller extends ChangeNotifier {
  AccountsContoller() {
    callAccountsApi();
    boolmethod();
    scrollcontrollerAddlistener();
  }
  //
  init(){
  }
  List<AccountsNewData> AccountsData = [];
  List<AccountsNewData> AccountsDataFilter = [];
  List<AccountsNewData> get getAccountsData => AccountsData;
  List<AccountsNewData> get getAccountsDataFilter => AccountsDataFilter;
  //
  //
  int? count = 0;
  int get getcount => count!;
  int? counti = 1;
  int get getcounti => counti!;
List<GlobalKey<FormState>> formkey = new List.generate(
      3, (i) => new GlobalKey<FormState>());
  //
  
List<TextEditingController> mycontroller =
      List.generate(20, (i) => TextEditingController());
  //
  List<String> items = ["VIP", "PREMIER", "FAKE", "AAAAAA", "CCCCCC", "BBBB"];
  List<String> get getitems => items;
  List<String> countitemlength = [];
  List<String> get getcountitemlength => countitemlength;
  List<String> countitem = [];
  List<String> get getcountitem => countitem;
  //
  String errorMsg = '';
  bool exception = false;
  bool cartLoading = false;
  bool isLoading = true;
  bool get getisLoading => isLoading;
  bool get getcartLoading => cartLoading;
  bool get getException => exception;
  String get getErrorMsg => errorMsg;
  //
  //
  Future<void> swipeRefreshIndiactor() async {
    AccountsData.clear();
    notifyListeners();
    callAccountsApi();
  }

  boolmethod() {
    cartLoading = true;
    notifyListeners();
    Future.delayed(Duration(seconds: 5), () {
      cartLoading = false;
      notifyListeners();
    });
  }

  callAccountsApi() async {
    //  int  counti=100;
    for (int i = 1; i == counti!; i++) {
      log("first....... loop:" + i.toString());
      await AccountsApiNew.getData(i).then((value) {
        isLoading = false;
        if (value.itemdata == null) {
          counti = 1;
          i = 2;
          notifyListeners();
        }
        if (value.stcode! >= 200 && value.stcode! <= 210) {
          if (value.itemdata != null) {
            for (int k = 0; k < value.itemdata!.length; k++) {
              //  log("second loop:"+k.toString());

              AccountsData.add(AccountsNewData(
                  cardcode: value.itemdata![i].cardcode,
                  cardname: value.itemdata![i].cardname,
                  street: value.itemdata![i].street,
                  block: value.itemdata![i].block,
                  zipcode: value.itemdata![i].zipcode,
                  city: value.itemdata![i].city,
                  state: value.itemdata![i].state,
                  country: value.itemdata![i].country,
                  tag: value.itemdata![i].tag));
              // AccountsData = value.itemdata!;
              AccountsDataFilter.add(AccountsNewData(
                  cardcode: value.itemdata![i].cardcode,
                  cardname: value.itemdata![i].cardname,
                  street: value.itemdata![i].street,
                  block: value.itemdata![i].block,
                  zipcode: value.itemdata![i].zipcode,
                  city: value.itemdata![i].city,
                  state: value.itemdata![i].state,
                  country: value.itemdata![i].country,
                  tag: value.itemdata![i].tag));
              notifyListeners();
            }

            counti = counti! + 1;
            notifyListeners();
          }
        } else if (value.stcode! >= 400 && value.stcode! <= 410) {
          exception = true;
          errorMsg = '${value.exception}';
          notifyListeners();
        } else if (value.stcode == 500) {
          if (value.exception == 'No route to host') {
            errorMsg = 'Check your Internet Connection...!!';
          } else {
            errorMsg = 'Something went wrong try again...!!';
          }
          exception = true;
          // errorMsg = '${value.exception}';
          notifyListeners();
        }
        notifyListeners();
      });
      print("iteration" + i.toString());
      print("counti" + counti.toString());
      count = count! + AccountsData.length;
      notifyListeners();
    }

    print("accountdata outside legnth:" + AccountsData.length.toString());
    print(counti);
    log("Totalll: " + count.toString());
  }

  SearchFilter(String v) {
    print('saearch :' + v);
    if (v.isNotEmpty) {
      AccountsDataFilter = AccountsData.where((e) =>
          (e).cardcode!.toLowerCase().contains(v.toLowerCase()) ||
          (e).cardname!.toLowerCase().contains(v.toLowerCase())).toList();
      notifyListeners();
    } else if (v.isEmpty) {
      AccountsDataFilter = AccountsData;
      notifyListeners();
    }
  }
  ScrollController scrollController = ScrollController();

  scrollcontrollerAddlistener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        // if (mycontroller[0].text.isEmpty) {
        // if(StockItemAPi.nextLink!='null'){
        //   getmoredata();
        // }

        // }
      }
    });
  }


}
