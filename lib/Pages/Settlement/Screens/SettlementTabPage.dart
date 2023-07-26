// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Pages/Settlement/Widgets/DDTab.dart';
import 'package:sellerkit/Pages/Settlement/Widgets/UPITab.dart';
import '../../../Constant/MenuAuth.dart';
import '../../../Constant/Screen.dart';
import '../../../Controller/EnquiryController/EnquiryMngController.dart';
import '../../../Controller/EnquiryController/NewEnqController.dart';
import '../../../Controller/SettlementController/SettlementController.dart';
import '../../../Widgets/Navi3.dart';
import '../Widgets/CardTab.dart';
import '../Widgets/CashTab.dart';
import '../Widgets/ChequeTab.dart';

class SettlementTabPage extends StatefulWidget {
  SettlementTabPage({Key? key}) : super(key: key);

  @override
  State<SettlementTabPage> createState() => _EnquiryPageState();
}

class _EnquiryPageState extends State<SettlementTabPage>
    with TickerProviderStateMixin {
  static const List<Tab> myTabs = <Tab>[
    Tab(
      text: 'Cash',
    ),
    Tab(text: 'Card'),
    Tab(text: 'Cheque'),
    Tab(text: 'UPI'),
    Tab(text: 'DD'),
  ];
  TabController? controller;
  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 5, initialIndex: 0);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //   log("enq data prev : "+EnquiryMangerContoller.enqDataprev.toString());
      //   if(EnquiryMangerContoller.enqDataprev == 0){
      context.read<SettlementController>().init();
      // context.read<EnquiryMangerContoller>().callUserListApi();
      // context.read<EnquiryMangerContoller>().callResonApi();
      //   }else{
      //      context.read<EnquiryMangerContoller>().resetAll(context);
      //   }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  DateTime? currentBackPressTime;
  Future<bool> onbackpress() {
    DateTime now = DateTime.now();
  
      if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
        currentBackPressTime = now;
        Get.offAllNamed(ConstantRoutes.dashboard);
        return Future.value(true);
      } else {
        return Future.value(true);
      }
    }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: onbackpress,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.primaryColor,
          bottom: TabBar(
            isScrollable: true,
            // key: RIKeys.riKey2,
            controller: controller,
            tabs: myTabs,
          ),
          title: Text('Settlement'),
        ),
        drawer: drawer3(context),
        body: TabBarView(controller: controller,
            //  key: RIKeys.riKey1,
            // physics: const NeverScrollableScrollPhysics(),
            children: [
              CashTabPage(theme: theme),
              CardTabPage(theme: theme),
              ChequeTabPage(theme: theme),
              UPITabPage(theme: theme),
              DDTabPage(theme: theme),

              // AssignedPage(theme: theme),
              // UnAssignedPage(theme: theme),
              // LostEnqPage(theme: theme),
            ]),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     if (MenuAuthDetail.Enquiries == "Y") {
        //       context.read<NewEnqController>().clearAllData();
        //       Get.toNamed(ConstantRoutes.newEnq)!.then((value) {
        //         context.read<EnquiryMangerContoller>().resetAll(context);
        //       });
        //     } else {
        //       showDialog(
        //           context: context,
        //           barrierDismissible: true,
        //           builder: (BuildContext context) {
        //             return AlertDialog(
        //                 shape: RoundedRectangleBorder(
        //                     borderRadius: BorderRadius.all(Radius.circular(4))),
        //                 contentPadding: EdgeInsets.all(0),
        //                 insetPadding:
        //                     EdgeInsets.all(Screens.bodyheight(context) * 0.02),
        //                 content: settings(context));
        //           });
        //     }
        //   },
        //   child: Icon(Icons.add),
        // ),
      ),
    );
  }
}
