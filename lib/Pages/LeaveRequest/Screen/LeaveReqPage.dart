// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_new, sort_child_properties_last, unnecessary_string_interpolations, duplicate_import, unused_import, unnecessary_import, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Pages/SiteOut/Widgets/AssignToMeAlertBox.dart';
// import 'package:sellerkit/Controller/EnquiryController/SiteOutController.dart';
import '../../../Constant/ConstantRoutes.dart';
import '../../../Constant/Screen.dart';
import '../../../Constant/ShowSearchDialog.dart';
import '../../../Constant/padings.dart';
import '../../../Controller/CollectionController/NewCollectionEntryCotroller.dart';
import '../../../Controller/SiteOutController/SiteOutController.dart';
import '../../../Controller/SiteOutController/SiteOutController.dart';
import '../../../Controller/VisitplanController/NewVisitController.dart';
import '../../../Widgets/Appbar.dart';
import '../../../Widgets/Navi3.dart';
import '../../VisitPlans/widgets/PurposeShowSearchDialog.dart';

class LeaveReqPage extends StatefulWidget {
  LeaveReqPage({Key? key}) : super(key: key);

  @override
  State<LeaveReqPage> createState() => _LeaveReqPageState();
}

class _LeaveReqPageState extends State<LeaveReqPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Paddings paddings = Paddings();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        context.read<SiteOutController>().init(context);
      });
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
          resizeToAvoidBottomInset: false,
          key: scaffoldKey,
          drawer: drawer3(context),
          appBar: appbar("Leave Request", theme, context),
          body: Container(
            padding: paddings.padding2(context),
            child: Form(
              key: context.read<SiteOutController>().formkey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: Screens.width(context),
                      // height: Screens.bodyheight(context) * 0.9,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // TextFormField(
                            //     controller: context
                            //         .read<SiteOutController>()
                            //         .mycontroller[0],
                            //     validator: (value) {
                            //       if (value!.isEmpty) {
                            //         return "Enter Customer";
                            //       }
                            //       return null;
                            //     },
                            //     onTap: () {

                            //     },
                            //     onChanged: (v) {

                            //     },
                            //     decoration: InputDecoration(
                            //       labelText: 'Customer',
                            //       border: UnderlineInputBorder(),
                            //       labelStyle: theme.textTheme.bodyText1!
                            //           .copyWith(color: Colors.grey),
                            //       enabledBorder: UnderlineInputBorder(
                            //         borderSide: BorderSide(color: Colors.grey),
                            //         //  when the TextFormField in unfocused
                            //       ),
                            //       focusedBorder: UnderlineInputBorder(
                            //         borderSide: BorderSide(color: Colors.grey),
                            //         //  when the TextFormField in focused
                            //       ),
                            //       errorBorder: UnderlineInputBorder(),
                            //       focusedErrorBorder: UnderlineInputBorder(),
                            //     )),

                            // SizedBox(
                            //   height: Screens.bodyheight(context) * 0.005,
                            // ),
                            //tags

                            ///

                            TextFormField(
                                controller: context
                                    .read<SiteOutController>()
                                    .mycontroller[2],
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter Emp Name";
                                  }
                                  return null;
                                },
                                onTap: () {},
                                decoration: InputDecoration(
                                  labelText: 'Emp Name',
                                  border: UnderlineInputBorder(),
                                  labelStyle: theme.textTheme.bodyText1!
                                      .copyWith(color: Colors.grey),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                    //  when the TextFormField in unfocused
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                    //  when the TextFormField in focused
                                  ),
                                  errorBorder: UnderlineInputBorder(),
                                  focusedErrorBorder: UnderlineInputBorder(),
                                )),
                            Container(
                              width: Screens.width(context),
                              child: DropdownButton(
                                hint: Text("Select Mode"),
                                // value: context.read<EnquiryUserContoller>(). valueChosedReason,
                                //dropdownColor:Colors.green,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 30,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                isExpanded: true,
                                value: context
                                    .read<NewCollectionContoller>()
                                    .paymentmode,
                                onChanged: (val) {
                                  // setState(() {
                                  //   valueChosedReason = val.toString();
                                  //   print(val.toString());
                                  //   print("valavalaa: .........." +
                                  //       valueChosedReason.toString());
                                  // });
                                  context
                                      .read<NewCollectionContoller>()
                                      .resonChoosed(val.toString());
                                },
                                items: <String>[
                                  "Cash",
                                  "Cheque",
                                  "Card",
                                  "UPI",
                                  "DD"
                                ].map((String value) {
                                  return DropdownMenuItem(
                                      value: value,
                                      child: Text(value.toString()));
                                }).toList(),
                              ),
                            ),

                            Container(
                              width: Screens.width(context),
                              // alignment: Alignment.centerLeft,
                              height: Screens.bodyheight(context) * 0.07,
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: Screens.bodyheight(context),
                                    width: Screens.width(context) * 0.3,
                                    alignment: Alignment.center,
                                    // color: Colors.amber,
                                    child: RadioListTile(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 0),
                                      title: Text(
                                        'Full Day',
                                        style: theme.textTheme.bodySmall,
                                      ),
                                      value: "Full Day",
                                      groupValue: context
                                          .read<SiteOutController>()
                                          .selectedRadioValue,
                                      onChanged: (value) {
                                        setState(() {
                                          context
                                                  .read<SiteOutController>()
                                                  .selectedRadioValue =
                                              value.toString();
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    height: Screens.bodyheight(context),
                                    width: Screens.width(context) * 0.3,
                                    // color: Colors.amber,
                                    child: RadioListTile(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 0),
                                      title: Text(
                                        'Half Day',
                                        style: theme.textTheme.bodySmall,
                                      ),
                                      value: "Half Day",
                                      groupValue: context
                                          .read<SiteOutController>()
                                          .selectedRadioValue,
                                      onChanged: (value) {
                                        setState(() {
                                          context
                                                  .read<SiteOutController>()
                                                  .selectedRadioValue =
                                              value.toString();
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    height: Screens.bodyheight(context),
                                    width: Screens.width(context) * 0.34,
                                    // color: Colors.amber,
                                    child: RadioListTile(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 0),
                                      title: Text(
                                        'Permission',
                                        style: theme.textTheme.bodySmall,
                                      ),
                                      value: "Permission",
                                      groupValue: context
                                          .read<SiteOutController>()
                                          .selectedRadioValue,
                                      onChanged: (value) {
                                        setState(() {
                                          context
                                                  .read<SiteOutController>()
                                                  .selectedRadioValue =
                                              value.toString();
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: Screens.bodyheight(context) * 0.015,
                            ),
                            context
                                        .read<SiteOutController>()
                                        .selectedRadioValue ==
                                    "Full Day"
                                ? Container(
                                    width: Screens.width(context),
                                    padding: EdgeInsets.all(
                                        Screens.bodyheight(context) * 0.008),
                                    // height: Screens.bodyheight(context)*0.5,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: theme.primaryColor)),
                                    child: Column(
                                      children: [
                                        // Container(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width:
                                                  Screens.width(context) * 0.4,
                                              child: TextFormField(
                                                  onTap: () {
                                                    context
                                                        .read<
                                                            SiteOutController>()
                                                        .showNextVisitOn(
                                                            context);
                                                  },
                                                  controller: context
                                                      .read<SiteOutController>()
                                                      .mycontroller[13],
                                                  validator: context
                                                              .read<
                                                                  SiteOutController>()
                                                              .selectedRadioValue !=
                                                          "Full Day"
                                                      ? null
                                                      : (value) {
                                                          if (value!.isEmpty) {
                                                            return "Choose Start Date";
                                                          }
                                                          return null;
                                                        },
                                                  readOnly: true,
                                                  decoration: InputDecoration(
                                                      labelText:
                                                          'Start Date', //
                                                      border:
                                                          UnderlineInputBorder(),
                                                      labelStyle: theme
                                                          .textTheme.bodyText1!
                                                          .copyWith(
                                                              color:
                                                                  Colors.grey),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.grey),
                                                        //  when the TextFormField in unfocused
                                                      ),
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.grey),
                                                        //  when the TextFormField in focused
                                                      ),
                                                      errorBorder:
                                                          UnderlineInputBorder(),
                                                      // contentPadding: EdgeInsets.symmetric(horizontal: 5),
                                                      focusedErrorBorder:
                                                          UnderlineInputBorder(),
                                                      suffixIcon: Icon(Icons
                                                          .date_range_outlined))),
                                            ),
                                            Container(
                                              width:
                                                  Screens.width(context) * 0.4,
                                              child: TextFormField(
                                                  onTap: () {
                                                    context
                                                        .read<
                                                            SiteOutController>()
                                                        .showNextVisitOn(
                                                            context);
                                                  },
                                                  controller: context
                                                      .read<SiteOutController>()
                                                      .mycontroller[13],
                                                  validator: context
                                                              .read<
                                                                  SiteOutController>()
                                                              .selectedRadioValue !=
                                                          "Full Day"
                                                      ? null
                                                      : (value) {
                                                          if (value!.isEmpty) {
                                                            return "Choose End Date";
                                                          }
                                                          return null;
                                                        },
                                                  readOnly: true,
                                                  decoration: InputDecoration(
                                                      labelText: 'End Date', //
                                                      border:
                                                          UnderlineInputBorder(),
                                                      labelStyle: theme
                                                          .textTheme.bodyText1!
                                                          .copyWith(
                                                              color:
                                                                  Colors.grey),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.grey),
                                                        //  when the TextFormField in unfocused
                                                      ),
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.grey),
                                                        //  when the TextFormField in focused
                                                      ),
                                                      errorBorder:
                                                          UnderlineInputBorder(),
                                                      focusedErrorBorder:
                                                          UnderlineInputBorder(),
                                                      suffixIcon: Icon(Icons
                                                          .date_range_outlined))),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: Screens.bodyheight(context) *
                                              0.02,
                                        ),
                                        Container(
                                          width: Screens.width(context),
                                          child: Text(
                                            "No Of Leave Request Days",
                                            style: theme.textTheme.bodyText1,
                                          ),
                                        ),
                                        SizedBox(
                                          height: Screens.bodyheight(context) *
                                              0.01,
                                        ),
                                      ],
                                    ),
                                  )
                                : context
                                            .read<SiteOutController>()
                                            .selectedRadioValue ==
                                        "Half Day"
                                    ? Container(
                                        width: Screens.width(context),
                                        // alignment: Alignment.center,

                                        padding: EdgeInsets.all(
                                            Screens.bodyheight(context) *
                                                0.005),
                                        // height: Screens.bodyheight(context)*0.5,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                color: theme.primaryColor)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            // Container(),
                                            Container(
                                              height:
                                                  Screens.bodyheight(context) *
                                                      0.08,
                                              // color: Colors.amber,
                                              child: Row(
                                                // crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    height: Screens.bodyheight(
                                                            context) *
                                                        0.09,
                                                    // color: Colors.blue,

                                                    width:
                                                        Screens.width(context) *
                                                            0.4,
                                                    // color: Colors.amber,
                                                    child: RadioListTile(
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      title: Text(
                                                        'First Half',
                                                        style: theme.textTheme
                                                            .bodySmall,
                                                      ),
                                                      value: "First Half",
                                                      groupValue: context
                                                          .read<
                                                              SiteOutController>()
                                                          .selectedRadioValue,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          context
                                                                  .read<
                                                                      SiteOutController>()
                                                                  .selectedRadioValue =
                                                              value.toString();
                                                        });
                                                      },
                                                    ),
                                                    alignment: Alignment.center,
                                                  ),
                                                  Container(
                                                    // color: Colors.blue,

                                                    alignment: Alignment.center,
                                                    height: Screens.bodyheight(
                                                            context) *
                                                        0.09,
                                                    width:
                                                        Screens.width(context) *
                                                            0.4,
                                                    // color: Colors.amber,
                                                    child: RadioListTile(
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      title: Text(
                                                        'Second Half',
                                                        style: theme.textTheme
                                                            .bodySmall,
                                                      ),
                                                      value: "Second Half",
                                                      groupValue: context
                                                          .read<
                                                              SiteOutController>()
                                                          .selectedRadioValue,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          context
                                                                  .read<
                                                                      SiteOutController>()
                                                                  .selectedRadioValue =
                                                              value.toString();
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // SizedBox(
                                            //   height: Screens.bodyheight(context) *
                                            //       0.02,
                                            // ),
                                            // Container(
                                            //   width: Screens.width(context),
                                            //   child: Text(
                                            //     "No Of Leave Request Days",
                                            //     style: theme.textTheme.bodyText1,
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      )
                                    : Container(
                                        width: Screens.width(context),
                                        // alignment: Alignment.center,

                                        padding: EdgeInsets.all(
                                            Screens.bodyheight(context) * 0.01),
                                        // height: Screens.bodyheight(context)*0.5,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                color: theme.primaryColor)),

                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width:
                                                      Screens.width(context) *
                                                          0.37,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: TextFormField(
                                                    controller: context
                                                        .read<
                                                            NewVisitplanController>()
                                                        .mycontroller[11],

                                                    onTap: () {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                NewVisitplanController>()
                                                            .clearbool();
                                                        context
                                                            .read<
                                                                NewVisitplanController>()
                                                            .selectTime(
                                                                context);
                                                      });
                                                    },
                                                    // autofocus: true,
                                                    readOnly: true,
                                                    style: theme
                                                        .textTheme.bodyText2
                                                        ?.copyWith(
                                                            backgroundColor:
                                                                Colors.white),
                                                    onChanged: (v) {},
                                                    validator: (value) {},
                                                    decoration: InputDecoration(
                                                      labelText:
                                                          'Start Time', //
                                                      border:
                                                          UnderlineInputBorder(),
                                                      labelStyle: theme
                                                          .textTheme.bodyText1!
                                                          .copyWith(
                                                              color:
                                                                  Colors.grey),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.grey),
                                                        //  when the TextFormField in unfocused
                                                      ),
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.grey),
                                                        //  when the TextFormField in focused
                                                      ),
                                                      errorBorder:
                                                          UnderlineInputBorder(),
                                                      focusedErrorBorder:
                                                          UnderlineInputBorder(),
                                                      suffixIcon: IconButton(
                                                          padding: EdgeInsets.only(
                                                              top: Screens.bodyheight(
                                                                      context) *
                                                                  0.002),
                                                          onPressed: () {
                                                            setState(() {
                                                              context
                                                                  .read<
                                                                      NewVisitplanController>()
                                                                  .selectTime(
                                                                      context);
                                                            });
                                                          },
                                                          icon: Icon(
                                                            Icons.timer,
                                                            color: theme
                                                                .primaryColor,
                                                          )),
                                                      // filled: true,
                                                      contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                        vertical: 11,
                                                        horizontal: 5,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width:
                                                      Screens.width(context) *
                                                          0.37,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: TextFormField(
                                                    controller: context
                                                        .read<
                                                            NewVisitplanController>()
                                                        .mycontroller[11],

                                                    onTap: () {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                NewVisitplanController>()
                                                            .clearbool();
                                                        context
                                                            .read<
                                                                NewVisitplanController>()
                                                            .selectTime(
                                                                context);
                                                      });
                                                    },
                                                    // autofocus: true,
                                                    readOnly: true,
                                                    style: theme
                                                        .textTheme.bodyText2
                                                        ?.copyWith(
                                                            backgroundColor:
                                                                Colors.white),
                                                    onChanged: (v) {},
                                                    validator: (value) {},
                                                    decoration: InputDecoration(
                                                      labelText: 'End Time', //
                                                      border:
                                                          UnderlineInputBorder(),
                                                      labelStyle: theme
                                                          .textTheme.bodyText1!
                                                          .copyWith(
                                                              color:
                                                                  Colors.grey),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.grey),
                                                        //  when the TextFormField in unfocused
                                                      ),
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.grey),
                                                        //  when the TextFormField in focused
                                                      ),
                                                      errorBorder:
                                                          UnderlineInputBorder(),
                                                      focusedErrorBorder:
                                                          UnderlineInputBorder(),
                                                      suffixIcon: IconButton(
                                                          padding: EdgeInsets.only(
                                                              top: Screens.bodyheight(
                                                                      context) *
                                                                  0.002),
                                                          onPressed: () {
                                                            setState(() {
                                                              context
                                                                  .read<
                                                                      NewVisitplanController>()
                                                                  .selectTime(
                                                                      context);
                                                            });
                                                          },
                                                          icon: Icon(
                                                            Icons.timer,
                                                            color: theme
                                                                .primaryColor,
                                                          )),
                                                      // filled: true,
                                                      contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                        vertical: 11,
                                                        horizontal: 5,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height:
                                                  Screens.bodyheight(context) *
                                                      0.005,
                                            )
                                          ],
                                        ),
                                      ),
                            context.read<SiteOutController>().assignTo == false
                                ? SizedBox()
                                : SizedBox(
                                    height: Screens.bodyheight(context) * 0.015,
                                  ),
                            context.read<SiteOutController>().assignTo == false
                                ? Container()
                                : Column(
                                    children: [
                                      Stack(children: [
                                        SizedBox(
                                          child: TextFormField(
                                            onTap: () {
                                              showDialog<dynamic>(
                                                  context: context,
                                                  builder: (_) {
                                                    return AssignToMeDialog();
                                                  });
                                            },
                                            // validator: (value) {
                                            //   if (value!.isEmpty) {
                                            //     return "Enter Assigned To";
                                            //   }
                                            //   return null;
                                            // },
                                            // readOnly: true,
                                            controller: context
                                                .read<SiteOutController>()
                                                .mycontroller[8],
                                            readOnly: true,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 10),
                                              labelText: "Assigned To:",
                                              labelStyle: TextStyle(
                                                  color: theme.primaryColor,
                                                  fontWeight: FontWeight.bold),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                borderSide: BorderSide(
                                                    color: theme.primaryColor),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                borderSide: BorderSide(
                                                    color: theme.primaryColor),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                borderSide: BorderSide(
                                                    color: theme.primaryColor),
                                              ),
                                            ),
                                            // cursorColor: Colors.green,
                                          ),
                                        ),
                                        Positioned(
                                            top: 0,
                                            left: Screens.width(context) * 0.74,
                                            child: InkWell(
                                                onTap: () {
                                                  showDialog<dynamic>(
                                                      context: context,
                                                      builder: (_) {
                                                        return AssignToMeDialog();
                                                      });
                                                },
                                                child: Container(
                                                    width:
                                                        Screens.width(context) *
                                                            0.2,
                                                    height: Screens.bodyheight(
                                                            context) *
                                                        0.079,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            theme.primaryColor,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  8),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  8),
                                                        )),
                                                    child: Icon(Icons.search))))
                                      ]),
                                    ],
                                  ),
                            SizedBox(
                              height: Screens.bodyheight(context) * 0.01,
                            ),
                            Container(
                              height: Screens.bodyheight(context) * 0.05,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                " Visits Outcomes",
                                style: TextStyle(
                                    color: theme.primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            TextFormField(
                              minLines: 6,
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter Looking for";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                  top: Screens.bodyheight(context) * 0.04,
                                  left: Screens.bodyheight(context) * 0.01,
                                ),
                                alignLabelWithHint: true,
                                // border: OutlineInputBorder(),
                                hintText: '',
                              ),
                            ),
                            SizedBox(
                              // width: Screens.width(context),
                              height: Screens.bodyheight(context) * 0.01,
                            ),
                            SizedBox(
                              width: Screens.width(context),
                              height: Screens.bodyheight(context) * 0.07,
                              child: ElevatedButton(
                                  onPressed: () {
                                    // controller:
                                    context
                                        .read<SiteOutController>()
                                        .validateCheckOut(context);
                                    // // context
                                    //     .read<SiteOutController>()
                                    //     .callAddEnq(context);
                                    // context.read<SiteOutController>().callAlertDialog(context, "Successfully Created..!!");
                                  },
                                  child: Text("Create Leave Request")),
                            )
                          ],
                        ),
                      ),
                    ),
                    //
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
