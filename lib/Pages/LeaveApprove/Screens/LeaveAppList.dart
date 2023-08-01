// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import '../../../Constant/Screen.dart';
import '../../../Constant/padings.dart';
import '../../../Controller/LeaveApproveController/LeaveApproveController.dart';
import '../../../Widgets/Appbar.dart';
import '../../../Widgets/Navi3.dart';

class LeaveAppList extends StatefulWidget {
  const LeaveAppList({Key? key}) : super(key: key);

  @override
  State<LeaveAppList> createState() => _LeaveAppListState();
}

class _LeaveAppListState extends State<LeaveAppList> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Paddings paddings = Paddings();

  @override
  void initState() {
    // TODO: implement initState

// callKpiApi();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<LeaveApproveContoller>().init(context);
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
        key: scaffoldKey,
        drawer: drawer3(context),
        appBar: appbar("Leave Request List", theme, context),
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                width: Screens.width(context),
                height: Screens.bodyheight(context),
                padding: paddings.padding2(context),
                child: Column(
                  children: [
                    SizedBox(
                      height: Screens.bodyheight(context) * 0.01,
                    ),
                    // SearchWidget(themes: theme),
                    // SearchbarWidget(
                    //   theme: theme,
                    //   accountsContoller: prdACC,
                    // ),
                    Container(
                      height: Screens.bodyheight(context) * 0.06,
                      decoration: BoxDecoration(
                        color: theme.primaryColor
                            .withOpacity(0.1), //Colors.grey[200],
                        borderRadius: BorderRadius.circular(
                            Screens.width(context) * 0.02),
                      ),
                      child: TextField(
                        autocorrect: false,
                        onChanged: (v) {
                          //srdACC.SearchFilter(v);
                        },
                        decoration: InputDecoration(
                          filled: false,
                          hintText: 'Search Here!!..',
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {
                              FocusScopeNode focus = FocusScope.of(context);
                              if (!focus.hasPrimaryFocus) {
                                focus.unfocus();
                              }
                              // accountsContoller.boolmethod();
                              // Get.offAllNamed(ConstantRoutes.cartLoading);
                              // setState(() {
                              // prdACC.boolmethod();
                              // });
                            }, //
                            color: theme.primaryColor,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 5,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Screens.bodyheight(context) * 0.005,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: context
                            .watch<LeaveApproveContoller>()
                            .filterListOfReq
                            .length,
                        //  prdACC
                        //     .getAccountsDataFilter
                        //     .length,
                        // prdACC.getAccountsData.length,
                        itemBuilder: (BuildContext context, int i) {
                          return Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: GestureDetector(
                              onTap: () {
                                context
                                    .read<LeaveApproveContoller>()
                                    .setReqData(context
                                        .read<LeaveApproveContoller>()
                                        .filterListOfReq[i]);
                                // AccountsDetailsState
                                //         .data =
                                //     "Balamurugan";
                                Get.toNamed(ConstantRoutes.leaveApprove);
                              },
                              child: Container(
                                padding: EdgeInsets.all(
                                    Screens.bodyheight(context) * 0.005),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(
                                              Screens.bodyheight(context) *
                                                  0.002),
                                          alignment: Alignment.topLeft,
                                          // color: Colors.amber,
                                          // width: Screens.width(context) * 0.8,
                                          child: Text(
                                            "${context.read<LeaveApproveContoller>().filterListOfReq[i].empId}",
                                            // "${AccountsData[i].cardname}",
                                            // "${prdACC.getAccountsDataFilter[i].cardname}",
                                            style: theme.textTheme.bodyText1
                                                ?.copyWith(),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(
                                              Screens.bodyheight(context) *
                                                  0.002),
                                          // color: Colors.amber,
                                          alignment: Alignment.centerLeft,
                                          // width: Screens.width(context) * 0.8,
                                          child: Text(
                                            "${context.read<LeaveApproveContoller>().filterListOfReq[i].empName}",
                                            // "${AccountsData[i].street}",
                                            // "${prdACC.getAccountsDataFilter[i].cardcode}",
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ],
                                    ),

                                    // SizedBox(
                                    //   height:
                                    //       Screens.bodyheight(context) * 0.01,
                                    // ),

                                    IntrinsicHeight(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            alignment: Alignment.topLeft,
                                            padding: EdgeInsets.all(
                                                Screens.bodyheight(context) *
                                                    0.005),
                                            width: Screens.width(context) * 0.4,
                                            child: Text(
                                              "${context.read<LeaveApproveContoller>().filterListOfReq[i].leaveType}",
                                              style: theme.textTheme.bodyText1
                                                  ?.copyWith(),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(
                                                Screens.bodyheight(context) *
                                                    0.005),

                                            alignment: Alignment.bottomRight,
                                            // width: Screens.width(context),
                                            child: Text(
                                              "${context.read<LeaveApproveContoller>().filterListOfReq[i].createdDate}",
                                              style: theme.textTheme.bodySmall
                                                  ?.copyWith(
                                                      color: Colors.grey),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
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
            ],
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     Get.toNamed(ConstantRoutes.newcollection);
        //   },
        //   child: Icon(
        //     Icons.add,
        //     color: Colors.white,
        //   ),
        // )
      ),
    );
  }
}
