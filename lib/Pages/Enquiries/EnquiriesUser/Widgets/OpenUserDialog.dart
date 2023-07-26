// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../Constant/Screen.dart';
import '../../../../Controller/EnquiryController/EnquiryUserContoller.dart';

class AssignedToDialogUser extends StatefulWidget {
  AssignedToDialogUser({Key? key, required this.indx}) : super(key: key);
  final int indx;
  @override
  State<AssignedToDialogUser> createState() => AssignedToDialogUserState();
}

class AssignedToDialogUserState extends State<AssignedToDialogUser> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      insetPadding: EdgeInsets.all(10),
      contentPadding: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: context.read<EnquiryUserContoller>().getassignto == false &&
              context.read<EnquiryUserContoller>().getassigntoApiCall ==
                  false &&
              context.read<EnquiryUserContoller>().getassignedToApiActResp ==
                  '' &&
              context.read<EnquiryUserContoller>().getstatusUpdate == false &&
              context.read<EnquiryUserContoller>().getstatusUpdateLoading ==
                  false &&
              context.read<EnquiryUserContoller>().getstatusUpdateApiResp ==
                  '' &&
              context.read<EnquiryUserContoller>().getisAnotherBranchEnq ==
                  false

          ///
          ? enqDetailsPage(context, theme)
          : context.read<EnquiryUserContoller>().getassignto == false &&
                  context.read<EnquiryUserContoller>().getassigntoApiCall ==
                      false &&
                  context.read<EnquiryUserContoller>().getassignedToApiActResp ==
                      '' &&
                  context.read<EnquiryUserContoller>().getstatusUpdate ==
                      false &&
                  context.read<EnquiryUserContoller>().getstatusUpdateLoading ==
                      false &&
                  context.read<EnquiryUserContoller>().getstatusUpdateApiResp ==
                      '' &&
                  context.read<EnquiryUserContoller>().getisAnotherBranchEnq ==
                      true

              ///
              ? enqDetailsToOtherBranch(context, theme)
              : context.read<EnquiryUserContoller>().getassignto == true &&
                      context.read<EnquiryUserContoller>().getassigntoApiCall ==
                          false &&
                      context.read<EnquiryUserContoller>().getassignedToApiActResp ==
                          '' &&
                      context.read<EnquiryUserContoller>().getstatusUpdate ==
                          false &&
                      context.read<EnquiryUserContoller>().getstatusUpdateLoading ==
                          false &&
                      context.read<EnquiryUserContoller>().getstatusUpdateApiResp ==
                          '' &&
                      context.read<EnquiryUserContoller>().getisAnotherBranchEnq ==
                          false
                  ? assignedTOPage(context, theme)
                  : context.read<EnquiryUserContoller>().getassignto == true &&
                          context.read<EnquiryUserContoller>().getassigntoApiCall ==
                              true &&
                          context.read<EnquiryUserContoller>().getassignedToApiActResp ==
                              '' &&
                          context.read<EnquiryUserContoller>().getstatusUpdate ==
                              false &&
                          context.read<EnquiryUserContoller>().getstatusUpdateLoading ==
                              false &&
                          context.read<EnquiryUserContoller>().getstatusUpdateApiResp ==
                              '' &&
                          context.read<EnquiryUserContoller>().getisAnotherBranchEnq ==
                              false
                      ? LoadingPage(context)
                      : context.read<EnquiryUserContoller>().getassignto == true &&
                              context.read<EnquiryUserContoller>().getassigntoApiCall ==
                                  false &&
                              context.read<EnquiryUserContoller>().getassignedToApiActResp != '' &&
                              context.read<EnquiryUserContoller>().getstatusUpdate == false &&
                              context.read<EnquiryUserContoller>().getstatusUpdateLoading == false &&
                              context.read<EnquiryUserContoller>().getstatusUpdateApiResp == '' &&
                              context.read<EnquiryUserContoller>().getisAnotherBranchEnq == false
                          ? assignedToApiRespPage(context, theme)
                          : context.read<EnquiryUserContoller>().getassignto == false && context.read<EnquiryUserContoller>().getassigntoApiCall == false && context.read<EnquiryUserContoller>().getassignedToApiActResp == '' && context.read<EnquiryUserContoller>().getstatusUpdate == true && context.read<EnquiryUserContoller>().getstatusUpdateLoading == false && context.read<EnquiryUserContoller>().getstatusUpdateApiResp == '' && context.read<EnquiryUserContoller>().getisAnotherBranchEnq == false
                              ? statusRespPage(context, theme)
                              : //

                              context.read<EnquiryUserContoller>().getassignto == false && 
                              context.read<EnquiryUserContoller>().getassigntoApiCall == false 
                              && context.read<EnquiryUserContoller>().getassignedToApiActResp == ''
                              && context.read<EnquiryUserContoller>().getstatusUpdate == true && 
                              context.read<EnquiryUserContoller>().getstatusUpdateLoading == false 
                              && context.read<EnquiryUserContoller>().getstatusUpdateApiResp != '' 
                              && context.read<EnquiryUserContoller>().getisAnotherBranchEnq == false
                                  ? statusUpdateApiRespPage(context, theme)
                                  : LoadingPage(context),
    );
  }

  Row assignedToPageBtn(BuildContext context, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {
            setState(() {
              if (context.read<EnquiryUserContoller>().assignto == false) {
                context.read<EnquiryUserContoller>().assignto = true;
              } else {
                context.read<EnquiryUserContoller>().assignto = false;
              }
            });
          },
          child: Text(
            "Back",
            style: theme.textTheme.bodyText1?.copyWith(color: Colors.white),
          ),
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(theme.primaryColor)),
        ),
        TextButton(
          onPressed: context.watch<EnquiryUserContoller>().getUserKey == null
              ? null
              : () {
                  if (context.read<EnquiryUserContoller>().getUserKey == null) {
                  } else {
                    context.read<EnquiryUserContoller>().callAsignedToApi(
                        // "1000","1000",context
                        context
                            .read<EnquiryUserContoller>()
                            .getopenEnqData[widget.indx]
                            .EnqID
                            .toString(),
                        context
                            .read<EnquiryUserContoller>()
                            .getuserLtData[context
                                .read<EnquiryUserContoller>()
                                .selectedIdxFUser!]
                            .SalesEmpID //changeddd UserKey
                            .toString(),
                        context);

                    print(context
                        .read<EnquiryUserContoller>()
                        .getopenEnqData[widget.indx]
                        .EnqID
                        .toString());
                    print(context
                        .read<EnquiryUserContoller>()
                        .getuserLtData[context
                            .read<EnquiryUserContoller>()
                            .selectedIdxFUser!]
                        .SalesEmpID//.UserKey
                        .toString());
                  }
                },
          child: Text(
            "Forward to",
            style: theme.textTheme.bodyText1?.copyWith(color: Colors.white),
          ),
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(theme.primaryColor)),
        )
      ],
    );
  }

  Container statusUpdateApiRespPage(BuildContext context, ThemeData theme) {
    return Container(
      width: Screens.width(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: Screens.width(context),
            height: Screens.bodyheight(context) * 0.06,
            child: ElevatedButton(
              onPressed: null,
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(
                    // fontSize: 12,
                    ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                )), //Radius.circular(6)
              ),
              child: Text(
                "Alert",
                style: theme.textTheme.bodyText1?.copyWith(color: Colors.white),
              ),
            ),
          ),
          Container(
            width: Screens.width(context),
            height: Screens.bodyheight(context) * 0.2,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    context
                        .watch<EnquiryUserContoller>()
                        .getstatusUpdateApiResp,
                    style: context
                            .watch<EnquiryUserContoller>()
                            .getstatusUpdateApiResp
                            .contains("Success")
                        ? theme.textTheme.headline6
                            ?.copyWith(color: Colors.green)
                        : theme.textTheme.headline6
                            ?.copyWith(color: Colors.red),
                  ),
                  SizedBox(
                    height: Screens.bodyheight(context) * 0.02,
                  ),
                  Text(
                    context
                        .watch<EnquiryUserContoller>()
                        .getstatusUpdateApiRespMsg,
                    style: theme.textTheme.bodyText1,
                  ),
                  SizedBox(
                    height: Screens.bodyheight(context) * 0.01,
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Ok",
                        style: theme.textTheme.bodyText1
                            ?.copyWith(color: Colors.white),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              theme.primaryColor)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container statusRespPage(BuildContext context, ThemeData theme) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: Screens.width(context),
            height: Screens.bodyheight(context) * 0.06,
            child: ElevatedButton(
              onPressed: () {
                // context.read<LeadTabController>().viweDetailsClicked();
              },
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(
                    // fontSize: 12,
                    ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                )), //Radius.circular(6)
              ),
              child: Text(
                "Status Update",
              ),
            ),
          ),
          Container(
            width: Screens.width(context),
            // height: Screens.bodyheight(context) * 0.4,
            padding: EdgeInsets.only(
              left: Screens.width(context) * 0.02,
              right: Screens.width(context) * 0.02,
              top: Screens.bodyheight(context) * 0.03,
              bottom: Screens.bodyheight(context) * 0.03,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Text(
                //   "Status Update",
                //   style: theme.textTheme.bodyText1,
                // ),
                SizedBox(
                  height: Screens.bodyheight(context) * 0.01,
                ),
                Wrap(
                    spacing: 5.0, // gap between adjacent chips
                    runSpacing: 5.0, // gap between lines
                    children: listContainersReson(
                      theme,
                    )),
                SizedBox(
                  height: Screens.bodyheight(context) * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          if (context
                                  .read<EnquiryUserContoller>()
                                  .statusUpdate ==
                              false) {
                            context.read<EnquiryUserContoller>().statusUpdate =
                                true;
                          } else {
                            context.read<EnquiryUserContoller>().statusUpdate =
                                false;
                          }
                        });
                      },
                      child: Text(
                        "Back",
                        style: theme.textTheme.bodyText1
                            ?.copyWith(color: Colors.white),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              theme.primaryColor)),
                    ),
                    TextButton(
                      onPressed: () {
                        if (context
                                    .read<EnquiryUserContoller>()
                                    .valueChosedReason !=
                                null
                            // context.read<EnquiryUserContoller>().mycontroller[0].text.isNotEmpty
                            ) {
                          context.read<EnquiryUserContoller>().callUpdateEnqApi(
                              context,
                              context
                                  .read<EnquiryUserContoller>()
                                  .getopenEnqData[widget.indx]
                                  .EnqID
                                  .toString());
                        } else {
                          print("reason value: " +
                              context
                                  .read<EnquiryUserContoller>()
                                  .valueChosedReason
                                  .toString());
                        }
                      },
                      child: Text(
                        "Update",
                        style: theme.textTheme.bodyText1
                            ?.copyWith(color: Colors.white),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              theme.primaryColor)),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: Screens.width(context),
            height: Screens.bodyheight(context) * 0.06,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                context.read<EnquiryUserContoller>().mapValuesToLead(widget.indx);
              },
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(
                    // fontSize: 12,
                    ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                )), //Radius.circular(6)
              ),
              child: Text(
                "Convert to lead",
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container assignedToApiRespPage(BuildContext context, ThemeData theme) {
    return Container(
      width: Screens.width(context) * 0.9,
      height: Screens.bodyheight(context) * 0.3,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.watch<EnquiryUserContoller>().getassignedToApiActResp,
              style: context
                      .watch<EnquiryUserContoller>()
                      .getassignedToApiActResp
                      .contains("Success")
                  ? theme.textTheme.headline6?.copyWith(color: Colors.green)
                  : theme.textTheme.headline6?.copyWith(color: Colors.red),
            ),
            SizedBox(
              height: Screens.bodyheight(context) * 0.02,
            ),
            Text(
              context.watch<EnquiryUserContoller>().getassignedToApiActRespMsg,
              style: theme.textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }

  Container LoadingPage(BuildContext context) {
    return Container(
        width: Screens.width(context) * 0.9,
        height: Screens.bodyheight(context) * 0.3,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
            ],
          ),
        ));
  }

  Container assignedTOPage(BuildContext context, ThemeData theme) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: Screens.width(context),
            height: Screens.bodyheight(context) * 0.06,
            child: ElevatedButton(
              onPressed: () {
                // context.read<LeadTabController>().viweDetailsClicked();
              },
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(
                    // fontSize: 12,
                    ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                )), //Radius.circular(6)
              ),
              child: Text(
                "Forward to",
              ),
            ),
          ),
          Container(
            width: Screens.width(context),
            //height: Screens.bodyheight(context) * 0.4,
            padding: EdgeInsets.only(
              left: Screens.width(context) * 0.05,
              right: Screens.width(context) * 0.05,
              top: Screens.bodyheight(context) * 0.03,
              bottom: Screens.bodyheight(context) * 0.03,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                //  Text(
                //           "Forward to",
                //           style: theme.textTheme.bodyText1,
                //         ),
                SizedBox(
                  height: Screens.bodyheight(context) * 0.01,
                ),
                Wrap(
                    spacing: 5.0, // gap between adjacent chips
                    runSpacing: 5.0, // gap between lines
                    children: listContainersProduct(
                      theme,
                    )),
                SizedBox(
                  height: Screens.bodyheight(context) * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          if (context.read<EnquiryUserContoller>().assignto ==
                              false) {
                            context.read<EnquiryUserContoller>().assignto =
                                true;
                          } else {
                            context.read<EnquiryUserContoller>().assignto =
                                false;
                          }
                        });
                      },
                      child: Text(
                        "Back",
                        style: theme.textTheme.bodyText1
                            ?.copyWith(color: Colors.white),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              theme.primaryColor)),
                    ),
                    TextButton(
                      onPressed: context
                                  .watch<EnquiryUserContoller>()
                                  .getUserKey ==
                              null
                          ? null
                          : () {
                              if (context
                                      .read<EnquiryUserContoller>()
                                      .getUserKey ==
                                  null) {
                              } else {
                                context
                                    .read<EnquiryUserContoller>()
                                    .callAsignedToApi(
                                        context
                                            .read<EnquiryUserContoller>()
                                            .getopenEnqData[widget.indx]
                                            .EnqID
                                            .toString(),
                                        context
                                            .read<EnquiryUserContoller>()
                                            .getuserLtData[context
                                                .read<EnquiryUserContoller>()
                                                .selectedIdxFUser!]
                                            .SalesEmpID//.UserKey 
                                            .toString(),
                                        context);

                                print(context
                                    .read<EnquiryUserContoller>()
                                    .getopenEnqData[widget.indx] 
                                    .EnqID
                                    .toString());
                                print(context
                                    .read<EnquiryUserContoller>()
                                    .getuserLtData[context
                                        .read<EnquiryUserContoller>()
                                        .selectedIdxFUser!]
                                   .SalesEmpID// .UserKey
                                    .toString());
                              }
                            },
                      child: Text(
                        "Forward to",
                        style: theme.textTheme.bodyText1
                            ?.copyWith(color: Colors.white),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              theme.primaryColor)),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container enqDetailsPage(BuildContext context, ThemeData theme) {
    return Container(
      //  color: Colors.black12,
      // height: Screens.bodyheight(context) * 0.4,
      width: Screens.width(context),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: Screens.width(context),
              height: Screens.bodyheight(context) * 0.06,
              child: ElevatedButton(
                  onPressed: () {
                    // context.read<LeadTabController>().viweDetailsClicked();
                  },
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(
                        // fontSize: 12,
                        ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )), //Radius.circular(6)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Call assigned to ${context.watch<EnquiryUserContoller>().getopenEnqData[widget.indx].AssignedTo_UserName}",
                      ),
                      Text(
                        "${context.watch<EnquiryUserContoller>().getopenEnqData[widget.indx].Status}",
                      ),
                    ],
                  )),
            ),
            Container(
              padding: EdgeInsets.only(
                left: Screens.width(context) * 0.05,
                right: Screens.width(context) * 0.05,
                top: Screens.bodyheight(context) * 0.03,
                bottom: Screens.bodyheight(context) * 0.03,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,

                        //     width: Screens.width(context) * 0.4,
                        child: Text(
                          "Customer",
                          style: theme.textTheme.bodyText2
                              ?.copyWith(color: Colors.grey),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,

                        //    width: Screens.width(context) * 0.4,
                        child: Text(
                          "Date",
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
                        alignment: Alignment.centerLeft,

                        //    width: Screens.width(context) * 0.4,
                        child: Text(
                            "${context.watch<EnquiryUserContoller>().getopenEnqData[widget.indx].CardName}",
                            style: theme.textTheme.bodyText2?.copyWith(
                              color: theme.primaryColor,
                              //  fontWeight: FontWeight.bold
                            )),
                      ),
                      Container(
                        alignment: Alignment.centerRight,

                        //    width: Screens.width(context) * 0.4,
                        child: Text(
                            context.read<EnquiryUserContoller>().config.alignDate(
                                "${context.watch<EnquiryUserContoller>().getopenEnqData[widget.indx].EnqDate}"),
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
                        alignment: Alignment.centerLeft,

                        // width: Screens.width(context) * 0.4,
                        child: Text(
                          "Product",
                          style: theme.textTheme.bodyText2
                              ?.copyWith(color: Colors.grey),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,

                        //   width: Screens.width(context) * 0.4,
                        child: Text(
                          "Potential Value",
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
                        alignment: Alignment.centerLeft,
                        width: Screens.width(context) * 0.4,
                        child: Text(
                            "Looking for ${context.watch<EnquiryUserContoller>().getopenEnqData[widget.indx].Lookingfor}",
                            style: theme.textTheme.bodyText2?.copyWith(
                              color: theme.primaryColor,
                              //  fontWeight: FontWeight.bold
                            )),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        width: Screens.width(context) * 0.2,
                        child: Text(
                            "₹ ${context.watch<EnquiryUserContoller>().getopenEnqData[widget.indx].PotentialValue}",
                            style: theme.textTheme.bodyText2?.copyWith(
                              color: theme.primaryColor,
                              // fontWeight: FontWeight.bold
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
                        alignment: Alignment.centerLeft,

                        //color: Colors.red,
                        width: Screens.width(context) * 0.35,
                        child: Text("Follow Up Date",
                            //textAlign: TextAlign.center,
                            style: theme.textTheme.bodyText2?.copyWith(
                              color: Colors.grey,
                              // fontWeight: FontWeight.bold
                            )),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        //color: Colors.red,
                        width: Screens.width(context) * 0.45,
                        child: Text("Enq type",
                            textAlign: TextAlign.right,
                            style: theme.textTheme.bodyText2?.copyWith(
                              color: Colors.grey,
                              //   fontWeight: FontWeight.bold
                            )),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        //color: Colors.red,
                        alignment: Alignment.centerLeft,
                        width: Screens.width(context) * 0.35,
                        child: Text(
                          context.watch<EnquiryUserContoller>().getopenEnqData[widget.indx].Followup!.isNotEmpty?
                            context.read<EnquiryUserContoller>().config.alignDate(
                                "${context.watch<EnquiryUserContoller>().getopenEnqData[widget.indx].Followup}")
                                :'',
                            style: theme.textTheme.bodyText2?.copyWith(
                              color: theme.primaryColor,
                              //fontWeight: FontWeight.bold
                            )),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        //color: Colors.red,
                        width: Screens.width(context) * 0.45,
                        child: Text(
                            "${context.watch<EnquiryUserContoller>().getopenEnqData[widget.indx].EnqType}",
                            textAlign: TextAlign.right,
                            style: theme.textTheme.bodyText2?.copyWith(
                              color: theme.primaryColor,
                              //  fontWeight: FontWeight.bold
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Screens.bodyheight(context) * 0.01,
                  ),
                  Column(children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      //color: Colors.red,
                      child: Text("Address",
                          style: theme.textTheme.bodyText2?.copyWith(
                            color: Colors.grey,
                            //fontWeight: FontWeight.bold
                          )),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      //color: Colors.red,
                      child: Text(
                          "${context.watch<EnquiryUserContoller>().getopenEnqData[widget.indx].Address_Line_1}",
                          style: theme.textTheme.bodyText2?.copyWith(
                            color: theme.primaryColor,
                            //  fontWeight: FontWeight.bold
                          )),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      //color: Colors.red,
                      child: Text(
                          "${context.watch<EnquiryUserContoller>().getopenEnqData[widget.indx].Address_Line_2}",
                          style: theme.textTheme.bodyText2?.copyWith(
                            color: theme.primaryColor,
                            // fontWeight: FontWeight.bold
                          )),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      //color: Colors.red,
                      child: Text(
                          "${context.watch<EnquiryUserContoller>().getopenEnqData[widget.indx].City} - ${context.watch<EnquiryUserContoller>().getopenEnqData[widget.indx].Pincode}",
                          style: theme.textTheme.bodyText2?.copyWith(
                            color: theme.primaryColor,
                            //fontWeight: FontWeight.bold
                          )),
                    ),
                  ]),

                  //
                  SizedBox(
                    height: Screens.bodyheight(context) * 0.02,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: Screens.width(context) * 0.32,
                        height: Screens.bodyheight(context) * 0.06,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: theme.primaryColor,
                              textStyle: TextStyle(color: Colors.white),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6))),
                            ),
                            onPressed: () {
                              setState(() {
                                if (context
                                        .read<EnquiryUserContoller>()
                                        .statusUpdate ==
                                    false) {
                                  context
                                      .read<EnquiryUserContoller>()
                                      .statusUpdate = true;
                                } else {
                                  context
                                      .read<EnquiryUserContoller>()
                                      .statusUpdate = false;
                                }
                              });
                            },
                            child: Text(
                              "Status Update",
                              style: theme.textTheme.bodyText2
                                  ?.copyWith(color: Colors.white),
                            )),
                      ),
                      Container(
                        width: Screens.width(context) * 0.15,
                        height: Screens.bodyheight(context) * 0.06,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: theme.primaryColor,
                              textStyle: TextStyle(color: Colors.white),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6))),
                            ),
                            onPressed: () {
                              context
                                  .read<EnquiryUserContoller>()
                                  .makePhoneCall(context
                                      .read<EnquiryUserContoller>()
                                      .getopenEnqData[widget.indx]
                                      .CardCode!);
                            },
                            child: Icon(Icons.call,
                                color: Colors.white,
                                size: Screens.bodyheight(context) * 0.03)),
                      ),
                      Container(
                        width: Screens.width(context) * 0.32,
                        height: Screens.bodyheight(context) * 0.06,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: theme.primaryColor,
                              textStyle: TextStyle(color: Colors.white),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6))),
                            ),
                            onPressed: () {
                              setState(() {
                                if (context
                                        .read<EnquiryUserContoller>()
                                        .assignto ==
                                    false) {
                                  context
                                      .read<EnquiryUserContoller>()
                                      .assignto = true;
                                } else {
                                  context
                                      .read<EnquiryUserContoller>()
                                      .assignto = false;
                                }
                              });
                            },
                            child: Text(
                              "Forward",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: Screens.width(context),
              height: Screens.bodyheight(context) * 0.06,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.read<EnquiryUserContoller>().mapValuesToLead(widget.indx);
                },
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(
                      // fontSize: 12,
                      ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )), //Radius.circular(6)
                ),
                child: Text(
                  "Convert to lead",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container enqDetailsToOtherBranch(BuildContext context, ThemeData theme) {
    return Container(
      //  color: Colors.black12,
      // height: Screens.bodyheight(context) * 0.4,
      width: Screens.width(context),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: Screens.width(context),
              height: Screens.bodyheight(context) * 0.06,
              child: ElevatedButton(
                  onPressed: () {
                    // context.read<LeadTabController>().viweDetailsClicked();
                  },
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(
                        // fontSize: 12,
                        ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )), //Radius.circular(6)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Call assigned to ${context.watch<EnquiryUserContoller>().getopenEnqData[widget.indx].AssignedTo_UserName}",
                      ),
                      Text(
                        "${context.watch<EnquiryUserContoller>().getopenEnqData[widget.indx].Status}",
                      ),
                    ],
                  )),
            ),
            Container(
              padding: EdgeInsets.only(
                left: Screens.width(context) * 0.05,
                right: Screens.width(context) * 0.05,
                top: Screens.bodyheight(context) * 0.03,
                bottom: Screens.bodyheight(context) * 0.03,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,

                        //     width: Screens.width(context) * 0.4,
                        child: Text(
                          "Customer",
                          style: theme.textTheme.bodyText2
                              ?.copyWith(color: Colors.grey),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,

                        //    width: Screens.width(context) * 0.4,
                        child: Text(
                          "Date",
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
                        alignment: Alignment.centerLeft,

                        //    width: Screens.width(context) * 0.4,
                        child: Text(
                            "${context.watch<EnquiryUserContoller>().getopenEnqData[widget.indx].CardName}",
                            style: theme.textTheme.bodyText2?.copyWith(
                              color: theme.primaryColor,
                              //  fontWeight: FontWeight.bold
                            )),
                      ),
                      Container(
                        alignment: Alignment.centerRight,

                        //    width: Screens.width(context) * 0.4,
                        child: Text(
                            context.read<EnquiryUserContoller>().config.alignDate(
                                "${context.watch<EnquiryUserContoller>().getopenEnqData[widget.indx].EnqDate}"),
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
                        alignment: Alignment.centerLeft,

                        // width: Screens.width(context) * 0.4,
                        child: Text(
                          "Product",
                          style: theme.textTheme.bodyText2
                              ?.copyWith(color: Colors.grey),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,

                        //   width: Screens.width(context) * 0.4,
                        child: Text(
                          "Potential Value",
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
                        alignment: Alignment.centerLeft,
                        width: Screens.width(context) * 0.4,
                        child: Text(
                            "Looking for ${context.watch<EnquiryUserContoller>().getopenEnqData[widget.indx].Lookingfor}",
                            style: theme.textTheme.bodyText2?.copyWith(
                              color: theme.primaryColor,
                              //  fontWeight: FontWeight.bold
                            )),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        width: Screens.width(context) * 0.2,
                        child: Text(
                            "₹ ${context.watch<EnquiryUserContoller>().getopenEnqData[widget.indx].PotentialValue}",
                            style: theme.textTheme.bodyText2?.copyWith(
                              color: theme.primaryColor,
                              // fontWeight: FontWeight.bold
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
                        alignment: Alignment.centerLeft,

                        //color: Colors.red,
                        width: Screens.width(context) * 0.35,
                        child: Text("Follow Up Date",
                            //textAlign: TextAlign.center,
                            style: theme.textTheme.bodyText2?.copyWith(
                              color: Colors.grey,
                              // fontWeight: FontWeight.bold
                            )),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        //color: Colors.red,
                        width: Screens.width(context) * 0.45,
                        child: Text("Enq type",
                            textAlign: TextAlign.right,
                            style: theme.textTheme.bodyText2?.copyWith(
                              color: Colors.grey,
                              //   fontWeight: FontWeight.bold
                            )),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        //color: Colors.red,
                        alignment: Alignment.centerLeft,
                        width: Screens.width(context) * 0.35,
                        child: Text(
                            context.read<EnquiryUserContoller>().config.alignDate(
                                "${context.watch<EnquiryUserContoller>().getopenEnqData[widget.indx].Followup}"),
                            style: theme.textTheme.bodyText2?.copyWith(
                              color: theme.primaryColor,
                              //fontWeight: FontWeight.bold
                            )),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        //color: Colors.red,
                        width: Screens.width(context) * 0.45,
                        child: Text(
                            "${context.watch<EnquiryUserContoller>().getopenEnqData[widget.indx].EnqType}",
                            textAlign: TextAlign.right,
                            style: theme.textTheme.bodyText2?.copyWith(
                              color: theme.primaryColor,
                              //  fontWeight: FontWeight.bold
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Screens.bodyheight(context) * 0.01,
                  ),
                  Column(children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      //color: Colors.red,
                      child: Text("Address",
                          style: theme.textTheme.bodyText2?.copyWith(
                            color: Colors.grey,
                            //fontWeight: FontWeight.bold
                          )),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      //color: Colors.red,
                      child: Text(
                          "${context.watch<EnquiryUserContoller>().getopenEnqData[widget.indx].Address_Line_1}",
                          style: theme.textTheme.bodyText2?.copyWith(
                            color: theme.primaryColor,
                            //  fontWeight: FontWeight.bold
                          )),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      //color: Colors.red,
                      child: Text(
                          "${context.watch<EnquiryUserContoller>().getopenEnqData[widget.indx].Address_Line_2}",
                          style: theme.textTheme.bodyText2?.copyWith(
                            color: theme.primaryColor,
                            // fontWeight: FontWeight.bold
                          )),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      //color: Colors.red,
                      child: Text(
                          "${context.watch<EnquiryUserContoller>().getopenEnqData[widget.indx].City} - ${context.watch<EnquiryUserContoller>().getopenEnqData[widget.indx].Pincode}",
                          style: theme.textTheme.bodyText2?.copyWith(
                            color: theme.primaryColor,
                            //fontWeight: FontWeight.bold
                          )),
                    ),
                  ]),
                ],
              ),
            ),
            Container(
              width: Screens.width(context),
              height: Screens.bodyheight(context) * 0.06,
              child: ElevatedButton(
                onPressed: () {
                  //Provider.of<EnquiryUserContoller>(context, listen: false);
                  Navigator.pop(context);
                  context.read<EnquiryUserContoller>().mapValuesToEnq();
                },
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )),
                ),
                child: Text(
                  "Create New Enquiry",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> listContainersProduct(
    ThemeData theme,
  ) {
    return List.generate(
      context.watch<EnquiryUserContoller>().getuserLtData.length,
      (ind) => GestureDetector(
        onTap: () {
          context.read<EnquiryUserContoller>().selectedIdxFUser = ind;
          context.read<EnquiryUserContoller>().selectUser(ind);
        },
        child: Container(
          // alignment: Alignment.center,
          // width: Screens.width(context) * 0.2,
          // height: Screens.bodyheight(context) * 0.06,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: context
                          .watch<EnquiryUserContoller>()
                          .getuserLtData[ind]
                          .color ==
                      1
                  ? theme.primaryColor
                  : Colors.white,
              border: Border.all(color: theme.primaryColor, width: 1),
              borderRadius: BorderRadius.circular(5)),
          child: Text(
              context
                  .watch<EnquiryUserContoller>()
                  .getuserLtData[ind]
                  .UserName!,
              // maxLines: 1,
              //overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyText2?.copyWith(
                fontWeight: FontWeight.normal,
                fontSize: 12,
                color: context
                            .watch<EnquiryUserContoller>()
                            .getuserLtData[ind]
                            .color ==
                        1
                    //content[index].isselected == 1
                    ? Colors.white
                    : theme.primaryColor,
              )),
        ),
      ),
    );
  }

  List<Widget> listContainersReson(
    ThemeData theme,
  ) {
    return List.generate(
      context.watch<EnquiryUserContoller>().getresonData.length,
      (ind) => GestureDetector(
        onTap: () {
          context.read<EnquiryUserContoller>().selectedIdxFUser = ind;
          context.read<EnquiryUserContoller>().selectReason(ind);
        },
        child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color:
                  context.watch<EnquiryUserContoller>().getresonData[ind].color == 1
                      ? theme.primaryColor
                      : Colors.white,
              border: Border.all(color: theme.primaryColor, width: 1),
              borderRadius: BorderRadius.circular(5)),
          child: Text(context.watch<EnquiryUserContoller>().getresonData[ind].CODE!,
              // maxLines: 1,
              //overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyText2?.copyWith(
                fontWeight: FontWeight.normal,
                fontSize: 12,
                color:
                    context.watch<EnquiryUserContoller>().getresonData[ind].color ==
                            1
                        //content[index].isselected == 1
                        ? Colors.white
                        : theme.primaryColor,
              )),
        ),
      ),
    );
  }
}

  // SizedBox(
                  //   height: Screens.bodyheight(context) * 0.01,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Container(
                  //       alignment: Alignment.centerLeft,

                  //       //color: Colors.red,
                  //       width: Screens.width(context) * 0.4,
                  //       child: Text(
                  //           "Call assigned to ${ context.watch<EnquiryUserContoller>().getopenEnqData[widget.indx].AssignedTo_UserName}",
                  //           style: theme.textTheme.bodyText2?.copyWith(
                  //               color: Colors.grey,
                  //              // fontWeight: FontWeight.bold
                  //               )),
                  //     ),
                  //     Container(
                  //       alignment: Alignment.centerRight,
                  //       //color: Colors.red,
                  //       width: Screens.width(context) * 0.2,
                  //       child: Text("${ context.watch<EnquiryUserContoller>().getopenEnqData[widget.indx].Status}",
                  //           style: theme.textTheme.bodyText2?.copyWith(
                  //               color: Colors.grey,
                  //             //  fontWeight: FontWeight.bold
                  //               )),
                  //     ),
                  //   ],
                  // ),

// actions:
//  [
//     context.read<EnquiryUserContoller>().getassignto == false &&
//        context.read<EnquiryUserContoller>().getassigntoApiCall == false &&
// context.read<EnquiryUserContoller>().getassignedToApiActResp == ''
// &&
//  context.read<EnquiryUserContoller>().getstatusUpdate == false &&
//   context.read<EnquiryUserContoller>().getstatusUpdateLoading == false &&
//  context.read<EnquiryUserContoller>().getstatusUpdateApiResp ==''
// ?

//    enqDetailsPageBtn(context, theme):

//       context.read<EnquiryUserContoller>().getassignto == true &&
//        context.read<EnquiryUserContoller>().getassigntoApiCall == false &&
// context.read<EnquiryUserContoller>().getassignedToApiActResp == ''
// &&
//  context.read<EnquiryUserContoller>().getstatusUpdate == false &&
//   context.read<EnquiryUserContoller>().getstatusUpdateLoading == false &&
//  context.read<EnquiryUserContoller>().getstatusUpdateApiResp ==''
// ?
//    assignedToPageBtn(context, theme):
//  context.read<EnquiryUserContoller>().getassignto == false &&
//                    context.read<EnquiryUserContoller>().getassigntoApiCall == false &&
//             context.read<EnquiryUserContoller>().getassignedToApiActResp == ''
//             &&
//              context.read<EnquiryUserContoller>().getstatusUpdate == true &&
//               context.read<EnquiryUserContoller>().getstatusUpdateLoading == false &&
//              context.read<EnquiryUserContoller>().getstatusUpdateApiResp ==''?

//                 statusUpdateBtn(theme, context)
//                  :SizedBox()
//                ,
//            ],

// Row enqDetailsPageBtn(BuildContext context, ThemeData theme) {
//   return Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: [
//                           TextButton(
//                 onPressed: () {
//                   setState((){
//                     if( context.read<EnquiryUserContoller>().statusUpdate == false){
//                      context.read<EnquiryUserContoller>().statusUpdate = true;
//                     }else {
//                      context.read<EnquiryUserContoller>().statusUpdate = false;
//                     }
//                   });
//                 },
//                 child: Text(
//                   "Status Update",
//                   style: theme.textTheme.bodyText1
//                       ?.copyWith(color: Colors.white),
//                 ),
//                 style: ButtonStyle(
//                     backgroundColor:
//                         MaterialStateProperty.all<Color>(theme.primaryColor)),
//               ),
//              //  SizedBox(width: Screens.width(context)*0.03,),
//                  TextButton(
//                     onPressed: () {
//                       // Navigator.pop(context);
//                       // Future.delayed(Duration(seconds: 2),(){

//                     //  });
//                      context.read<EnquiryUserContoller>().makePhoneCall( context.read<EnquiryUserContoller>().getopenEnqData[widget.indx].CardCode!);
//                     },
//                     child:
//                     Icon(Icons.call,color: Colors.white,size: Screens.bodyheight(context)*0.03,),
//                     //  Text(
//                     //   "Call",
//                     //   style: theme.textTheme.bodyText1
//                     //       ?.copyWith(color: Colors.white),
//                     // ),
//                     style: ButtonStyle(
//                         backgroundColor:
//                             MaterialStateProperty.all<Color>(theme.primaryColor)),
//                   ),
//                  // SizedBox(width: Screens.width(context)*0.03,),
//                        TextButton(
//                 onPressed: () {
//                   setState((){
//                     if( context.read<EnquiryUserContoller>().assignto == false){
//                      context.read<EnquiryUserContoller>().assignto = true;
//                     }else {
//                      context.read<EnquiryUserContoller>().assignto = false;
//                     }
//                   });
//                 },
//                 child: Text(
//                   "Forward to",
//                   style: theme.textTheme.bodyText1
//                       ?.copyWith(color: Colors.white),
//                 ),
//                 style: ButtonStyle(
//                     backgroundColor:
//                         MaterialStateProperty.all<Color>(theme.primaryColor)),
//               ),
//                ],
//              );
// }

// Row statusUpdateBtn(ThemeData theme, BuildContext context) {
  //   return Row(
  //              mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //              children: [
  //                     TextButton(
  //               onPressed: () {
  //                 setState((){
  //                     if( context.read<EnquiryUserContoller>().statusUpdate == false){
  //                      context.read<EnquiryUserContoller>().statusUpdate = true;
  //                     }else {
  //                      context.read<EnquiryUserContoller>().statusUpdate = false;
  //                     }
  //                 });
  //               },
  //               child: Text(
  //                 "Back",
  //                 style: theme.textTheme.bodyText1
  //                     ?.copyWith(color: Colors.white),
  //               ),
  //               style: ButtonStyle(
  //                   backgroundColor:
  //                       MaterialStateProperty.all<Color>(theme.primaryColor)),
  //             ),

  //                    TextButton(
  //               onPressed:

  //                () {
  //               if(context.read<EnquiryUserContoller>(). valueChosedReason!=null
  //              // context.read<EnquiryUserContoller>().mycontroller[0].text.isNotEmpty
  //               ){
  //                        context.read<EnquiryUserContoller>().callUpdateEnqApi(context,widget.indx.toString());
  //                  }else{

  //                  }
  //               },
  //               child: Text(
  //                 "Update",
  //                 style: theme.textTheme.bodyText1
  //                     ?.copyWith(color: Colors.white),
  //               ),
  //               style: ButtonStyle(
  //                   backgroundColor:
  //                       MaterialStateProperty.all<Color>(theme.primaryColor)),
  //             )
  //              ],
  //            );
  // }
 //  Stack(children: [
                //     SizedBox(
                //       child: TextFormField(
                //         onTap: (){
                //           context.read<EnquiryUserContoller>().showDate(context);
                //         },
                //         validator: (value) {
                //           if (value!.isEmpty) {
                //             return "Enter FollowUP Date";
                //           }
                //           return null;
                //         },
                //         readOnly: true,
                //         controller:context.read<EnquiryUserContoller>(). mycontroller[0],
                //         decoration: InputDecoration(
                //           contentPadding: EdgeInsets.symmetric(
                //               vertical: 10, horizontal: 10),
                //           labelText: "Next follow up Date",
                //           labelStyle: theme.textTheme.bodyText2,
                //           // border: OutlineInputBorder(
                //           //   borderRadius: BorderRadius.circular(20),
                //           //   borderSide: BorderSide(color: Colors.green),
                //           // ),
                //           enabledBorder: OutlineInputBorder(
                //             borderSide:
                //                 BorderSide(color:theme.primaryColor),
                //             borderRadius: BorderRadius.circular(8),
                //           ),
                //           focusedBorder: OutlineInputBorder(
                //             borderSide: BorderSide(
                //                 color: theme.primaryColor, width: 2.0),
                //             borderRadius: BorderRadius.circular(8),
                //           ),
                //           suffixIcon: Icon(Icons.calendar_today,color: Colors.black,)
                //         ),
                //         cursorColor:theme.primaryColor,

                //       ),
                //     ),
                //     // Positioned(
                //     //     top: 10,
                //     //     left: Screens.width(context)*0.8,
                //     //     child: InkWell(
                //     //         onTap: () {
                //     //           context.read<EnquiryUserContoller>().showDate(context);
                //     //         },
                //     //         child: Icon(Icons.calendar_today,color: Colors.black,)))
                //   ]),

                   //    Container(
                //   width: Screens.width(context),
                //   padding: EdgeInsets.only(top: 1, left: 10, right: 10),
                //   decoration: BoxDecoration(
                //       border: Border.all(color: theme.primaryColor),
                //       borderRadius: BorderRadius.circular(8)),
                //   child: DropdownButton(
                //     hint: Text("Select Reason: ",
                //     style: theme.textTheme.bodyText2,
                //     ),
                //     value: context.read<EnquiryUserContoller>(). valueChosedReason,
                //     //dropdownColor:Colors.green,
                //     icon: Icon(Icons.arrow_drop_down),
                //     iconSize: 30,
                //     style: TextStyle(color: Colors.black, fontSize: 16),
                //     isExpanded: true,
                //     onChanged: (val) {
                //       // setState(() {
                //       //   valueChosedReason = val.toString();
                //       //   print(val.toString());
                //       //   print("valavalaa: .........." +
                //       //       valueChosedReason.toString());
                //       // });
                //        context.read<EnquiryUserContoller>().resonChoosed(val.toString());
                //     },
                //     items:context.read<EnquiryUserContoller>().resonData .map((e) {
                //       return DropdownMenuItem(
                //           value: "${e.CODE}",
                //           child: Text(e.CODE.toString()));
                //     }).toList(),
                //   ),
                // ),