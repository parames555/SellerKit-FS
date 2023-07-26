// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_new, sort_child_properties_last, unnecessary_string_interpolations, duplicate_import, unused_import, unnecessary_import

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
                            TextFormField(
                                onTap: () {
                                  context
                                      .read<SiteOutController>()
                                      .showNextVisitOn(context);
                                },
                                controller: context
                                    .read<SiteOutController>()
                                    .mycontroller[13],
                                // validator: (value) {
                                //   if (value!.isEmpty) {
                                //     return "Choose Next Visit Date";
                                //   }
                                //   return null;
                                // },
                                readOnly: true,
                                decoration: InputDecoration(
                                    labelText: 'Next Visit On', //
                                    border: UnderlineInputBorder(),
                                    labelStyle: theme.textTheme.bodyText1!
                                        .copyWith(color: Colors.grey),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                      //  when the TextFormField in unfocused
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                      //  when the TextFormField in focused
                                    ),
                                    errorBorder: UnderlineInputBorder(),
                                    focusedErrorBorder: UnderlineInputBorder(),
                                    suffixIcon:
                                        Icon(Icons.date_range_outlined))),
                            SizedBox(
                              height: Screens.bodyheight(context) * 0.015,
                            ),
                            TextFormField(
                                onTap: () {
                                  context
                                      .read<SiteOutController>()
                                      .showNextFollowupDate(context);
                                },
                                controller: context
                                    .read<SiteOutController>()
                                    .mycontroller[14],
                                // validator: (value) {
                                //   if (value!.isEmpty) {
                                //     return "Choose Next Followup Date";
                                //   }
                                //   return null;
                                // },
                                readOnly: true,
                                decoration: InputDecoration(
                                    labelText: 'Next Followup Date', //
                                    border: UnderlineInputBorder(),
                                    labelStyle: theme.textTheme.bodyText1!
                                        .copyWith(color: Colors.grey),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                      //  when the TextFormField in unfocused
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                      //  when the TextFormField in focused
                                    ),
                                    errorBorder: UnderlineInputBorder(),
                                    focusedErrorBorder: UnderlineInputBorder(),
                                    suffixIcon:
                                        Icon(Icons.date_range_outlined))),
                            Container(
                              width: Screens.width(context),
                              alignment: Alignment.centerLeft,
                              height: Screens.bodyheight(context) * 0.05,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  RadioListTile(
                                    title: Text('Option 1'),
                                    value: 1,
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
                                  RadioListTile(
                                    title: Text('Option 2'),
                                    value: 2,
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
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      height:
                                          Screens.bodyheight(context) * 0.05,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "  Assign To Me",
                                        style: TextStyle(
                                            color: theme.primaryColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
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
                              height: Screens.bodyheight(context) * 0.015,
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
                                  child: Text("Site Check-Out")),
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
