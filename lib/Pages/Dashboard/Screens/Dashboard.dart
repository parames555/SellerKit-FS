// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new, unused_field, prefer_final_fields
import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Controller/NotificationController/NotificationController.dart';
import '../../../Constant/padings.dart';
import '../../../Controller/DashBoardController/DashBoardController.dart';
import '../../../Widgets/Navi3.dart';
import 'Analytics.dart';
import 'FeedsPage.dart';
import 'KPIScreen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);
  @override
  State<Dashboard> createState() => DashboardState();
}

class DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  Timer? timer;
  TabController? controller;

@override
void didChangeDependencies() {
  Future.delayed(Duration(milliseconds: 300)).then((_) async {
    await Provider.of<NotificationContoller>(context, listen: false);
  });
  super.didChangeDependencies();
}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // context.read<NotificationContoller>().getUnSeenNotify();
      // context.read<NotificationContoller>().onReciveFCM();
      // context.read<DashBoardController>().getDefaultValues();
      // context.read<DashBoardController>().callKpiApi();
      // context.read<DashBoardController>().callFeedsApi();
      //context.read<DashBoardController>().checkAuth();
       log(ConstantValues.sapUserType);
    });

   // timer = Timer.periodic(Duration(seconds: 5), (Timer t) => periodicTask());
    controller = new TabController(vsync: this, length: 3, initialIndex: 0);
   // timer = Timer.periodic(Duration(seconds: 1), (Timer t) => notify());
  }

  // periodicTask() {
  //   print("Bala do it");
  //   // controller!.animateTo((controller!.index + 1));
  //   //changepageauto();
  // }

   int color = 0;
  // notify() {
  //   if (color == 0) {
  //     setState(() {
  //       color = 1;
  //     });
  //   } else {
  //     setState(() {
  //       color = 0;
  //     });
  //   }
  // }

  @override
  void dispose() {
    // TODO: implement dispose
   // timer!.cancel();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Paddings paddings = Paddings();
  var tabIndex = 0;
  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Feeds'),
    Tab(text: 'KPI'),
    Tab(text: 'Analytics'),
  ];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return
        //  DefaultTabController(
        //   length: 3,
        //   initialIndex: tabIndex,
        //   child:
        WillPopScope(
      onWillPop: onWillPop, // context.read<DashBoardController>().onbackpress ,
      child: 
      ChangeNotifierProvider<DashBoardController>(
                create: (context) => DashBoardController(),
                builder: (context, child) {
                  return Consumer<DashBoardController>(
                      builder: (BuildContext context, pvdDSBD, Widget? child) {
              return Scaffold(
                key: scaffoldKey,
                backgroundColor: Colors.grey[200],
                appBar: AppBar(
                  backgroundColor: theme.primaryColor,
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(80),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: Screens.bodyheight(context) * 0.02),
                      child: Column(
                        children: [
                          Container(
                            height: Screens.bodyheight(context) * 0.06,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                    Screens.width(context) * 0.01),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.7),
                                    spreadRadius: 3,
                                    blurRadius: 4,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ]),
                            child: TextField(
                              onTap: (){
                                  Get.toNamed(ConstantRoutes.screenshot);
                              },
                              autocorrect: false,
                              onChanged: (v) {
                              },
                              decoration: InputDecoration(
                                filled: false,
                                hintText: 'Search',
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                suffixIcon: Icon(
                                  Icons.search,
                                  color: theme.primaryColor,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 5,
                                ),
                              ),
                            ),
                          ),
                          TabBar(
                            controller: controller,
                            tabs: myTabs,
                          ),
                        ],
                      ),
                    ),
                  ),
                  title: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Hi, ${ConstantValues.firstName}',
                          style:
                              theme.textTheme.subtitle1?.copyWith(color: Colors.white),
                        ),
                        InkWell(
                            onTap: () {
                              //Get.toNamed(ConstantRoutes.testing);
                            },
                            child: Container(
                             // color: Colors.amber,
                               width: Screens.width(context)*0.12,
                               height: Screens.bodyheight(context)*0.055,
                              child: Stack(
                                children: [
                                  Icon(
                                    Icons.notifications,
                                    color: Colors.white54,
                                    size: Screens.bodyheight(context)*0.05,
                                  ),
                                  Positioned(
                                   // top: Screens.bodyheight(context)*0.005,
                                    left: Screens.width(context)*0.05,
                                    child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:  Colors.white
                              ),
                              padding: EdgeInsets.all(2),
                                      child: Text(context.watch<NotificationContoller>().getunSeenNotify.toString(),
                                        //"${pvdDSBD.getunSeenNotify}",
                                      style: theme.textTheme.bodyText2?.copyWith(
                                        color: theme.primaryColor
                                      ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
                // orderAppBar(context,scaffoldKey,"Dashboard"),
                drawer: drawer3(context),
                body:
                            DashBoardController. isLogout == true?
                            Center(child: CircularProgressIndicator())
                            :
                            TabBarView(controller: controller,
                                // physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  (pvdDSBD.feedData.isNotEmpty &&
                                          pvdDSBD.feedsApiExcp == '' &&
                                          pvdDSBD.isloading == false)
                                      ? FeedsPage(pvdDSBD: pvdDSBD)
                                      : (pvdDSBD.feedData.isEmpty &&
                                              pvdDSBD.feedsApiExcp != '' &&
                                              pvdDSBD.isloading == false)
                                          ? Center(child: Text(pvdDSBD.feedsApiExcp))
                                          : Center(
                                              child: CircularProgressIndicator(),
                                            ),
                                  //  Empojii(),
                                  pvdDSBD.getKpiData.isNotEmpty
                                      ? KPIScreen(
                                          pvdDSBD: pvdDSBD,
                                          color: color,
                                          kpiData: pvdDSBD.getKpiData,
                                        )
                                      : Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                  AnalyticsPage(
                                    data21: context.read<DashBoardController>().data21,
                                    dataMap:
                                        context.read<DashBoardController>().dataMap,
                                  )
                                ]),
                        //   });
                        // }),

                        floatingActionButton: FloatingActionButton(
                          child: Icon(Icons.add,
                          ),
                          onPressed: (){
                              Get.toNamed(ConstantRoutes.feedsCreation);
                        }),
              );
            }
          );
        }
      ),
    );
  }

  changepageauto() {
    if (controller!.index == 0) {
      controller!.animateTo((controller!.index + 1));
    } else if (controller!.index == 1) {
      controller!.animateTo((controller!.index + 1));
    } else if (controller!.index == 2) {
      controller!.animateTo((controller!.index - 2));
    }
  }

  Future<bool> onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Are you sure?"),
            content: Text("Do you want to exit an app"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text("No"),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text("yes"))
            ],
          ),
        )) ??
        false;
  }
}
