// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_new, sort_child_properties_last, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
// import 'package:sellerkit/Controller/EnquiryController/NewEnqController.dart';
import '../../../Constant/Screen.dart';
import '../../../Constant/padings.dart';
import '../../../Controller/SiteInController/SiteInController.dart';
import '../../../Controller/VisitplanController/NewVisitController.dart';
import '../../../Widgets/Appbar.dart';
import '../../../Widgets/Navi3.dart';
import '../../VisitPlans/widgets/PurposeShowSearchDialog.dart';
import 'ShowSearchDialog.dart';

class NewSiteIn extends StatefulWidget {
  NewSiteIn({Key? key}) : super(key: key);

  @override
  State<NewSiteIn> createState() => _NewSiteInState();
}

class _NewSiteInState extends State<NewSiteIn> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Paddings paddings = Paddings();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        context.read<SiteInController>().init();
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
        appBar: appbar("Site Check-In", theme, context),
        body: Container(
          padding: paddings.padding2(context),
          child: Form(
            key: context.read<SiteInController>().formkey,
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
                                .read<SiteInController>()
                                .mycontroller[0],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Customer";
                              }
                              return null;
                            },
                            onTap: () {},
                            onChanged: (v) {},
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

                        TextFormField(
                            controller: context
                                .read<SiteInController>()
                                .mycontroller[1],
                            onTap: () {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Mobile Number";
                              } else if (value.length > 10 ||
                                  value.length < 10) {
                                return "Enter a valid Mobile Number";
                              }
                              return null;
                            },
                            onChanged: (v) {},
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
                                .read<SiteInController>()
                                .mycontroller[2],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Contact Name";
                              }
                              return null;
                            },
                            onTap: () {},
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
                                .read<SiteInController>()
                                .mycontroller[3],
                            onTap: () {},
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
                                .read<SiteInController>()
                                .mycontroller[4],
                            onTap: () {},
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
                                      .read<SiteInController>()
                                      .mycontroller[5],
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter Area";
                                    }
                                    return null;
                                  },
                                  onTap: () {},
                                  onChanged: (v) {},
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
                                      .read<SiteInController>()
                                      .mycontroller[6],
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter City";
                                    }
                                    return null;
                                  },
                                  onTap: () {},
                                  onChanged: (v) {},
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

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Screens.width(context) * 0.4,
                              child: TextFormField(
                                  controller: context
                                      .read<SiteInController>()
                                      .mycontroller[7],
                                  onTap: () {},
                                  // validator: (value) {
                                  //   if (value!.isEmpty) {
                                  //     return "Enter Pincode";
                                  //   }
                                  //   return null;
                                  // },
                                  onChanged: (v) {},
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
                                      .read<SiteInController>()
                                      .mycontroller[8],
                                  onTap: () {},
                                  // validator: (value) {
                                  //   if (value!.isEmpty) {
                                  //     return "Enter State";
                                  //   }
                                  //   return null;
                                  // },
                                  onChanged: (v) {},
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
                                      .read<SiteInController>()
                                      .mycontroller[9],
                                  onTap: () {
                                    setState(() {
                                      context
                                          .read<SiteInController>()
                                          .mycontroller[12]
                                          .clear();
                                      // context
                                      //     .read<SiteInController>()
                                      //     .clearbool();
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
                                          // context
                                          //     .read<SiteInController>()
                                          //     .clearbool();
                                          showDialog<dynamic>(
                                              context: context,
                                              builder: (_) {
                                                return SiteInShowDialog();
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

                        SizedBox(
                          height: Screens.bodyheight(context) * 0.015,
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
                      onPressed: () {
                        controller:
                        context
                            .read<SiteInController>()
                            .validateSchedule(context);
                        // context
                        //     .read<NewEnqController>()
                        //     .callAddEnq(context);
                        // context.read<NewEnqController>().callAlertDialog(context, "Successfully Created..!!");
                      },
                      child: Text("Site Check-In")),
                )
              ],
            ),
          ),
        ));
  }
}
