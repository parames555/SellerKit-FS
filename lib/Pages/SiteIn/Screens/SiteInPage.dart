// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../../../Constant/ConstantRoutes.dart';
import '../../../Constant/Screen.dart';
import '../../../Controller/SiteInController/SiteInController.dart';
import '../../../Controller/SiteInController/SiteInController.dart';
import '../../../Widgets/Appbar.dart';
import '../../../Widgets/Navi3.dart';

class SiteInPage extends StatefulWidget {
  const SiteInPage({Key? key}) : super(key: key);

  @override
  State<SiteInPage> createState() => _SiteInPageState();
}

class _SiteInPageState extends State<SiteInPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState

// callKpiApi();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<SiteInController>().validateCheckIn(context);
      context.read<SiteInController>().clearAll();
      context.read<SiteInController>().init();
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
    return WillPopScope(
        onWillPop: onbackpress,
        child: Scaffold(
          drawer: drawer3(context),
          appBar: appbar("Site-Check-In", theme, context),
          body: Container(
            //color: Colors.red,
            width: Screens.width(context),
            height: Screens.bodyheight(context),
            padding: EdgeInsets.symmetric(
                horizontal: Screens.width(context) * 0.03,
                vertical: Screens.bodyheight(context) * 0.02),
            child: Column(
              children: [
                InkWell(
                  onTap: () async {
                    context.read<SiteInController>().source1 =
                        // await widget.prdsrch.
                        await context.read<SiteInController>().getPathOFDB();
                    context.read<SiteInController>().copyTo = await
                        //  widget.prdsrch.
                        context.read<SiteInController>().getDirectory();

                    bool permission = await context
                        .read<SiteInController>()
                        .getPermissionStorage();
                    if (permission == true) {
                      if ((await context
                          .read<SiteInController>()
                          .copyTo!
                          .exists())) {
                        print("EXISTS");
                        // widget.prdsrch
                        context.read<SiteInController>().createDBFile(
                            context.read<SiteInController>().copyTo!.path);
                      } else {
                        print("Not EXISTS");
                        // widget.prdsrch.
                        context.read<SiteInController>().createDirectory();
                      }
                    } else if (permission == false) {
                      context.read<SiteInController>().showSnackBars(
                          'Please give stoage permission to continue!!..',
                          Colors.red);
                    }
                  },
                  child: Container(
                    height: Screens.bodyheight(context) * 0.05,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      " Upcomming Visit Plans",
                      style: theme.textTheme.headline6
                          ?.copyWith(color: theme.primaryColor),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount:
                        context.watch<SiteInController>().openVisitData.length,
                    itemBuilder: (BuildContext context, int i) {
                      return InkWell(
                        onTap: () {
                          context.read<SiteInController>().selectedOpenVisits(
                              context
                                  .read<SiteInController>()
                                  .openVisitData[i]);
                          Get.toNamed(ConstantRoutes.newsitein);
                        },
                        onLongPress: () {},
                        child: Container(
                          width: Screens.width(context),
                          padding: EdgeInsets.symmetric(
                              horizontal: Screens.width(context) * 0.02,
                              vertical: Screens.bodyheight(context) * 0.01),
                          child: Container(
                            color: Colors.grey[200],
                            padding: EdgeInsets.symmetric(
                                horizontal: Screens.width(context) * 0.02,
                                vertical: Screens.bodyheight(context) * 0.01),
                            width: Screens.width(context),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: Screens.width(context) * 0.4,
                                      child: Text(
                                        "Customer",
                                        style: theme.textTheme.bodyText2
                                            ?.copyWith(color: Colors.grey),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      width: Screens.width(context) * 0.4,
                                      child: Text(
                                        "Date & Time",
                                        style: theme.textTheme.bodyText2
                                            ?.copyWith(color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: Screens.width(context) * 0.4,
                                      child: Text(
                                          "${context.watch<SiteInController>().openVisitData[i].customer}",
                                          style: theme.textTheme.bodyText2
                                              ?.copyWith(
                                            color: theme.primaryColor,
                                            // fontWeight: FontWeight.bold
                                          )),
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      width: Screens.width(context) * 0.4,
                                      child: Text(
                                          "${context.watch<SiteInController>().openVisitData[i].datetime}",
                                          style: theme.textTheme.bodyText2
                                              ?.copyWith(
                                            color: theme.primaryColor,
                                            //fontWeight: FontWeight.bold
                                          )),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: Screens.bodyheight(context) * 0.01,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: Screens.width(context) * 0.4,
                                      child: Text(
                                        "Purpose",
                                        style: theme.textTheme.bodyText2
                                            ?.copyWith(color: Colors.grey),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      width: Screens.width(context) * 0.4,
                                      child: Text(
                                        "Area",
                                        style: theme.textTheme.bodyText2
                                            ?.copyWith(color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                ),
                                IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        // color:Colors.red,

                                        alignment: Alignment.topLeft,
                                        width: Screens.width(context) * 0.4,
                                        child: Text(
                                            "${context.watch<SiteInController>().openVisitData[i].purpose}",
                                            style: theme.textTheme.bodyText2
                                                ?.copyWith(
                                              color: theme.primaryColor,
                                              //fontWeight: FontWeight.bold
                                            )),
                                      ),
                                      Container(
                                        // color:Colors.red,
                                        alignment: Alignment.topRight,
                                        width: Screens.width(context) * 0.4,
                                        child: Text(
                                            "${context.watch<SiteInController>().openVisitData[i].area!} ",
                                            textAlign: TextAlign.right,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3,
                                            //"₹ ${context.watch<EnquiryUserContoller>().getopenEnqData[i].PotentialValue}",
                                            style: theme.textTheme.bodyText2
                                                ?.copyWith(
                                              color: theme.primaryColor,
                                              //fontWeight: FontWeight.bold
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: Screens.bodyheight(context) * 0.01,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          //color: Colors.red,
                                          width: Screens.width(context) * 0.54,
                                          child: Text("Product",
                                              style: theme.textTheme.bodyText2
                                                  ?.copyWith(
                                                color: Colors.grey,
                                                // fontWeight: FontWeight.bold
                                              )),
                                        ),
                                        Container(
                                          // color: Colors.red,
                                          alignment: Alignment.centerLeft,
                                          width: Screens.width(context) * 0.54,
                                          child: Text(
                                              "${context.watch<SiteInController>().openVisitData[i].product!}",
                                              //"₹ ${context.watch<EnquiryUserContoller>().getopenEnqData[i].PotentialValue}",
                                              style: theme.textTheme.bodyText2
                                                  ?.copyWith(
                                                color: theme.primaryColor,
                                                //fontWeight: FontWeight.bold
                                              )),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      alignment: Alignment.bottomRight,
                                      // color: Colors.green[200],
                                      width: Screens.width(context) * 0.3,
                                      child: Container(
                                        // padding: EdgeInsets.only(
                                        //   left: Screens.width(context) * 0.02,
                                        //   right: Screens.width(context) * 0.02,
                                        // ),
                                        decoration: BoxDecoration(
                                            color: Colors.green[200],
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        // width: Screens.width(context) * 0.1,
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                              Screens.width(context) * 0.01),
                                          child: Text(
                                              "${context.watch<SiteInController>().openVisitData[i].type}",
                                              style: theme.textTheme.bodyText2
                                                  ?.copyWith(
                                                      color: Colors.green[700],
                                                      fontSize: 12
                                                      // fontWeight: FontWeight.bold
                                                      )),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                // Container(
                                //     padding: EdgeInsets.symmetric(
                                //         horizontal: Screens.width(context) * 0.1),
                                //     child: Divider(
                                //       thickness: 1,
                                //     ))
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.read<SiteInController>().clearText();
              Get.toNamed(ConstantRoutes.newsitein);
            },
            child: IconButton(
                onPressed: () {
                  context.read<SiteInController>().clearText();
                  Get.toNamed(ConstantRoutes.newsitein);
                },
                icon: Icon(Icons.add)),
          ),
        ));
  }
}
