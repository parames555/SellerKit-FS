// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_string_interpolations, unnecessary_new, prefer_const_constructors_in_immutables, prefer_interpolation_to_compose_strings, sized_box_for_whitespace

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Pages/Mycustomer/widgets/ShowSearchDialog.dart';
import '../../Controller/MyCustomerController/AccountsController.dart';
import '../../Controller/MyCustomerController/NewCustomerController.dart';
import '../../Widgets/Appbar.dart';
import '../../Widgets/Navi3.dart';

class NewCustomerReg extends StatefulWidget {
  NewCustomerReg({Key? key}) : super(key: key);

  @override
  State<NewCustomerReg> createState() => NewCustomerRegState();
}

class NewCustomerRegState extends State<NewCustomerReg> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<NewCustomerContoller>().init(context);
      // context.read<NewCustomerContoller>().getDataMethod();

      // print("sap user id: "+ConstantValues.sapUserID);

      // log("page on: "+context.read<NewCustomerContoller>().pageChanged.toString());
      // log("showItemList"+context.read<NewCustomerContoller>().showItemList.toString());
      //  log("oldcutomer: "+context.read<NewCustomerContoller>().oldcutomer.toString());
    });
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

  //  // });
  // }
  final GlobalKey<ScaffoldState> scaffoldKey1 = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
        // backgroundColor: Colors.grey[200],
        /// resizeToAvoidBottomInset: true,
        // key: scaffoldKey1,
        appBar: appbar("New Customer", theme, context),
        drawer: drawer3(context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                //  color: Colors.red,
                width: Screens.width(context),
                height: Screens.bodyheight(context),
                padding: EdgeInsets.symmetric(
                    horizontal: Screens.width(context) * 0.03,
                    vertical: Screens.bodyheight(context) * 0.02),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Form(
                        key: context.read<NewCustomerContoller>().formkey[0],
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.linear,
                          height: context
                                      .read<NewCustomerContoller>()
                                      .custInfobool ==
                                  true
                              ? Screens.bodyheight(context) * 0.09
                              : Screens.bodyheight(context) * 0.74,
                          padding: EdgeInsets.symmetric(
                              horizontal: Screens.width(context) * 0.03,
                              vertical: Screens.bodyheight(context) * 0.008),
                          width: Screens.width(context),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: theme.primaryColor)),
                          child: context
                                      .read<NewCustomerContoller>()
                                      .custInfobool ==
                                  true
                              ? Column(children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        context
                                            .read<NewCustomerContoller>()
                                            .customerDropDown();
                                      });
                                    },
                                    child: Container(
                                      // width: Screens.width(context),
                                      height:
                                          Screens.bodyheight(context) * 0.06,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: Screens.width(context) * 0.5,
                                            child: Text(
                                              "Customer Info",
                                              style: theme.textTheme.headline6
                                                  ?.copyWith(
                                                      color:
                                                          theme.primaryColor),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerRight,
                                            width: Screens.width(context) * 0.1,
                                            child: IconButton(
                                                padding: EdgeInsets.all(0),
                                                onPressed: () {
                                                  context
                                                      .read<
                                                          NewCustomerContoller>()
                                                      .customerDropDown();
                                                },
                                                iconSize: 30,
                                                icon: Icon(
                                                    Icons.arrow_drop_down,
                                                    color: Colors.black)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ])
                              : Stack(
                                  children: [
                                    SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height:
                                                Screens.bodyheight(context) *
                                                    0.06,
                                          ),
                                          TextFormField(
                                              controller: context
                                                  .read<NewCustomerContoller>()
                                                  .mycontroller[0],
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Enter Company Name";
                                                }
                                                return null;
                                              },
                                              onTap: () {},
                                              onChanged: (v) {},
                                              decoration: InputDecoration(
                                                labelText: 'Company Name',
                                                border: UnderlineInputBorder(),
                                                labelStyle: theme
                                                    .textTheme.bodyText1!
                                                    .copyWith(
                                                        color: Colors.grey),
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
                                              )),
                                          TextFormField(
                                              controller: context
                                                  .read<NewCustomerContoller>()
                                                  .mycontroller[1],
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Enter Contact Name";
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                labelText: 'Contact Name',
                                                labelStyle: theme
                                                    .textTheme.bodyText1!
                                                    .copyWith(
                                                        color: Colors.grey),
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
                                                border: UnderlineInputBorder(),
                                                // enabledBorder: UnderlineInputBorder(),
                                                // focusedBorder: UnderlineInputBorder(),
                                                errorBorder:
                                                    UnderlineInputBorder(),
                                                focusedErrorBorder:
                                                    UnderlineInputBorder(),
                                              )),
                                          TextFormField(
                                              controller: context
                                                  .read<NewCustomerContoller>()
                                                  .mycontroller[2],
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
                                                new LengthLimitingTextInputFormatter(
                                                    10),
                                              ],
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                labelText: 'Mobile',
                                                labelStyle: theme
                                                    .textTheme.bodyText1!
                                                    .copyWith(
                                                        color: Colors.grey),
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
                                                border: UnderlineInputBorder(),
                                                // enabledBorder: UnderlineInputBorder(),
                                                // focusedBorder: UnderlineInputBorder(),
                                                errorBorder:
                                                    UnderlineInputBorder(),
                                                focusedErrorBorder:
                                                    UnderlineInputBorder(),
                                              )),
                                          TextFormField(
                                              controller: context
                                                  .read<NewCustomerContoller>()
                                                  .mycontroller[3],
                                              // validator: (value) {
                                              //   if (value!.isEmpty) {
                                              //     return "Enter Email";
                                              //   }else if(!value.contains("@")){
                                              //       return "Enter Valid Email";
                                              //   }
                                              //   return null;
                                              // },
                                              decoration: InputDecoration(
                                                labelText: 'Email',
                                                labelStyle: theme
                                                    .textTheme.bodyText1!
                                                    .copyWith(
                                                        color: Colors.grey),
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
                                                border: UnderlineInputBorder(),
                                                // enabledBorder: UnderlineInputBorder(),
                                                // focusedBorder: UnderlineInputBorder(),
                                                errorBorder:
                                                    UnderlineInputBorder(),
                                                focusedErrorBorder:
                                                    UnderlineInputBorder(),
                                              )),
                                          TextFormField(
                                              controller: context
                                                  .read<NewCustomerContoller>()
                                                  .mycontroller[4],
                                              // validator: (value) {
                                              //   if (value!.isEmpty) {
                                              //     return "Enter Email";
                                              //   }else if(!value.contains("@")){
                                              //       return "Enter Valid Email";
                                              //   }
                                              //   return null;
                                              // },
                                              decoration: InputDecoration(
                                                labelText: 'Landline',
                                                labelStyle: theme
                                                    .textTheme.bodyText1!
                                                    .copyWith(
                                                        color: Colors.grey),
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
                                                border: UnderlineInputBorder(),
                                                // enabledBorder: UnderlineInputBorder(),
                                                // focusedBorder: UnderlineInputBorder(),
                                                errorBorder:
                                                    UnderlineInputBorder(),
                                                focusedErrorBorder:
                                                    UnderlineInputBorder(),
                                              )),
                                          TextFormField(
                                              controller: context
                                                  .read<NewCustomerContoller>()
                                                  .mycontroller[5],
                                              // validator: (value) {
                                              //   if (value!.isEmpty) {
                                              //     return "Enter Email";
                                              //   }else if(!value.contains("@")){
                                              //       return "Enter Valid Email";
                                              //   }
                                              //   return null;
                                              // },
                                              decoration: InputDecoration(
                                                labelText: 'Account Code',
                                                labelStyle: theme
                                                    .textTheme.bodyText1!
                                                    .copyWith(
                                                        color: Colors.grey),
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
                                                border: UnderlineInputBorder(),
                                                // enabledBorder: UnderlineInputBorder(),
                                                // focusedBorder: UnderlineInputBorder(),
                                                errorBorder:
                                                    UnderlineInputBorder(),
                                                focusedErrorBorder:
                                                    UnderlineInputBorder(),
                                              )),
                                          TextFormField(
                                              controller: context
                                                  .read<NewCustomerContoller>()
                                                  .mycontroller[6],
                                              // validator: (value) {
                                              //   if (value!.isEmpty) {
                                              //     return "Enter Email";
                                              //   }else if(!value.contains("@")){
                                              //       return "Enter Valid Email";
                                              //   }
                                              //   return null;
                                              // },
                                              decoration: InputDecoration(
                                                labelText: 'GST No',
                                                labelStyle: theme
                                                    .textTheme.bodyText1!
                                                    .copyWith(
                                                        color: Colors.grey),
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
                                                border: UnderlineInputBorder(),
                                                // enabledBorder: UnderlineInputBorder(),
                                                // focusedBorder: UnderlineInputBorder(),
                                                errorBorder:
                                                    UnderlineInputBorder(),
                                                focusedErrorBorder:
                                                    UnderlineInputBorder(),
                                              )),
                                          SizedBox(
                                            height:
                                                Screens.bodyheight(context) *
                                                    0.01,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            context
                                                .read<NewCustomerContoller>()
                                                .customerDropDown();
                                          });
                                        },
                                        child: Container(
                                          width: Screens.width(context) * 0.872,
                                          height: Screens.bodyheight(context) *
                                              0.06,
                                          color: Colors.white,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: Screens.width(context) *
                                                    0.5,
                                                child: Text(
                                                  "Customer Info",
                                                  style: theme
                                                      .textTheme.headline6
                                                      ?.copyWith(
                                                          color: theme
                                                              .primaryColor),
                                                ),
                                              ),
                                              Container(
                                                // color: Colors.black,
                                                alignment:
                                                    Alignment.centerRight,
                                                width: Screens.width(context) *
                                                    0.1,
                                                child: IconButton(
                                                    padding: EdgeInsets.all(0),
                                                    onPressed: () {
                                                      context
                                                          .read<
                                                              NewCustomerContoller>()
                                                          .customerDropDown();
                                                    },
                                                    iconSize: 30,
                                                    icon: Icon(
                                                        Icons.arrow_drop_down,
                                                        color: Colors.black)),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                        ),
                      ),
                      SizedBox(
                        height: Screens.bodyheight(context) * 0.015,
                      ),
                      //Office
                      Form(
                        key: context.read<NewCustomerContoller>().formkey[1],
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.linear,
                          height: context
                                      .read<NewCustomerContoller>()
                                      .officeaddress ==
                                  true
                              ? Screens.bodyheight(context) * 0.09
                              : Screens.bodyheight(context) * 0.55,
                          padding: EdgeInsets.symmetric(
                              horizontal: Screens.width(context) * 0.03,
                              vertical: Screens.bodyheight(context) * 0.008),
                          width: Screens.width(context),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: theme.primaryColor)),
                          child: context
                                      .read<NewCustomerContoller>()
                                      .officeaddress ==
                                  true
                              ? Column(children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        context
                                            .read<NewCustomerContoller>()
                                            .OfficeDropDown();
                                      });
                                    },
                                    child: Container(
                                      height:
                                          Screens.bodyheight(context) * 0.06,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: Screens.width(context) * 0.5,
                                            child: Text(
                                              "Office Address",
                                              style: theme.textTheme.headline6
                                                  ?.copyWith(
                                                      color:
                                                          theme.primaryColor),
                                            ),
                                          ),
                                          Container(
                                            // color: Colors.amber,
                                            alignment: Alignment.centerRight,
                                            width: Screens.width(context) * 0.1,
                                            child: IconButton(
                                                padding: EdgeInsets.all(0),
                                                onPressed: () {
                                                  context
                                                      .read<
                                                          NewCustomerContoller>()
                                                      .OfficeDropDown();
                                                },
                                                iconSize: 30,
                                                icon: Icon(
                                                    Icons.arrow_drop_down,
                                                    color: Colors.black)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ])
                              : Stack(
                                  //  width: Screens.width(context)*0.875,
                                  //           height: Screens.bodyheight(context) *
                                  //               0.06,
                                  children: [
                                    SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height:
                                                Screens.bodyheight(context) *
                                                    0.06,
                                          ),
                                          TextFormField(
                                              controller: context
                                                  .read<NewCustomerContoller>()
                                                  .mycontroller1[0],
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Enter Address1";
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                labelText: 'Address1',
                                                // fillColor: Colors.amber,
                                                border: UnderlineInputBorder(),
                                                labelStyle: theme
                                                    .textTheme.bodyText1!
                                                    .copyWith(
                                                        color: Colors.grey),
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
                                              )),
                                          // SizedBox(
                                          //   height: Screens.bodyheight(context) * 0.005,
                                          // ),
                                          TextFormField(
                                              controller: context
                                                  .read<NewCustomerContoller>()
                                                  .mycontroller1[1],
                                              // validator: (value) {
                                              //   if (value!.isEmpty) {
                                              //     return "Enter Address2";
                                              //   }
                                              //   return null;
                                              // },
                                              decoration: InputDecoration(
                                                labelText: 'Address2',
                                                border: UnderlineInputBorder(),
                                                labelStyle: theme
                                                    .textTheme.bodyText1!
                                                    .copyWith(
                                                        color: Colors.grey),
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
                                              )),
                                          // SizedBox(
                                          //   height: Screens.bodyheight(context) * 0.005,
                                          // ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: Screens.width(context) *
                                                    0.4,
                                                child: TextFormField(
                                                    controller: context
                                                        .read<
                                                            NewCustomerContoller>()
                                                        .mycontroller1[2],
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return "Enter Area";
                                                      }
                                                      return null;
                                                    },
                                                    onTap: () {
                                                      setState(() {});
                                                    },
                                                    onChanged: (v) {
                                                      setState(() {});
                                                    },
                                                    decoration: InputDecoration(
                                                      labelText: 'Area',
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
                                                    )),
                                              ),
                                              SizedBox(
                                                width: Screens.width(context) *
                                                    0.4,
                                                child: TextFormField(
                                                    controller: context
                                                        .read<
                                                            NewCustomerContoller>()
                                                        .mycontroller1[3],
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return "Enter City";
                                                      }
                                                      return null;
                                                    },
                                                    onTap: () {
                                                      setState(() {});
                                                    },
                                                    onChanged: (v) {
                                                      setState(() {});
                                                    },
                                                    decoration: InputDecoration(
                                                      labelText: 'City',
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
                                                    )),
                                              ),
                                            ],
                                          ),

                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: Screens.width(context) *
                                                    0.4,
                                                child: TextFormField(
                                                    controller: context
                                                        .read<
                                                            NewCustomerContoller>()
                                                        .mycontroller1[4],
                                                    onTap: () {},
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return "Enter Pincode";
                                                      }
                                                      return null;
                                                    },
                                                    onChanged: (v) {
                                                      setState(() {});
                                                    },
                                                    keyboardType:
                                                        TextInputType.number,
                                                    inputFormatters: [
                                                      new LengthLimitingTextInputFormatter(
                                                          6),
                                                    ],
                                                    decoration: InputDecoration(
                                                      labelText: 'Pincode',
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
                                                    )),
                                              ),
                                              SizedBox(
                                                width: Screens.width(context) *
                                                    0.4,
                                                child: TextFormField(
                                                    controller: context
                                                        .read<
                                                            NewCustomerContoller>()
                                                        .mycontroller1[5],
                                                    onTap: () {
                                                      setState(() {});
                                                    },
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return "Enter State";
                                                      }
                                                      return null;
                                                    },
                                                    onChanged: (v) {
                                                      setState(() {});
                                                    },
                                                    decoration: InputDecoration(
                                                      labelText: 'State',
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
                                                    )),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: Screens.width(context) *
                                                    0.4,
                                                child: TextFormField(
                                                    controller: context
                                                        .read<
                                                            NewCustomerContoller>()
                                                        .mycontroller1[6],
                                                    onTap: () {},
                                                    // validator: (value) {
                                                    //   if (value!.isEmpty) {
                                                    //     return "Enter Pincode";
                                                    //   }
                                                    //   return null;
                                                    // },
                                                    onChanged: (v) {
                                                      setState(() {});
                                                    },
                                                    keyboardType:
                                                        TextInputType.number,
                                                    inputFormatters: [
                                                      new LengthLimitingTextInputFormatter(
                                                          6),
                                                    ],
                                                    decoration: InputDecoration(
                                                      labelText: 'Latitude ',
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
                                                    )),
                                              ),
                                              SizedBox(
                                                width: Screens.width(context) *
                                                    0.075,
                                              ),
                                              SizedBox(
                                                width: Screens.width(context) *
                                                    0.32,
                                                child: TextFormField(
                                                    controller: context
                                                        .read<
                                                            NewCustomerContoller>()
                                                        .mycontroller1[7],
                                                    onTap: () {
                                                      setState(() {});
                                                    },
                                                    // validator: (value) {
                                                    //   if (value!.isEmpty) {
                                                    //     return "Longitude";
                                                    //   }
                                                    //   return null;
                                                    // },
                                                    onChanged: (v) {
                                                      setState(() {});
                                                    },
                                                    decoration: InputDecoration(
                                                      labelText: 'Longitude',
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
                                                    )),
                                              ),
                                              Container(
                                                width: Screens.width(context) *
                                                    0.05,
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Switch(
                                                  activeColor:
                                                      theme.primaryColor,
                                                  value: context
                                                      .watch<
                                                          NewCustomerContoller>()
                                                      .latilongbool,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      context
                                                          .read<
                                                              NewCustomerContoller>()
                                                          .latilongbool = value;
                                                      context
                                                          .read<
                                                              NewCustomerContoller>()
                                                          .radio(value);
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),

                                          SizedBox(
                                            height:
                                                Screens.bodyheight(context) *
                                                    0.01,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            context
                                                .read<NewCustomerContoller>()
                                                .OfficeDropDown();
                                          });
                                        },
                                        child: Container(
                                          width: Screens.width(context) * 0.872,
                                          height: Screens.bodyheight(context) *
                                              0.06,
                                          color: Colors.white,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: Screens.width(context) *
                                                    0.5,
                                                child: Text(
                                                  "Office Address",
                                                  style: theme
                                                      .textTheme.headline6
                                                      ?.copyWith(
                                                          color: theme
                                                              .primaryColor),
                                                ),
                                              ),
                                              Container(
                                                // color: Colors.amber,
                                                // alignment:
                                                //     Alignment.bottomLeft,
                                                width: Screens.width(context) *
                                                    0.1,
                                                child: IconButton(
                                                    padding: EdgeInsets.all(0),
                                                    onPressed: () {
                                                      context
                                                          .read<
                                                              NewCustomerContoller>()
                                                          .OfficeDropDown();
                                                    },
                                                    iconSize: 30,
                                                    icon: Icon(
                                                        Icons.arrow_drop_down,
                                                        color: Colors.black)),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                        ),
                      ),
                      SizedBox(
                        height: Screens.bodyheight(context) * 0.015,
                      ),
                      Form(
                        key: context.read<NewCustomerContoller>().formkey[2],
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.linear,
                          height: context
                                      .read<NewCustomerContoller>()
                                      .billadressbool ==
                                  true
                              ? Screens.bodyheight(context) * 0.09
                              : Screens.bodyheight(context) * 0.46,
                          padding: EdgeInsets.symmetric(
                              horizontal: Screens.width(context) * 0.03,
                              vertical: Screens.bodyheight(context) * 0.008),
                          width: Screens.width(context),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: theme.primaryColor)),
                          child: context
                                      .read<NewCustomerContoller>()
                                      .billadressbool ==
                                  true
                              ? Column(children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        context
                                            .read<NewCustomerContoller>()
                                            .billingAddDropDown();
                                      });
                                    },
                                    child: Container(
                                      height:
                                          Screens.bodyheight(context) * 0.06,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: Screens.width(context) * 0.5,
                                            child: Text(
                                              "Billing Address",
                                              style: theme.textTheme.headline6
                                                  ?.copyWith(
                                                      color:
                                                          theme.primaryColor),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerRight,
                                            width: Screens.width(context) * 0.1,
                                            child: IconButton(
                                                padding: EdgeInsets.all(0),
                                                onPressed: () {
                                                  context
                                                      .read<
                                                          NewCustomerContoller>()
                                                      .billingAddDropDown();
                                                },
                                                iconSize: 30,
                                                icon: Icon(
                                                    Icons.arrow_drop_down,
                                                    color: Colors.black)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ])
                              : Stack(
                                  children: [
                                    SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height:
                                                Screens.bodyheight(context) *
                                                    0.06,
                                          ),
                                          Container(
                                            width: Screens.width(context) * 0.9,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  // color:Colors.amber,
                                                  width:
                                                      Screens.width(context) *
                                                          0.72,
                                                  child: TextFormField(
                                                      controller: context
                                                          .read<
                                                              NewCustomerContoller>()
                                                          .mycontroller2[0],
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return "Enter Address1";
                                                        }
                                                        return null;
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: 'Address1',
                                                        labelStyle: theme
                                                            .textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                                color: Colors
                                                                    .grey),
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .grey),
                                                          //  when the TextFormField in unfocused
                                                        ),
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .grey),
                                                          //  when the TextFormField in focused
                                                        ),
                                                        border:
                                                            UnderlineInputBorder(),
                                                        // enabledBorder: UnderlineInputBorder(),
                                                        // focusedBorder: UnderlineInputBorder(),
                                                        errorBorder:
                                                            UnderlineInputBorder(),
                                                        focusedErrorBorder:
                                                            UnderlineInputBorder(),
                                                      )),
                                                ),
                                                Container(
                                                  width:
                                                      Screens.width(context) *
                                                          0.1,
                                                  child: Checkbox(
                                                    value: context
                                                        .read<
                                                            NewCustomerContoller>()
                                                        .billingCheckbox,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .billAddCheckboxmethod(
                                                                value!);
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .billingCheckbox = value;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // SizedBox(
                                          //   height: Screens.bodyheight(context) * 0.01,
                                          // ),
                                          TextFormField(
                                              controller: context
                                                  .read<NewCustomerContoller>()
                                                  .mycontroller2[1],
                                              // validator: (value) {
                                              //   if (value!.isEmpty) {
                                              //     return "Enter Address2";
                                              //   }
                                              //   return null;
                                              // },
                                              decoration: InputDecoration(
                                                labelText: 'Address2',
                                                labelStyle: theme
                                                    .textTheme.bodyText1!
                                                    .copyWith(
                                                        color: Colors.grey),
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
                                                border: UnderlineInputBorder(),
                                                // enabledBorder: UnderlineInputBorder(),
                                                // focusedBorder: UnderlineInputBorder(),
                                                errorBorder:
                                                    UnderlineInputBorder(),
                                                focusedErrorBorder:
                                                    UnderlineInputBorder(),
                                              )),
                                          // SizedBox(
                                          //   height: Screens.bodyheight(context) * 0.01,
                                          // ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: Screens.width(context) *
                                                    0.4,
                                                child: TextFormField(
                                                    controller: context
                                                        .read<
                                                            NewCustomerContoller>()
                                                        .mycontroller2[2],
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return "Enter Area";
                                                      }
                                                      return null;
                                                    },
                                                    onTap: () {},
                                                    onChanged: (v) {
                                                      setState(() {});
                                                    },
                                                    decoration: InputDecoration(
                                                      labelText: 'Area',
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
                                                    )),
                                              ),
                                              SizedBox(
                                                width: Screens.width(context) *
                                                    0.4,
                                                child: TextFormField(
                                                    controller: context
                                                        .read<
                                                            NewCustomerContoller>()
                                                        .mycontroller2[3],
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return "Enter City";
                                                      }
                                                      return null;
                                                    },
                                                    onTap: () {
                                                      setState(() {});
                                                    },
                                                    onChanged: (v) {
                                                      setState(() {});
                                                    },
                                                    decoration: InputDecoration(
                                                      labelText: 'City',
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
                                                    )),
                                              ),
                                            ],
                                          ),

                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: Screens.width(context) *
                                                    0.4,
                                                child: TextFormField(
                                                    controller: context
                                                        .read<
                                                            NewCustomerContoller>()
                                                        .mycontroller2[4],
                                                    onTap: () {
                                                      setState(() {});
                                                    },
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return "Enter Pincode";
                                                      }
                                                      return null;
                                                    },
                                                    onChanged: (v) {
                                                      setState(() {});
                                                    },
                                                    keyboardType:
                                                        TextInputType.number,
                                                    inputFormatters: [
                                                      new LengthLimitingTextInputFormatter(
                                                          6),
                                                    ],
                                                    decoration: InputDecoration(
                                                      labelText: 'Pincode',
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
                                                    )),
                                              ),
                                              SizedBox(
                                                width: Screens.width(context) *
                                                    0.4,
                                                child: TextFormField(
                                                    controller: context
                                                        .read<
                                                            NewCustomerContoller>()
                                                        .mycontroller2[5],
                                                    onTap: () {
                                                      setState(() {});
                                                    },
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return "Enter State";
                                                      }
                                                      return null;
                                                    },
                                                    onChanged: (v) {
                                                      setState(() {});
                                                    },
                                                    decoration: InputDecoration(
                                                      labelText: 'State',
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
                                                    )),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height:
                                                Screens.bodyheight(context) *
                                                    0.01,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            context
                                                .read<NewCustomerContoller>()
                                                .billingAddDropDown();
                                          });
                                        },
                                        child: Container(
                                          height: Screens.bodyheight(context) *
                                              0.06,
                                          color: Colors.white,
                                          width: Screens.width(context) * 0.872,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: Screens.width(context) *
                                                    0.5,
                                                child: Text(
                                                  "Billing Address",
                                                  style: theme
                                                      .textTheme.headline6
                                                      ?.copyWith(
                                                          color: theme
                                                              .primaryColor),
                                                ),
                                              ),
                                              Container(
                                                color: Colors.white,
                                                alignment:
                                                    Alignment.centerRight,
                                                width: Screens.width(context) *
                                                    0.1,
                                                child: IconButton(
                                                    padding: EdgeInsets.all(0),
                                                    onPressed: () {
                                                      context
                                                          .read<
                                                              NewCustomerContoller>()
                                                          .billingAddDropDown();
                                                    },
                                                    iconSize: 30,
                                                    icon: Icon(
                                                        Icons.arrow_drop_down,
                                                        color: Colors.black)),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                        ),
                      ),

                      SizedBox(
                        height: Screens.bodyheight(context) * 0.015,
                      ),

                      //Ship
                      Form(
                        key: context.read<NewCustomerContoller>().formkey[3],
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.linear,
                          height: context
                                      .read<NewCustomerContoller>()
                                      .shipaddressbool ==
                                  true
                              ? Screens.bodyheight(context) * 0.09
                              : Screens.bodyheight(context) * 0.46,
                          padding: EdgeInsets.symmetric(
                              horizontal: Screens.width(context) * 0.03,
                              vertical: Screens.bodyheight(context) * 0.008),
                          width: Screens.width(context),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: theme.primaryColor)),
                          child: context
                                      .read<NewCustomerContoller>()
                                      .shipaddressbool ==
                                  true
                              ? Column(children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        context
                                            .read<NewCustomerContoller>()
                                            .ShipAddDropDown();
                                      });
                                    },
                                    child: Container(
                                      height:
                                          Screens.bodyheight(context) * 0.06,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: Screens.width(context) * 0.5,
                                            child: Text(
                                              "Delivery Address",
                                              style: theme.textTheme.headline6
                                                  ?.copyWith(
                                                      color:
                                                          theme.primaryColor),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerRight,
                                            width: Screens.width(context) * 0.1,
                                            child: IconButton(
                                                padding: EdgeInsets.all(0),
                                                onPressed: () {
                                                  context
                                                      .read<
                                                          NewCustomerContoller>()
                                                      .ShipAddDropDown();
                                                },
                                                iconSize: 30,
                                                icon: Icon(
                                                    Icons.arrow_drop_down,
                                                    color: Colors.black)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ])
                              : Stack(
                                  children: [
                                    SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height:
                                                Screens.bodyheight(context) *
                                                    0.06,
                                          ),
                                          Container(
                                            width: Screens.width(context) * 0.9,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  // color:Colors.amber,
                                                  width:
                                                      Screens.width(context) *
                                                          0.72,
                                                  child: TextFormField(
                                                      controller: context
                                                          .read<
                                                              NewCustomerContoller>()
                                                          .mycontroller3[0],
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return "Enter Address1";
                                                        }
                                                        return null;
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: 'Address1',
                                                        labelStyle: theme
                                                            .textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                                color: Colors
                                                                    .grey),
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .grey),
                                                          //  when the TextFormField in unfocused
                                                        ),
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .grey),
                                                          //  when the TextFormField in focused
                                                        ),
                                                        border:
                                                            UnderlineInputBorder(),
                                                        // enabledBorder: UnderlineInputBorder(),
                                                        // focusedBorder: UnderlineInputBorder(),
                                                        errorBorder:
                                                            UnderlineInputBorder(),
                                                        focusedErrorBorder:
                                                            UnderlineInputBorder(),
                                                      )),
                                                ),
                                                Container(
                                                  width:
                                                      Screens.width(context) *
                                                          0.1,
                                                  child: Checkbox(
                                                    value: context
                                                        .read<
                                                            NewCustomerContoller>()
                                                        .delivAddCheckbox,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .deliAddCheckboxmethod(
                                                                value!);
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .delivAddCheckbox = value;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // SizedBox(
                                          //   height: Screens.bodyheight(context) * 0.005,
                                          // ),
                                          TextFormField(
                                              controller: context
                                                  .read<NewCustomerContoller>()
                                                  .mycontroller3[1],
                                              // validator: (value) {
                                              //   if (value!.isEmpty) {
                                              //     return "Enter Address2";
                                              //   }
                                              //   return null;
                                              // },
                                              decoration: InputDecoration(
                                                labelText: 'Address2',
                                                border: UnderlineInputBorder(),
                                                labelStyle: theme
                                                    .textTheme.bodyText1!
                                                    .copyWith(
                                                        color: Colors.grey),
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
                                              )),
                                          // SizedBox(
                                          //   height: Screens.bodyheight(context) * 0.005,
                                          // ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: Screens.width(context) *
                                                    0.4,
                                                child: TextFormField(
                                                    controller: context
                                                        .read<
                                                            NewCustomerContoller>()
                                                        .mycontroller3[2],
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return "Enter Area";
                                                      }
                                                      return null;
                                                    },
                                                    onTap: () {
                                                      setState(() {});
                                                    },
                                                    onChanged: (v) {
                                                      setState(() {});
                                                    },
                                                    decoration: InputDecoration(
                                                      labelText: 'Area',
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
                                                    )),
                                              ),
                                              SizedBox(
                                                width: Screens.width(context) *
                                                    0.4,
                                                child: TextFormField(
                                                    controller: context
                                                        .read<
                                                            NewCustomerContoller>()
                                                        .mycontroller3[3],
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return "Enter City";
                                                      }
                                                      return null;
                                                    },
                                                    onTap: () {
                                                      setState(() {});
                                                    },
                                                    onChanged: (v) {
                                                      setState(() {});
                                                    },
                                                    decoration: InputDecoration(
                                                      labelText: 'City',
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
                                                    )),
                                              ),
                                            ],
                                          ),

                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: Screens.width(context) *
                                                    0.4,
                                                child: TextFormField(
                                                    controller: context
                                                        .read<
                                                            NewCustomerContoller>()
                                                        .mycontroller3[4],
                                                    onTap: () {},
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return "Enter Pincode";
                                                      }
                                                      return null;
                                                    },
                                                    onChanged: (v) {
                                                      setState(() {});
                                                    },
                                                    keyboardType:
                                                        TextInputType.number,
                                                    inputFormatters: [
                                                      new LengthLimitingTextInputFormatter(
                                                          6),
                                                    ],
                                                    decoration: InputDecoration(
                                                      labelText: 'Pincode',
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
                                                    )),
                                              ),
                                              SizedBox(
                                                width: Screens.width(context) *
                                                    0.4,
                                                child: TextFormField(
                                                    controller: context
                                                        .read<
                                                            NewCustomerContoller>()
                                                        .mycontroller3[5],
                                                    onTap: () {
                                                      setState(() {});
                                                    },
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return "Enter State";
                                                      }
                                                      return null;
                                                    },
                                                    onChanged: (v) {
                                                      setState(() {});
                                                    },
                                                    decoration: InputDecoration(
                                                      labelText: 'State',
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
                                                    )),
                                              ),
                                            ],
                                          ),
                                          // SizedBox(
                                          //   height:
                                          //       Screens.bodyheight(context) * 0.01,
                                          // ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            context
                                                .read<NewCustomerContoller>()
                                                .ShipAddDropDown();
                                          });
                                        },
                                        child: Container(
                                          height: Screens.bodyheight(context) *
                                              0.06,
                                          color: Colors.white,
                                          width: Screens.width(context) * 0.872,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: Screens.width(context) *
                                                    0.5,
                                                child: Text(
                                                  "Delivery Address",
                                                  style: theme
                                                      .textTheme.headline6
                                                      ?.copyWith(
                                                          color: theme
                                                              .primaryColor),
                                                ),
                                              ),
                                              Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                width: Screens.width(context) *
                                                    0.1,
                                                child: IconButton(
                                                    padding: EdgeInsets.all(0),
                                                    onPressed: () {
                                                      context
                                                          .read<
                                                              NewCustomerContoller>()
                                                          .ShipAddDropDown();
                                                    },
                                                    iconSize: 30,
                                                    icon: Icon(
                                                        Icons.arrow_drop_down,
                                                        color: Colors.black)),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                      SizedBox(
                        height: Screens.bodyheight(context) * 0.015,
                      ),
                      Column(
                        children: [
                          Container(
                            width: Screens.width(context),
                            height: Screens.bodyheight(context) * 0.28,
                            decoration: BoxDecoration(
                                color: theme.primaryColor,
                                borderRadius: BorderRadius.circular(8)),
                            padding: EdgeInsets.only(
                              left: Screens.width(context) * 0.02,
                              right: Screens.width(context) * 0.02,
                              top: Screens.bodyheight(context) * 0.01,
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Payment Terms",
                                    style: theme.textTheme.bodyText1
                                        ?.copyWith(color: Colors.white),
                                  ),
                                  SizedBox(
                                      height:
                                          Screens.bodyheight(context) * 0.02),
                                  Center(
                                    child: Wrap(
                                        spacing: 20.0, // width
                                        runSpacing: 8.0, // height
                                        children:
                                            listContainersRefferes(theme)),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      // //nextbtn
                      SizedBox(
                        height: Screens.bodyheight(context) * 0.015,
                      ),
                      Form(
                        key: context.read<NewCustomerContoller>().formkey[4],
                        child: SizedBox(
                          child: TextFormField(
                            controller: context
                                .read<NewCustomerContoller>()
                                .mycontroller3[6],
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
                            // controller:
                            //     context.read<NewEnqController>().mycontroller[7],
                            readOnly: true,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              labelText: "Select Group",
                              labelStyle: TextStyle(
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
                      ),
                      SizedBox(
                        height: Screens.bodyheight(context) * 0.015,
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: SizedBox(
                            width: Screens.width(context),
                            height: Screens.bodyheight(context) * 0.07,
                            child: ElevatedButton(
                                onPressed: () {
                                  context
                                      .read<NewCustomerContoller>()
                                      .validate2(context);
                                },
                                child: Text("Save")),
                          ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  bool switched = false;
  bool switched2 = false;

  List<Widget> listContainersRefferes(
    ThemeData theme,
  ) {
    return List.generate(
      context.read<NewCustomerContoller>().getenqReffList.length,
      (index) => InkWell(
        onTap: () {
          // context.read<NewEnqController>(). isSelectedenquirytype = context.read<NewEnqController>()
          // .getenqReffList[index].Name.toString();
          context.read<NewCustomerContoller>().selectEnqReffers(
              context
                  .read<NewCustomerContoller>()
                  .getenqReffList[index]
                  .Name
                  .toString(),
              context.read<NewCustomerContoller>().getenqReffList[index].Name!);
        },
        child: Container(
          width: Screens.width(context) * 0.4,
          height: Screens.bodyheight(context) * 0.06,
          //  padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: context
                          .read<NewCustomerContoller>()
                          .getisSelectedenquiryReffers ==
                      context
                          .read<NewCustomerContoller>()
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
                      .watch<NewCustomerContoller>()
                      .getenqReffList[index]
                      .Name
                      .toString(),
                  maxLines: 8,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyText1?.copyWith(
                    color: context
                                .read<NewCustomerContoller>()
                                .getisSelectedenquiryReffers ==
                            context
                                .read<NewCustomerContoller>()
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

  // List<Widget> listContainersCustomertags(
  //   ThemeData theme,
  // ) {
  //   return List.generate(
  //     context.watch<NewCustomerContoller>().getcusReffList.length,
  //     (index) => InkWell(
  //       onTap: () {
  //         // context.read<NewEnqController>(). isSelectedenquirytype = context.read<NewEnqController>()
  //         // .getenqReffList[index].Name.toString();
  //         context.read<NewCustomerContoller>().selectEnqReffers(
  //             context
  //                 .read<NewCustomerContoller>()
  //                 .getcusReffList[index]
  //                 .tagname
  //                 .toString(),
  //             context.read<NewCustomerContoller>().getcusReffList[index].tagname!);
  //       },
  //       child: Container(
  //         width: Screens.width(context) * 0.2,
  //         height: Screens.bodyheight(context) * 0.05,
  //         //  padding: EdgeInsets.all(10),
  //         decoration: BoxDecoration(
  //             color: context
  //                         .watch<NewCustomerContoller>()
  //                         .getisSelectedenquiryReffers ==
  //                     context
  //                         .read<NewCustomerContoller>()
  //                         .getcusReffList[index]
  //                         .tagname
  //                         .toString()
  //                 ? Color(0xffB299A5) //theme.primaryColor.withOpacity(0.5)
  //                 : Colors.white,
  //             border: Border.all(color: theme.primaryColor, width: 1),
  //             borderRadius: BorderRadius.circular(10)),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Text(
  //                 context
  //                     .watch<NewCustomerContoller>()
  //                     .getcusReffList[index]
  //                     .tagname
  //                     .toString(),
  //                 maxLines: 8,
  //                 overflow: TextOverflow.ellipsis,
  //                 style: theme.textTheme.bodyText1?.copyWith(
  //                   color: context
  //                               .watch<NewCustomerContoller>()
  //                               .getisSelectedenquiryReffers ==
  //                           context
  //                               .read<NewCustomerContoller>()
  //                               .getcusReffList[index]
  //                               .tagname
  //                               .toString()
  //                       ? theme.primaryColor //,Colors.white
  //                       : theme.primaryColor,
  //                 ))
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
