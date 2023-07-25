// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_new, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Controller/EnquiryController/NewEnqController.dart';
import '../../Constant/Screen.dart';
import '../../Constant/ShowSearchDialog.dart';
import '../../Constant/padings.dart';
import '../../Widgets/Appbar.dart';
import '../../Widgets/Navi3.dart';
import 'EnquiriesUser/Widgets/EnqAssingUser.dart';

class NewEnquiry extends StatefulWidget {
  NewEnquiry({Key? key}) : super(key: key);

  @override
  State<NewEnquiry> createState() => _NewEnquiryState();
}

class _NewEnquiryState extends State<NewEnquiry> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Paddings paddings = Paddings();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<NewEnqController>().getUserAssingData();
      context.read<NewEnqController>().clearAllData();
      context.read<NewEnqController>().customerapicalled = false;
      context.read<NewEnqController>().getEnqType();
      context.read<NewEnqController>().getEnqRefferes();
      context.read<NewEnqController>().getDivisionValue();
      context.read<NewEnqController>().mapValuesFormEnq();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        key: scaffoldKey,
        drawer: drawer3(context),
        appBar: appbar("New Enquiry", theme, context),
        body: (context.read<NewEnqController>().getexceptionOnApiCall.isEmpty &&
                context.watch<NewEnqController>().getcustomerapicLoading ==
                    true)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : (context
                        .read<NewEnqController>()
                        .getexceptionOnApiCall
                        .isNotEmpty &&
                    context.watch<NewEnqController>().getcustomerapicLoading ==
                        false)
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          context
                              .read<NewEnqController>()
                              .getexceptionOnApiCall,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  )
                : Container(
                    padding: paddings.padding2(context),
                    child: Form(
                      key: context.read<NewEnqController>().formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: Screens.width(context),
                            height: Screens.bodyheight(context) * 0.9,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  TextFormField(
                                      controller: context
                                          .read<NewEnqController>()
                                          .mycontroller[0],
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Enter Mobile Number";
                                        } else if (value.length > 10 ||
                                            value.length < 10) {
                                          return "Enter a valid Mobile Number";
                                        }
                                        return null;
                                      },
                                      onChanged: (v) {
                                        if (v.length == 10 &&
                                            context
                                                    .read<NewEnqController>()
                                                    .getcustomerapicalled ==
                                                false) {
                                          // context.read<NewEnqController>().callApi();
                                          context
                                              .read<NewEnqController>()
                                              .callCheckEnqDetailsApi(context
                                                  .read<NewEnqController>()
                                                  .mycontroller[0]
                                                  .text);
                                        }
                                      },
                                      inputFormatters: [
                                        new LengthLimitingTextInputFormatter(
                                            10),
                                      ],
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: 'Mobile',
                                        border: UnderlineInputBorder(),
                                        enabledBorder: UnderlineInputBorder(),
                                        focusedBorder: UnderlineInputBorder(),
                                        errorBorder: UnderlineInputBorder(),
                                        focusedErrorBorder:
                                            UnderlineInputBorder(),
                                      )),
                                  SizedBox(
                                    height: Screens.bodyheight(context) * 0.01,
                                  ),
                                  //tags
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              context
                                                  .read<NewEnqController>()
                                                  .selectCsTag("Corporate");
                                            },
                                            child: Container(
                                              width:
                                                  Screens.width(context) * 0.2,
                                              height:
                                                  Screens.bodyheight(context) *
                                                      0.05,
                                              //  padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  color: context
                                                              .watch<
                                                                  NewEnqController>()
                                                              .getisSelectedCsTag ==
                                                          'Corporate'
                                                      ? theme.primaryColor
                                                      : Colors.white,
                                                  border: Border.all(
                                                      color: theme.primaryColor,
                                                      width: 1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text("Corporate",
                                                      maxLines: 8,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: theme
                                                          .textTheme.bodyText2
                                                          ?.copyWith(
                                                        fontSize: 12,
                                                        color: context
                                                                    .watch<
                                                                        NewEnqController>()
                                                                    .getisSelectedCsTag ==
                                                                "Corporate"
                                                            ? Colors.white
                                                            : theme
                                                                .primaryColor,
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              context
                                                  .read<NewEnqController>()
                                                  .selectCsTag("Doctor");
                                            },
                                            child: Container(
                                              width:
                                                  Screens.width(context) * 0.2,
                                              height:
                                                  Screens.bodyheight(context) *
                                                      0.05,
                                              //  padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  color: context
                                                              .watch<
                                                                  NewEnqController>()
                                                              .getisSelectedCsTag ==
                                                          'Doctor'
                                                      ? theme.primaryColor
                                                      : Colors.white,
                                                  border: Border.all(
                                                      color: theme.primaryColor,
                                                      width: 1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text("Doctor",
                                                      maxLines: 8,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: theme
                                                          .textTheme.bodyText1
                                                          ?.copyWith(
                                                        fontSize: 12,
                                                        color: context
                                                                    .watch<
                                                                        NewEnqController>()
                                                                    .getisSelectedCsTag ==
                                                                "Doctor"
                                                            ? Colors.white
                                                            : theme
                                                                .primaryColor,
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              context
                                                  .read<NewEnqController>()
                                                  .selectCsTag("Govt");
                                            },
                                            child: Container(
                                              width:
                                                  Screens.width(context) * 0.2,
                                              height:
                                                  Screens.bodyheight(context) *
                                                      0.05,
                                              //  padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  color: context
                                                              .watch<
                                                                  NewEnqController>()
                                                              .getisSelectedCsTag ==
                                                          'Govt'
                                                      ? theme.primaryColor
                                                      : Colors.white,
                                                  border: Border.all(
                                                      color: theme.primaryColor,
                                                      width: 1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text("Govt",
                                                      maxLines: 8,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: theme
                                                          .textTheme.bodyText1
                                                          ?.copyWith(
                                                        fontSize: 12,
                                                        color: context
                                                                    .watch<
                                                                        NewEnqController>()
                                                                    .getisSelectedCsTag ==
                                                                "Govt"
                                                            ? Colors.white
                                                            : theme
                                                                .primaryColor,
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ),

                                          //
                                          InkWell(
                                            onTap: () {
                                              context
                                                  .read<NewEnqController>()
                                                  .selectCsTag("Student");
                                            },
                                            child: Container(
                                              width:
                                                  Screens.width(context) * 0.2,
                                              height:
                                                  Screens.bodyheight(context) *
                                                      0.05,
                                              //  padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  color: context
                                                              .watch<
                                                                  NewEnqController>()
                                                              .getisSelectedCsTag ==
                                                          'Student'
                                                      ? theme.primaryColor
                                                      : Colors.white,
                                                  border: Border.all(
                                                      color: theme.primaryColor,
                                                      width: 1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text("Student",
                                                      maxLines: 8,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: theme
                                                          .textTheme.bodyText1
                                                          ?.copyWith(
                                                        fontSize: 12,
                                                        color: context
                                                                    .watch<
                                                                        NewEnqController>()
                                                                    .getisSelectedCsTag ==
                                                                "Student"
                                                            ? Colors.white
                                                            : theme
                                                                .primaryColor,
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            Screens.bodyheight(context) * 0.01,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              context
                                                  .read<NewEnqController>()
                                                  .selectCsTag("Police/Army");
                                            },
                                            child: Container(
                                              width:
                                                  Screens.width(context) * 0.25,
                                              height:
                                                  Screens.bodyheight(context) *
                                                      0.05,
                                              //  padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  color: context
                                                              .watch<
                                                                  NewEnqController>()
                                                              .getisSelectedCsTag ==
                                                          'Police/Army'
                                                      ? theme.primaryColor
                                                      : Colors.white,
                                                  border: Border.all(
                                                      color: theme.primaryColor,
                                                      width: 1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text("Police/Army",
                                                      maxLines: 8,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: theme
                                                          .textTheme.bodyText1
                                                          ?.copyWith(
                                                        fontSize: 12,
                                                        color: context
                                                                    .watch<
                                                                        NewEnqController>()
                                                                    .getisSelectedCsTag ==
                                                                "Police/Army"
                                                            ? Colors.white
                                                            : theme
                                                                .primaryColor,
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              context
                                                  .read<NewEnqController>()
                                                  .selectCsTag("Advocate");
                                            },
                                            child: Container(
                                              width:
                                                  Screens.width(context) * 0.2,
                                              height:
                                                  Screens.bodyheight(context) *
                                                      0.05,
                                              //  padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  color: context
                                                              .watch<
                                                                  NewEnqController>()
                                                              .getisSelectedCsTag ==
                                                          'Advocate'
                                                      ? theme.primaryColor
                                                      : Colors.white,
                                                  border: Border.all(
                                                      color: theme.primaryColor,
                                                      width: 1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text("Advocate",
                                                      maxLines: 8,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: theme
                                                          .textTheme.bodyText1
                                                          ?.copyWith(
                                                        fontSize: 12,
                                                        color: context
                                                                    .watch<
                                                                        NewEnqController>()
                                                                    .getisSelectedCsTag ==
                                                                "Advocate"
                                                            ? Colors.white
                                                            : theme
                                                                .primaryColor,
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ),

                                          ///
                                          InkWell(
                                            onTap: () {
                                              context
                                                  .read<NewEnqController>()
                                                  .selectCsTag("Celebrity");
                                            },
                                            child: Container(
                                              width:
                                                  Screens.width(context) * 0.2,
                                              height:
                                                  Screens.bodyheight(context) *
                                                      0.05,
                                              //  padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  color: context
                                                              .watch<
                                                                  NewEnqController>()
                                                              .getisSelectedCsTag ==
                                                          'Celebrity'
                                                      ? theme.primaryColor
                                                      : Colors.white,
                                                  border: Border.all(
                                                      color: theme.primaryColor,
                                                      width: 1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text("Celebrity",
                                                      maxLines: 8,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: theme
                                                          .textTheme.bodyText1
                                                          ?.copyWith(
                                                        fontSize: 12,
                                                        color: context
                                                                    .watch<
                                                                        NewEnqController>()
                                                                    .getisSelectedCsTag ==
                                                                "Celebrity"
                                                            ? Colors.white
                                                            : theme
                                                                .primaryColor,
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            Screens.bodyheight(context) * 0.01,
                                      ),
                                    ],
                                  ),

                                  ///

                                  TextFormField(
                                      controller: context
                                          .read<NewEnqController>()
                                          .mycontroller[1],
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Enter Name";
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'Name',
                                        border: UnderlineInputBorder(),
                                        enabledBorder: UnderlineInputBorder(),
                                        focusedBorder: UnderlineInputBorder(),
                                        errorBorder: UnderlineInputBorder(),
                                        focusedErrorBorder:
                                            UnderlineInputBorder(),
                                      )),
                                  SizedBox(
                                    height: Screens.bodyheight(context) * 0.01,
                                  ),
                                  TextFormField(
                                      controller: context
                                          .read<NewEnqController>()
                                          .mycontroller[2],
                                      // validator: (value) {
                                      //   if (value!.isEmpty) {
                                      //     return "Enter Address1";
                                      //   }
                                      //   return null;
                                      // },
                                      maxLines: 1,
                                      decoration: InputDecoration(
                                        hintText: 'Address1',
                                        border: UnderlineInputBorder(),
                                        enabledBorder: UnderlineInputBorder(),
                                        focusedBorder: UnderlineInputBorder(),
                                        errorBorder: UnderlineInputBorder(),
                                        focusedErrorBorder:
                                            UnderlineInputBorder(),
                                      )),
                                  SizedBox(
                                    height: Screens.bodyheight(context) * 0.01,
                                  ),
                                  TextFormField(
                                      controller: context
                                          .read<NewEnqController>()
                                          .mycontroller[3],
                                      // validator: (value) {
                                      //   if (value!.isEmpty) {
                                      //     return "Enter Address2";
                                      //   }
                                      //   return null;
                                      // },
                                      maxLines: 1,
                                      decoration: InputDecoration(
                                        hintText: 'Address2',
                                        border: UnderlineInputBorder(),
                                        enabledBorder: UnderlineInputBorder(),
                                        focusedBorder: UnderlineInputBorder(),
                                        errorBorder: UnderlineInputBorder(),
                                        focusedErrorBorder:
                                            UnderlineInputBorder(),
                                      )),
                                  SizedBox(
                                    height: Screens.bodyheight(context) * 0.01,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: Screens.width(context) * 0.4,
                                        child: TextFormField(
                                            controller: context
                                                .read<NewEnqController>()
                                                .mycontroller[4],
                                            // validator: (value) {
                                            //   if (value!.isEmpty) {
                                            //     return "Enter Pincode";
                                            //   }
                                            //   return null;
                                            // },
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              new LengthLimitingTextInputFormatter(
                                                  6),
                                            ],
                                            decoration: InputDecoration(
                                              hintText: 'Pincode',
                                              border: UnderlineInputBorder(),
                                              enabledBorder:
                                                  UnderlineInputBorder(),
                                              focusedBorder:
                                                  UnderlineInputBorder(),
                                              errorBorder:
                                                  UnderlineInputBorder(),
                                              focusedErrorBorder:
                                                  UnderlineInputBorder(),
                                            )),
                                      ),
                                      SizedBox(
                                        width: Screens.width(context) * 0.4,
                                        child: TextFormField(
                                            controller: context
                                                .read<NewEnqController>()
                                                .mycontroller[5],
                                            // validator: (value) {
                                            //   if (value!.isEmpty) {
                                            //     return "Enter City";
                                            //   }
                                            //   return null;
                                            // },
                                            decoration: InputDecoration(
                                              hintText: 'City',
                                              border: UnderlineInputBorder(),
                                              enabledBorder:
                                                  UnderlineInputBorder(),
                                              focusedBorder:
                                                  UnderlineInputBorder(),
                                              errorBorder:
                                                  UnderlineInputBorder(),
                                              focusedErrorBorder:
                                                  UnderlineInputBorder(),
                                            )),
                                      ),
                                    ],
                                  ),
                                  // SizedBox(
                                  //   height: Screens.bodyheight(context) * 0.01,
                                  // ),

                                  //new

                                  TextFormField(
                                      controller: context
                                          .read<NewEnqController>()
                                          .mycontroller[6],
                                      // validator: (value) {
                                      //   if (value!.isEmpty) {
                                      //     return "Enter Email";
                                      //   }
                                      //   return null;
                                      // },
                                      decoration: InputDecoration(
                                        hintText: 'Email',
                                        border: UnderlineInputBorder(),
                                        enabledBorder: UnderlineInputBorder(),
                                        focusedBorder: UnderlineInputBorder(),
                                        errorBorder: UnderlineInputBorder(),
                                        focusedErrorBorder:
                                            UnderlineInputBorder(),
                                      )),

                                  SizedBox(
                                    height: Screens.bodyheight(context) * 0.02,
                                  ),
                                  Column(
                                    children: [
                                      Stack(children: [
                                        SizedBox(
                                          child: TextFormField(
                                            onTap: () {
                                              showDialog<dynamic>(
                                                  context: context,
                                                  builder: (_) {
                                                    return ShowSearchDialog();
                                                  });
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Enter Looking for";
                                              }
                                              return null;
                                            },
                                            // readOnly: true,
                                            controller: context
                                                .read<NewEnqController>()
                                                .mycontroller[7],
                                            readOnly: true,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 10),
                                              labelText: "Looking for:",
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
                                                        return ShowSearchDialog();
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
                                    height: Screens.bodyheight(context) * 0.02,
                                  ),

                                  Column(
                                    children: [
                                      Stack(children: [
                                        SizedBox(
                                          child: TextFormField(
                                            onTap: () {
                                              showDialog<dynamic>(
                                                  context: context,
                                                  builder: (_) {
                                                    return EnqAssignUserDialog();
                                                  });
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Enter Assigned To";
                                              }
                                              return null;
                                            },
                                            // readOnly: true,
                                            controller: context
                                                .read<NewEnqController>()
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
                                                        return EnqAssignUserDialog();
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
                                    height: Screens.bodyheight(context) * 0.02,
                                  ),
                                  Container(
                                    width: Screens.width(context),
                                    height: Screens.bodyheight(context) * 0.3,
                                    decoration: BoxDecoration(
                                        color: theme.primaryColor,
                                        borderRadius: BorderRadius.circular(8)),
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            Screens.width(context) * 0.02,
                                        vertical:
                                            Screens.bodyheight(context) * 0.02),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Refferal",
                                            style: theme.textTheme.bodyText1
                                                ?.copyWith(color: Colors.white),
                                          ),
                                          SizedBox(
                                              height:
                                                  Screens.bodyheight(context) *
                                                      0.02),
                                          Visibility(
                                            visible: context
                                                .read<NewEnqController>()
                                                .getvisibleRefferal,
                                            child: Column(
                                              children: [
                                                Text(
                                                  "Required Enquiry Refferal*",
                                                  style: theme
                                                      .textTheme.bodyText1
                                                      ?.copyWith(
                                                          color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: context
                                                        .read<
                                                            NewEnqController>()
                                                        .getvisibleRefferal ==
                                                    true
                                                ? Screens.bodyheight(context) *
                                                    0.02
                                                : Screens.bodyheight(context) *
                                                    0.04,
                                          ),
                                          Center(
                                            child: Wrap(
                                                spacing: 20.0, // width
                                                runSpacing: 20.0, // height
                                                children:
                                                    listContainersRefferes(
                                                  theme,
                                                )),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Screens.bodyheight(context) * 0.02,
                                  ),

                                  //new
                                  Container(
                                    width: Screens.width(context),
                                    height: Screens.bodyheight(context) * 0.3,
                                    decoration: BoxDecoration(
                                        color: theme.primaryColor,
                                        borderRadius: BorderRadius.circular(8)),
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            Screens.width(context) * 0.02,
                                        vertical:
                                            Screens.bodyheight(context) * 0.02),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Enquiry Type",
                                            style: theme.textTheme.bodyText1
                                                ?.copyWith(color: Colors.white),
                                          ),
                                          SizedBox(
                                              height:
                                                  Screens.bodyheight(context) *
                                                      0.02),
                                          Visibility(
                                            visible: context
                                                .read<NewEnqController>()
                                                .getvisibleEnqType,
                                            child: Column(
                                              children: [
                                                Text(
                                                  "Required Enquiry Type*",
                                                  style: theme
                                                      .textTheme.bodyText1
                                                      ?.copyWith(
                                                          color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: context
                                                        .read<
                                                            NewEnqController>()
                                                        .getvisibleEnqType ==
                                                    true
                                                ? Screens.bodyheight(context) *
                                                    0.02
                                                : Screens.bodyheight(context) *
                                                    0.04,
                                          ),
                                          Center(
                                            child: Wrap(
                                                spacing: 20.0, // width
                                                runSpacing: 20.0, // height
                                                children: listContainersProduct(
                                                  theme,
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Screens.bodyheight(context) * 0.02,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          //
                          SizedBox(
                            width: Screens.width(context),
                            height: Screens.bodyheight(context) * 0.07,
                            child: ElevatedButton(
                                onPressed: context
                                            .watch<NewEnqController>()
                                            .getisloadingBtn ==
                                        true
                                    ? null
                                    : () {
                                        context
                                            .read<NewEnqController>()
                                            .callAddEnq(context);
                                        // context.read<NewEnqController>().callAlertDialog(context, "Successfully Created..!!");
                                      },
                                child: context
                                            .watch<NewEnqController>()
                                            .getisloadingBtn ==
                                        true
                                    ? SizedBox(
                                        width: Screens.width(context) * 0.06,
                                        height:
                                            Screens.bodyheight(context) * 0.04,
                                        child: CircularProgressIndicator(
                                            color: Colors.white))
                                    : Text("Add Enquiry")),
                          )
                        ],
                      ),
                    ),
                  ));
  }

  List<Widget> listContainersProduct(
    ThemeData theme,
  ) {
    return List.generate(
      context.watch<NewEnqController>().getEnqList.length,
      (index) => InkWell(
        onTap: () {
          // context.read<NewEnqController>(). isSelectedenquirytype = context.read<NewEnqController>()
          // .getEnqList[index].Name.toString();
          context.read<NewEnqController>().selectEnqMeida(
              context
                  .read<NewEnqController>()
                  .getEnqList[index]
                  .Name
                  .toString(),
              context.read<NewEnqController>().getEnqList[index].Code!);
        },
        child: Container(
          width: Screens.width(context) * 0.4,
          height: Screens.bodyheight(context) * 0.06,
          //  padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color:
                  context.watch<NewEnqController>().getisSelectedenquirytype ==
                          context
                              .read<NewEnqController>()
                              .getEnqList[index]
                              .Name
                              .toString()
                      ? Color(0xffB299A5) //theme.primaryColor.withOpacity(0.5)
                      : Colors.white,
              border: Border.all(color: theme.primaryColor, width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  context
                      .watch<NewEnqController>()
                      .getEnqList[index]
                      .Name
                      .toString(),
                  maxLines: 8,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyText1?.copyWith(
                    color: context
                                .watch<NewEnqController>()
                                .getisSelectedenquirytype ==
                            context
                                .read<NewEnqController>()
                                .getEnqList[index]
                                .Name
                                .toString()
                        ? theme.primaryColor //,Colors.white
                        : theme.primaryColor,
                  ))
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> listContainersRefferes(
    ThemeData theme,
  ) {
    return List.generate(
      context.watch<NewEnqController>().getenqReffList.length,
      (index) => InkWell(
        onTap: () {
          // context.read<NewEnqController>(). isSelectedenquirytype = context.read<NewEnqController>()
          // .getenqReffList[index].Name.toString();
          context.read<NewEnqController>().selectEnqReffers(
              context
                  .read<NewEnqController>()
                  .getenqReffList[index]
                  .Name
                  .toString(),
              context.read<NewEnqController>().getenqReffList[index].Name!);
        },
        child: Container(
          width: Screens.width(context) * 0.4,
          height: Screens.bodyheight(context) * 0.06,
          //  padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: context
                          .watch<NewEnqController>()
                          .getisSelectedenquiryReffers ==
                      context
                          .read<NewEnqController>()
                          .getenqReffList[index]
                          .Name
                          .toString()
                  ? Color(0xffB299A5) //theme.primaryColor.withOpacity(0.5)
                  : Colors.white,
              border: Border.all(color: theme.primaryColor, width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  context
                      .watch<NewEnqController>()
                      .getenqReffList[index]
                      .Name
                      .toString(),
                  maxLines: 8,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyText1?.copyWith(
                    color: context
                                .watch<NewEnqController>()
                                .getisSelectedenquiryReffers ==
                            context
                                .read<NewEnqController>()
                                .getenqReffList[index]
                                .Name
                                .toString()
                        ? theme.primaryColor //,Colors.white
                        : theme.primaryColor,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
