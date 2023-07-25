// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, unnecessary_string_interpolations, unused_local_variable

import 'dart:developer';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/Helper.dart';
import '../Constant/AppConstant.dart';
import '../Constant/ConstantSapValues.dart';
import '../Constant/MenuAuth.dart';
import '../Constant/Screen.dart';
import '../Constant/SharedPreference.dart';
import '../Controller/DashBoardController/DashBoardController.dart';
// import '../Pages/VisitPlans/visitplanScreen.dart';
import '../Controller/SiteInController/SiteInController.dart';
import '../Controller/SiteOutController/SiteOutController.dart';
import '../Pages/SiteIn/Widgets/TestMapPage.dart';
import '../Pages/VisitPlans/visitplanScreen.dart';
import 'IconContainer.dart';

Container drawer3(BuildContext context) {
  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;
  final theme = Theme.of(context);
  return Container(
    width: Screens.width(context),
    child: Drawer(
        child: ListView(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
              vertical: Screens.fullHeight(context) * 0.02,
              horizontal: Screens.width(context) * 0.02),
          width: Screens.width(context),
          height: Screens.fullHeight(context),
          // color: theme.primaryColor,
          color: Colors.grey[200],
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: Screens.fullHeight(context) * 0.01,
                  ),

                  InkWell(
                    onTap: () {
                      log("MenuAuthDetail.Dashboard ${MenuAuthDetail.Dashboard}");
                      if (MenuAuthDetail.Dashboard == "Y") {
                        Navigator.pop(context);
                        Get.offAllNamed(ConstantRoutes.dashboard);
                      } else {
                        showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4))),
                                  contentPadding: EdgeInsets.all(0),
                                  insetPadding: EdgeInsets.all(
                                      Screens.bodyheight(context) * 0.02),
                                  content: settings(context));
                            });
                      }
                    },
                    child: Container(
                      width: Screens.width(context),
                      // height: Screens.fullHeight(context)*0.3,
                      //Colors.white,//Colors.amber,
                      padding: EdgeInsets.symmetric(
                          vertical: Screens.fullHeight(context) * 0.02,
                          horizontal: Screens.width(context) * 0.04),
                      decoration: BoxDecoration(
                          color: theme.primaryColor,
                          borderRadius: BorderRadius.circular(8)),
                      alignment: Alignment.center,
                      child: Center(
                        child: Row(
                          children: [
                            Container(
                              width: Screens.width(context) * 0.4,
                              child: Icon(Icons.home),
                              alignment: Alignment.centerRight,
                              // height: Screens.fullHeight(context)*0.3,
                            ),
                            SizedBox(
                              width: Screens.width(context) * 0.004,
                            ),
                            Container(
                              width: Screens.width(context) * 0.4,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Dashboard",
                                style: theme.textTheme.bodyLarge
                                    ?.copyWith(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: Screens.fullHeight(context) * 0.01,
                  ),

                  ///
                  Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Container(
                      width: Screens.width(context),
                      // height: Screens.fullHeight(context)*0.3,
                      //Colors.amber,
                      padding: EdgeInsets.symmetric(
                          vertical: Screens.fullHeight(context) * 0.01,
                          horizontal: Screens.width(context) * 0.02),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              "Activities",
                              style: theme.textTheme.headline6
                                  ?.copyWith(color: theme.primaryColor),
                            ),
                          ),
                          SizedBox(
                            height: Screens.fullHeight(context) * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconContainer(
                                theme: theme,
                                callback: () async {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => MapSample(),
                                  //     ));
                                  String? dayType =
                                      await SharedPref.getDayStart();
                                  log(dayType.toString());
                                  if (dayType == "DayStart") {
                                    Get.toNamed(ConstantRoutes.dayEndPage);
                                  } else if (dayType == "DayEnd"||dayType == null) {
                                    Get.toNamed(ConstantRoutes.daystartend);
                                  }

                                  // if (MenuAuthDetail.ScoreCard == "Y") {
                                  //   Navigator.pop(context);
                                  // Get.toNamed(
                                  //     ConstantRoutes.scoreCardScreenOne);
                                  // } else {
                                  //   showDialog(
                                  //       context: context,
                                  //       barrierDismissible: true,
                                  //       builder: (BuildContext context) {
                                  //         return AlertDialog(
                                  //             shape: RoundedRectangleBorder(
                                  //                 borderRadius:
                                  //                     BorderRadius.all(
                                  //                         Radius.circular(4))),
                                  //             contentPadding: EdgeInsets.all(0),
                                  //             insetPadding: EdgeInsets.all(
                                  //                 Screens.bodyheight(context) *
                                  //                     0.02),
                                  //             content: settings(context));
                                  //       });
                                  // }
                                },
                                icon: Icons.update,
                                iconColor: theme.primaryColor, // Colors.green,
                                title: 'Day Start/End',
                                textalign: TextAlign.center,
                              ),
                              IconContainer(
                                theme: theme,
                                callback: () {
                                  // if (MenuAuthDetail.Earnings == "Y") {
                                  Navigator.pop(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => visitplanPage(),
                                      ));
                                  // } else {
                                  //   showDialog(
                                  //       context: context,
                                  //       barrierDismissible: true,
                                  //       builder: (BuildContext context) {
                                  //         return AlertDialog(
                                  //             shape: RoundedRectangleBorder(
                                  //                 borderRadius:
                                  //                     BorderRadius.all(
                                  //                         Radius.circular(4))),
                                  //             contentPadding: EdgeInsets.all(0),
                                  //             insetPadding: EdgeInsets.all(
                                  //                 Screens.bodyheight(context) *
                                  //                     0.02),
                                  //             content: settings(context));
                                  //       });
                                  // }
                                },
                                icon: Icons.hail,
                                iconColor: theme.primaryColor, //Colors.blue,
                                title: 'Visit Plan',
                              ),
                              IconContainer(
                                theme: theme,
                                callback: () {
                                  // if (MenuAuthDetail.Performance == "Y") {
                                  //   Navigator.pop(context);
                                  Navigator.pop(context);
                                  context
                                      .read<SiteInController>()
                                      .validateCheckIn(context);

                                  Get.toNamed(ConstantRoutes.sitein);
                                  // } else {
                                  //   showDialog(
                                  //       context: context,
                                  //       barrierDismissible: true,
                                  //       builder: (BuildContext context) {
                                  //         return AlertDialog(
                                  //             shape: RoundedRectangleBorder(
                                  //                 borderRadius:
                                  //                     BorderRadius.all(
                                  //                         Radius.circular(4))),
                                  //             contentPadding: EdgeInsets.all(0),
                                  //             insetPadding: EdgeInsets.all(
                                  //                 Screens.bodyheight(context) *
                                  //                     0.02),
                                  //             content: settings(context));
                                  //       });
                                  // }
                                },
                                icon: Icons.login,
                                iconColor: theme.primaryColor, //Colors.orange,
                                title: 'Site In',
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Screens.fullHeight(context) * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconContainer(
                                theme: theme,
                                callback: () {
                                  // if (MenuAuthDetail.Target == "Y") {
                                  //   Navigator.pop(context);
                                  context
                                      .read<SiteOutController>()
                                      .validateCheckIn(context);

                                  // } else {
                                  //   showDialog(
                                  //       context: context,
                                  //       barrierDismissible: true,
                                  //       builder: (BuildContext context) {
                                  //         return AlertDialog(
                                  //             shape: RoundedRectangleBorder(
                                  //                 borderRadius:
                                  //                     BorderRadius.all(
                                  //                         Radius.circular(4))),
                                  //             contentPadding: EdgeInsets.all(0),
                                  //             insetPadding: EdgeInsets.all(
                                  //                 Screens.bodyheight(context) *
                                  //                     0.02),
                                  //             content: settings(context));
                                  //       });
                                  // }
                                },
                                icon: Icons.logout,
                                iconColor: theme.primaryColor, //.pink,
                                title: 'Site Out',
                                textalign: TextAlign.center,
                              ),
                              IconContainer(
                                theme: theme,
                                callback: () {
                                  // if (MenuAuthDetail.Challenges == "Y") {
                                  //   Navigator.pop(context);
                                  //   // Navigator.push(
                                  //   //     context,
                                  //   //     MaterialPageRoute(
                                  //   //       builder: (context) => Challenges(),
                                  //   //     ));
                                  // } else {
                                  //   showDialog(
                                  //       context: context,
                                  //       barrierDismissible: true,
                                  //       builder: (BuildContext context) {
                                  //         return AlertDialog(
                                  //             shape: RoundedRectangleBorder(
                                  //                 borderRadius:
                                  //                     BorderRadius.all(
                                  //                         Radius.circular(4))),
                                  //             contentPadding: EdgeInsets.all(0),
                                  //             insetPadding: EdgeInsets.all(
                                  //                 Screens.bodyheight(context) *
                                  //                     0.02),
                                  //             content: settings(context));
                                  //       });
                                  // }
                                },
                                icon: Icons.send_time_extension,
                                iconColor: theme.primaryColor, //Colors.amber,
                                title: 'Leave Request',
                                textalign: TextAlign.center,
                              ),
                              IconContainer(
                                theme: theme,
                                callback: () {},
                                icon: Icons.beenhere,
                                iconColor: theme.primaryColor,
                                title: 'Leave Approval',
                                textalign: TextAlign.center,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Screens.fullHeight(context) * 0.01,
                  ),
                  Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Container(
                      width: Screens.width(context),
                      // height: Screens.fullHeight(context)*0.3,
                      //Colors.amber,
                      padding: EdgeInsets.symmetric(
                          vertical: Screens.fullHeight(context) * 0.01,
                          horizontal: Screens.width(context) * 0.02),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              "Resource",
                              style: theme.textTheme.headline6
                                  ?.copyWith(color: theme.primaryColor),
                            ),
                          ),
                          SizedBox(
                            height: Screens.fullHeight(context) * 0.01,
                          ),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconContainer(
                                  theme: theme,
                                  callback: () {
                                    // if (MenuAuthDetail.Stocks == "Y") {
                                    Navigator.pop(context);
                                    Get.toNamed(ConstantRoutes.stock);
                                    // } else {
                                    //   showDialog(
                                    //       context: context,
                                    //       barrierDismissible: true,
                                    //       builder: (BuildContext context) {
                                    //         return AlertDialog(
                                    //             shape: RoundedRectangleBorder(
                                    //                 borderRadius:
                                    //                     BorderRadius.all(
                                    //                         Radius.circular(
                                    //                             4))),
                                    //             contentPadding:
                                    //                 EdgeInsets.all(0),
                                    //             insetPadding: EdgeInsets.all(
                                    //                 Screens.bodyheight(
                                    //                         context) *
                                    //                     0.02),
                                    //             content: settings(context));
                                    //       });
                                    // }
                                  },
                                  icon: Icons.inventory,
                                  iconColor:
                                      theme.primaryColor, // Colors.green,
                                  title: 'Stocks'),
                              IconContainer(
                                theme: theme,
                                callback: () {
                                  // if (MenuAuthDetail.PriceList == "Y") {
                                  Navigator.pop(context);
                                  Get.toNamed(ConstantRoutes.priceList);
                                  // } else {
                                  //   showDialog(
                                  //       context: context,
                                  //       barrierDismissible: true,
                                  //       builder: (BuildContext context) {
                                  //         return AlertDialog(
                                  //             shape: RoundedRectangleBorder(
                                  //                 borderRadius:
                                  //                     BorderRadius.all(
                                  //                         Radius.circular(4))),
                                  //             contentPadding: EdgeInsets.all(0),
                                  //             insetPadding: EdgeInsets.all(
                                  //                 Screens.bodyheight(context) *
                                  //                     0.02),
                                  //             content: settings(context));
                                  //       });
                                  // }
                                },
                                icon: Icons.currency_rupee,
                                iconColor: theme.primaryColor, //Colors.blue,
                                title: 'Price List',
                              ),
                              // IconContainer(
                              //   theme: theme,
                              //   callback: () {
                              // if (MenuAuthDetail.OfferZone == "Y") {
                              //   Navigator.pop(context);
                              //   Get.toNamed(ConstantRoutes.offerZone);
                              // } else {
                              //   showDialog(
                              //       context: context,
                              //       barrierDismissible: true,
                              //       builder: (BuildContext context) {
                              //         return AlertDialog(
                              //             shape: RoundedRectangleBorder(
                              //                 borderRadius:
                              //                     BorderRadius.all(
                              //                         Radius.circular(4))),
                              //             contentPadding: EdgeInsets.all(0),
                              //             insetPadding: EdgeInsets.all(
                              //                 Screens.bodyheight(context) *
                              //                     0.02),
                              //             content: settings(context));
                              //       });
                              // }
                              //   },
                              //   icon: Icons.free_cancellation,
                              //   iconColor: theme.primaryColor, //Colors.orange,
                              //   title: 'Offer Zone',
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Screens.fullHeight(context) * 0.01,
                  ),
                  Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Container(
                      width: Screens.width(context),
                      // height: Screens.fullHeight(context)*0.3,
                      //Colors.amber,
                      padding: EdgeInsets.symmetric(
                          vertical: Screens.fullHeight(context) * 0.01,
                          horizontal: Screens.width(context) * 0.02),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              "Pre Sales",
                              style: theme.textTheme.headline6
                                  ?.copyWith(color: theme.primaryColor),
                            ),
                          ),
                          SizedBox(
                            height: Screens.fullHeight(context) * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              // IconContainer(
                              //   theme: theme,
                              //   callback: () {
                              //     if (MenuAuthDetail.Walkins == "Y") {
                              //       Navigator.pop(context);
                              //       Get.toNamed(ConstantRoutes.walkins);
                              //     } else {
                              //       showDialog(
                              //           context: context,
                              //           barrierDismissible: true,
                              //           builder: (BuildContext context) {
                              //             return AlertDialog(
                              //                 shape: RoundedRectangleBorder(
                              //                     borderRadius:
                              //                         BorderRadius.all(
                              //                             Radius.circular(4))),
                              //                 contentPadding: EdgeInsets.all(0),
                              //                 insetPadding: EdgeInsets.all(
                              //                     Screens.bodyheight(context) *
                              //                         0.02),
                              //                 content: settings(context));
                              //           });
                              //     }
                              //   },
                              //   icon: Icons.wysiwyg,
                              //   iconColor: theme.primaryColor, //Colors.blue,
                              //   title: 'Walkins',
                              // ),
                              // IconContainer(
                              //   theme: theme,
                              //   callback: () {
                              //     if (MenuAuthDetail.Leads != "Y") {
                              //       Navigator.pop(context);
                              //       Get.offAllNamed(
                              //           ConstantRoutes.leadstab);

                              //     } else {
                              //       showDialog(
                              //           context: context,
                              //           barrierDismissible: true,
                              //           builder: (BuildContext context) {
                              //             return AlertDialog(
                              //                 shape: RoundedRectangleBorder(
                              //                     borderRadius:
                              //                         BorderRadius.all(
                              //                             Radius.circular(4))),
                              //                 contentPadding: EdgeInsets.all(0),
                              //                 insetPadding: EdgeInsets.all(
                              //                     Screens.bodyheight(context) *
                              //                         0.02),
                              //                 content: settings(context));
                              //           });
                              //     }
                              //   },
                              //   icon: Icons.checklist,
                              //   iconColor: theme.primaryColor, //Colors.orange,
                              //   title: 'Leads',
                              // ),
                            ],
                          ),
                          SizedBox(
                            height: Screens.fullHeight(context) * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconContainer(
                                theme: theme,
                                callback: () {
                                  if (MenuAuthDetail.Enquiries == "Y") {
                                    Navigator.pop(context);

                                    if (ConstantValues.sapUserType
                                            .toLowerCase() ==
                                        'manager') {
                                      // Get.toNamed(ConstantRoutes.enquiriesManager);
                                      log(ConstantValues.sapUserType);
                                      Get.offAllNamed(
                                          ConstantRoutes.enquiriesManager);
                                    } else {
                                      Get.offAllNamed(
                                          ConstantRoutes.enquiriesUser);
                                      // Get.toNamed(ConstantRoutes.enquiriesUser);
                                    }
                                  } else {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(4))),
                                              contentPadding: EdgeInsets.all(0),
                                              insetPadding: EdgeInsets.all(
                                                  Screens.bodyheight(context) *
                                                      0.02),
                                              content: settings(context));
                                        });
                                  }
                                },
                                icon: Icons.edit_note,
                                iconColor: theme.primaryColor, // Colors.green,
                                title: 'Enquiries',
                              ),
                              IconContainer(
                                theme: theme,
                                callback: () {
                                  Get.toNamed(ConstantRoutes.leadstab);
                                },
                                icon: Icons.shopping_bag,
                                iconColor: theme.primaryColor, //.pink,
                                title: 'Order Booking',
                                textalign: TextAlign.center,
                              ),
                              IconContainer(
                                theme: theme,
                                callback: () {
                                  //
                                  // if (MenuAuthDetail.Followup == "Y") {
                                  Navigator.pop(context);
                                  Get.toNamed(ConstantRoutes.followupTab);
                                  // } else {
                                  //   showDialog(
                                  //       context: context,
                                  //       barrierDismissible: true,
                                  //       builder: (BuildContext context) {
                                  //         return AlertDialog(
                                  //             shape: RoundedRectangleBorder(
                                  //                 borderRadius:
                                  //                     BorderRadius.all(
                                  //                         Radius.circular(4))),
                                  //             contentPadding: EdgeInsets.all(0),
                                  //             insetPadding: EdgeInsets.all(
                                  //                 Screens.bodyheight(context) *
                                  //                     0.02),
                                  //             content: settings(context));
                                  //       });
                                  // }
                                },
                                icon: Icons.redeem_rounded,
                                iconColor: theme.primaryColor, //Colors.amber,
                                title: 'Follow up',
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Screens.fullHeight(context) * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconContainer(
                                theme: theme,
                                callback: () {
                                  // if (MenuAuthDetail.Accounts == "Y") {
                                  Navigator.pop(context);
                                  Get.toNamed(ConstantRoutes.accounts);
                                  // } else {
                                  //   showDialog(
                                  //       context: context,
                                  //       barrierDismissible: true,
                                  //       builder: (BuildContext context) {
                                  //         return AlertDialog(
                                  //             shape: RoundedRectangleBorder(
                                  //                 borderRadius:
                                  //                     BorderRadius.all(
                                  //                         Radius.circular(4))),
                                  //             contentPadding: EdgeInsets.all(0),
                                  //             insetPadding: EdgeInsets.all(
                                  //                 Screens.bodyheight(context) *
                                  //                     0.02),
                                  //             content: settings(context));
                                  //       });
                                  // }
                                },
                                icon: Icons.people_alt,
                                iconColor: theme.primaryColor,
                                title: 'My Customer',
                                // textalign: ,
                              ),
                              // InkWell(
                              //   onTap: () {
                              //     if (MenuAuthDetail.Accounts == "Y") {
                              //       Navigator.pop(context);
                              //       Get.toNamed(ConstantRoutes.accounts);
                              //     } else {
                              //       showDialog(
                              //           context: context,
                              //           barrierDismissible: true,
                              //           builder: (BuildContext context) {
                              //             return AlertDialog(
                              //                 shape: RoundedRectangleBorder(
                              //                     borderRadius:
                              //                         BorderRadius.all(
                              //                             Radius.circular(4))),
                              //                 contentPadding: EdgeInsets.all(0),
                              //                 insetPadding: EdgeInsets.all(
                              //                     Screens.bodyheight(context) *
                              //                         0.02),
                              //                 content: settings(context));
                              //           });
                              //     }
                              //   },
                              //   child: Container(
                              //     alignment: Alignment.bottomCenter,
                              //     width: Screens.width(context) * 0.29,
                              //     // color: Colors.blue,
                              //     height: Screens.fullHeight(context) * 0.11,
                              //     decoration: BoxDecoration(
                              //         //  color: Colors.red[200],
                              //         borderRadius: BorderRadius.circular(8)),
                              //     child: Column(
                              //       mainAxisAlignment:
                              //           MainAxisAlignment.spaceAround,
                              //       children: [
                              //         Container(
                              //           width: Screens.width(context) * 0.26,
                              //           alignment: Alignment.center,
                              //           child: Column(
                              //             children: [
                              //               Container(
                              //                 width:
                              //                     Screens.width(context) * 0.1,
                              //                 padding: EdgeInsets.all(5),
                              //                 alignment: Alignment.center,
                              //                 decoration: BoxDecoration(
                              //                     color: theme.primaryColor
                              //                         .withOpacity(
                              //                             0.2), //,Colors.amber,
                              //                     borderRadius:
                              //                         BorderRadius.circular(
                              //                             10)),
                              //                 child: Icon(
                              //                   Icons.people_alt, // Icons.home,
                              //                   color: theme
                              //                       .primaryColor, //Colors.red,//Colors.white,
                              //                   size: Screens.padingHeight(
                              //                           context) *
                              //                       0.04,
                              //                 ),
                              //               ),
                              //             ],
                              //           ),
                              //         ),
                              //         Container(
                              //           // color:Colors.amber,
                              //           width: Screens.width(context) * 0.38,
                              //           height:
                              //               Screens.bodyheight(context) * 0.055,
                              //           alignment: Alignment.topCenter,
                              //           child: Text(
                              //             "My Customer",
                              //             // textAlign: textalign,
                              //             style: theme.textTheme.bodyText1
                              //                 ?.copyWith(
                              //                     color: theme
                              //                         .primaryColor, //color:Colors.red,//Colors.white,//
                              //                     fontWeight: FontWeight.w400),
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              IconContainer(
                                theme: theme,
                                callback: () {
                                  Navigator.pop(context);
                                  Get.toNamed(ConstantRoutes.collectionlist);
                                },
                                icon: Icons.request_quote,
                                iconColor: theme.primaryColor,
                                title: 'Collection',
                                textalign: TextAlign.center,
                              ),

                              IconContainer(
                                theme: theme,
                                callback: () {
                                  Get.toNamed(ConstantRoutes.settlement);
                                },
                                icon: Icons.account_balance_wallet,
                                iconColor: theme.primaryColor,
                                title: 'Settlement',
                                textalign: TextAlign.center,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Screens.fullHeight(context) * 0.01,
                  ),
                  Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Container(
                      width: Screens.width(context),
                      // height: Screens.fullHeight(context)*0.3,
                      //Colors.amber,
                      padding: EdgeInsets.symmetric(
                          vertical: Screens.fullHeight(context) * 0.01,
                          horizontal: Screens.width(context) * 0.02),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              "Reports",
                              style: theme.textTheme.headline6
                                  ?.copyWith(color: theme.primaryColor),
                            ),
                          ),
                          SizedBox(
                            height: Screens.fullHeight(context) * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              // IconContainer(
                              //   theme: theme,
                              //   callback: () {
                              //     if (MenuAuthDetail.Walkins == "Y") {
                              //       Navigator.pop(context);
                              //       Get.toNamed(ConstantRoutes.walkins);
                              //     } else {
                              //       showDialog(
                              //           context: context,
                              //           barrierDismissible: true,
                              //           builder: (BuildContext context) {
                              //             return AlertDialog(
                              //                 shape: RoundedRectangleBorder(
                              //                     borderRadius:
                              //                         BorderRadius.all(
                              //                             Radius.circular(4))),
                              //                 contentPadding: EdgeInsets.all(0),
                              //                 insetPadding: EdgeInsets.all(
                              //                     Screens.bodyheight(context) *
                              //                         0.02),
                              //                 content: settings(context));
                              //           });
                              //     }
                              //   },
                              //   icon: Icons.wysiwyg,
                              //   iconColor: theme.primaryColor, //Colors.blue,
                              //   title: 'Walkins',
                              // ),
                              // IconContainer(
                              //   theme: theme,
                              //   callback: () {
                              //     if (MenuAuthDetail.Leads != "Y") {
                              //       Navigator.pop(context);
                              //       Get.offAllNamed(
                              //           ConstantRoutes.leadstab);

                              //     } else {
                              //       showDialog(
                              //           context: context,
                              //           barrierDismissible: true,
                              //           builder: (BuildContext context) {
                              //             return AlertDialog(
                              //                 shape: RoundedRectangleBorder(
                              //                     borderRadius:
                              //                         BorderRadius.all(
                              //                             Radius.circular(4))),
                              //                 contentPadding: EdgeInsets.all(0),
                              //                 insetPadding: EdgeInsets.all(
                              //                     Screens.bodyheight(context) *
                              //                         0.02),
                              //                 content: settings(context));
                              //           });
                              //     }
                              //   },
                              //   icon: Icons.checklist,
                              //   iconColor: theme.primaryColor, //Colors.orange,
                              //   title: 'Leads',
                              // ),
                            ],
                          ),
                          SizedBox(
                            height: Screens.fullHeight(context) * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconContainer(
                                theme: theme,
                                callback: () {
                                  if (MenuAuthDetail.Enquiries == "Y") {
                                    Navigator.pop(context);

                                    if (ConstantValues.sapUserType
                                            .toLowerCase() ==
                                        'manager') {
                                      // Get.toNamed(ConstantRoutes.enquiriesManager);
                                      log(ConstantValues.sapUserType);
                                      Get.offAllNamed(
                                          ConstantRoutes.enquiriesManager);
                                    } else {
                                      Get.offAllNamed(
                                          ConstantRoutes.enquiriesUser);
                                      // Get.toNamed(ConstantRoutes.enquiriesUser);
                                    }
                                  } else {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(4))),
                                              contentPadding: EdgeInsets.all(0),
                                              insetPadding: EdgeInsets.all(
                                                  Screens.bodyheight(context) *
                                                      0.02),
                                              content: settings(context));
                                        });
                                  }
                                },
                                icon: Icons.edit_note,
                                iconColor: theme.primaryColor, // Colors.green,
                                title: '',
                              ),
                              IconContainer(
                                theme: theme,
                                callback: () {
                                  //Navigator.push(context, MaterialPageRoute(builder:(_)=>NewLeadFrom()));
                                },
                                icon: Icons.credit_score_rounded,
                                iconColor: theme.primaryColor, //.pink,
                                title: '',
                                textalign: TextAlign.center,
                              ),
                              IconContainer(
                                theme: theme,
                                callback: () {
                                  //
                                  if (MenuAuthDetail.Followup == "Y") {
                                    Navigator.pop(context);
                                    Get.toNamed(ConstantRoutes.followupTab);
                                  } else {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(4))),
                                              contentPadding: EdgeInsets.all(0),
                                              insetPadding: EdgeInsets.all(
                                                  Screens.bodyheight(context) *
                                                      0.02),
                                              content: settings(context));
                                        });
                                  }
                                },
                                icon: Icons.redeem_rounded,
                                iconColor: theme.primaryColor, //Colors.amber,
                                title: '',
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Screens.fullHeight(context) * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              //  IconContainer(
                              //   theme: theme,
                              //   callback: () {
                              //     if (MenuAuthDetail.Accounts == "Y") {
                              //       Navigator.pop(context);
                              //       Get.toNamed(ConstantRoutes.accounts);
                              //     } else {
                              //       showDialog(
                              //           context: context,
                              //           barrierDismissible: true,
                              //           builder: (BuildContext context) {
                              //             return AlertDialog(
                              //                 shape: RoundedRectangleBorder(
                              //                     borderRadius:
                              //                         BorderRadius.all(
                              //                             Radius.circular(4))),
                              //                 contentPadding: EdgeInsets.all(0),
                              //                 insetPadding: EdgeInsets.all(
                              //                     Screens.bodyheight(context) *
                              //                         0.02),
                              //                 content: settings(context));
                              //           });
                              //     }
                              //   },
                              //   icon: Icons.contact_page,
                              //   iconColor: theme.primaryColor,
                              //   title: 'My Customer',
                              //   // textalign: ,
                              // ),
                              InkWell(
                                onTap: () {
                                  if (MenuAuthDetail.Accounts == "Y") {
                                    Navigator.pop(context);
                                    Get.toNamed(ConstantRoutes.accounts);
                                  } else {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(4))),
                                              contentPadding: EdgeInsets.all(0),
                                              insetPadding: EdgeInsets.all(
                                                  Screens.bodyheight(context) *
                                                      0.02),
                                              content: settings(context));
                                        });
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.bottomCenter,
                                  width: Screens.width(context) * 0.29,
                                  // color: Colors.blue,
                                  height: Screens.fullHeight(context) * 0.11,
                                  decoration: BoxDecoration(
                                      //  color: Colors.red[200],
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        width: Screens.width(context) * 0.26,
                                        alignment: Alignment.center,
                                        child: Column(
                                          children: [
                                            Container(
                                              width:
                                                  Screens.width(context) * 0.1,
                                              padding: EdgeInsets.all(5),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: theme.primaryColor
                                                      .withOpacity(
                                                          0.2), //,Colors.amber,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Icon(
                                                Icons.person, // Icons.home,
                                                color: theme
                                                    .primaryColor, //Colors.red,//Colors.white,
                                                size: Screens.padingHeight(
                                                        context) *
                                                    0.04,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        // color:Colors.amber,
                                        width: Screens.width(context) * 0.38,
                                        height:
                                            Screens.bodyheight(context) * 0.055,
                                        alignment: Alignment.topCenter,
                                        child: Text(
                                          "",
                                          // textAlign: textalign,
                                          style: theme.textTheme.bodyText1
                                              ?.copyWith(
                                                  color: theme
                                                      .primaryColor, //color:Colors.red,//Colors.white,//
                                                  fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              IconContainer(
                                theme: theme,
                                callback: () {},
                                icon: Icons.qr_code_2_outlined,
                                iconColor: theme.primaryColor,
                                title: '',
                                textalign: TextAlign.center,
                              ),

                              IconContainer(
                                theme: theme,
                                callback: () {},
                                icon: Icons.home,
                                iconColor: theme.primaryColor,
                                title: '',
                                textalign: TextAlign.center,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Screens.fullHeight(context) * 0.01,
                  ),
                  Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Container(
                      width: Screens.width(context),
                      // height: Screens.fullHeight(context)*0.3,
                      //Colors.amber,
                      padding: EdgeInsets.symmetric(
                          vertical: Screens.fullHeight(context) * 0.01,
                          horizontal: Screens.width(context) * 0.02),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              "Others",
                              style: theme.textTheme.headline6
                                  ?.copyWith(color: theme.primaryColor),
                            ),
                          ),
                          SizedBox(
                            height: Screens.fullHeight(context) * 0.01,
                          ),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconContainer(
                                  theme: theme,
                                  callback: () {
                                    // if (MenuAuthDetail.Profile == "Y") {
                                    Navigator.pop(context);
                                    Get.toNamed(ConstantRoutes.newprofile);
                                    // } else {
                                    //   showDialog(
                                    //       context: context,
                                    //       barrierDismissible: true,
                                    //       builder: (BuildContext context) {
                                    //         return AlertDialog(
                                    //             shape: RoundedRectangleBorder(
                                    //                 borderRadius:
                                    //                     BorderRadius.all(
                                    //                         Radius.circular(
                                    //                             4))),
                                    //             contentPadding:
                                    //                 EdgeInsets.all(0),
                                    //             insetPadding: EdgeInsets.all(
                                    //                 Screens.bodyheight(
                                    //                         context) *
                                    //                     0.02),
                                    //             content: settings(context));
                                    //       });
                                    // }
                                  },
                                  icon: Icons.photo_camera_front_outlined,
                                  iconColor:
                                      theme.primaryColor, // Colors.green,
                                  title: 'Profile'),
                              // IconContainer(
                              //   theme: theme,
                              //   callback: () {
                              //     Navigator.pop(context);
                              //     Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //           builder: (context) => Settings(),
                              //         ));
                              //   },
                              //   icon: Icons.settings,
                              //   iconColor: theme.primaryColor, //Colors.blue,
                              //   title: 'Setting',
                              // ),
                              // IconContainer(
                              //   theme: theme,
                              //   callback: () {

                              //     Get.offAllNamed(ConstantRoutes.dashboard);
                              //     Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //           builder: (context) => Settings(),
                              //         ));
                              //   },
                              //   icon: Icons.settings,
                              //   iconColor: theme.primaryColor, //Colors.blue,
                              //   title: 'Setting',
                              // ),
                              IconContainer(
                                theme: theme,
                                callback: () {
                                  Navigator.pop(context);
                                  DashBoardController.isLogout = true;
                                  Get.offAllNamed(ConstantRoutes.dashboard);
                                },
                                icon: Icons.logout_outlined,
                                iconColor: theme.primaryColor, //Colors.orange,
                                title: 'Logout',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Screens.fullHeight(context) * 0.01,
                  ),

                  Container(
                    width: Screens.width(context),
                    //   color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.bottomLeft,
                          width: Screens.width(context) * 0.35,
                          child: Text("Copyright@2022",
                              style: theme.textTheme.bodyText1
                                  ?.copyWith(color: Colors.grey)),
                        ),
                        Column(
                          children: [
                            Container(
                              //  color: Colors.red,
                              width: Screens.width(context) * 0.6,
                              alignment: Alignment.bottomRight,
                              child: Text(
                                "${AppConstant.version}",
                                style: theme.textTheme.bodyText1
                                    ?.copyWith(color: Colors.grey),
                              ), //\n 8752sdseaw3j99awe931
                            ),
                            Container(
                              //  color: Colors.red,
                              width: Screens.width(context) * 0.6,
                              alignment: Alignment.bottomRight,
                              child: Text("",
                                  style: theme.textTheme.bodyText1?.copyWith(
                                      color: Colors
                                          .grey)), //\n 8752sdseaw3j99awe931
                            ),
                          ],
                        ),
                        SizedBox(
                          width: Screens.width(context) * 0.01,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: Screens.fullHeight(context) * 0.02,
                  ),
                ]),
          ),
        ),
      ],
    )),
  );
}

settings(BuildContext context) {
  final theme = Theme.of(context);
  return StatefulBuilder(builder: (context, st) {
    return Container(
      padding: EdgeInsets.only(
          top: Screens.padingHeight(context) * 0.01,
          left: Screens.width(context) * 0.03,
          right: Screens.width(context) * 0.03,
          bottom: Screens.padingHeight(context) * 0.01),
      width: Screens.width(context) * 1.1,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: Screens.width(context),
              height: Screens.padingHeight(context) * 0.05,
              color: theme.primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: Screens.padingHeight(context) * 0.02,
                        right: Screens.padingHeight(context) * 0.02),
                    // color: Colors.red,
                    width: Screens.width(context) * 0.7,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Alert",
                      style: theme.textTheme.bodyText2
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        size: Screens.padingHeight(context) * 0.025,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: Screens.bodyheight(context) * 0.02,
            ),
            Container(
                alignment: Alignment.center,
                width: Screens.width(context),
                child: Text('You are not authorised..!!')),
            SizedBox(
              height: Screens.bodyheight(context) * 0.02,
            ),
          ],
        ),
      ),
    );
  });
}
