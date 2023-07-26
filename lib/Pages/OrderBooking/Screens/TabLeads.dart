// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import '../../../Controller/LeadController/TabLeadController.dart';
import '../../../Widgets/Navi3.dart';
import '../../Enquiries/EnquiriesUser/Widgets/GlobalKeys.dart';
import '../Widgets/WonLeadPage.dart';
import '../Widgets/LostLead.dart';
import '../Widgets/OpenLead.dart';

class LeadsTabPage extends StatefulWidget {
  LeadsTabPage({Key? key}) : super(key: key);

  @override
  State<LeadsTabPage> createState() =>LeadsTabState();
}

class LeadsTabState extends State<LeadsTabPage>
    with TickerProviderStateMixin {
  // final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Open'),
    Tab(text: 'Delivered'),
    // Tab(text: 'Lost'),
  ];
  TabController? controller;
  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 2, initialIndex: 0);
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        log("comeFromEnq: "+LeadTabController.comeFromEnq.toString());
        if(LeadTabController.comeFromEnq==-1){
           log("comeFromEnq: 11");
            context.read<LeadTabController>().clearAllListData();
            context.read<LeadTabController>().callGetAllApi();
            context.read<LeadTabController>().callSummaryApi();
            context.read<LeadTabController>().getLeadStatus();
        }else if(LeadTabController.comeFromEnq!=-1){
           log("comeFromEnq: 22");
           log("LeadTabController.isSameBranch: ${LeadTabController.isSameBranch}");
                          
           if( LeadTabController.isSameBranch == true){
             context.read<LeadTabController>().clearAllListData();
            context.read<LeadTabController>().callGetAllApi();
            context.read<LeadTabController>().callSummaryApi();
            context.read<LeadTabController>().getLeadStatus();
            context.read<LeadTabController>().comeFromEnqApi( context,LeadTabController.comeFromEnq.toString());
           }
           else{
              context.read<LeadTabController>().clearAllListData();
            context.read<LeadTabController>().callGetAllApi();
            context.read<LeadTabController>().callSummaryApi();
            context.read<LeadTabController>().getLeadStatus();
            context.read<LeadTabController>().comeFromEnqApi( context,LeadTabController.comeFromEnq.toString());
           }       
        }
    });
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
    return 
    WillPopScope(
      onWillPop: onbackpress,
      child: Scaffold(
        appBar:
         AppBar(
          backgroundColor: theme.primaryColor,
          bottom: TabBar(
            controller: controller,
            tabs: myTabs,
          ),
          title: Text('Orders'),
        ),
        // :AppBar(
        //    backgroundColor: theme.primaryColor,
        //   title: Text('Leads'),),
        drawer: drawer3(context),
        body: 
      //  ChangeNotifierProvider<LeadTabController>(
      //         create: (context) => LeadTabController(),
      //         builder: (context, child) {
      //           return Consumer<LeadTabController>(
      //               builder: (BuildContext context, provi, Widget? child) {
           //     return 
                  
                       context.watch<LeadTabController>().getLeadCheckDataExcep.isEmpty&&
               (
                 context.watch<LeadTabController>().getleadSummaryLost.isNotEmpty||
                 context.watch<LeadTabController>().getleadSummaryOpen.isNotEmpty||
                 context.watch<LeadTabController>().getleadSummaryWon.isNotEmpty
               ) &&
                ( context.watch<LeadTabController>().getAllLeadData.isNotEmpty ||
                 context.watch<LeadTabController>().getleadLostAllData.isNotEmpty||
                 context.watch<LeadTabController>().getleadClosedAllData.isNotEmpty
                )?
                TabBarView(
                    controller: controller,
                    children: [
                      OpenLeadPage(theme: theme, leadOpenAllData: context.read<LeadTabController>().getAllLeadData, 
                      leadSummaryOpen: context.read<LeadTabController>().getleadSummaryOpen, 
                      provi: context.watch<LeadTabController>(),),
                      WonLeadPage(theme: theme, leadWonAllData: 
                      context.read<LeadTabController>().getleadClosedAllData, 
                      leadSummaryWon: context.read<LeadTabController>().getleadSummaryWon,
                       provi: context.read<LeadTabController>(),),
                      // LostLeadPage(theme: theme, leadLostAllData: context.read<LeadTabController>().getleadLostAllData, 
                      // leadSummaryLost: context.read<LeadTabController>().getleadSummaryLost, 
                      // provi: context.read<LeadTabController>(),),
                    ])
                   :
             
               context.watch<LeadTabController>().getLeadCheckDataExcep.isEmpty&&
                    (
                 context.watch<LeadTabController>().getleadSummaryLost.isEmpty&&
                 context.watch<LeadTabController>().getleadSummaryOpen.isEmpty&&
                 context.watch<LeadTabController>().getleadSummaryWon.isEmpty
               ) &&
                ( context.watch<LeadTabController>().getAllLeadData.isEmpty &&
                 context.watch<LeadTabController>().getleadLostAllData.isEmpty&&
                 context.watch<LeadTabController>().getleadClosedAllData.isEmpty
                )?
                    Center(child: CircularProgressIndicator())
                    :Center(child: Text(context.watch<LeadTabController>().getLeadCheckDataExcep),
                    ),
        //      }
        //     );
        //   }
        // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(ConstantRoutes.leads)!.then((value) {
          });
        },
        child: Icon(Icons.add),
      ),
      ),
    );
  }
}


