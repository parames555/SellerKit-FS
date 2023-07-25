// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
// import 'package:sellerkit/Controller/EnquiryController/EnquiryMngController.dart';
import 'package:sellerkit/Pages/Enquiries/EnquiriesUser/Widgets/ClosedEnq.dart';
import 'package:sellerkit/Pages/Enquiries/EnquiriesUser/Widgets/LostEnqUser.dart';
import 'package:sellerkit/Pages/Enquiries/EnquiriesUser/Widgets/OpenEnqPage.dart';
import '../../../Constant/MenuAuth.dart';
import '../../../Constant/Screen.dart';
import '../../../Controller/EnquiryController/EnquiryUserContoller.dart';
import '../../../Controller/EnquiryController/NewEnqController.dart';
import '../../../Widgets/Navi3.dart';
import '../NewEnquiry.dart';
import 'Widgets/GlobalKeys.dart';

class EnquiryUserPage extends StatefulWidget {
  EnquiryUserPage({Key? key}) : super(key: key);

  @override
  State<EnquiryUserPage> createState() => EnquiryUserPageState();
}

class EnquiryUserPageState extends State<EnquiryUserPage>
    with TickerProviderStateMixin {
  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Open'),
    Tab(text: 'Closed'),
    Tab(text: 'Lost'),
  ];
  TabController? controller;
  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 3, initialIndex: 0);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (EnquiryUserContoller.enqDataprev == 0) {
        context.read<EnquiryUserContoller>().callApi();
        context.read<EnquiryUserContoller>().callUserListApi();
        context.read<EnquiryUserContoller>().callResonApi();
      } else {
        context.read<EnquiryUserContoller>().resetAll(context);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    EnquiryUserContoller.enqDataprev = 0;
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
        appBar: context.watch<EnquiryUserContoller>().getdatagotByApi == true &&
                context.watch<EnquiryUserContoller>().getException == false
            ? AppBar(
                backgroundColor: theme.primaryColor,
                bottom: TabBar(
                  // key: RIKeys.riKey2,
                  controller: controller,
                  tabs: myTabs,
                ),
                title: Text('Enquiries'),
              )
            : AppBar(
                backgroundColor: theme.primaryColor,
                title: Text('Enquiries'),
              ),
        drawer: drawer3(context),
        body: context.watch<EnquiryUserContoller>().getdatagotByApi == true &&
                (context
                        .watch<EnquiryUserContoller>()
                        .getopenEnqData
                        .isNotEmpty ||
                    context
                        .watch<EnquiryUserContoller>()
                        .getclosedEnqdata
                        .isNotEmpty ||
                    context
                        .watch<EnquiryUserContoller>()
                        .getlostEnqUserdata
                        .isNotEmpty) &&
                context.watch<EnquiryUserContoller>().getException == false
            ? TabBarView(controller: controller,
                //  key: RIKeys.riKey1,
                // physics: const NeverScrollableScrollPhysics(),
                children: [
                    OpenEnqPage(theme: theme),
                    ClosedEnqPage(theme: theme),
                    LostEnqUserPage(theme: theme),
                  ])
            : context.watch<EnquiryUserContoller>().getdatagotByApi == false &&
                    (context
                            .watch<EnquiryUserContoller>()
                            .getopenEnqData
                            .isEmpty ||
                        context
                            .watch<EnquiryUserContoller>()
                            .getclosedEnqdata
                            .isEmpty ||
                        context
                            .watch<EnquiryUserContoller>()
                            .getlostEnqUserdata
                            .isEmpty) &&
                    context.watch<EnquiryUserContoller>().getException == true
                ? Center(
                    child:
                        Text(context.watch<EnquiryUserContoller>().getErrorMsg))
                : Center(child: CircularProgressIndicator()),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (MenuAuthDetail.Enquiries == "Y") {
              context.read<NewEnqController>().clearAllData();
              Get.toNamed(ConstantRoutes.newEnq)!.then((value) {
                context.read<EnquiryUserContoller>().resetAll(context);
              });
            } else {
              showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        contentPadding: EdgeInsets.all(0),
                        insetPadding:
                            EdgeInsets.all(Screens.bodyheight(context) * 0.02),
                        content: settings(context));
                  });
            }
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
