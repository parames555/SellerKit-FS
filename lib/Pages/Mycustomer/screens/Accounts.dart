// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import '../../../Constant/Screen.dart';
import '../../../Constant/padings.dart';
import '../../../Controller/MyCustomerController/AccountsController.dart';
import '../../../Models/AccountsModel/AccountsModel.dart';
import '../../../Services/AccountsApi/AccountsApi.dart';
import '../../../Widgets/Appbar.dart';
import '../../../Widgets/Navi3.dart';
import '../Widgets/search_bar.dart';
import 'AccoountsDetails.dart';

class Accounts extends StatefulWidget {
  const Accounts({Key? key}) : super(key: key);

  @override
  State<Accounts> createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Paddings paddings = Paddings();

  List<AccountsNewData> AccountsData = [];
  List<String> items = ["VIP", "PREMIER", "FAKE", "AAAAAA", "XXXXXX", "BBBB"];
  List<AccountsNewData> get getAccountsData => AccountsData;
  List<String> get getitems => items;
  List<String> countitem = [];
  List<String> get getcountitem => countitem;
  List<String> countitemlength = [];
  List<String> get getcountitemlength => countitemlength;
  String errorMsg = 'Some thing went wrong';
  bool exception = false;
  bool cartLoading = false;
  bool isLoading = true;
  bool get getisLoading => isLoading;
  bool get getcartLoading => cartLoading;
  bool get getException => exception;
  String get getErrorMsg => errorMsg;
  @override
  void initState() {
    // TODO: implement initState

// callKpiApi();
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   context.read<AccountsContoller>().callKpiApi();
    // });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        key: scaffoldKey,
        drawer: drawer3(context),
        appBar: appbar("My Customers", theme, context),
        body: ChangeNotifierProvider<AccountsContoller>(
            create: (context) => AccountsContoller(),
            builder: (context, child) {
              return Consumer<AccountsContoller>(
                  builder: (BuildContext context, prdACC, Widget? child) {
                return SafeArea(
                  child:
                      (prdACC.getisLoading == true &&
                              prdACC.getErrorMsg.isEmpty)
                          ? Center(child: CircularProgressIndicator())
                          : (prdACC.getisLoading == false &&
                                  prdACC.getErrorMsg.isNotEmpty)
                              ? Center(child: Text(prdACC.getErrorMsg))
                              : Stack(
                                  children: [
                                    Container(
                                      width: Screens.width(context),
                                      height: Screens.bodyheight(context),
                                      padding: paddings.padding2(context),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height:
                                                Screens.bodyheight(context) *
                                                    0.01,
                                          ),
                                          // SearchWidget(themes: theme),
                                          // SearchbarWidget(
                                          //   theme: theme,
                                          //   accountsContoller: prdACC,
                                          // ),
                                          Container(
                                            height:
                                                Screens.bodyheight(context) *
                                                    0.06,
                                            decoration: BoxDecoration(
                                              color: theme.primaryColor
                                                  .withOpacity(
                                                      0.1), //Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Screens.width(context) *
                                                          0.02),
                                            ),
                                            child: TextField(
                                              autocorrect: false,
                                              onChanged: (v) {
                                                print(v);
                                                prdACC.SearchFilter(v);
                                              },
                                              decoration: InputDecoration(
                                                filled: false,
                                                hintText: 'Search Here!!..',
                                                enabledBorder: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                suffixIcon: IconButton(
                                                  icon:
                                                      const Icon(Icons.search),
                                                  onPressed: () {
                                                    FocusScopeNode focus =
                                                        FocusScope.of(context);
                                                    if (!focus
                                                        .hasPrimaryFocus) {
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
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 12,
                                                  horizontal: 5,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height:
                                                Screens.bodyheight(context) *
                                                    0.005,
                                          ),
                                          Expanded(
                                            child:
                                                prdACC.getAccountsData.isEmpty
                                                    ? Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      )
                                                    : ListView.builder(
                                                        itemCount: 10,
                                                        //  prdACC
                                                        //     .getAccountsDataFilter
                                                        //     .length,
                                                        // prdACC.getAccountsData.length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int i) {
                                                          return Card(
                                                            elevation: 4,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            child:
                                                                GestureDetector(
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
                                                                    Screens.bodyheight(
                                                                            context) *
                                                                        0.007),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                                child: Column(
                                                                  children: [
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Container(
                                                                          // color:
                                                                          //     Colors.amber,
                                                                          padding:
                                                                              EdgeInsets.all(Screens.bodyheight(context) * 0.002),
                                                                          width:
                                                                              Screens.width(context) * 0.35,
                                                                          child:
                                                                              Text(
                                                                            "CBE0000A1",
                                                                            // "${AccountsData[i].cardname}",
                                                                            // "${prdACC.getAccountsDataFilter[i].cardname}",
                                                                            style:
                                                                                theme.textTheme.bodyText1?.copyWith(),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          // color: Colors.blueGrey,
                                                                          width:
                                                                              Screens.width(context) * 0.5,
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.end,
                                                                            children: [
                                                                              Container(
                                                                                padding: EdgeInsets.all(Screens.bodyheight(context) * 0.002),
                                                                                child: Text(
                                                                                  "Balance :",
                                                                                  style: theme.textTheme.bodyText1?.copyWith(),
                                                                                ),
                                                                              ),
                                                                              Container(
                                                                                padding: EdgeInsets.all(Screens.bodyheight(context) * 0.002),
                                                                                child: Text(
                                                                                  "23,400.00",
                                                                                  style: theme.textTheme.bodyText1?.copyWith(),
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        )
                                                                        // Container(
                                                                        //   width:
                                                                        //       Screens.width(context) * 0.45,
                                                                        //   // color: Colors.amber,
                                                                        //   padding:
                                                                        //       EdgeInsets.only(
                                                                        //     left:
                                                                        //         Screens.width(context) * 0.01,
                                                                        //     right:
                                                                        //         Screens.width(context) * 0.01,
                                                                        //     top:
                                                                        //         Screens.bodyheight(context) * 0.01,
                                                                        //     bottom:
                                                                        //         Screens.bodyheight(context) * 0.001,
                                                                        //   ),
                                                                        //   child:
                                                                        //       Row(
                                                                        //     mainAxisAlignment:
                                                                        //         MainAxisAlignment.spaceAround,
                                                                        //     children: [
                                                                        //       Container(
                                                                        //         alignment: Alignment.center,
                                                                        //         decoration: BoxDecoration(color: Colors.green.withOpacity(0.5), borderRadius: BorderRadius.circular(3)),
                                                                        //         padding: EdgeInsets.only(
                                                                        //           left: Screens.width(context) * 0.012,
                                                                        //           right: Screens.width(context) * 0.012,
                                                                        //           top: Screens.bodyheight(context) * 0.005,
                                                                        //           bottom: Screens.bodyheight(context) * 0.005,
                                                                        //         ),
                                                                        //         // width: Screens.width(context)* 0.09,
                                                                        //         child: Text(
                                                                        //           "VIP",
                                                                        //           style: theme.textTheme.bodySmall?.copyWith(fontSize: 10),
                                                                        //         ),
                                                                        //       ),
                                                                        //       Container(
                                                                        //         alignment: Alignment.center,
                                                                        //         decoration: BoxDecoration(color: Colors.green.withOpacity(0.5), borderRadius: BorderRadius.circular(3)),
                                                                        //         padding: EdgeInsets.only(
                                                                        //           left: Screens.width(context) * 0.012,
                                                                        //           right: Screens.width(context) * 0.012,
                                                                        //           top: Screens.bodyheight(context) * 0.005,
                                                                        //           bottom: Screens.bodyheight(context) * 0.005,
                                                                        //         ),
                                                                        //         // width: Screens.width(context)* 0.09,
                                                                        //         child: Text(
                                                                        //           "PREMIER",
                                                                        //           style: theme.textTheme.bodySmall?.copyWith(fontSize: 10),
                                                                        //         ),
                                                                        //       ),
                                                                        //       Container(
                                                                        //         alignment: Alignment.center,
                                                                        //         decoration: BoxDecoration(color: Colors.green.withOpacity(0.5), borderRadius: BorderRadius.circular(3)),
                                                                        //         padding: EdgeInsets.only(
                                                                        //           left: Screens.width(context) * 0.012,
                                                                        //           right: Screens.width(context) * 0.012,
                                                                        //           top: Screens.bodyheight(context) * 0.005,
                                                                        //           bottom: Screens.bodyheight(context) * 0.005,
                                                                        //         ),
                                                                        //         // width: Screens.width(context)* 0.09,
                                                                        //         child: Text(
                                                                        //           "FAKE",
                                                                        //           style: theme.textTheme.bodySmall?.copyWith(fontSize: 10),
                                                                        //         ),
                                                                        //       ),
                                                                        //       Container(
                                                                        //         alignment: Alignment.center,
                                                                        //         decoration: BoxDecoration(
                                                                        //             // color: Colors.green
                                                                        //             // .withOpacity(0.5),
                                                                        //             borderRadius: BorderRadius.circular(3)),
                                                                        //         padding: EdgeInsets.only(
                                                                        //           left: Screens.width(context) * 0.012,
                                                                        //           right: Screens.width(context) * 0.012,
                                                                        //           top: Screens.bodyheight(context) * 0.005,
                                                                        //           bottom: Screens.bodyheight(context) * 0.005,
                                                                        //         ),
                                                                        //         // width: Screens.width(context)* 0.09,
                                                                        //         child: Text(
                                                                        //           "+${prdACC.getcount}",
                                                                        //           style: theme.textTheme.bodySmall?.copyWith(fontSize: 4),
                                                                        //         ),
                                                                        //       ),
                                                                        //     ],
                                                                        //   ),
                                                                        // ),
                                                                      ],
                                                                    ),
                                                                    // SizedBox(
                                                                    //   height:
                                                                    //       Screens.bodyheight(context) * 0.01,
                                                                    // ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Container(
                                                                          alignment:
                                                                              Alignment.bottomLeft,
                                                                          padding:
                                                                              EdgeInsets.all(Screens.bodyheight(context) * 0.002),
                                                                          width:
                                                                              Screens.width(context) * 0.6,
                                                                          child:
                                                                              Text(
                                                                            "Raman Furnitures",
                                                                            // "${AccountsData[i].street}",
                                                                            // "${prdACC.getAccountsDataFilter[i].cardcode}",
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    // SizedBox(
                                                                    //   height:
                                                                    //       Screens.bodyheight(context) * 0.01,
                                                                    // ),
                                                                    Container(
                                                                      padding: EdgeInsets.all(
                                                                          Screens.bodyheight(context) *
                                                                              0.002),
                                                                      width: Screens
                                                                          .width(
                                                                              context),
                                                                      child: Text(
                                                                          "Mr.Ramesh"),
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Container(
                                                                          padding:
                                                                              EdgeInsets.all(Screens.bodyheight(context) * 0.002),
                                                                          width:
                                                                              Screens.width(context) * 0.4,
                                                                          child:
                                                                              Text(
                                                                            "Saibaba Colony ,Coimbatore",
                                                                            style:
                                                                                theme.textTheme.bodyText1?.copyWith(),
                                                                          ),
                                                                        ),
                                                                        Column(
                                                                          children: [
                                                                            Container(
                                                                              alignment: Alignment.bottomRight,
                                                                              padding: EdgeInsets.all(Screens.bodyheight(context) * 0.002),
                                                                              width: Screens.width(context) * 0.4,
                                                                              child: Text(
                                                                                "Last Visit",
                                                                                style: theme.textTheme.bodyText1?.copyWith(),
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              alignment: Alignment.bottomRight,
                                                                              padding: EdgeInsets.all(Screens.bodyheight(context) * 0.002),
                                                                              width: Screens.width(context) * 0.4,
                                                                              child: Text(
                                                                                "12-03-2023",
                                                                                style: theme.textTheme.bodyText1?.copyWith(),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),

                                                                    // SizedBox(
                                                                    //   height: Screens.bodyheight(
                                                                    //           context) *
                                                                    //       0.01,
                                                                    // )
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
                );
              });
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(ConstantRoutes.newcustomerReg);
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ));
  }
}
