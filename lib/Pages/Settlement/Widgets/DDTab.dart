// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Pages/Enquiries/EnquiryManger/Widgets/AssignedtoDilaog.dart';

import '../../../../Constant/Screen.dart';
import '../../../../Controller/EnquiryController/EnquiryMngController.dart';
import '../../../Controller/SettlementController/SettlementController.dart';
import 'CashSavePop.dart';

class DDTabPage extends StatelessWidget {
  const DDTabPage({
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
              itemCount: context.read<SettlementController>().ddtList.length,
              itemBuilder: (BuildContext context, int i) {
                return InkWell(
                  onTap: () {
                    context.read<SettlementController>().iselectMethodDD(
                          i,
                        );
                  },
                  child: Container(
                    width: Screens.width(context),
                    padding: EdgeInsets.symmetric(
                        horizontal: Screens.width(context) * 0.02,
                        vertical: Screens.bodyheight(context) * 0.01),
                    child: Container(
                      //  decoration: BoxDecoration(
                      //   ),
                      color: context
                                  .read<SettlementController>()
                                  .ddtList[i]
                                  .isselect ==
                              true
                          ? Colors.green[100]
                          : Colors.grey[200],
                      // color: Colors.grey[200],
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
                                  "DD",
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
                                    "${context.watch<SettlementController>().ddtList[i].cusstomer}",
                                    style: theme.textTheme.bodyText2?.copyWith(
                                      color: theme.primaryColor,
                                      // fontWeight: FontWeight.bold
                                    )),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                width: Screens.width(context) * 0.4,
                                child: Text(
                                    context
                                        .watch<SettlementController>()
                                        .ddtList[i]
                                        .typeAmount!
                                        .toStringAsFixed(2),
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
                                  "Date",
                                  style: theme.textTheme.bodyText2
                                      ?.copyWith(color: Colors.grey),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                width: Screens.width(context) * 0.4,
                                child: Text(
                                  "Total Amount",
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
                                width: Screens.width(context) * 0.5,
                                child: Text(
                                    "${context.watch<SettlementController>().ddtList[i].collectionDate}",
                                    style: theme.textTheme.bodyText2?.copyWith(
                                      color: theme.primaryColor,
                                      //fontWeight: FontWeight.bold
                                    )),
                              ),
                              Container(
                                //color:Colors.red,
                                alignment: Alignment.centerRight,
                                width: Screens.width(context) * 0.3,
                                child: Text(
                                    context
                                        .watch<SettlementController>()
                                        .ddtList[i]
                                        .totalAmount!
                                        .toStringAsFixed(2),
                                    //"₹ ${context.watch<EnquiryMangerContoller>().getopenEnqData[i].PotentialValue}",
                                    style: theme.textTheme.bodyText2?.copyWith(
                                      color: theme.primaryColor,
                                      //fontWeight: FontWeight.bold
                                    )),
                              ),
                            ],
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.end,
                          //   children: [
                          //     Container(
                          //       alignment: Alignment.centerRight,
                          //       width: Screens.width(context) * 0.08,
                          //       height: Screens.bodyheight(context)*0.04,
                          //       // color: Colors.amber,
                          //       child: Checkbox(
                          //         value:context.read<SettlementController>().ddtList[i].isselect,
                          //         onChanged: (value) {
                          //           // setState(() {
                          //             context
                          //                 .read<SettlementController>()
                          //                 .iselectMethodDD(i,value!);
                          //             // context
                          //             //     .read<NewCustomerContoller>()
                          //             //     .billingCheckbox = value;
                          //           // });
                          //         },
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // SizedBox(
                          //   height: Screens.bodyheight(context) * 0.01,
                          // ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Column(
            children: [
              Container(
                width: Screens.width(context),
                height: Screens.bodyheight(context) * 0.06,
                //  padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color:
                        Color(0xffB299A5) //theme.primaryColor.withOpacity(0.5)
                    ,
                    border: Border.all(color: theme.primaryColor, width: 1),
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Card Total Rs.${context.watch<SettlementController>().totalDD()}",
                        maxLines: 8,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyText1?.copyWith(
                          color: theme.primaryColor,
                        ))
                  ],
                ),
              ),
              Container(
                width: Screens.width(context),
                height: Screens.bodyheight(context) * 0.077,
                padding: EdgeInsets.symmetric(
                    // horizontal: Screens.width(context) * 0.01,
                    vertical: Screens.bodyheight(context) * 0.005),
                child: ElevatedButton(
                    onPressed: () {
                      context.read<SettlementController>().validateMethodDD(context);
                      //  showDialog<dynamic>(
                      //     context: context,
                      //     builder: (_) {
                      //          // context.read<EnquiryUserContoller>(). showSpecificDialog();
                      //        //   context.read<EnquiryUserContoller>().showSuccessDia();
                      //       return CashAlertBox(indx: 1,);
                      //     });
                      // Get.toNamed(ConstantRoutes.cameraPage);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: theme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Submit Settlement')),
              ),
            ],
          )
        ],
      ),
    );
  }
}
