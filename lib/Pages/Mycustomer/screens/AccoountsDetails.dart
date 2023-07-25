// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Controller/MyCustomerController/AccountsController.dart';
import '../../../Constant/Screen.dart';
import '../../../Constant/padings.dart';
import '../../../Widgets/Appbar.dart';
import '../../../Widgets/Navi3.dart';

class AccountsDetails extends StatefulWidget {  
   AccountsDetails({Key? key,}) : super(key: key);

  @override
  State<AccountsDetails> createState() => AccountsDetailsState();
}

class AccountsDetailsState extends State<AccountsDetails> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Paddings paddings = Paddings();
  static String? data;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
        key: scaffoldKey,
        drawer: drawer3(context),
        appBar: appbar("Account Details", theme, context),
        body: ChangeNotifierProvider<AccountsContoller>(
            create: (context) => AccountsContoller(),
            builder: (context, child) {
              return Consumer<AccountsContoller>(
                  builder: (BuildContext context, prdACC, Widget? child) {
                return Container(
                  alignment: Alignment.center,
                  width: Screens.width(context),
                  height: Screens.bodyheight(context),
                  // padding: paddings.padding2(context),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: Screens.bodyheight(context) * 0.01),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: Screens.width(context) * 0.94,
                                decoration: BoxDecoration(
                                  color: theme.primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: const Offset(
                                        1.0,
                                        1.0,
                                      ),
                                      blurRadius: 3.0,
                                      spreadRadius: 1.0,
                                    ), //BoxShadow
                                    //BoxShadow
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      alignment: Alignment.bottomLeft,
                                      width: Screens.width(context) * 0.65,
                                      //
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomLeft: Radius.circular(10)),
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            // color: Colors.amber,
                                            padding: EdgeInsets.only(
                                              left:
                                                  Screens.width(context) * 0.01,
                                              right:
                                                  Screens.width(context) * 0.01,
                                              top: Screens.bodyheight(context) *
                                                  0.01,
                                              bottom:
                                                  Screens.bodyheight(context) *
                                                      0.001,
                                            ),
                                            width:
                                                Screens.width(context) * 0.45,
                                            child: Text(
                                              "${data}",
                                              style: theme.textTheme.bodyText1
                                                  ?.copyWith(),
                                            ),
                                          ),
                                          // SizedBox(
                                          //   height:
                                          //       Screens.bodyheight(context) * 0.01,
                                          // ),
                                          Container(
                                            alignment: Alignment.bottomLeft,
                                            padding: EdgeInsets.only(
                                              left:
                                                  Screens.width(context) * 0.01,
                                              right:
                                                  Screens.width(context) * 0.01,
                                              top: Screens.bodyheight(context) *
                                                  0.001,
                                              bottom:
                                                  Screens.bodyheight(context) *
                                                      0.001,
                                            ),
                                            width:
                                                Screens.width(context) * 0.45,
                                            child: Text(
                                              "7091231239",
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          // SizedBox(
                                          //   height:
                                          //       Screens.bodyheight(context) * 0.01,
                                          // ),
                                          Container(
                                            padding: EdgeInsets.only(
                                              left:
                                                  Screens.width(context) * 0.01,
                                              right:
                                                  Screens.width(context) * 0.01,
                                              top: Screens.bodyheight(context) *
                                                  0.001,
                                              bottom:
                                                  Screens.bodyheight(context) *
                                                      0.001,
                                            ),
                                            width:
                                                Screens.width(context) * 0.45,
                                            child: Text("Madurai"),
                                          ),
                                          SizedBox(
                                            height:
                                                Screens.bodyheight(context) *
                                                    0.01,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: Screens.width(context) * 0.28,
                                      height:
                                          Screens.bodyheight(context) * 0.085,
                                      // color: Colors.black,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
                                              offset: const Offset(
                                                2.0,
                                                2.0,
                                              ),
                                              blurRadius: 5.0,
                                              spreadRadius: 1.0,
                                            ), //BoxShadow
                                            //BoxShadow
                                          ],
                                          shape: BoxShape.circle),
                                      child: Text("MK"),
                                    )
                                  ],
                                ),
                                // margin: EdgeInsets.only(top:0),
                              ),
                              SizedBox(
                                height: Screens.bodyheight(context) * 0.01,
                              ),
                              Container(
                                width: Screens.width(context) * 0.94,
                                // height: Screens.bodyheight(context) * 0.3,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: const Offset(
                                        2.0,
                                        2.0,
                                      ),
                                      blurRadius: 5.0,
                                      spreadRadius: 1.0,
                                    ), //BoxShadow
                                    //BoxShadow
                                  ],
                                ),
                                child: Wrap(
                                    direction: Axis.horizontal,
                                    children: List.generate(
                                        prdACC.getitems.length, (intex) {
                                      return Container(
                                        margin: EdgeInsets.only(
                                          left: Screens.width(context) * 0.012,
                                          right: Screens.width(context) * 0.012,
                                          top: Screens.bodyheight(context) *
                                              0.005,
                                          bottom: Screens.bodyheight(context) *
                                              0.005,
                                        ),
                                        alignment: Alignment.center,
                                        // height: Screens.bodyheight(context) * 0.04,
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.green.withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(3)),
                                        padding: EdgeInsets.only(
                                          left: Screens.width(context) * 0.011,
                                          right: Screens.width(context) * 0.011,
                                          top: Screens.bodyheight(context) *
                                              0.004,
                                          bottom: Screens.bodyheight(context) *
                                              0.004,
                                        ),
                                        width: Screens.width(context) * 0.2,
                                        child: Text(
                                          "${prdACC.getitems[intex]}",
                                          style: theme.textTheme.bodySmall
                                              ?.copyWith(fontSize: 10),
                                        ),
                                      );
                                    })),
                                // child: context.read<AccountsContoller>().wrapContainer(
                                //     context.watch<AccountsContoller>().getitems,
                                //     context,
                                //     theme)
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.bottomLeft,
                                // color: Colors.amber,
                                padding: EdgeInsets.only(
                                  left: Screens.width(context) * 0.03,
                                  right: Screens.width(context) * 0.01,
                                  top: Screens.bodyheight(context) * 0.01,
                                  bottom: Screens.bodyheight(context) * 0.001,
                                ),
                                width: Screens.width(context),
                                child: Text(
                                  "Recent Activities",
                                  style: theme.textTheme.subtitle1?.copyWith(),
                                ),
                              ),
                              SizedBox(
                                height: Screens.bodyheight(context) * 0.001,
                              ),
                              Container(
                                // color: Colors.amber,
                                // alignment: Alignment.center,
                                height: Screens.bodyheight(context) * 0.65,
                                width: Screens.width(context),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(
                                        parent:
                                            AlwaysScrollableScrollPhysics()),
                                    itemCount: 1,
                                    itemBuilder: (context, int i) {
                                      return GestureDetector(
                                        onTap: () {
                                          // Get.toNamed(ConstantRoutes.receipt);
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: Screens.bodyheight(
                                                          context) *
                                                      0.009),
                                              // height: Screens.padingHeight(context) * 0.14,
                                              width:
                                                  Screens.width(context) *
                                                      0.92,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(5)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey,
                                                    blurRadius:
                                                        3.0, // soften the shadow
                                                    spreadRadius:
                                                        0.0, //extend the shadow
                                                    offset: Offset(
                                                      2.0, // Move to right 10  horizontally
                                                      2.0, // Move to bottom 10 Vertically
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(
                                                        6.0),
                                                child: Column(
                                                  children: [
                                                    Column(
                                                      // mainAxisAlignment:
                                                      //     MainAxisAlignment.start,
                                                      // mainAxisSize: MainAxisSize.max,
                                                      children: [
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            "Mobile No",
                                                            style: theme
                                                                .textTheme
                                                                .bodySmall
                                                                ?.copyWith(
                                                              color: Colors
                                                                      .grey[
                                                                  600],
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          // padding: EdgeInsets.only(
                                                          //     left: Screens.width(context) *
                                                          //         0.02),
                                                          // alignment: Alignment.center,
                                                          child: Text(
                                                            "7092571625",
                                                            style: theme
                                                                .textTheme
                                                                .bodySmall
                                                                ?.copyWith(
                                                              color: Colors
                                                                  .black,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    // SizedBox(height: Screens.padingHeight(context)*0.01,),
                                                    Divider(
                                                      height: 3,
                                                    ),
                                                    // SizedBox(height: Screens.padingHeight(context)*0.01,),
                                                    Container(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        // crossAxisAlignment: CrossAxisAlignment.end,
                                                        children: [
                                                          Container(
                                                            child: Column(
                                                              // mainAxisAlignment: MainAxisAlignment.start,
                                                              // crossAxisAlignment: CrossAxisAlignment.end,
                                                              children: [
                                                                Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child:
                                                                      Text(
                                                                    "Total Amount Due",
                                                                    style: theme
                                                                        .textTheme
                                                                        .bodySmall
                                                                        ?.copyWith(
                                                                      color:
                                                                          Colors.grey[600],
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  padding: EdgeInsets.only(
                                                                      right:
                                                                          Screens.width(context) * 0.1),
                                                                  alignment:
                                                                      Alignment
                                                                          .bottomLeft,
                                                                  child:
                                                                      Text(
                                                                    "Rs 16428  ",
                                                                    style: theme
                                                                        .textTheme
                                                                        .bodySmall
                                                                        ?.copyWith(
                                                                      color:
                                                                          Colors.black,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Column(
                                                            children: [
                                                              Container(
                                                                // padding: EdgeInsets.only(
                                                                //     left:
                                                                //         Screens.width(context) *
                                                                //             0.02),
                                                                alignment:
                                                                    Alignment
                                                                        .centerLeft,
                                                                child: Text(
                                                                  "Minimum Due",
                                                                  style: theme
                                                                      .textTheme
                                                                      .bodySmall
                                                                      ?.copyWith(
                                                                    color: Colors
                                                                        .grey[600],
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                padding: EdgeInsets.only(
                                                                    left: Screens.width(context) *
                                                                        0.02),
                                                                alignment:
                                                                    Alignment
                                                                        .centerRight,
                                                                child: Text(
                                                                  "Rs 4781.00",
                                                                  style: theme
                                                                      .textTheme
                                                                      .bodySmall
                                                                      ?.copyWith(
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          // SizedBox(width: Screens.width(context)*0.02,),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: Screens.bodyheight(context) * 0.01),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: theme.primaryColor,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      height:
                                          Screens.bodyheight(context) * 0.054,
                                      width: Screens.width(context) * 0.45,
                                      child: ElevatedButton(
                                          onPressed: () {},
                                          child: Text("Create Lead")),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: theme.primaryColor,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      // color: theme.primaryColor,
                                      width: Screens.width(context) * 0.45,
                                      height:
                                          Screens.bodyheight(context) * 0.054,
                                      child: ElevatedButton(
                                          onPressed: () {},
                                          child: Text("Create Enquiry")),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
            }));
  }
}
