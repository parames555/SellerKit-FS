// ignore_for_file: prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Constant/padings.dart';
import 'package:sellerkit/Controller/TargetController/TargetController.dart';
import '../../../Widgets/Appbar.dart';
import '../../../Widgets/Navi3.dart';

class GoalTracker extends StatefulWidget {
  const GoalTracker({Key? key}) : super(key: key);

  @override
  State<GoalTracker> createState() => _GoalTrackerState();
}

class _GoalTrackerState extends State<GoalTracker> {
  int? groupValue;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Paddings paddings = Paddings();
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        key: scaffoldKey,
        drawer: drawer3(context),
        appBar: appbar("Goal Tracker", theme, context),
        body: ChangeNotifierProvider<TargetTabController>(
            create: (context) => TargetTabController(),
            builder: (context, child) {
              return Consumer<TargetTabController>(
                  builder: (BuildContext context, prdFUP, Widget? child) {
                return SafeArea(
                    child: (prdFUP.getLeadCheckDataExcep.isNotEmpty &&
                            prdFUP.getisloading == false)
                        ? Center(child: Text(prdFUP.getLeadCheckDataExcep))
                        : (prdFUP.getisloading == true &&
                                prdFUP.getLeadCheckDataExcep.isEmpty)
                            ? Center(
                                child: CircularProgressIndicator(
                                color: theme.primaryColor,
                              ))
                            : SingleChildScrollView(
                                child: Container(
                                  // padding: paddings.padding2(context),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                            top: Screens.bodyheight(context) *
                                                0.015),
                                        child: Center(
                                          child:
                                              CupertinoSlidingSegmentedControl<
                                                  int>(
                                            backgroundColor: Colors.grey,
                                            padding: EdgeInsets.all(0),
                                            thumbColor: theme.primaryColor,
                                            groupValue:
                                                prdFUP.getgroupValueSelected,
                                            children: {
                                              0: Container(
                                                alignment: Alignment.center,
                                                width: Screens.width(context) *
                                                    0.425,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 7, horizontal: 5),
                                                // height: Screens.bodyheight(context) * 0.05,
                                                child: Text(
                                                  'Today',
                                                  style: theme
                                                      .textTheme.bodyLarge
                                                      ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.white),
                                                ),
                                              ),
                                              1: Container(
                                                alignment: Alignment.center,
                                                width: Screens.width(context) *
                                                    0.42,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 7, horizontal: 5),
                                                // height: Screens.bodyheight(context) * 0.05,
                                                child: Text(
                                                  'MTD',
                                                  style: theme
                                                      .textTheme.bodyLarge
                                                      ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.white),
                                                ),
                                              ),
                                            },
                                            onValueChanged: (v) {
                                              prdFUP.groupSelectvalue(v!);
                                              print(v);
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            Screens.bodyheight(context) * 0.005,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left:
                                                  Screens.bodyheight(context) *
                                                      0.01,
                                            ),
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  8),
                                                          topRight:
                                                              Radius.circular(
                                                                  8))),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: theme.primaryColor
                                                        .withOpacity(0.05)),
                                                height: Screens.bodyheight(
                                                        context) *
                                                    0.14,
                                                width: Screens.width(context) *
                                                    0.46,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                        alignment:
                                                            Alignment.center,
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                                vertical: 5,
                                                                horizontal: 5),
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        8),
                                                                topRight: Radius
                                                                    .circular(
                                                                        8)),
                                                            color: theme
                                                                .primaryColor,
                                                            border: Border.all(
                                                                color: theme
                                                                    .primaryColor)
                                                            // borderRadius: BorderRadius.circular(10)),
                                                            ),
                                                        child: Text(
                                                          prdFUP.getgroupValueSelected ==
                                                                  0
                                                              ? '${prdFUP.getTodaydData[0].kPI1Title}'
                                                              : '${prdFUP.getMonthdData[0].kPI1Title}',
                                                          style: theme.textTheme
                                                              .bodyLarge
                                                              ?.copyWith(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                        )),
                                                    SizedBox(
                                                      height:
                                                          Screens.bodyheight(
                                                                  context) *
                                                              0.01,
                                                    ),
                                                    Text(
                                                        prdFUP.getgroupValueSelected ==
                                                                0
                                                            ? '${prdFUP.getTodaydData[0].kPI1MainValue}'
                                                            : '${prdFUP.getMonthdData[0].kPI1MainValue}',
                                                        style: theme
                                                            .textTheme.subtitle1
                                                            // headline6
                                                            ?.copyWith(
                                                                // fontSize: 17,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                    SizedBox(
                                                      height:
                                                          Screens.bodyheight(
                                                                  context) *
                                                              0.01,
                                                    ),
                                                    Text(
                                                        prdFUP.getgroupValueSelected ==
                                                                0
                                                            ? '${prdFUP.getTodaydData[0].kPI1SubValue}'
                                                            : '${prdFUP.getMonthdData[0].kPI1SubValue}',
                                                        style: theme
                                                            .textTheme.bodyText1
                                                            ?.copyWith(
                                                                color: Colors
                                                                    .grey[600]))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              right:
                                                  Screens.bodyheight(context) *
                                                      0.01,
                                            ),
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  8),
                                                          topRight:
                                                              Radius.circular(
                                                                  8))),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: theme.primaryColor
                                                        .withOpacity(0.05)),
                                                height: Screens.bodyheight(
                                                        context) *
                                                    0.14,
                                                width: Screens.width(context) *
                                                    0.46,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                        alignment:
                                                            Alignment.center,
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                                vertical: 5,
                                                                horizontal: 5),
                                                        // height: Screens.bodyheight(context) * 0.05,
                                                        // width: Screens.width(context) * 0.4,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        8),
                                                                topRight: Radius
                                                                    .circular(
                                                                        8)),
                                                            color: theme
                                                                .primaryColor,
                                                            border: Border.all(
                                                                color: theme
                                                                    .primaryColor)),
                                                        child: Text(
                                                          prdFUP.getgroupValueSelected ==
                                                                  0
                                                              ? '${prdFUP.getTodaydData[0].kPI2Title}'
                                                              : '${prdFUP.getMonthdData[0].kPI2Title}',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: theme.textTheme
                                                              .bodyLarge
                                                              ?.copyWith(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                        )),
                                                    SizedBox(
                                                      height:
                                                          Screens.bodyheight(
                                                                  context) *
                                                              0.01,
                                                    ),
                                                    Text(
                                                        prdFUP.getgroupValueSelected ==
                                                                0
                                                            ? '${prdFUP.getTodaydData[0].kPI2MainValue}'
                                                            : '${prdFUP.getMonthdData[0].kPI2MainValue}',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: theme
                                                            .textTheme.subtitle1
                                                            ?.copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                    SizedBox(
                                                      height:
                                                          Screens.bodyheight(
                                                                  context) *
                                                              0.01,
                                                    ),
                                                    Text(
                                                        prdFUP.getgroupValueSelected ==
                                                                0
                                                            ? '${prdFUP.getTodaydData[0].kPI2SubValue}'
                                                            : '${prdFUP.getMonthdData[0].kPI2SubValue}',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: theme
                                                            .textTheme.bodyText1
                                                            ?.copyWith(
                                                                color: Colors
                                                                    .grey[600]))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            Screens.bodyheight(context) * 0.005,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left:
                                                  Screens.bodyheight(context) *
                                                      0.01,
                                            ),
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  8),
                                                          topRight:
                                                              Radius.circular(
                                                                  8))),
                                              child: Container(
                                                height: Screens.bodyheight(
                                                        context) *
                                                    0.16,
                                                width: Screens.width(context) *
                                                    0.46,
                                                decoration: BoxDecoration(
                                                    color: theme.primaryColor
                                                        .withOpacity(0.05)),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                                vertical: 5,
                                                                horizontal: 5),
                                                        alignment:
                                                            Alignment.center,
                                                        // height: Screens.bodyheight(context) * 0.05,
                                                        // width: Screens.width(context) * 0.4,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        8),
                                                                topRight: Radius
                                                                    .circular(
                                                                        8)),
                                                            color: theme
                                                                .primaryColor,
                                                            border: Border.all(
                                                                color: theme
                                                                    .primaryColor)
                                                            // borderRadius: BorderRadius.circular(10)),
                                                            ),
                                                        child: Text(
                                                          prdFUP.getgroupValueSelected ==
                                                                  0
                                                              ? '${prdFUP.getTodaydData[0].kPI3Title}'
                                                              : '${prdFUP.getMonthdData[0].kPI3Title}',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: theme.textTheme
                                                              .bodyLarge
                                                              ?.copyWith(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                        )),
                                                    SizedBox(
                                                      height:
                                                          Screens.bodyheight(
                                                                  context) *
                                                              0.01,
                                                    ),
                                                    Text(
                                                        prdFUP.getgroupValueSelected ==
                                                                0
                                                            ? '${prdFUP.getTodaydData[0].kPI3MainValue}'
                                                            : '${prdFUP.getMonthdData[0].kPI3MainValue}',
                                                        style: theme
                                                            .textTheme.subtitle1
                                                            ?.copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                    SizedBox(
                                                      height:
                                                          Screens.bodyheight(
                                                                  context) *
                                                              0.01,
                                                    ),
                                                    Text(
                                                        prdFUP.getgroupValueSelected ==
                                                                0
                                                            ? '${prdFUP.getTodaydData[0].kPI3SubValue}'
                                                            : '${prdFUP.getMonthdData[0].kPI3SubValue}',
                                                        style: theme
                                                            .textTheme.bodyText1
                                                            ?.copyWith(
                                                                color: Colors
                                                                    .grey[600]))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              right:
                                                  Screens.bodyheight(context) *
                                                      0.01,
                                            ),
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  8),
                                                          topRight:
                                                              Radius.circular(
                                                                  8))),
                                              child: Container(
                                                height: Screens.bodyheight(
                                                        context) *
                                                    0.16,
                                                width: Screens.width(context) *
                                                    0.46,
                                                decoration: BoxDecoration(
                                                    color: theme.primaryColor
                                                        .withOpacity(0.05)),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                                vertical: 5,
                                                                horizontal: 5),
                                                        alignment:
                                                            Alignment.center,
                                                        // height: Screens.bodyheight(context) * 0.05,
                                                        // width: Screens.width(context) * 0.4,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        8),
                                                                topRight: Radius
                                                                    .circular(
                                                                        8)),
                                                            color: theme
                                                                .primaryColor,
                                                            border: Border.all(
                                                                color: theme
                                                                    .primaryColor)
                                                            // borderRadius: BorderRadius.circular(10)),
                                                            ),
                                                        child: Text(
                                                          prdFUP.getgroupValueSelected ==
                                                                  0
                                                              ? '${prdFUP.getTodaydData[0].kPI4Title}'
                                                              : '${prdFUP.getMonthdData[0].kPI4Title}',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: theme.textTheme
                                                              .bodyLarge
                                                              ?.copyWith(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                        )),
                                                    SizedBox(
                                                      height:
                                                          Screens.bodyheight(
                                                                  context) *
                                                              0.01,
                                                    ),
                                                    Text(
                                                        prdFUP.getgroupValueSelected ==
                                                                0
                                                            ? '${prdFUP.getTodaydData[0].kPI4MainValue}'
                                                            : '${prdFUP.getMonthdData[0].kPI4MainValue}',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: theme
                                                            .textTheme.subtitle1
                                                            ?.copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                    SizedBox(
                                                      height:
                                                          Screens.bodyheight(
                                                                  context) *
                                                              0.01,
                                                    ),
                                                    Text(
                                                        prdFUP.getgroupValueSelected ==
                                                                0
                                                            ? '${prdFUP.getTodaydData[0].kPI4SubValue}'
                                                            : '${prdFUP.getMonthdData[0].kPI4SubValue}',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: theme
                                                            .textTheme.bodyText1
                                                            ?.copyWith(
                                                                color: Colors
                                                                    .grey[600]))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                          height: Screens.bodyheight(context) *
                                              0.01),
                                      Padding(
                                          padding: EdgeInsets.only(
                                            right: Screens.bodyheight(context) *
                                                0.015,
                                            left: Screens.bodyheight(context) *
                                                0.015,
                                          ),
                                          child: createTable(theme, prdFUP))
                                    ],
                                  ),
                                ),
                              ));
              });
            }));
  }

  Widget createTable(ThemeData theme, TargetTabController prdFUP) {
    var todaykeyss = prdFUP.getTodaydTableData.toList();
    var monthkeyss2 = prdFUP.getMonthTableData.toList();

    List<TableRow> rows = [];
    rows.add(TableRow(children: [
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "Segment",
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        // alignment: Alignment.center,
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 1),
        child: Text(
          "Target",
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 1),
        child: Text(
          "Achieved",
          style: theme.textTheme.bodyLarge
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 1),
        child: Text(
          "Ach %",
          style: theme.textTheme.bodyLarge
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    ]));
    print("Above Row");
    for (int i = 0; i < todaykeyss.length; ++i) {
      print("in Row");
      rows.add(TableRow(children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            prdFUP.getgroupValueSelected == 0
                ? '${todaykeyss[i].segment}'
                : '${monthkeyss2[i].segment}',
            textAlign: TextAlign.left,
            style: theme.textTheme.bodyText1?.copyWith(
              color: theme.primaryColor,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 1),
          child: Text(
            prdFUP.getgroupValueSelected == 0
                ? '${todaykeyss[i].target}'
                : '${monthkeyss2[i].target}',
            textAlign: TextAlign.right,
            style: theme.textTheme.bodyText1?.copyWith(
              color: theme.primaryColor,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 7),
          child: Text(
            prdFUP.getgroupValueSelected == 0
                ? '${todaykeyss[i].achieved}'
                : '${monthkeyss2[i].achieved}',
            textAlign: TextAlign.right,
            style: theme.textTheme.bodyText1?.copyWith(
              color: theme.primaryColor,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
          child: Text(
            prdFUP.getgroupValueSelected == 0
                ? '${todaykeyss[i].ach}'
                : '${monthkeyss2[i].ach}',
            textAlign: TextAlign.right,
            style: theme.textTheme.bodyText1?.copyWith(
              color: theme.primaryColor,
            ),
          ),
        ),
      ]));
    }
    return Table(columnWidths: {
      0: FlexColumnWidth(2.2), //tp
      1: FlexColumnWidth(2.2), //seg
      2: FlexColumnWidth(1.5), //tar
      3: FlexColumnWidth(1.3), //ach
      // 4: FlexColumnWidth(1.1), //ach%
    }, children: rows);
  }
}
  // TableRow builRow(List<String> cells, ThemeData theme) => TableRow(
  //         children: cells.map((e) {
  //       return Padding(
  //         padding: EdgeInsets.symmetric(vertical: 5, horizontal: 1),
  //         child: Center(
  //           child: Text(
  //             e,
  //             style: theme.textTheme.bodyText1,
  //           ),
  //         ),
  //       );
  //     }).toList());

  // TableRow builRowchild(List<String> cells, ThemeData theme) => TableRow(
  //         children: cells.map((e) {
  //       return Padding(
  //         padding: EdgeInsets.symmetric(vertical: 5, horizontal: 1),
  //         child: Center(
  //           child: Text(
  //             e,
  //             style: theme.textTheme.bodyText1?.copyWith(color: Colors.grey),
  //           ),
  //         ),
  //       )
  //     }).toList());

