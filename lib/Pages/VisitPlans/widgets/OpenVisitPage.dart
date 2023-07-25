// ignore_for_file: prefer_const_constructors, unnecessary_new, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../Constant/Screen.dart';
// import '../../../../Controller/EnquiryController/EnquiryMngController.dart';
// import '../../../../Controller/EnquiryController/EnquiryUserContoller.dart';
import '../../../Controller/VisitplanController/VisitPlanController.dart';

class OpenVisitPage extends StatelessWidget {
  const OpenVisitPage({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.red,
      width: Screens.width(context),
      height: Screens.bodyheight(context),
      padding: EdgeInsets.symmetric(
          horizontal: Screens.width(context) * 0.03,
          vertical: Screens.bodyheight(context) * 0.02),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount:
                  context.watch<VisitplanController>().openVisitData.length,
              itemBuilder: (BuildContext context, int i) {
                return InkWell(
                  onDoubleTap: () {},
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: Screens.width(context) * 0.4,
                                child: Text(
                                    "${context.watch<VisitplanController>().openVisitData[i].customer}",
                                    style: theme.textTheme.bodyText2?.copyWith(
                                      color: theme.primaryColor,
                                      // fontWeight: FontWeight.bold
                                    )),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                width: Screens.width(context) * 0.4,
                                child: Text(
                                    "${context.watch<VisitplanController>().openVisitData[i].datetime}",
                                    style: theme.textTheme.bodyText2?.copyWith(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                                                    // color:Colors.red,

                                  alignment: Alignment.topLeft,
                                  width: Screens.width(context) * 0.4,
                                  child: Text(
                                      "${context.watch<VisitplanController>().openVisitData[i].purpose}",
                                      style: theme.textTheme.bodyText2?.copyWith(
                                        color: theme.primaryColor,
                                        //fontWeight: FontWeight.bold
                                      )),
                                ),
                                Container(
                                  // color:Colors.red,
                                  alignment: Alignment.topRight,
                                  width: Screens.width(context) * 0.4,
                                  child: Text(
                                      "${context.watch<VisitplanController>().openVisitData[i].area!} ",
                                      textAlign: TextAlign.right,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      //"₹ ${context.watch<EnquiryUserContoller>().getopenEnqData[i].PotentialValue}",
                                      style: theme.textTheme.bodyText2?.copyWith(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    //color: Colors.red,
                                    width: Screens.width(context) * 0.54,
                                    child: Text(
                                        "Product",
                                        style:
                                            theme.textTheme.bodyText2?.copyWith(
                                          color: Colors.grey,
                                          // fontWeight: FontWeight.bold
                                        )),
                                  ),
                                  Container(
                                    // color: Colors.red,
                                    alignment: Alignment.centerLeft,
                                    width: Screens.width(context) * 0.54,
                                    child: Text(
                                        "${context.watch<VisitplanController>().openVisitData[i].product!}",
                                        //"₹ ${context.watch<EnquiryUserContoller>().getopenEnqData[i].PotentialValue}",
                                        style:
                                            theme.textTheme.bodyText2?.copyWith(
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
                                      borderRadius: BorderRadius.circular(4)),
                                  // width: Screens.width(context) * 0.1,
                                  child: Padding(
                                    padding:  EdgeInsets.all(Screens.width(context) * 0.01),
                                    child: Text(
                                        "${context.watch<VisitplanController>().openVisitData[i].type}",
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
    );
  }
}
