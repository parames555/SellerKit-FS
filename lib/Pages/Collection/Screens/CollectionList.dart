// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import '../../../Constant/Screen.dart';
import '../../../Constant/padings.dart';
import '../../../Widgets/Appbar.dart';
import '../../../Widgets/Navi3.dart';

class Collections extends StatefulWidget {
  const Collections({Key? key}) : super(key: key);

  @override
  State<Collections> createState() => _CollectionsState();
}

class _CollectionsState extends State<Collections> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Paddings paddings = Paddings();

  @override
  void initState() {
    // TODO: implement initState

// callKpiApi();
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   context.read<AccountsContoller>().callKpiApi();
    // });
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
      onWillPop:onbackpress,
      child: Scaffold(
          key: scaffoldKey,
          drawer: drawer3(context),
          appBar: appbar("Collections", theme, context),
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
                          itemCount: 10,
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
                                  // AccountsDetailsState
                                  //         .data =
                                  //     "Balamurugan";
                                  // Get.toNamed(
                                  //     ConstantRoutes
                                  //         .accountsDetails);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(
                                      Screens.bodyheight(context) * 0.005),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(
                                                    Screens.bodyheight(context) *
                                                        0.002),
                                                alignment: Alignment.topLeft,
                                                // color:
                                                //     Colors.amber,

                                                width:
                                                    Screens.width(context) * 0.4,
                                                child: Text(
                                                  "CBE0000A1",
                                                  // "${AccountsData[i].cardname}",
                                                  // "${prdACC.getAccountsDataFilter[i].cardname}",
                                                  style: theme.textTheme.bodyText1
                                                      ?.copyWith(),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(
                                                    Screens.bodyheight(context) *
                                                        0.005),
                                                // color:
                                                //     Colors.amber,
                                                alignment: Alignment.centerLeft,

                                                width:
                                                    Screens.width(context) * 0.4,
                                                child: Text(
                                                  "Raman Furnitures",
                                                  // "${AccountsData[i].street}",
                                                  // "${prdACC.getAccountsDataFilter[i].cardcode}",
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            // color: Colors.blueGrey,
                                            width: Screens.width(context) * 0.45,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(
                                                      Screens.bodyheight(
                                                              context) *
                                                          0.002),
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    "Cash",
                                                    style: theme
                                                        .textTheme.bodyText1
                                                        ?.copyWith(),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.all(
                                                      Screens.bodyheight(
                                                              context) *
                                                          0.005),
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    "23,400.00",
                                                    style: theme
                                                        .textTheme.bodyText1
                                                        ?.copyWith(),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
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
                                                "Saibaba Colony ,Coimbatore",
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
                                                "23-Jun-2023 10:40 PM",
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
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.toNamed(ConstantRoutes.newcollection);
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          )),
    );
  }
}
