// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Controller/WalkinController/WalkinController.dart';
import 'package:sellerkit/Widgets/Appbar.dart';

import '../../../Widgets/Navi3.dart';

class WalkinsPage extends StatefulWidget {
  WalkinsPage({Key? key}) : super(key: key);

  @override
  State<WalkinsPage> createState() => _WalkinsPageState();
}

class _WalkinsPageState extends State<WalkinsPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: appbar("Walkins", theme, context),
      drawer: drawer3(context),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: Screens.width(context) * 0.01,
              vertical: Screens.bodyheight(context) * 0.02),
          width: Screens.width(context),
          height: Screens.bodyheight(context),
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 2,
                color: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Container(
                    padding: EdgeInsets.symmetric(
              horizontal: Screens.width(context) * 0.01,
              vertical: Screens.bodyheight(context) * 0.01),
                  width: Screens.width(context),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Purpose of visit",
                      style: theme.textTheme.bodyText1,),
                      SizedBox(height: Screens.bodyheight(context)*0.01,),
              // Wrap(
              //     spacing: 10.0, // gap between adjacent chips
              //     runSpacing: 15.0, // gap between lines
              //     children: listContainers(theme, values, selectedvalues)),

                 Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                context.read<WalkinController>().selectPurposeOfVisit("Purchase");
                                },
                                child: Container(
                                  width: Screens.width(context) * 0.29,
                                  height: Screens.bodyheight(context) * 0.06,
                                  //  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color:  context.watch<WalkinController>().
                                      getisSelectedPurposeOfVisit == 'Purchase'
                                          ? theme.primaryColor
                                          : Colors.white,
                                      border: Border.all(
                                          color: theme.primaryColor,
                                          width: 1),
                                      borderRadius:
                                          BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Text("Purchase",
                                      textAlign: TextAlign.center,
                                          maxLines: 8,
                                          overflow: TextOverflow.ellipsis,
                                          style: theme.textTheme.bodyText1
                                              ?.copyWith(
                                            color:  context.watch<WalkinController>()
                                            .getisSelectedPurposeOfVisit == 'Purchase'
                                                ? Colors.white
                                                : theme.primaryColor,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  context.read<WalkinController>().selectPurposeOfVisit("Finance");
                                },
                                child: Container(
                                  width: Screens.width(context) * 0.29,
                                  height: Screens.bodyheight(context) * 0.06,
                                  //  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: context.watch<WalkinController>()
                                      .getisSelectedPurposeOfVisit == 'Finance'
                                          ? theme.primaryColor
                                          : Colors.white,
                                      border: Border.all(
                                          color: theme.primaryColor,
                                          width: 1),
                                      borderRadius:
                                          BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Text("Finance",
                                          maxLines: 8,
                                      textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          style: theme.textTheme.bodyText1
                                              ?.copyWith(
                                            color: context.watch<WalkinController>()
                                            .getisSelectedPurposeOfVisit == "Finance"
                                                ? Colors.white
                                                : theme.primaryColor,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                   context.read<WalkinController>().selectPurposeOfVisit("Service");
                                },
                                child: Container(
                                  width: Screens.width(context) * 0.29,
                                  height: Screens.bodyheight(context) * 0.06,
                                  //  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color:  context.watch<WalkinController>()
                                      .getisSelectedPurposeOfVisit == 'Service'
                                          ? theme.primaryColor
                                          : Colors.white,
                                      border: Border.all(
                                          color: theme.primaryColor,
                                          width: 1),
                                      borderRadius:
                                          BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Text("Service",
                                          maxLines: 8,
                                      textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          style: theme.textTheme.bodyText1
                                              ?.copyWith(
                                            color:  context.watch<WalkinController>().
                                            getisSelectedPurposeOfVisit == "Service"
                                                ? Colors.white
                                                : theme.primaryColor,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                   SizedBox(height: Screens.bodyheight(context)*0.01,),
                    ],
                  ),
                ),
              ),
                SizedBox(height: Screens.bodyheight(context)*0.01,),
                 Card(
                 elevation: 2,
                color: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Container(
                    padding: EdgeInsets.symmetric(
              horizontal: Screens.width(context) * 0.01,
              vertical: Screens.bodyheight(context) * 0.01),
                  width: Screens.width(context),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Division",
                      style: theme.textTheme.bodyText1,),
                      SizedBox(height: Screens.bodyheight(context)*0.01,),
              // Wrap(
              //     spacing: 10.0, // gap between adjacent chips
              //     runSpacing: 15.0, // gap between lines
              //     children: listContainers(theme, values2, selectedvalues2)),
                 //  SizedBox(height: Screens.bodyheight(context)*0.01,),
                     Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                context.read<WalkinController>().selectDivision("Refrigerator");
                                },
                                child: Container(
                                  width: Screens.width(context) * 0.29,
                                  height: Screens.bodyheight(context) * 0.06,
                                  //  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color:  context.watch<WalkinController>().
                                      getisSelectedDivision == 'Refrigerator'
                                          ? theme.primaryColor
                                          : Colors.white,
                                      border: Border.all(
                                          color: theme.primaryColor,
                                          width: 1),
                                      borderRadius:
                                          BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Text("Refrigerator",
                                      textAlign: TextAlign.center,
                                          maxLines: 8,
                                          overflow: TextOverflow.ellipsis,
                                          style: theme.textTheme.bodyText1
                                              ?.copyWith(
                                            color:  context.watch<WalkinController>().
                                            getisSelectedDivision == 'Refrigerator'
                                                ? Colors.white
                                                : theme.primaryColor,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  context.read<WalkinController>().selectDivision("Washing Machine");
                                },
                                child: Container(
                                  width: Screens.width(context) * 0.29,
                                  height: Screens.bodyheight(context) * 0.06,
                                  //  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: context.watch<WalkinController>()
                                      .getisSelectedDivision == 'Washing Machine'
                                          ? theme.primaryColor
                                          : Colors.white,
                                      border: Border.all(
                                          color: theme.primaryColor,
                                          width: 1),
                                      borderRadius:
                                          BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Text("Washing Machine",
                                      textAlign: TextAlign.center,
                                          maxLines: 8,
                                          overflow: TextOverflow.ellipsis,
                                          style: theme.textTheme.bodyText1
                                              ?.copyWith(
                                            color: context.watch<WalkinController>().
                                            getisSelectedDivision == "Washing Machine"
                                                ? Colors.white
                                                : theme.primaryColor,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                   context.read<WalkinController>().selectDivision("IT");
                                },
                                child: Container(
                                  width: Screens.width(context) * 0.29,
                                  height: Screens.bodyheight(context) * 0.06,
                                  //  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color:  context.watch<WalkinController>().
                                      getisSelectedDivision == 'IT'
                                          ? theme.primaryColor
                                          : Colors.white,
                                      border: Border.all(
                                          color: theme.primaryColor,
                                          width: 1),
                                      borderRadius:
                                          BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Text("IT",
                                          maxLines: 8,
                                      textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          style: theme.textTheme.bodyText1
                                              ?.copyWith(
                                            color:  context.watch<WalkinController>().
                                            getisSelectedDivision == "IT"
                                                ? Colors.white
                                                : theme.primaryColor,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                   SizedBox(height: Screens.bodyheight(context)*0.02,),
                   //
                    Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                context.read<WalkinController>().selectDivision("Air Conditioner");
                                },
                                child: Container(
                                  width: Screens.width(context) * 0.29,
                                  height: Screens.bodyheight(context) * 0.06,
                                  //  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color:  context.watch<WalkinController>().
                                      getisSelectedDivision == 'Air Conditioner'
                                          ? theme.primaryColor
                                          : Colors.white,
                                      border: Border.all(
                                          color: theme.primaryColor,
                                          width: 1),
                                      borderRadius:
                                          BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Text("Air Conditioner",
                                          maxLines: 8,
                                      textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          style: theme.textTheme.bodyText1
                                              ?.copyWith(
                                            color:  context.watch<WalkinController>().
                                            getisSelectedDivision == 'Air Conditioner'
                                                ? Colors.white
                                                : theme.primaryColor,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  context.read<WalkinController>().selectDivision("Pannel TV");
                                },
                                child: Container(
                                  width: Screens.width(context) * 0.29,
                                  height: Screens.bodyheight(context) * 0.06,
                                  //  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: context.watch<WalkinController>()
                                      .getisSelectedDivision == 'Pannel TV'
                                          ? theme.primaryColor
                                          : Colors.white,
                                      border: Border.all(
                                          color: theme.primaryColor,
                                          width: 1),
                                      borderRadius:
                                          BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Text("Pannel TV",
                                          maxLines: 8,
                                      textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          style: theme.textTheme.bodyText1
                                              ?.copyWith(
                                            color: context.watch<WalkinController>().
                                            getisSelectedDivision == "Pannel TV"
                                                ? Colors.white
                                                : theme.primaryColor,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                   context.read<WalkinController>().selectDivision("Mobile");
                                },
                                child: Container(
                                  width: Screens.width(context) * 0.29,
                                  height: Screens.bodyheight(context) * 0.06,
                                  //  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color:  context.watch<WalkinController>().
                                      getisSelectedDivision == 'Mobile'
                                          ? theme.primaryColor
                                          : Colors.white,
                                      border: Border.all(
                                          color: theme.primaryColor,
                                          width: 1),
                                      borderRadius:
                                          BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Text("Mobile",
                                          maxLines: 8,
                                      textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          style: theme.textTheme.bodyText1
                                              ?.copyWith(
                                            color:  context.watch<WalkinController>().
                                            getisSelectedDivision == "Mobile"
                                                ? Colors.white
                                                : theme.primaryColor,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                   SizedBox(height: Screens.bodyheight(context)*0.02,),
                     Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                context.read<WalkinController>().selectDivision("Dish Washer");
                                },
                                child: Container(
                                  width: Screens.width(context) * 0.29,
                                  height: Screens.bodyheight(context) * 0.06,
                                  //  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color:  context.watch<WalkinController>().
                                      getisSelectedDivision == 'Dish Washer'
                                          ? theme.primaryColor
                                          : Colors.white,
                                      border: Border.all(
                                          color: theme.primaryColor,
                                          width: 1),
                                      borderRadius:
                                          BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Text("Dish Washer",
                                          maxLines: 8,
                                      textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          style: theme.textTheme.bodyText1
                                              ?.copyWith(
                                            color:  context.watch<WalkinController>().
                                            getisSelectedDivision == 'Dish Washer'
                                                ? Colors.white
                                                : theme.primaryColor,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  context.read<WalkinController>().selectDivision("Home Theater");
                                },
                                child: Container(
                                  width: Screens.width(context) * 0.29,
                                  height: Screens.bodyheight(context) * 0.06,
                                  //  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: context.watch<WalkinController>()
                                      .getisSelectedDivision == 'Home Theater'
                                          ? theme.primaryColor
                                          : Colors.white,
                                      border: Border.all(
                                          color: theme.primaryColor,
                                          width: 1),
                                      borderRadius:
                                          BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Text("Home Theater",
                                          maxLines: 8,
                                      textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          style: theme.textTheme.bodyText1
                                              ?.copyWith(
                                            color: context.watch<WalkinController>().
                                            getisSelectedDivision == "Home Theater"
                                                ? Colors.white
                                                : theme.primaryColor,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                   context.read<WalkinController>().selectDivision("Others");
                                },
                                child: Container(
                                  width: Screens.width(context) * 0.29,
                                  height: Screens.bodyheight(context) * 0.06,
                                  //  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color:  context.watch<WalkinController>().
                                      getisSelectedDivision == 'Others'
                                          ? theme.primaryColor
                                          : Colors.white,
                                      border: Border.all(
                                          color: theme.primaryColor,
                                          width: 1),
                                      borderRadius:
                                          BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Text("Others",
                                          maxLines: 8,
                                      textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          style: theme.textTheme.bodyText1
                                              ?.copyWith(
                                            color:  context.watch<WalkinController>().
                                            getisSelectedDivision == "Others"
                                                ? Colors.white
                                                : theme.primaryColor,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                   SizedBox(height: Screens.bodyheight(context)*0.02,),

                      Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                context.read<WalkinController>().selectDivision("Furniture");
                                },
                                child: Container(
                                  width: Screens.width(context) * 0.29,
                                  height: Screens.bodyheight(context) * 0.06,
                                  //  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color:  context.watch<WalkinController>().
                                      getisSelectedDivision == 'Furniture'
                                          ? theme.primaryColor
                                          : Colors.white,
                                      border: Border.all(
                                          color: theme.primaryColor,
                                          width: 1),
                                      borderRadius:
                                          BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Text("Furniture",
                                          maxLines: 8,
                                      textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          style: theme.textTheme.bodyText1
                                              ?.copyWith(
                                            color:  context.watch<WalkinController>().
                                            getisSelectedDivision == 'Furniture'
                                                ? Colors.white
                                                : theme.primaryColor,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  context.read<WalkinController>().selectDivision("Kitchen Appliances");
                                },
                                child: Container(
                                  width: Screens.width(context) * 0.29,
                                  height: Screens.bodyheight(context) * 0.06,
                                  //  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: context.watch<WalkinController>()
                                      .getisSelectedDivision == 'Kitchen Appliances'
                                          ? theme.primaryColor
                                          : Colors.white,
                                      border: Border.all(
                                          color: theme.primaryColor,
                                          width: 1),
                                      borderRadius:
                                          BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Text("Kitchen Appliances",
                                          maxLines: 8,
                                      textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          style: theme.textTheme.bodyText1
                                              ?.copyWith(
                                            color: context.watch<WalkinController>().
                                            getisSelectedDivision == "Kitchen Appliances"
                                                ? Colors.white
                                                : theme.primaryColor,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                             InkWell(
                                onTap: () {
                                  // context.read<WalkinController>().selectDivision("Others");
                                },
                                child: Container(
                                  width: Screens.width(context) * 0.29,
                                  height: Screens.bodyheight(context) * 0.06,
                                  //  padding: EdgeInsets.all(10),
                                  // decoration: BoxDecoration(
                                  //     color:  context.watch<WalkinController>().
                                  //     getisSelectedDivision == 'Others'
                                  //         ? theme.primaryColor
                                  //         : Colors.white,
                                  //     border: Border.all(
                                  //         color: theme.primaryColor,
                                  //         width: 1),
                                  //     borderRadius:
                                  //         BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      // Text("Others",
                                      //     maxLines: 8,
                                      //     overflow: TextOverflow.ellipsis,
                                      //     style: theme.textTheme.bodyText1
                                      //         ?.copyWith(
                                      //       color:  context.watch<WalkinController>().
                                      //       getisSelectedDivision == "Others"
                                      //           ? Colors.white
                                      //           : theme.primaryColor,
                                      //     ))
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                   SizedBox(height: Screens.bodyheight(context)*0.02,),
                    ],
                  ),
                ),
              ),
                SizedBox(height: Screens.bodyheight(context)*0.01,),
                 Card(
                  elevation: 2,
                color: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Container(
                    padding: EdgeInsets.symmetric(
              horizontal: Screens.width(context) * 0.01,
              vertical: Screens.bodyheight(context) * 0.01),
                  width: Screens.width(context),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Head count",
                      style: theme.textTheme.bodyText1,),
                      SizedBox(height: Screens.bodyheight(context)*0.01,),
              // Wrap(
              //     spacing: 10.0, // gap between adjacent chips
              //     runSpacing: 15.0, // gap between lines
              //     children: listContainers(theme, values3, selectedvalues3)),
                //   SizedBox(height: Screens.bodyheight(context)*0.01,),

                   Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                context.read<WalkinController>().selectHeadcount("1");
                                },
                                child: Container(
                                  width: Screens.width(context) * 0.29,
                                  height: Screens.bodyheight(context) * 0.06,
                                  //  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color:  context.watch<WalkinController>().
                                      getisSelectedHeadCount == '1'
                                          ? theme.primaryColor
                                          : Colors.white,
                                      border: Border.all(
                                          color: theme.primaryColor,
                                          width: 1),
                                      borderRadius:
                                          BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Text("1",
                                      textAlign: TextAlign.center,
                                          maxLines: 8,
                                          overflow: TextOverflow.ellipsis,
                                          style: theme.textTheme.bodyText1
                                              ?.copyWith(
                                            color:  context.watch<WalkinController>().
                                            getisSelectedHeadCount == '1'
                                                ? Colors.white
                                                : theme.primaryColor,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  context.read<WalkinController>().selectHeadcount("2");
                                },
                                child: Container(
                                  width: Screens.width(context) * 0.29,
                                  height: Screens.bodyheight(context) * 0.06,
                                  //  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: context.watch<WalkinController>()
                                      .getisSelectedHeadCount == '2'
                                          ? theme.primaryColor
                                          : Colors.white,
                                      border: Border.all(
                                          color: theme.primaryColor,
                                          width: 1),
                                      borderRadius:
                                          BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Text("2",
                                      textAlign: TextAlign.center,
                                          maxLines: 8,
                                          overflow: TextOverflow.ellipsis,
                                          style: theme.textTheme.bodyText1
                                              ?.copyWith(
                                            color: context.watch<WalkinController>().
                                            getisSelectedHeadCount == "2"
                                                ? Colors.white
                                                : theme.primaryColor,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                   context.read<WalkinController>().selectHeadcount("3");
                                },
                                child: Container(
                                  width: Screens.width(context) * 0.29,
                                  height: Screens.bodyheight(context) * 0.06,
                                  //  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color:  context.watch<WalkinController>().
                                      getisSelectedHeadCount == '3'
                                          ? theme.primaryColor
                                          : Colors.white,
                                      border: Border.all(
                                          color: theme.primaryColor,
                                          width: 1),
                                      borderRadius:
                                          BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Text("3",
                                      textAlign: TextAlign.center,
                                          maxLines: 8,
                                          overflow: TextOverflow.ellipsis,
                                          style: theme.textTheme.bodyText1
                                              ?.copyWith(
                                            color:  context.watch<WalkinController>().
                                            getisSelectedHeadCount == "3"
                                                ? Colors.white
                                                : theme.primaryColor,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                   SizedBox(height: Screens.bodyheight(context)*0.02,),

                      Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                context.read<WalkinController>().selectHeadcount("4");
                                },
                                child: Container(
                                  width: Screens.width(context) * 0.29,
                                  height: Screens.bodyheight(context) * 0.06,
                                  //  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color:  context.watch<WalkinController>().
                                      getisSelectedHeadCount == '4'
                                          ? theme.primaryColor
                                          : Colors.white,
                                      border: Border.all(
                                          color: theme.primaryColor,
                                          width: 1),
                                      borderRadius:
                                          BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Text("4",
                                      textAlign: TextAlign.center,
                                          maxLines: 8,
                                          overflow: TextOverflow.ellipsis,
                                          style: theme.textTheme.bodyText1
                                              ?.copyWith(
                                            color:  context.watch<WalkinController>().
                                            getisSelectedHeadCount == '4'
                                                ? Colors.white
                                                : theme.primaryColor,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  context.read<WalkinController>().selectHeadcount("5");
                                },
                                child: Container(
                                  width: Screens.width(context) * 0.29,
                                  height: Screens.bodyheight(context) * 0.06,
                                  //  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: context.watch<WalkinController>()
                                      .getisSelectedHeadCount == '5'
                                          ? theme.primaryColor
                                          : Colors.white,
                                      border: Border.all(
                                          color: theme.primaryColor,
                                          width: 1),
                                      borderRadius:
                                          BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Text("5",
                                      textAlign: TextAlign.center,
                                          maxLines: 8,
                                          overflow: TextOverflow.ellipsis,
                                          style: theme.textTheme.bodyText1
                                              ?.copyWith(
                                            color: context.watch<WalkinController>().
                                            getisSelectedHeadCount == "5"
                                                ? Colors.white
                                                : theme.primaryColor,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                             InkWell(
                                onTap: () {
                                 //  context.read<WalkinController>().selectDivision("Others");
                                },
                                child: Container(
                                  width: Screens.width(context) * 0.29,
                                  height: Screens.bodyheight(context) * 0.06,
                                  //  padding: EdgeInsets.all(10),
                                  // decoration: BoxDecoration(
                                  //     color:  context.watch<WalkinController>().
                                  //     getisSelectedDivision == 'Others'
                                  //         ? theme.primaryColor
                                  //         : Colors.white,
                                  //     border: Border.all(
                                  //         color: theme.primaryColor,
                                  //         width: 1),
                                  //     borderRadius:
                                  //         BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      // Text("Others",
                                      //     maxLines: 8,
                                      //     overflow: TextOverflow.ellipsis,
                                      //     style: theme.textTheme.bodyText1
                                      //         ?.copyWith(
                                      //       color:  context.watch<WalkinController>().
                                      //       getisSelectedDivision == "Others"
                                      //           ? Colors.white
                                      //           : theme.primaryColor,
                                      //     ))
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                   SizedBox(height: Screens.bodyheight(context)*0.02,),
                    ],
                  ),
                ),
              ),
 SizedBox(height: Screens.bodyheight(context)*0.02,),
              Center(
                child: SizedBox(
                  width: Screens.width(context),
                  height: Screens.bodyheight(context)*0.07,
                  child: ElevatedButton(
                    onPressed: context.watch<WalkinController>().getisloadingBtn == true ?null:
                     (){
                      context.read<WalkinController>().callWalkinApi(context);
                    },
                    child: 
          context.watch<WalkinController>().getisloadingBtn == true?  
          SizedBox(
            width: Screens.width(context)*0.06,
            height:Screens.bodyheight(context)*0.04,
            child: CircularProgressIndicator(
              color: Colors.white
            ))
          :        
                    Text("Submit")),
                ),
              )
            ],
          )),
        ),
      ),
    );
  }

  static List<bool> selectedvalues = [false, false, false];
  static List<String> values = ["Purchase", "Finance", "Service"];

//division
    static List<bool> selectedvalues2 = [false, false, false,false, false, false,
    false, false, false,false, false
    ];
  static List<String> values2 = [
    "Refrigerator", "Washing Machine", "IT",
  "Air Conditioner", "Pannel TV", "Mobile",
  "DishWasher", "HomeTheatre", "Others",
  "Furniture", "Kitchen Appliances", ];

   static List<bool> selectedvalues3 = [false, false, false,false, false, 
    ];
  static List<String> values3 = [
    "1", "2", "3",
  "4", "5" ];


  List<Widget> listContainers(
      ThemeData theme, List<String> content, List<bool> isSelected) {
    return List.generate(
      content.length,
      (index) => GestureDetector(
        onTap: () {
          setState(() {
            if (isSelected[index] == false) {
              isSelected[index] = true;
            } else {
              isSelected[index] = false;
            }
          });
        },
        child: Container(
          width: Screens.width(context) * 0.29,
          height: Screens.bodyheight(context) * 0.06,
          //  padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color:
                  isSelected[index] == true ? theme.primaryColor : Colors.white,
              border: Border.all(color: theme.primaryColor, width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${content[index]}",
                  maxLines: 8,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyText1?.copyWith(
                    color: isSelected[index] == true
                        ? Colors.white
                        : theme.primaryColor,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
