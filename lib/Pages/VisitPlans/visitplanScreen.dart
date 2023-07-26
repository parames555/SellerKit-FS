// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, camel_case_types, unused_import

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Pages/VisitPlans/widgets/ClosedVisit.dart';
import 'package:sellerkit/Pages/VisitPlans/widgets/MissedVisitUser.dart';
import 'package:sellerkit/Pages/VisitPlans/widgets/OpenVisitPage.dart';
import '../../../Constant/MenuAuth.dart';
import '../../../Constant/Screen.dart';
// import '../../../Controller/EnquiryController/EnquiryUserContoller.dart';
// import '../../../Controller/EnquiryController/NewEnqController.dart';
import '../../../Widgets/Navi3.dart';
import '../../Controller/VisitplanController/VisitPlanController.dart';


class visitplanPage extends StatefulWidget {
  visitplanPage({Key? key}) : super(key: key);

  @override
  State<visitplanPage> createState() => visitplanPageState();
}

class visitplanPageState extends State<visitplanPage>
    with TickerProviderStateMixin {
  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Open'),
    Tab(text: 'Closed'),
    Tab(text: 'Missed'),
  ];
  TabController? controller;
  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 3, initialIndex: 0);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    setState(() {
              context.read<VisitplanController>().init();

    });
  
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // EnquiryUserContoller.enqDataprev = 0;
  }

  DateTime? currentBackPressTime;
  Future<bool> onbackpress() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Get.toNamed(ConstantRoutes.dashboard);
      return Future.value(true);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: onbackpress,
      child: Scaffold(
        appBar:AppBar(
                backgroundColor: theme.primaryColor,
                bottom: TabBar(
                  // key: RIKeys.riKey2,
                  controller: controller,
                  tabs: myTabs,
                ),
                title: Text('Visit Plan'),
              ),
           
        drawer: drawer3(context),
        body:  TabBarView(controller: controller,
                //  key: RIKeys.riKey1,
                // physics: const NeverScrollableScrollPhysics(),
                children: [
                    OpenVisitPage(theme: theme),
                    ClosedVisitPage(theme: theme),
                    MissiedUserPage(theme: theme),
                  ])
           
                ,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(ConstantRoutes.newvisitplan);
            // if (MenuAuthDetail.Enquiries == "Y") {
            //   context.read<NewEnqController>().clearAllData();
            //   Get.toNamed(ConstantRoutes.newEnq)!.then((value) {
            //     context.read<EnquiryUserContoller>().resetAll(context);
            //   });
            // } else {
            //   showDialog(
            //       context: context,
            //       barrierDismissible: true,
            //       builder: (BuildContext context) {
            //         return AlertDialog(
            //             shape: RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.all(Radius.circular(4))),
            //             contentPadding: EdgeInsets.all(0),
            //             insetPadding:
            //                 EdgeInsets.all(Screens.bodyheight(context) * 0.02),
            //             content: settings(context));
            //       });
            // }
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
