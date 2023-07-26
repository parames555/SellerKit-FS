// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Pages/OpenLead/Screen/FilterOpenLeadPage.dart';
import 'package:sellerkit/Pages/OpenLead/Screen/OpLViewAll.dart';
import '../../../Controller/OpenLeadController/OpenLeadController.dart';
import '../../../Widgets/Navi3.dart';
import '../Widegts/OpenLeadFDP.dart';
import 'OpenLeadFPFilt.dart';

class OpenLeadPageFoll extends StatefulWidget {
  OpenLeadPageFoll({Key? key}) : super(key: key);

  @override
  State<OpenLeadPageFoll> createState() => OpenLeadPageFollState();
}

class OpenLeadPageFollState extends State<OpenLeadPageFoll> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ChangeNotifierProvider<OpenLeadController>(
                      create: (context) => OpenLeadController(),
                      builder: (context, child) {
                        return Consumer<OpenLeadController>(
                            builder: (BuildContext context, prdFUP, Widget? child) {
            return WillPopScope(
              onWillPop: prdFUP.onbackpress,
              child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: theme.primaryColor,
                    title: Text('Open Lead'),
                  ),
                  drawer: drawer3(context),
                  body:
                  //  ChangeNotifierProvider<OpenLeadController>(
                  //     create: (context) => OpenLeadController(),
                  //     builder: (context, child) {
                  //       return Consumer<OpenLeadController>(
                  //           builder: (BuildContext context, prdFUP, Widget? child) {
                           (prdFUP.errorMsg == '' &&
                                  prdFUP.getOpenLeadData.isEmpty)
                              ? Center(child: CircularProgressIndicator())
                              : (prdFUP.errorMsg != '' &&
                                  prdFUP.getOpenLeadData.isEmpty)
                                  ? Center(child: Text(prdFUP.geterrorMsg))
                                  :PageView(
                                     physics: new NeverScrollableScrollPhysics(),
                            controller: prdFUP.pageController,
                            onPageChanged: (index) {
                              setState(() {
                               prdFUP.pageChanged = index;
                              });
                              print(prdFUP.pageChanged);
                            },
                                    children: [
                                      ListViewOpenLead(theme: theme, prdFUP: prdFUP,),
                                      FilterOpenLeadPage(openLeadController: prdFUP,),
                                      OPLViewALL(prdFUP: prdFUP,)
                                    ],
                                  )
                      ),
            );
          }
        );
      }
    );
  }  
  }






