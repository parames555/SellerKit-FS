// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_new, sort_child_properties_last, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
// import 'package:sellerkit/Controller/EnquiryController/NewEnqController.dart';
import '../../../Constant/Screen.dart';
import '../../../Constant/padings.dart';
import '../../../Controller/VisitplanController/NewVisitController.dart';
import '../../../Widgets/Appbar.dart';
import '../../../Widgets/Navi3.dart';
import '../widgets/PurposeShowSearchDialog.dart';

class NewVisitPlan extends StatefulWidget {
  NewVisitPlan({Key? key}) : super(key: key);

  @override
  State<NewVisitPlan> createState() => _NewVisitPlanState();
}

class _NewVisitPlanState extends State<NewVisitPlan> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Paddings paddings = Paddings();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        context.read<NewVisitplanController>().init();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        key: scaffoldKey,
        drawer: drawer3(context),
        appBar: appbar("Schedule Visit", theme, context),
        body: Container(
          padding: paddings.padding2(context),
          child: Form(
            key: context.read<NewVisitplanController>().formkey,
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
                                .read<NewVisitplanController>()
                                .mycontroller[0],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Customer";
                              }
                              return null;
                            },
                            onTap: () {
                              setState(() {
                                context
                                    .read<NewVisitplanController>()
                                    .clearbool();
                              });
                            },
                            onChanged: (v) {
                              setState(() {
                                context
                                    .read<NewVisitplanController>()
                                    .filterListcustomer(v);
                                // if (context
                                //     .read<NewVisitplanController>()
                                //     .filterexistCusDataList
                                //     .isEmpty) {
                                //   context
                                //       .read<NewVisitplanController>()
                                //       .customerbool = false;
                                // } else {
                                //   context
                                //       .read<NewVisitplanController>()
                                //       .customerbool = true;
                                // }
                                if (v.isEmpty) {
                                  context
                                      .read<NewVisitplanController>()
                                      .customerbool = false;
                                } else {
                                  context
                                      .read<NewVisitplanController>()
                                      .customerbool = true;
                                }
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'Customer',
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
                        Visibility(
                          visible: context
                              .read<NewVisitplanController>()
                              .customerbool,
                          child: Column(
                            children: [
                              SizedBox(
                                height: Screens.bodyheight(context) * 0.01,
                              ),
                             context
                                          .read<NewVisitplanController>()
                                          .filterexistCusDataList
                                          .isEmpty
                                      ? Container()
                                      : Container(

                                  // color: Colors.amber,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: theme.primaryColor)),
                                  width: Screens.width(context),
                                  height: Screens.bodyheight(context) * 0.2,
                                  child:  ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          itemCount: context
                                              .read<NewVisitplanController>()
                                              .filterexistCusDataList
                                              .length,
                                          itemBuilder:
                                              (BuildContext context, int i) {
                                            return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  context
                                                      .read<
                                                          NewVisitplanController>()
                                                      .customerbool = false;
                                                  context
                                                      .read<
                                                          NewVisitplanController>()
                                                      .getExiCustomerData(context
                                                          .read<
                                                              NewVisitplanController>()
                                                          .filterexistCusDataList[
                                                              i]
                                                          .Customer
                                                          .toString());
                                                  context
                                                          .read<
                                                              NewVisitplanController>()
                                                          .mycontroller[0]
                                                          .text =
                                                      context
                                                          .read<
                                                              NewVisitplanController>()
                                                          .filterexistCusDataList[
                                                              i]
                                                          .Customer
                                                          .toString();
                                                });
                                              },
                                              child: Column(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.all(
                                                        Screens.bodyheight(
                                                                context) *
                                                            0.008),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    // color: Colors.red,
                                                    height: Screens.bodyheight(
                                                            context) *
                                                        0.05,
                                                    width:
                                                        Screens.width(context),
                                                    child: Text(
                                                      "${context.watch<NewVisitplanController>().filterexistCusDataList[i].Customer}",
                                                      style: theme
                                                          .textTheme.bodyText1
                                                          ?.copyWith(
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                  ),
                                                  Divider()
                                                ],
                                              ),
                                            );
                                          })),
                            ],
                          ),
                        ),

                        // SizedBox(
                        //   height: Screens.bodyheight(context) * 0.005,
                        // ),
                        TextFormField(
                            controller: context
                                .read<NewVisitplanController>()
                                .mycontroller[1],
                            onTap: () {
                              setState(() {
                                context
                                    .read<NewVisitplanController>()
                                    .clearbool();
                              });
                            },
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
                              // if (v.length == 10 &&
                              //     context
                              //             .read<NewEnqController>()
                              //             .getcustomerapicalled ==
                              //         false) {
                              //   // context.read<NewEnqController>().callApi();
                              //   context
                              //       .read<NewEnqController>()
                              //       .callCheckEnqDetailsApi(context
                              //           .read<NewEnqController>()
                              //           .mycontroller[0]
                              //           .text);
                              // }
                            },
                            inputFormatters: [
                              new LengthLimitingTextInputFormatter(10),
                            ],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Mobile No',
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
                        // SizedBox(
                        //   height: Screens.bodyheight(context) * 0.005,
                        // ),
                        //tags

                        ///

                        TextFormField(
                            controller: context
                                .read<NewVisitplanController>()
                                .mycontroller[2],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Contact Name";
                              }
                              return null;
                            },
                            onTap: () {
                              setState(() {
                                context
                                    .read<NewVisitplanController>()
                                    .clearbool();
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'Contact Name',
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
                        // SizedBox(
                        //   height: Screens.bodyheight(context) * 0.005,
                        // ),
                        TextFormField(
                            controller: context
                                .read<NewVisitplanController>()
                                .mycontroller[3],
                            onTap: () {
                              setState(() {
                                context
                                    .read<NewVisitplanController>()
                                    .clearbool();
                              });
                            },
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return "Enter Address1";
                            //   }
                            //   return null;
                            // },
                            maxLines: 1,
                            decoration: InputDecoration(
                              labelText: 'Address1',
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
                        // SizedBox(
                        //   height: Screens.bodyheight(context) * 0.005,
                        // ),
                        TextFormField(
                            controller: context
                                .read<NewVisitplanController>()
                                .mycontroller[4],
                            onTap: () {
                              setState(() {
                                context
                                    .read<NewVisitplanController>()
                                    .clearbool();
                              });
                            },
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return "Enter Address2";
                            //   }
                            //   return null;
                            // },
                            maxLines: 1,
                            decoration: InputDecoration(
                              labelText: 'Address2',
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
                        // SizedBox(
                        //   height: Screens.bodyheight(context) * 0.005,
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Screens.width(context) * 0.4,
                              child: TextFormField(
                                  controller: context
                                      .read<NewVisitplanController>()
                                      .mycontroller[5],
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter Area";
                                    }
                                    return null;
                                  },
                                  onTap: () {
                                    setState(() {
                                      context
                                          .read<NewVisitplanController>()
                                          .clearbool();
                                    });
                                  },
                                  onChanged: (v) {
                                    setState(() {
                                      context
                                          .read<NewVisitplanController>()
                                          .filterListArea(v);
                                      if (v.isEmpty) {
                                        context
                                            .read<NewVisitplanController>()
                                            .areabool = false;
                                      } else {
                                        context
                                            .read<NewVisitplanController>()
                                            .areabool = true;
                                      }
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Area',
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
                                  )),
                            ),
                            SizedBox(
                              width: Screens.width(context) * 0.4,
                              child: TextFormField(
                                  controller: context
                                      .read<NewVisitplanController>()
                                      .mycontroller[6],
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter City";
                                    }
                                    return null;
                                  },
                                  onTap: () {
                                    setState(() {
                                      context
                                          .read<NewVisitplanController>()
                                          .clearbool();
                                    });
                                  },
                                  onChanged: (v) {
                                    setState(() {
                                      context
                                          .read<NewVisitplanController>()
                                          .filterListCity(v);
                                      if (v.isEmpty) {
                                        context
                                            .read<NewVisitplanController>()
                                            .citybool = false;
                                      } else {
                                        context
                                            .read<NewVisitplanController>()
                                            .citybool = true;
                                      }
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'City',
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
                                  )),
                            ),
                          ],
                        ),
                        Visibility(
                          visible:
                              context.read<NewVisitplanController>().areabool,
                          child: Column(
                            children: [
                              SizedBox(
                                height: Screens.bodyheight(context) * 0.01,
                              ),
                             context
                                          .read<NewVisitplanController>()
                                          .filterexistCusDataList
                                          .isEmpty
                                      ? Container()
                                      :  Container(

                                  // color: Colors.amber,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: theme.primaryColor)),
                                  width: Screens.width(context),
                                  height: Screens.bodyheight(context) * 0.2,
                                  child: ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          itemCount: context
                                              .read<NewVisitplanController>()
                                              .filterexistCusDataList
                                              .length,
                                          itemBuilder:
                                              (BuildContext context, int i) {
                                            return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  // context
                                                  //     .read<
                                                  //         NewVisitplanController>()
                                                  //     .getExiAreaData(context
                                                  //         .read<
                                                  //             NewVisitplanController>()
                                                  //         .filterexistCusDataList[
                                                  //             i]
                                                  //         .U_Area
                                                  //         .toString());
                                                  context
                                                      .read<
                                                          NewVisitplanController>()
                                                      .areabool = false;
                                                  context
                                                          .read<
                                                              NewVisitplanController>()
                                                          .mycontroller[5]
                                                          .text =
                                                      context
                                                          .read<
                                                              NewVisitplanController>()
                                                          .filterexistCusDataList[
                                                              i]
                                                          .U_Area
                                                          .toString();
                                                });
                                              },
                                              child: Column(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.all(
                                                        Screens.bodyheight(
                                                                context) *
                                                            0.008),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    // color: Colors.red,
                                                    height: Screens.bodyheight(
                                                            context) *
                                                        0.05,
                                                    width:
                                                        Screens.width(context),
                                                    child: Text(
                                                      "${context.watch<NewVisitplanController>().filterexistCusDataList[i].U_Area}",
                                                      style: theme
                                                          .textTheme.bodyText1
                                                          ?.copyWith(
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                  ),
                                                  Divider()
                                                ],
                                              ),
                                            );
                                          })),
                            ],
                          ),
                        ),
                        Visibility(
                          visible:
                              context.read<NewVisitplanController>().citybool,
                          child: Column(
                            children: [
                              SizedBox(
                                height: Screens.bodyheight(context) * 0.01,
                              ),
                              context
                                          .read<NewVisitplanController>()
                                          .filterexistCusDataList
                                          .isEmpty
                                      ? Container()
                                      : Container(

                                  // color: Colors.amber,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: theme.primaryColor)),
                                  width: Screens.width(context),
                                  height: Screens.bodyheight(context) * 0.2,
                                  child:  ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          itemCount: context
                                              .read<NewVisitplanController>()
                                              .filterexistCusDataList
                                              .length,
                                          itemBuilder:
                                              (BuildContext context, int i) {
                                            return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  // context
                                                  //     .read<
                                                  //         NewVisitplanController>()
                                                  //     .getExicityData(context
                                                  //         .read<
                                                  //             NewVisitplanController>()
                                                  //         .filterexistCusDataList[
                                                  //             i]
                                                  //         .U_City
                                                  //         .toString());
                                                  context
                                                      .read<
                                                          NewVisitplanController>()
                                                      .citybool = false;
                                                  context
                                                          .read<
                                                              NewVisitplanController>()
                                                          .mycontroller[6]
                                                          .text =
                                                      context
                                                          .read<
                                                              NewVisitplanController>()
                                                          .filterexistCusDataList[
                                                              i]
                                                          .U_City
                                                          .toString();
                                                });
                                              },
                                              child: Column(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.all(
                                                        Screens.bodyheight(
                                                                context) *
                                                            0.008),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    // color: Colors.red,
                                                    height: Screens.bodyheight(
                                                            context) *
                                                        0.05,
                                                    width:
                                                        Screens.width(context),
                                                    child: Text(
                                                      "${context.watch<NewVisitplanController>().filterexistCusDataList[i].U_City}",
                                                      style: theme
                                                          .textTheme.bodyText1
                                                          ?.copyWith(
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                  ),
                                                  Divider()
                                                ],
                                              ),
                                            );
                                          })),
                            ],
                          ),
                        ),
                        // SizedBox(
                        //   height: Screens.bodyheight(context) * 0.005,
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Screens.width(context) * 0.4,
                              child: TextFormField(
                                  controller: context
                                      .read<NewVisitplanController>()
                                      .mycontroller[7],
                                  onTap: () {
                                    setState(() {
                                      context
                                          .read<NewVisitplanController>()
                                          .clearbool();
                                    });
                                  },
                                  // validator: (value) {
                                  //   if (value!.isEmpty) {
                                  //     return "Enter Pincode";
                                  //   }
                                  //   return null;
                                  // },
                                  onChanged: (v) {
                                    setState(() {
                                      context
                                          .read<NewVisitplanController>()
                                          .filterListPincode(v);
                                      if (v.isEmpty) {
                                        context
                                            .read<NewVisitplanController>()
                                            .pincodebool = false;
                                      } else {
                                        context
                                            .read<NewVisitplanController>()
                                            .pincodebool = true;
                                      }
                                    });
                                  },
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    new LengthLimitingTextInputFormatter(6),
                                  ],
                                  decoration: InputDecoration(
                                    labelText: 'Pincode',
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
                                  )),
                            ),
                            SizedBox(
                              width: Screens.width(context) * 0.4,
                              child: TextFormField(
                                  controller: context
                                      .read<NewVisitplanController>()
                                      .mycontroller[8],
                                  onTap: () {
                                    setState(() {
                                      context
                                          .read<NewVisitplanController>()
                                          .clearbool();
                                    });
                                  },
                                  // validator: (value) {
                                  //   if (value!.isEmpty) {
                                  //     return "Enter State";
                                  //   }
                                  //   return null;
                                  // },
                                  onChanged: (v) {
                                    setState(() {
                                      context
                                          .read<NewVisitplanController>()
                                          .filterListState(v);
                                      if (v.isEmpty) {
                                        context
                                            .read<NewVisitplanController>()
                                            .statebool = false;
                                      } else {
                                        context
                                            .read<NewVisitplanController>()
                                            .statebool = true;
                                      }
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'State',
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
                                  )),
                            ),
                          ],
                        ),
                        Visibility(
                          visible: context
                              .read<NewVisitplanController>()
                              .pincodebool,
                          child: Column(
                            children: [
                              SizedBox(
                                height: Screens.bodyheight(context) * 0.01,
                              ),
                              context
                                          .read<NewVisitplanController>()
                                          .filterexistCusDataList
                                          .isEmpty
                                      ? Container()
                                      :  Container(

                                  // color: Colors.amber,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: theme.primaryColor)),
                                  width: Screens.width(context),
                                  height: Screens.bodyheight(context) * 0.2,
                                  child:ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          itemCount: context
                                              .read<NewVisitplanController>()
                                              .filterexistCusDataList
                                              .length,
                                          itemBuilder:
                                              (BuildContext context, int i) {
                                            return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  context
                                                      .read<
                                                          NewVisitplanController>()
                                                      .pincodebool = false;
                                                  // context
                                                  //     .read<
                                                  //         NewVisitplanController>()
                                                  //     .getExipincodeData(context
                                                  //         .read<
                                                  //             NewVisitplanController>()
                                                  //         .filterexistCusDataList[
                                                  //             i]
                                                  //         .U_Pincode
                                                  //         .toString());
                                                  context
                                                          .read<
                                                              NewVisitplanController>()
                                                          .mycontroller[7]
                                                          .text =
                                                      context
                                                          .read<
                                                              NewVisitplanController>()
                                                          .filterexistCusDataList[
                                                              i]
                                                          .U_Pincode
                                                          .toString();
                                                });
                                              },
                                              child: Column(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.all(
                                                        Screens.bodyheight(
                                                                context) *
                                                            0.008),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    // color: Colors.red,
                                                    height: Screens.bodyheight(
                                                            context) *
                                                        0.05,
                                                    width:
                                                        Screens.width(context),
                                                    child: Text(
                                                      "${context.watch<NewVisitplanController>().filterexistCusDataList[i].U_Pincode}",
                                                      style: theme
                                                          .textTheme.bodyText1
                                                          ?.copyWith(
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                  ),
                                                  Divider()
                                                ],
                                              ),
                                            );
                                          })),
                            ],
                          ),
                        ),
                        Visibility(
                          visible:
                              context.read<NewVisitplanController>().statebool,
                          child: Column(
                            children: [
                              SizedBox(
                                height: Screens.bodyheight(context) * 0.01,
                              ),
                             context
                                          .read<NewVisitplanController>()
                                          .filterexistCusDataList
                                          .isEmpty
                                      ? Container()
                                      :   Container(

                                  // color: Colors.amber,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: theme.primaryColor)),
                                  width: Screens.width(context),
                                  height: Screens.bodyheight(context) * 0.2,
                                  child: ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          itemCount: context
                                              .read<NewVisitplanController>()
                                              .filterexistCusDataList
                                              .length,
                                          itemBuilder:
                                              (BuildContext context, int i) {
                                            return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  // context
                                                  //     .read<
                                                  //         NewVisitplanController>()
                                                  //     .getExistateData(context
                                                  //         .read<
                                                  //             NewVisitplanController>()
                                                  //         .filterexistCusDataList[
                                                  //             i]
                                                  //         .U_State
                                                  //         .toString());
                                                  context
                                                      .read<
                                                          NewVisitplanController>()
                                                      .statebool = false;
                                                  context
                                                          .read<
                                                              NewVisitplanController>()
                                                          .mycontroller[8]
                                                          .text =
                                                      context
                                                          .read<
                                                              NewVisitplanController>()
                                                          .filterexistCusDataList[
                                                              i]
                                                          .U_State
                                                          .toString();
                                                });
                                              },
                                              child: Column(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.all(
                                                        Screens.bodyheight(
                                                                context) *
                                                            0.008),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    // color: Colors.red,
                                                    height: Screens.bodyheight(
                                                            context) *
                                                        0.05,
                                                    width:
                                                        Screens.width(context),
                                                    child: Text(
                                                      "${context.watch<NewVisitplanController>().filterexistCusDataList[i].U_State}",
                                                      style: theme
                                                          .textTheme.bodyText1
                                                          ?.copyWith(
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                  ),
                                                  Divider()
                                                ],
                                              ),
                                            );
                                          })),
                            ],
                          ),
                        ),
                        // SizedBox(
                        //   height: Screens.bodyheight(context) * 0.01,
                        // ),

                        //new

                        SizedBox(
                          height: Screens.bodyheight(context) * 0.02,
                        ),
                        // Container(
                        //   width: Screens.width(context),
                        //   alignment: Alignment.centerLeft,
                        //   child: Text(
                        //     "Purpose Of Visit",
                        //     style: theme.textTheme.bodyLarge?.copyWith(
                        //         color: theme.primaryColor,
                        //         fontWeight: FontWeight.bold),
                        //   ),
                        // ),

                        Column(
                          children: [
                            Stack(children: [
                              SizedBox(
                                child: TextFormField(
                                  controller: context
                                      .read<NewVisitplanController>()
                                      .mycontroller[9],
                                  onTap: () {
                                    setState(() {
                                      context
                                          .read<NewVisitplanController>()
                                          .mycontroller[12]
                                          .clear();
                                      context
                                          .read<NewVisitplanController>()
                                          .clearbool();
                                      showDialog<dynamic>(
                                          context: context,
                                          builder: (_) {
                                            return VisitPlanShowDialog();
                                          });
                                    });
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter Purpose Of Visit";
                                    }
                                    return null;
                                  },
                                  // readOnly: true,
                                  // controller: context
                                  //     .read<NewEnqController>()
                                  //     .mycontroller[7],
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    hintText: "Purpose Of Visit",
                                    hintStyle: TextStyle(
                                        color: theme.primaryColor,
                                        fontWeight: FontWeight.bold),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide:
                                          BorderSide(color: theme.primaryColor),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide:
                                          BorderSide(color: theme.primaryColor),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide:
                                          BorderSide(color: theme.primaryColor),
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
                                        setState(() {
                                          print(context
                                              .read<NewVisitplanController>()
                                              .filterpurposeofVisitList
                                              .length);
                                          context
                                              .read<NewVisitplanController>()
                                              .clearbool();
                                          showDialog<dynamic>(
                                              context: context,
                                              builder: (_) {
                                                return VisitPlanShowDialog();
                                              });
                                        });
                                      },
                                      child: Container(
                                          width: Screens.width(context) * 0.2,
                                          height: Screens.bodyheight(context) *
                                              0.079,
                                          decoration: BoxDecoration(
                                              color: theme.primaryColor,
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(8),
                                                bottomRight: Radius.circular(8),
                                              )),
                                          child: Icon(Icons.search))))
                            ]),
                          ],
                        ),
                        // SizedBox(
                        //   height: Screens.bodyheight(context) * 0.01,
                        // ),

                        // Column(
                        //   children: [
                        //     Stack(children: [
                        //       SizedBox(
                        //         child: TextFormField(
                        //           onTap: () {
                        //             // showDialog<dynamic>(
                        //             //     context: context,
                        //             //     builder: (_) {
                        //             //       return EnqAssignUserDialog();
                        //             //     });
                        //           },
                        //           validator: (value) {
                        //             if (value!.isEmpty) {
                        //               return "Enter Assigned To";
                        //             }
                        //             return null;
                        //           },
                        //           // readOnly: true,
                        //           // controller: context
                        //           //     .read<NewEnqController>()
                        //           //     .mycontroller[8],
                        //           readOnly: true,
                        //           decoration: InputDecoration(
                        //             contentPadding: EdgeInsets.symmetric(
                        //                 vertical: 10, horizontal: 10),
                        //             labelText: "Assigned To:",
                        //             labelStyle: TextStyle(
                        //                 color: theme.primaryColor,
                        //                 fontWeight: FontWeight.bold),
                        //             border: OutlineInputBorder(
                        //               borderRadius: BorderRadius.circular(8),
                        //               borderSide:
                        //                   BorderSide(color: theme.primaryColor),
                        //             ),
                        //             enabledBorder: OutlineInputBorder(
                        //               borderRadius: BorderRadius.circular(8),
                        //               borderSide:
                        //                   BorderSide(color: theme.primaryColor),
                        //             ),
                        //             focusedBorder: OutlineInputBorder(
                        //               borderRadius: BorderRadius.circular(8),
                        //               borderSide:
                        //                   BorderSide(color: theme.primaryColor),
                        //             ),
                        //           ),
                        //           // cursorColor: Colors.green,
                        //         ),
                        //       ),
                        //       Positioned(
                        //           top: 0,
                        //           left: Screens.width(context) * 0.74,
                        //           child: InkWell(
                        //               onTap: () {
                        //                 // showDialog<dynamic>(
                        //                 //     context: context,
                        //                 //     builder: (_) {
                        //                 //       return EnqAssignUserDialog();
                        //                 //     });
                        //               },
                        //               child: Container(
                        //                   width: Screens.width(context) * 0.2,
                        //                   height: Screens.bodyheight(context) *
                        //                       0.079,
                        //                   decoration: BoxDecoration(
                        //                       color: theme.primaryColor,
                        //                       borderRadius: BorderRadius.only(
                        //                         topRight: Radius.circular(8),
                        //                         bottomRight: Radius.circular(8),
                        //                       )),
                        //                   child: Icon(Icons.search))))
                        //     ]),
                        //   ],
                        // ),
                        SizedBox(
                          height: Screens.bodyheight(context) * 0.015,
                        ),
                        Container(
                          width: Screens.width(context),
                          // height: Screens.bodyheight(context) * 0.15,
                          decoration: BoxDecoration(
                              color: theme.primaryColor,
                              borderRadius: BorderRadius.circular(8)),
                          padding: EdgeInsets.symmetric(
                              horizontal: Screens.width(context) * 0.02,
                              vertical: Screens.bodyheight(context) * 0.02),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                // color: Colors.amber,
                                // height: Screens.bodyheight(context) * 0.05,
                                child: Text(
                                  "Meeting Time",
                                  style: theme.textTheme.bodyText1
                                      ?.copyWith(color: Colors.white),
                                ),
                              ),
                              SizedBox(
                                  height: Screens.bodyheight(context) * 0.02),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: context
                                                .read<NewVisitplanController>()
                                                .Datebool ==
                                            false
                                        ? Screens.bodyheight(context) * 0.06
                                        : null,
                                    // height: cashHeight * 0.2,
                                    width: Screens.width(context) * 0.5,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.grey.withOpacity(0.01),
                                    ),
                                    // child: GestureDetector(
                                    //   onTap: () {
                                    //     st(() {
                                    //       posC.getDate(context, 'Cheque');
                                    //     });
                                    //   },
                                    child: TextFormField(
                                      controller: context
                                          .read<NewVisitplanController>()
                                          .mycontroller[10],
                                      // decoration: InputDecoration(
                                      //   filled:
                                      //       true, //<-- SEE HERE
                                      //   fillColor: Colors
                                      //       .white, //<-- SEE HERE
                                      // ),
                                      onTap: () {
                                        setState(() {
                                          context
                                              .read<NewVisitplanController>()
                                              .clearbool();
                                          context
                                              .read<NewVisitplanController>()
                                              .getDate(context);
                                        });
                                      },
                                      autofocus: true,
                                      readOnly: true,
                                      // controller: posC.mycontroller[24],
                                      cursorColor: Colors.grey,
                                      style: theme.textTheme.bodyText2
                                          ?.copyWith(
                                              backgroundColor: Colors.white),
                                      onChanged: (v) {},
                                      validator: (value) {
                                        if (value!.isEmpty &&
                                            context
                                                    .read<
                                                        NewVisitplanController>()
                                                    .Datebool ==
                                                false) {
                                          setState(() {
                                            context
                                                .read<NewVisitplanController>()
                                                .Datebool = true;
                                          });

                                          return 'Please Enter Date';
                                        } else if (value.isNotEmpty) {
                                          setState(() {
                                            context
                                                .read<NewVisitplanController>()
                                                .Datebool = false;
                                          });

                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        suffixIcon: IconButton(
                                            padding: EdgeInsets.only(
                                                top: Screens.bodyheight(
                                                        context) *
                                                    0.002),
                                            onPressed: () {
                                              context
                                                  .read<
                                                      NewVisitplanController>()
                                                  .getDate(context);
                                            },
                                            icon: Icon(
                                              Icons.date_range,
                                              color: theme.primaryColor,
                                            )),
                                        filled: true,
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          vertical: 11,
                                          horizontal: 10,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: context
                                                .read<NewVisitplanController>()
                                                .timebool ==
                                            false
                                        ? Screens.bodyheight(context) * 0.06
                                        : null,
                                    // height: cashHeight * 0.2,
                                    width: Screens.width(context) * 0.37,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      // color: Colors.grey
                                      //     .withOpacity(0.01),
                                    ),
                                    // child: GestureDetector(
                                    //   onTap: () {
                                    //     st(() {
                                    //       posC.getDate(context, 'Cheque');
                                    //     });
                                    //   },
                                    child: TextFormField(
                                      controller: context
                                          .read<NewVisitplanController>()
                                          .mycontroller[11],

                                      onTap: () {
                                        setState(() {
                                          context
                                              .read<NewVisitplanController>()
                                              .clearbool();
                                          context
                                              .read<NewVisitplanController>()
                                              .selectTime(context);
                                        });
                                      },
                                      autofocus: true,
                                      readOnly: true,
                                      // controller: posC.mycontroller[24],
                                      cursorColor: Colors.grey,
                                      style: theme.textTheme.bodyText2
                                          ?.copyWith(
                                              backgroundColor: Colors.white),
                                      onChanged: (v) {},
                                      validator: (value) {
                                        if (value!.isEmpty &&
                                            context
                                                    .read<
                                                        NewVisitplanController>()
                                                    .timebool ==
                                                false) {
                                          setState(() {
                                            context
                                                .read<NewVisitplanController>()
                                                .timebool = true;
                                          });

                                          return '  Please Enter the Time';
                                        } else if (value.isNotEmpty) {
                                          setState(() {
                                            context
                                                .read<NewVisitplanController>()
                                                .timebool = false;
                                          });

                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                        fillColor: Colors.white,
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
                                                    .selectTime(context);
                                              });
                                            },
                                            icon: Icon(
                                              Icons.timer,
                                              color: theme.primaryColor,
                                            )),
                                        filled: true,
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          vertical: 11,
                                          horizontal: 10,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // SizedBox(
                              //   height:context
                              //       .read<NewEnqController>()
                              //       .isSwitched ==
                              //           true
                              //       ? Screens.bodyheight(context) *
                              //           0.02
                              //       : Screens.bodyheight(context) *
                              //           0.04,
                              // ),
                              // Center(
                              //   child: Wrap(
                              //       spacing: 20.0, // width
                              //       runSpacing: 20.0, // height
                              //       children:
                              //           listContainersRefferes(
                              //         theme,
                              //       )),
                              // )
                            ],
                          ),
                        ),
                        context.read<NewVisitplanController>().errorTime.isEmpty
                            ? Container()
                            : Container(
                                height: Screens.bodyheight(context) * 0.1,
                                width: Screens.width(context) * 0.95,
                                child: Text(
                                  "${context.watch<NewVisitplanController>().errorTime}",
                                  style: theme.textTheme.bodyText1!
                                      .copyWith(color: Colors.red),
                                ),
                              ),
                        // Text(
                        //       "${context.watch<NewVisitplanController>().errorTime}")
                        // SizedBox(
                        //   height: Screens.bodyheight(context) * 0.02,
                        // ),

                        //new
                        // SizedBox(
                        //   height: Screens.bodyheight(context) * 0.01,
                        // ),
                      ],
                    ),
                  ),
                ),
                //
                SizedBox(
                  width: Screens.width(context),
                  height: Screens.bodyheight(context) * 0.07,
                  child: ElevatedButton(
                      onPressed: () {
                        controller:
                        context
                            .read<NewVisitplanController>()
                            .validateSchedule(context);
                        // context
                        //     .read<NewEnqController>()
                        //     .callAddEnq(context);
                        // context.read<NewEnqController>().callAlertDialog(context, "Successfully Created..!!");
                      },
                      child: Text("Schedule Visit")),
                )
              ],
            ),
          ),
        ));
  }
}
