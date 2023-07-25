// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_string_interpolations, unnecessary_new, prefer_const_constructors_in_immutables, prefer_interpolation_to_compose_strings

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/Screen.dart';
import '../../Controller/LeadController/LeadNewController.dart';
import '../../Widgets/Appbar.dart';
import '../../Widgets/Navi3.dart';

class LeadBookNew extends StatefulWidget {
  LeadBookNew({Key? key}) : super(key: key);

  @override
  State<LeadBookNew> createState() => LeadBookNewState();
}

class LeadBookNewState extends State<LeadBookNew> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<LeadNewController>().checkComeFromEnq();
      context.read<LeadNewController>().getDataMethod();

      // print("sap user id: "+ConstantValues.sapUserID);

      // log("page on: "+context.read<LeadNewController>().pageChanged.toString());
      // log("showItemList"+context.read<LeadNewController>().showItemList.toString());
      //  log("oldcutomer: "+context.read<LeadNewController>().oldcutomer.toString());
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
        key: scaffoldKey1,
        appBar: appbar("New Orders", theme, context),
        drawer: drawer3(context),
        // body: ChangeNotifierProvider<LeadNewController>(
        //     create: (context) => LeadNewController(),
        //     builder: (context, child) {
        //       return Consumer<LeadNewController>(
        //           builder: (BuildContext context, provi, Widget? child) {
        // return
        body: PageView(
          physics: new NeverScrollableScrollPhysics(),
          controller: context.read<LeadNewController>().pageController,
          onPageChanged: (index) {
            log("index: ${index}");
            setState(() {
              context.read<LeadNewController>().pageChanged = index;
            });
            print(context.read<LeadNewController>().pageChanged);
          },
          children: [
            FirstPage(
              context,
              theme,
            ),
            SecondPage(
              context,
              theme,
            ),
            ThirdPage(
              context,
              theme,
            ),
          ],
        )
        //   });
        // })
        );
  }

  Container ThirdPage(
    BuildContext context,
    ThemeData theme,
  ) {
    //LeadNewController provi
    return Container(
      width: Screens.width(context),
      height: Screens.bodyheight(context),
      padding: EdgeInsets.only(
        left: Screens.width(context) * 0.03,
        right: Screens.width(context) * 0.03,
        top: Screens.bodyheight(context) * 0.02,
        bottom: Screens.bodyheight(context) * 0.01,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: Screens.width(context),
              height: Screens.bodyheight(context) * 0.82,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                height: Screens.bodyheight(context) * 0.02),
                            // Visibility(
                            //   visible: provi.getvisibleRefferal,
                            //   child: Column(
                            //     children: [
                            //       Text(
                            //         "Required Referral*",
                            //         style: theme.textTheme.bodyText1
                            //             ?.copyWith(color: Colors.white),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: provi.getvisibleRefferal == true
                            //       ? Screens.bodyheight(context) * 0.02
                            //       : Screens.bodyheight(context) * 0.04,
                            // ),
                            Center(
                              child: Wrap(
                                  spacing: 20.0, // width
                                  runSpacing: 8.0, // height
                                  children: listContainersRefferes(theme)),
                            )
                          ],
                        ),
                      ),
                    ),
                    //SizedBox(height: Screens.bodyheight(context)*0.02,),
                    // SizedBox(
                    //   height: Screens.bodyheight(context) * 0.01,
                    // ),
                    //dates
                    Form(
                      key: context.read<LeadNewController>().formkey[1],
                      child: Column(
                        children: [
                          TextFormField(
                              onTap: () {
                                context
                                    .read<LeadNewController>()
                                    .showFollowupDate(context);
                              },
                              controller: context
                                  .read<LeadNewController>()
                                  .mycontroller[13],
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Choose Delivery Date";
                                }
                                return null;
                              },
                              readOnly: true,
                              decoration: InputDecoration(
                                  labelText: 'Delivery Date', //
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
                                  suffixIcon: Icon(Icons.date_range_outlined))),
                          SizedBox(
                            height: Screens.bodyheight(context) * 0.005,
                          ),
                          TextFormField(
                              onTap: () {
                                // context
                                //     .read<LeadNewController>()
                                //     .showPurchaseDate(context);
                              },
                              controller: context
                                  .read<LeadNewController>()
                                  .mycontroller[14],
                              // validator: (value) {
                              //   if (value!.isEmpty) {
                              //     return "Enter Customer PO Reference"; //
                              //   }
                              //   return null;
                              // },
                              readOnly: false,
                              decoration: InputDecoration(
                                labelText: 'Customer PO Reference',
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
                                // suffixIcon: Icon(Icons.date_range_outlined)
                              )),
                          SizedBox(
                            height: Screens.bodyheight(context) * 0.02,
                          ),
                          TextFormField(
                            minLines: 6,
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                top: Screens.bodyheight(context) * 0.04,
                                left: Screens.bodyheight(context) * 0.01,
                              ),
                              alignLabelWithHint: true,
                              // border: OutlineInputBorder(),
                              hintText: 'Notes',
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Screens.bodyheight(context) * 0.015,
                    ),
                    Container(
                        //  width: Screens.width(context),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: theme.primaryColor)),
                        padding: EdgeInsets.only(
                            top: Screens.padingHeight(context) * 0.01,
                            left: Screens.padingHeight(context) * 0.01,
                            bottom: Screens.padingHeight(context) * 0.015,
                            right: Screens.padingHeight(context) * 0.01),
                        // height: Screens.padingHeight(context) * 0.14,
                        // color: Colors.red,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Attachment',
                                      style: theme.textTheme.subtitle1?.copyWith(
                                          color: context
                                                      .read<LeadNewController>()
                                                      .fileValidation ==
                                                  true
                                              ? Colors.red
                                              : Colors.black)),
                                  Row(
                                    children: [
                                      Container(
                                          // alignment: Alignment.center,
                                          height:
                                              Screens.padingHeight(context) *
                                                  0.06,
                                          width: Screens.width(context) * 0.13,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              color: context
                                                          .read<
                                                              LeadNewController>()
                                                          .fileValidation ==
                                                      true
                                                  ? Colors.red
                                                  : theme.primaryColor
                                              // shape: BoxShape
                                              //     .circle
                                              ),
                                          child: Center(
                                            child: IconButton(
                                                onPressed: context
                                                            .read<
                                                                LeadNewController>()
                                                            .files
                                                            .length >
                                                        5
                                                    ? null
                                                    : () {
                                                        setState(() {
                                                          // log("files length" + files.length.toString());
                                                          // showtoast();
                                                          if (context
                                                                  .read<
                                                                      LeadNewController>()
                                                                  .files
                                                                  .length <=
                                                              4) {
                                                            setState(() {
                                                              context
                                                                  .read<
                                                                      LeadNewController>()
                                                                  .imagetoBinary(
                                                                      ImageSource
                                                                          .camera);
                                                              context
                                                                  .read<
                                                                      LeadNewController>()
                                                                  .fileValidation = false;
                                                            });
                                                          } else {
                                                            print(
                                                                "obAAAAAject");
                                                            context
                                                                .read<
                                                                    LeadNewController>()
                                                                .showtoast();
                                                          }
                                                        });
                                                      },
                                                icon: Icon(
                                                  Icons.photo_camera,
                                                  color: Colors.white,
                                                )),
                                          )),
                                      SizedBox(
                                        width: Screens.width(context) * 0.02,
                                      ),

                                      //old
                                      Container(
                                          // alignment: Alignment.center,
                                          height:
                                              Screens.padingHeight(context) *
                                                  0.06,
                                          width: Screens.width(context) * 0.13,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              color: context
                                                          .read<
                                                              LeadNewController>()
                                                          .fileValidation ==
                                                      true
                                                  ? Colors.red
                                                  : theme.primaryColor
                                              // shape: BoxShape
                                              //     .circle
                                              ),
                                          child: Center(
                                            child: IconButton(
                                                onPressed: context
                                                            .read<
                                                                LeadNewController>()
                                                            .files
                                                            .length >
                                                        5
                                                    ? null
                                                    : () {
                                                        setState(() {
                                                          // log("files length" + files.length.toString());
                                                          // showtoast();
                                                          if (context
                                                                  .read<
                                                                      LeadNewController>()
                                                                  .files
                                                                  .length <=
                                                              4) {
                                                            setState(() {
                                                              context
                                                                  .read<
                                                                      LeadNewController>()
                                                                  .selectattachment();

                                                              context
                                                                  .read<
                                                                      LeadNewController>()
                                                                  .fileValidation = false;
                                                            });
                                                          } else {
                                                            print(
                                                                "obAAAAAject");

                                                            context
                                                                .read<
                                                                    LeadNewController>()
                                                                .showtoast();
                                                          }
                                                        });
                                                      },
                                                icon: Icon(
                                                  Icons.attach_file,
                                                  color: Colors.white,
                                                )),
                                          )),
                                    ],
                                  )
                                ],
                              ),
                             
                              context.read<LeadNewController>().files == null
                                  ? Container(
                                      height:
                                          Screens.padingHeight(context) * 0.3,
                                      padding: EdgeInsets.only(
                                        top: Screens.padingHeight(context) *
                                            0.001,
                                        right: Screens.padingHeight(context) *
                                            0.015,
                                        left: Screens.padingHeight(context) *
                                            0.015,
                                        bottom: Screens.padingHeight(context) *
                                            0.015,
                                      ),
                                      child: Container(
                                          alignment: Alignment.center,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Center(
                                                  child: Text(
                                                "No Files Selected",
                                                style: theme
                                                    .textTheme.bodyText1!
                                                    .copyWith(
                                                        color: context
                                                                    .read<
                                                                        LeadNewController>()
                                                                    .fileValidation ==
                                                                true
                                                            ? Colors.red
                                                            : Colors.green),
                                              )),
                                              Icon(
                                                Icons.file_present_outlined,
                                                color: theme.primaryColor,
                                              )
                                            ],
                                          )))
                                  : Container(
                                      height: context
                                                  .read<LeadNewController>()
                                                  .files
                                                  .length ==
                                              0
                                          ? Screens.padingHeight(context) * 0.0
                                          : Screens.padingHeight(context) * 0.3,
                                      padding: EdgeInsets.only(
                                        top: Screens.padingHeight(context) *
                                            0.001,
                                        right: Screens.padingHeight(context) *
                                            0.015,
                                        left: Screens.padingHeight(context) *
                                            0.015,
                                        bottom: Screens.padingHeight(context) *
                                            0.015,
                                      ),
                                      child: ListView.builder(
                                          itemCount: context
                                              .read<LeadNewController>()
                                              .files
                                              .length,
                                          itemBuilder:
                                              (BuildContext context, int i) {
                                            if (context
                                                .read<LeadNewController>()
                                                .files[i]
                                                .path
                                                .split('/')
                                                .last
                                                .contains("png")) {
                                              return Container(
                                                  child: Column(children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                          decoration:
                                                              BoxDecoration(),
                                                          width: Screens.width(
                                                                  context) *
                                                              0.09,
                                                          height: Screens
                                                                  .padingHeight(
                                                                      context) *
                                                              0.06,
                                                          child: Center(
                                                              child: Image.asset(
                                                                  "Assets/img.jpg"))),
                                                      Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          decoration:
                                                              BoxDecoration(),
                                                          width: Screens.width(
                                                                  context) *
                                                              0.6,
                                                          // height: Screens.padingHeight(context) * 0.06,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            context
                                                                .watch<
                                                                    LeadNewController>()
                                                                .files[i]
                                                                .path
                                                                .split('/')
                                                                .last,
                                                            // overflow: TextOverflow.ellipsis,
                                                          )),
                                                      Container(
                                                          width: Screens.width(
                                                                  context) *
                                                              0.1,
                                                          height: Screens
                                                                  .padingHeight(
                                                                      context) *
                                                              0.06,
                                                          child: IconButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  context
                                                                      .read<
                                                                          LeadNewController>()
                                                                      .files
                                                                      .removeAt(
                                                                          i);
                                                                });
                                                              },
                                                              icon: Icon(
                                                                Icons
                                                                    .cancel_rounded,
                                                                color:
                                                                    Colors.grey,
                                                              )))
                                                    ])
                                              ])
                                                  // )
                                                  );
                                            } else if (context
                                                .read<LeadNewController>()
                                                .files[i]
                                                .path
                                                .split('/')
                                                .last
                                                .contains("jp")) {
                                              return Container(
                                                  child: Column(children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                          decoration:
                                                              BoxDecoration(),
                                                          width: Screens.width(
                                                                  context) *
                                                              0.09,
                                                          height: Screens
                                                                  .padingHeight(
                                                                      context) *
                                                              0.06,
                                                          child: Center(
                                                              child: Image.asset(
                                                                  "Assets/img.jpg"))),
                                                      Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          decoration:
                                                              BoxDecoration(),
                                                          width: Screens.width(
                                                                  context) *
                                                              0.6,
                                                          // height: Screens.padingHeight(context) * 0.06,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            context
                                                                .watch<
                                                                    LeadNewController>()
                                                                .files[i]
                                                                .path
                                                                .split('/')
                                                                .last,
                                                          )),
                                                      Container(
                                                          width: Screens.width(
                                                                  context) *
                                                              0.1,
                                                          height: Screens
                                                                  .padingHeight(
                                                                      context) *
                                                              0.06,
                                                          child: IconButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  context
                                                                      .read<
                                                                          LeadNewController>()
                                                                      .files
                                                                      .removeAt(
                                                                          i);
                                                                });
                                                              },
                                                              icon: Icon(
                                                                Icons
                                                                    .cancel_rounded,
                                                                color:
                                                                    Colors.grey,
                                                              )))
                                                    ])
                                              ])
                                                  // )
                                                  );
                                            } else if (context
                                                .read<LeadNewController>()
                                                .files[i]
                                                .path
                                                .split('/')
                                                .last
                                                .contains("pdf")) {
                                              return Container(
                                                  child: Column(children: [
                                                SizedBox(
                                                  height: Screens.padingHeight(
                                                          context) *
                                                      0.01,
                                                ),
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(),
                                                        width: Screens.width(
                                                                context) *
                                                            0.09,
                                                        height: Screens
                                                                .padingHeight(
                                                                    context) *
                                                            0.06,
                                                        child: Center(
                                                            child: Image.asset(
                                                                "Assets/PDFimg.png")),
                                                      ),
                                                      Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          decoration:
                                                              BoxDecoration(),
                                                          width: Screens.width(
                                                                  context) *
                                                              0.6,
                                                          // height: Screens.padingHeight(context) * 0.06,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            context
                                                                .watch<
                                                                    LeadNewController>()
                                                                .files[i]
                                                                .path
                                                                .split('/')
                                                                .last,
                                                          )),
                                                      Container(
                                                          width: Screens.width(
                                                                  context) *
                                                              0.1,
                                                          height: Screens
                                                                  .padingHeight(
                                                                      context) *
                                                              0.06,
                                                          child: IconButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  context
                                                                      .read<
                                                                          LeadNewController>()
                                                                      .files
                                                                      .removeAt(
                                                                          i);
                                                                });
                                                              },
                                                              icon: Icon(
                                                                Icons
                                                                    .cancel_rounded,
                                                                color:
                                                                    Colors.grey,
                                                              )))
                                                    ])
                                              ]));
                                            } else if (context
                                                .read<LeadNewController>()
                                                .files[i]
                                                .path
                                                .split('/')
                                                .last
                                                .contains("xlsx")) {
                                              return Container(
                                                  child: Column(children: [
                                                SizedBox(
                                                  height: Screens.padingHeight(
                                                          context) *
                                                      0.01,
                                                ),
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                          decoration:
                                                              BoxDecoration(),
                                                          width: Screens.width(
                                                                  context) *
                                                              0.09,
                                                          height: Screens
                                                                  .padingHeight(
                                                                      context) *
                                                              0.06,
                                                          child: Center(
                                                              child: Image.asset(
                                                                  "Assets/xls.png"))),
                                                      Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          decoration:
                                                              BoxDecoration(),
                                                          width: Screens.width(
                                                                  context) *
                                                              0.6,
                                                          // height: Screens.padingHeight(context) * 0.06,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            context
                                                                .read<
                                                                    LeadNewController>()
                                                                .files[i]
                                                                .path
                                                                .split('/')
                                                                .last,
                                                          )),
                                                      Container(
                                                          width: Screens.width(
                                                                  context) *
                                                              0.1,
                                                          height: Screens
                                                                  .padingHeight(
                                                                      context) *
                                                              0.06,
                                                          child: IconButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  context
                                                                      .read<
                                                                          LeadNewController>()
                                                                      .files
                                                                      .removeAt(
                                                                          i);
                                                                });
                                                              },
                                                              icon: Icon(
                                                                Icons
                                                                    .cancel_rounded,
                                                                color:
                                                                    Colors.grey,
                                                              )))
                                                    ])
                                              ])
                                                  // )
                                                  );
                                            }
                                            return Container(
                                                child: Column(children: [
                                              SizedBox(
                                                height: Screens.padingHeight(
                                                        context) *
                                                    0.01,
                                              ),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                        decoration:
                                                            BoxDecoration(),
                                                        width: Screens.width(
                                                                context) *
                                                            0.09,
                                                        height: Screens
                                                                .padingHeight(
                                                                    context) *
                                                            0.06,
                                                        child: Center(
                                                            child: Image.asset(
                                                                "Assets/txt.png"))),
                                                    Container(
                                                        padding:
                                                            EdgeInsets.all(10),
                                                        decoration:
                                                            BoxDecoration(),
                                                        width: Screens.width(
                                                                context) *
                                                            0.6,
                                                        // height: Screens.padingHeight(context) * 0.06,
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          context
                                                              .watch<
                                                                  LeadNewController>()
                                                              .files[i]
                                                              .path
                                                              .split('/')
                                                              .last,
                                                        )),
                                                    Container(
                                                        width: Screens.width(
                                                                context) *
                                                            0.1,
                                                        height: Screens
                                                                .padingHeight(
                                                                    context) *
                                                            0.06,
                                                        child: IconButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                context
                                                                    .read<
                                                                        LeadNewController>()
                                                                    .files
                                                                    .removeAt(
                                                                        i);
                                                              });
                                                            },
                                                            icon: Icon(
                                                              Icons
                                                                  .cancel_rounded,
                                                              color:
                                                                  Colors.grey,
                                                            )))
                                                  ])
                                            ]));
                                          })),
                            ])),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  width: Screens.width(context),
                  height: Screens.bodyheight(context) * 0.07,
                  //  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color(
                          0xffB299A5) //theme.primaryColor.withOpacity(0.5)
                      ,
                      border: Border.all(color: theme.primaryColor, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          "Total Order Value Rs.${context.read<LeadNewController>().getTotalOrderAmount()}",
                          maxLines: 8,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyText1?.copyWith(
                            color: theme.primaryColor,
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: Screens.bodyheight(context) * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: Screens.width(context) * 0.3,
                      height: Screens.bodyheight(context) * 0.07,
                      child: ElevatedButton(
                          onPressed: () {
                            context
                                .read<LeadNewController>()
                                .pageController
                                .animateToPage(
                                    --context
                                        .read<LeadNewController>()
                                        .pageChanged,
                                    duration: Duration(milliseconds: 250),
                                    curve: Curves.bounceIn);
                          },
                          child: Icon(Icons.keyboard_arrow_left)),
                    ),
                    SizedBox(
                      width: Screens.width(context) * 0.3,
                      height: Screens.bodyheight(context) * 0.07,
                      child: ElevatedButton(
                          onPressed: context
                                      .watch<LeadNewController>()
                                      .getisloadingBtn ==
                                  true
                              ? null
                              : () {
                                  context
                                      .read<LeadNewController>()
                                      .thirPageBtnClicked(context);
                                },
                          child: context
                                      .watch<LeadNewController>()
                                      .getisloadingBtn ==
                                  true
                              ? SizedBox(
                                  width: Screens.width(context) * 0.08,
                                  height: Screens.bodyheight(context) * 0.07,
                                  child: CircularProgressIndicator(
                                      color: Colors.white))
                              : Icon(Icons.save)),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
    //       }
    //     );
    //   }
    // );
  }

  bool switched = false;
  bool switched2 = false;

  Container SecondPage(
    BuildContext context,
    ThemeData theme,
  ) {
    //  return ChangeNotifierProvider<LeadNewController>(
    //       create: (context) => LeadNewController(),
    //       builder: (context, child) {
    //         return Consumer<LeadNewController>(
    //           builder: (BuildContext context, provi, Widget? child) {
    return Container(
      // color: Colors.blue,
      width: Screens.width(context),
      height: Screens.bodyheight(context),
      padding: EdgeInsets.only(
          left: Screens.width(context) * 0.01,
          right: Screens.width(context) * 0.01,
          bottom: Screens.bodyheight(context) * 0.01,
          top: Screens.bodyheight(context) * 0.02),
      child: Column(
        children: [
          Container(
            height: Screens.bodyheight(context) * 0.06,
            decoration: BoxDecoration(
              color: theme.primaryColor.withOpacity(0.1), //Colors.grey[200],
              borderRadius:
                  BorderRadius.circular(Screens.width(context) * 0.02),
            ),
            child: TextField(
              autocorrect: false,
              onChanged: (val) {
                context.read<LeadNewController>().filterList(val);
              },
              controller: context.read<LeadNewController>().mycontroller[12],
              decoration: InputDecoration(
                filled: false,
                hintText: 'Search Here!!..',
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    FocusScopeNode focus = FocusScope.of(context);
                    if (!focus.hasPrimaryFocus) {
                      focus.unfocus();
                    }
                    context.read<LeadNewController>().changeVisible();
                  }, //
                  color: theme.primaryColor,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 11,
                  horizontal: 10,
                ),
              ),
            ),
          ),
          context.read<LeadNewController>().showItemList == true
              ? Expanded(
                  child: ListView.builder(
                    itemCount: context
                        .watch<LeadNewController>()
                        .getAllProductDetails
                        .length,
                    itemBuilder: (BuildContext context, int i) {
                      return InkWell(
                        onTap: () {
                          context.read<LeadNewController>().resetItems(i);
                          context.read<LeadNewController>().isUpdateClicked =
                              false;
                          // context
                          //     .read<LeadNewController>()
                          //     .showBottomSheetInsert(context, i);
                          context
                              .read<LeadNewController>()
                              .showBottomSheetInsert(context, i);
                        },
                        child: Card(
                          elevation: 5,
                          child: Container(
                            width: Screens.width(context),
                            padding: EdgeInsets.symmetric(
                                vertical: Screens.bodyheight(context) * 0.01,
                                horizontal: Screens.width(context) * 0.02),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: Screens.width(context) * 0.4,
                                      child: Text(
                                          "Item code: ${context.read<LeadNewController>().getAllProductDetails[i].itemCode}",
                                          style: theme.textTheme.bodyText1
                                              ?.copyWith(
                                                  color: theme.primaryColor)),
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      width: Screens.width(context) * 0.4,
                                      child: Text(
                                        "Date: " +
                                            context
                                                .read<LeadNewController>()
                                                .config
                                                .alignDate(context
                                                    .read<LeadNewController>()
                                                    .getAllProductDetails[i]
                                                    .refreshedRecordDate!),
                                        // context
                                        //     .watch<LeadNewController>()
                                        //     .config
                                        //     .alignDate(context
                                        //         .read<LeadNewController>()
                                        //         .getAllProductDetails[i]
                                        //         .refreshedRecordDate!),
                                        style: theme.textTheme.bodyText1
                                            ?.copyWith(color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          Screens.width(context) * 0.05),
                                  child: Divider(
                                    color: Colors.grey[400],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  width: Screens.width(context) * 0.4,
                                  child: Text("Product",
                                      style: theme.textTheme.bodyText1
                                          ?.copyWith(color: Colors.grey)),
                                ),
                                SizedBox(
                                  height: Screens.bodyheight(context) * 0.01,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: Screens.width(context) * 0.4,
                                      child: Text(
                                          "${context.read<LeadNewController>().getAllProductDetails[i].itemName}",
                                          style: theme.textTheme.bodyText1
                                              ?.copyWith(
                                                  //color: theme.primaryColor
                                                  )),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          alignment: Alignment.centerRight,
                                          width: Screens.width(context) * 0.1,
                                          child: Text(
                                            "₹ ",
                                            style: theme.textTheme.bodyText1
                                                ?.copyWith(color: Colors.grey),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          //width: Screens.width(context) * 0.2,
                                          child: Text(
                                            "${context.read<LeadNewController>().getAllProductDetails[i].slpPrice}",
                                            style: theme.textTheme.bodyText1
                                                ?.copyWith(
                                                    color: theme.primaryColor),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount:
                        context.read<LeadNewController>().getProduct.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text(
                                        "" +
                                            context
                                                .read<LeadNewController>()
                                                .getProduct[index]
                                                .ItemCode
                                                .toString(),
                                        style: TextStyle(
                                          color: theme.primaryColor,
                                          fontSize: 15.0,
                                        )),
                                  ),
                                  SizedBox(height: 10.0),
                                  Row(
                                    children: [
                                      Text("Product",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 15.0,
                                          )),
                                    ],
                                  ),
                                  SizedBox(height: 10.0),
                                  Container(
                                    // width: Screens.width(context)*0.8,
                                    ///  color: Colors.red,
                                    child: Text(
                                        context
                                            .read<LeadNewController>()
                                            .getProduct[index]
                                            .ItemDescription!,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.0,
                                        )),
                                  ),
                                  SizedBox(height: 10.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          "Qty: " +
                                              context
                                                  .read<LeadNewController>()
                                                  .getProduct[index]
                                                  .Quantity
                                                  .toString(),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.0,
                                          )),
                                      // SizedBox(
                                      //     width: Screens.bodyheight(context) /
                                      //         2.9),
                                      Text(
                                          "Price: " +
                                              context
                                                  .read<LeadNewController>()
                                                  .getProduct[index]
                                                  .Price
                                                  .toString(),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.0,
                                          )),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 40, right: 40),
                                    child: Divider(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text("Total: " +
                                                  context
                                                      .read<LeadNewController>()
                                                      .getProduct[index]
                                                      .LineTotal
                                                      .toString())
                                            ]),
                                        Row(
                                          children: [
                                            GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    print(index);
                                                    context
                                                        .read<
                                                            LeadNewController>()
                                                        .getProduct
                                                        .removeAt(index);

                                                    for (int i = 0;
                                                        i <
                                                            context
                                                                .read<
                                                                    LeadNewController>()
                                                                .productDetails
                                                                .length;
                                                        i++) {
                                                      //  provi.productDetails[i].lineId =
                                                      //     (i + 1).toString();
                                                    }
                                                  });
                                                },
                                                child: Icon(
                                                  Icons.close,
                                                  color: Colors.red,
                                                )),
                                            SizedBox(width: 10.0),
                                            GestureDetector(
                                                onTap: () {
                                                  context
                                                          .read<LeadNewController>()
                                                          .mycontroller[10]
                                                          .text =
                                                      context
                                                          .read<
                                                              LeadNewController>()
                                                          .getProduct[index]
                                                          .Price!
                                                          .toStringAsFixed(2);
                                                  context
                                                          .read<LeadNewController>()
                                                          .mycontroller[11]
                                                          .text =
                                                      context
                                                          .read<
                                                              LeadNewController>()
                                                          .getProduct[index]
                                                          .Quantity!
                                                          .toStringAsFixed(2);
                                                  context
                                                          .read<LeadNewController>()
                                                          .mycontroller[11]
                                                          .text =
                                                      context
                                                          .read<
                                                              LeadNewController>()
                                                          .getProduct[index]
                                                          .Quantity!
                                                          .toStringAsFixed(0);
                                                  context
                                                          .read<LeadNewController>()
                                                          .total =
                                                      context
                                                          .read<
                                                              LeadNewController>()
                                                          .getProduct[index]
                                                          .LineTotal!;
                                                  context
                                                      .read<LeadNewController>()
                                                      .isUpdateClicked = true;

                                                  context
                                                      .read<LeadNewController>()
                                                      .showBottomSheetInsert(
                                                          context, index);
                                                },
                                                child: Icon(
                                                  Icons.edit,
                                                  color: Colors.blue,
                                                )),
                                          ],
                                        ),
                                      ]),
                                ]),
                          ));
                    },
                  ),
                ),
          //

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: Screens.width(context) * 0.3,
                height: Screens.bodyheight(context) * 0.07,
                child: ElevatedButton(
                    onPressed: () {
                      context
                          .read<LeadNewController>()
                          .pageController
                          .animateToPage(
                              --context.read<LeadNewController>().pageChanged,
                              duration: Duration(milliseconds: 250),
                              curve: Curves.bounceIn);
                    },
                    child: Icon(Icons.keyboard_arrow_left)),
              ),
              SizedBox(
                width: Screens.width(context) * 0.3,
                height: Screens.bodyheight(context) * 0.07,
                child: ElevatedButton(
                    onPressed: () {
                      FocusScopeNode focus = FocusScope.of(context);
                      if (!focus.hasPrimaryFocus) {
                        focus.unfocus();
                      }
                      // provi.pageController.animateToPage(++provi.pageChanged,
                      //     duration: Duration(milliseconds: 250),
                      //     curve: Curves.bounceIn);

                      context.read<LeadNewController>().seconPageBtnClicked();
                      log("oldcutomer: " +
                          context
                              .read<LeadNewController>()
                              .oldcutomer
                              .toString());
                    },
                    child: Icon(Icons.keyboard_arrow_right)),
              ),
            ],
          )
        ],
      ),
    );
    //       }
    //     );
    //   }
    // );
  }

  InkWell FirstPage(
    BuildContext context,
    ThemeData theme,
  ) {
    // return ChangeNotifierProvider<LeadNewController>(
    //       create: (context) => LeadNewController(),
    //       builder: (context, child) {
    //         return Consumer<LeadNewController>(
    //           builder: (BuildContext context, provi, Widget? child) {
    return InkWell(
      onTap: () {
        FocusScopeNode focus = FocusScope.of(context);
        if (!focus.hasPrimaryFocus) {
          focus.unfocus();
        }
      },
      child: (context.read<LeadNewController>().getexceptionOnApiCall.isEmpty &&
              context.read<LeadNewController>().getcustomerapicLoading == true)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : (context
                      .read<LeadNewController>()
                      .getexceptionOnApiCall
                      .isNotEmpty &&
                  context.read<LeadNewController>().getcustomerapicLoading ==
                      false)
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        context.read<LeadNewController>().getexceptionOnApiCall,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                )
              : Container(
                  //  color: Colors.red,
                  width: Screens.width(context),
                  height: Screens.bodyheight(context),
                  padding: EdgeInsets.symmetric(
                      horizontal: Screens.width(context) * 0.03,
                      vertical: Screens.bodyheight(context) * 0.02),
                  child: SingleChildScrollView(
                    child: Form(
                      key: context.read<LeadNewController>().formkey[0],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: Screens.width(context) * 0.03,
                                vertical: Screens.bodyheight(context) * 0.008),
                            width: Screens.width(context),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: theme.primaryColor)),
                            child: Column(
                              children: [
                                Container(
                                  width: Screens.width(context),
                                  child: Text(
                                    "Customer Info",
                                    style: theme.textTheme.headline6
                                        ?.copyWith(color: theme.primaryColor),
                                  ),
                                ),
                                TextFormField(
                                    controller: context
                                        .read<LeadNewController>()
                                        .mycontroller[16],
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Enter Customer";
                                      }
                                      return null;
                                    },
                                    onTap: () {
                                      setState(() {
                                        context
                                            .read<LeadNewController>()
                                            .clearbool();
                                      });
                                    },
                                    onChanged: (v) {
                                      setState(() {
                                        context
                                            .read<LeadNewController>()
                                            .filterListcustomer(v);
                                        if (v.isEmpty) {
                                          context
                                              .read<LeadNewController>()
                                              .customerbool = false;
                                        } else {
                                          context
                                              .read<LeadNewController>()
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
                                      focusedErrorBorder:
                                          UnderlineInputBorder(),
                                    )),
                                Visibility(
                                  visible: context
                                      .read<LeadNewController>()
                                      .customerbool,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height:
                                            Screens.bodyheight(context) * 0.01,
                                      ),
                                      context
                                              .read<LeadNewController>()
                                              .filterexistCusDataList
                                              .isEmpty
                                          ? Container()
                                          : Container(

                                              // color: Colors.amber,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                      color:
                                                          theme.primaryColor)),
                                              width: Screens.width(context),
                                              height:
                                                  Screens.bodyheight(context) *
                                                      0.2,
                                              child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount: context
                                                      .read<LeadNewController>()
                                                      .filterexistCusDataList
                                                      .length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int i) {
                                                    return InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          context
                                                              .read<
                                                                  LeadNewController>()
                                                              .customerbool = false;
                                                          context
                                                              .read<
                                                                  LeadNewController>()
                                                              .getExiCustomerData(context
                                                                  .read<
                                                                      LeadNewController>()
                                                                  .filterexistCusDataList[
                                                                      i]
                                                                  .Customer
                                                                  .toString());
                                                          context
                                                                  .read<
                                                                      LeadNewController>()
                                                                  .mycontroller[16]
                                                                  .text =
                                                              context
                                                                  .read<
                                                                      LeadNewController>()
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
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            // color: Colors.red,
                                                            height: Screens
                                                                    .bodyheight(
                                                                        context) *
                                                                0.05,
                                                            width:
                                                                Screens.width(
                                                                    context),
                                                            child: Text(
                                                              "${context.watch<LeadNewController>().filterexistCusDataList[i].Customer}",
                                                              style: theme
                                                                  .textTheme
                                                                  .bodyText1
                                                                  ?.copyWith(
                                                                      color: Colors
                                                                          .black),
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
                                SizedBox(
                                  height: Screens.bodyheight(context) * 0.01,
                                ),
                                Center(
                                  child: Wrap(
                                      spacing: 5.0, // width
                                      runSpacing: 10.0, // height
                                      children: listContainersCustomertags(
                                        theme,
                                      )),
                                ),
                                // SizedBox(
                                //   height: Screens.bodyheight(context) * 0.005,
                                // ),
                                TextFormField(
                                    controller: context
                                        .read<LeadNewController>()
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
                                      // if (v.length == 10 &&
                                      //     context
                                      //             .read<LeadNewController>()
                                      //             .getcustomerapicalled ==
                                      //         false) {
                                      //   // context.read<LeadNewController>().callApi();
                                      //   context
                                      //       .read<LeadNewController>()
                                      //       .callCheckEnqDetailsApi(context);
                                      // }
                                    },
                                    inputFormatters: [
                                      new LengthLimitingTextInputFormatter(10),
                                    ],
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: 'Mobile',
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
                                      border: UnderlineInputBorder(),
                                      // enabledBorder: UnderlineInputBorder(),
                                      // focusedBorder: UnderlineInputBorder(),
                                      errorBorder: UnderlineInputBorder(),
                                      focusedErrorBorder:
                                          UnderlineInputBorder(),
                                    )),
                                TextFormField(
                                    controller: context
                                        .read<LeadNewController>()
                                        .mycontroller[1],
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Enter Contact Name";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Contact Name',
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
                                      border: UnderlineInputBorder(),
                                      // enabledBorder: UnderlineInputBorder(),
                                      // focusedBorder: UnderlineInputBorder(),
                                      errorBorder: UnderlineInputBorder(),
                                      focusedErrorBorder:
                                          UnderlineInputBorder(),
                                    )),
                                TextFormField(
                                    controller: context
                                        .read<LeadNewController>()
                                        .mycontroller[6],
                                    // validator: (value) {
                                    //   if (value!.isEmpty) {
                                    //     return "Enter Alternate Mobile No";
                                    //   } else if (value.length > 10 || value.length < 10) {
                                    //     return "Enter a valid Mobile Number";
                                    //   }
                                    //   return null;
                                    // },
                                    inputFormatters: [
                                      new LengthLimitingTextInputFormatter(10),
                                    ],
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: 'Alternate Mobile No',
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
                                      border: UnderlineInputBorder(),
                                      // enabledBorder: UnderlineInputBorder(),
                                      // focusedBorder: UnderlineInputBorder(),
                                      errorBorder: UnderlineInputBorder(),
                                      focusedErrorBorder:
                                          UnderlineInputBorder(),
                                    )),
                                TextFormField(
                                    controller: context
                                        .read<LeadNewController>()
                                        .mycontroller[7],
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
                                      border: UnderlineInputBorder(),
                                      // enabledBorder: UnderlineInputBorder(),
                                      // focusedBorder: UnderlineInputBorder(),
                                      errorBorder: UnderlineInputBorder(),
                                      focusedErrorBorder:
                                          UnderlineInputBorder(),
                                    )),
                                TextFormField(
                                    controller: context
                                        .read<LeadNewController>()
                                        .mycontroller[25],
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
                                      border: UnderlineInputBorder(),
                                      // enabledBorder: UnderlineInputBorder(),
                                      // focusedBorder: UnderlineInputBorder(),
                                      errorBorder: UnderlineInputBorder(),
                                      focusedErrorBorder:
                                          UnderlineInputBorder(),
                                    )),

                                SizedBox(
                                  height: Screens.bodyheight(context) * 0.01,
                                ),
                              ],
                            ),
                          ),
                          // Text("Mobile"),

                          //Vip tags
                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     Row(
                          //       mainAxisAlignment:
                          //           MainAxisAlignment.spaceBetween,
                          //       children: [
                          //         InkWell(
                          //           onTap: () {
                          //             context
                          //                 .read<LeadNewController>()
                          //                 .selectCsTag("Corporate");
                          //           },
                          //           child: Container(
                          //             width: Screens.width(context) * 0.2,
                          //             height:
                          //                 Screens.bodyheight(context) * 0.05,
                          //             //  padding: EdgeInsets.all(10),
                          //             decoration: BoxDecoration(
                          //                 color: context
                          //                             .watch<
                          //                                 LeadNewController>()
                          //                             .getisSelectedCsTag ==
                          //                         'Corporate'
                          //                     ? theme.primaryColor
                          //                     : Colors.white,
                          //                 border: Border.all(
                          //                     color: theme.primaryColor,
                          //                     width: 1),
                          //                 borderRadius:
                          //                     BorderRadius.circular(10)),
                          //             child: Column(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.center,
                          //               children: [
                          //                 Text("Corporate",
                          //                     maxLines: 8,
                          //                     overflow: TextOverflow.ellipsis,
                          //                     style: theme.textTheme.bodyText2
                          //                         ?.copyWith(
                          //                       fontSize: 12,
                          //                       color: context
                          //                                   .watch<
                          //                                       LeadNewController>()
                          //                                   .getisSelectedCsTag ==
                          //                               "Corporate"
                          //                           ? Colors.white
                          //                           : theme.primaryColor,
                          //                     ))
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //         InkWell(
                          //           onTap: () {
                          //             context
                          //                 .read<LeadNewController>()
                          //                 .selectCsTag("Doctor");
                          //           },
                          //           child: Container(
                          //             width: Screens.width(context) * 0.2,
                          //             height:
                          //                 Screens.bodyheight(context) * 0.05,
                          //             //  padding: EdgeInsets.all(10),
                          //             decoration: BoxDecoration(
                          //                 color: context
                          //                             .watch<
                          //                                 LeadNewController>()
                          //                             .getisSelectedCsTag ==
                          //                         'Doctor'
                          //                     ? theme.primaryColor
                          //                     : Colors.white,
                          //                 border: Border.all(
                          //                     color: theme.primaryColor,
                          //                     width: 1),
                          //                 borderRadius:
                          //                     BorderRadius.circular(10)),
                          //             child: Column(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.center,
                          //               children: [
                          //                 Text("Doctor",
                          //                     maxLines: 8,
                          //                     overflow: TextOverflow.ellipsis,
                          //                     style: theme.textTheme.bodyText1
                          //                         ?.copyWith(
                          //                       fontSize: 12,
                          //                       color: context
                          //                                   .watch<
                          //                                       LeadNewController>()
                          //                                   .getisSelectedCsTag ==
                          //                               "Doctor"
                          //                           ? Colors.white
                          //                           : theme.primaryColor,
                          //                     ))
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //         InkWell(
                          //           onTap: () {
                          //             context
                          //                 .read<LeadNewController>()
                          //                 .selectCsTag("Govt");
                          //           },
                          //           child: Container(
                          //             width: Screens.width(context) * 0.2,
                          //             height:
                          //                 Screens.bodyheight(context) * 0.05,
                          //             //  padding: EdgeInsets.all(10),
                          //             decoration: BoxDecoration(
                          //                 color: context
                          //                             .watch<
                          //                                 LeadNewController>()
                          //                             .getisSelectedCsTag ==
                          //                         'Govt'
                          //                     ? theme.primaryColor
                          //                     : Colors.white,
                          //                 border: Border.all(
                          //                     color: theme.primaryColor,
                          //                     width: 1),
                          //                 borderRadius:
                          //                     BorderRadius.circular(10)),
                          //             child: Column(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.center,
                          //               children: [
                          //                 Text("Govt",
                          //                     maxLines: 8,
                          //                     overflow: TextOverflow.ellipsis,
                          //                     style: theme.textTheme.bodyText1
                          //                         ?.copyWith(
                          //                       fontSize: 12,
                          //                       color: context
                          //                                   .watch<
                          //                                       LeadNewController>()
                          //                                   .getisSelectedCsTag ==
                          //                               "Govt"
                          //                           ? Colors.white
                          //                           : theme.primaryColor,
                          //                     ))
                          //               ],
                          //             ),
                          //           ),
                          //         ),

                          //         //
                          //         InkWell(
                          //           onTap: () {
                          //             context
                          //                 .read<LeadNewController>()
                          //                 .selectCsTag("Student");
                          //           },
                          //           child: Container(
                          //             width: Screens.width(context) * 0.2,
                          //             height:
                          //                 Screens.bodyheight(context) * 0.05,
                          //             //  padding: EdgeInsets.all(10),
                          //             decoration: BoxDecoration(
                          //                 color: context
                          //                             .watch<
                          //                                 LeadNewController>()
                          //                             .getisSelectedCsTag ==
                          //                         'Student'
                          //                     ? theme.primaryColor
                          //                     : Colors.white,
                          //                 border: Border.all(
                          //                     color: theme.primaryColor,
                          //                     width: 1),
                          //                 borderRadius:
                          //                     BorderRadius.circular(10)),
                          //             child: Column(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.center,
                          //               children: [
                          //                 Text("Student",
                          //                     maxLines: 8,
                          //                     overflow: TextOverflow.ellipsis,
                          //                     style: theme.textTheme.bodyText1
                          //                         ?.copyWith(
                          //                       fontSize: 12,
                          //                       color: context
                          //                                   .watch<
                          //                                       LeadNewController>()
                          //                                   .getisSelectedCsTag ==
                          //                               "Student"
                          //                           ? Colors.white
                          //                           : theme.primaryColor,
                          //                     ))
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //     SizedBox(
                          //       height: Screens.bodyheight(context) * 0.01,
                          //     ),
                          //     Row(
                          //       mainAxisAlignment:
                          //           MainAxisAlignment.spaceEvenly,
                          //       children: [
                          //         InkWell(
                          //           onTap: () {
                          //             context
                          //                 .read<LeadNewController>()
                          //                 .selectCsTag("Police/Army");
                          //           },
                          //           child: Container(
                          //             width: Screens.width(context) * 0.25,
                          //             height:
                          //                 Screens.bodyheight(context) * 0.05,
                          //             //  padding: EdgeInsets.all(10),
                          //             decoration: BoxDecoration(
                          //                 color: context
                          //                             .watch<
                          //                                 LeadNewController>()
                          //                             .getisSelectedCsTag ==
                          //                         'Police/Army'
                          //                     ? theme.primaryColor
                          //                     : Colors.white,
                          //                 border: Border.all(
                          //                     color: theme.primaryColor,
                          //                     width: 1),
                          //                 borderRadius:
                          //                     BorderRadius.circular(10)),
                          //             child: Column(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.center,
                          //               children: [
                          //                 Text("Police/Army",
                          //                     maxLines: 8,
                          //                     overflow: TextOverflow.ellipsis,
                          //                     style: theme.textTheme.bodyText1
                          //                         ?.copyWith(
                          //                       fontSize: 12,
                          //                       color: context
                          //                                   .watch<
                          //                                       LeadNewController>()
                          //                                   .getisSelectedCsTag ==
                          //                               "Police/Army"
                          //                           ? Colors.white
                          //                           : theme.primaryColor,
                          //                     ))
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //         InkWell(
                          //           onTap: () {
                          //             context
                          //                 .read<LeadNewController>()
                          //                 .selectCsTag("Advocate");
                          //           },
                          //           child: Container(
                          //             width: Screens.width(context) * 0.2,
                          //             height:
                          //                 Screens.bodyheight(context) * 0.05,
                          //             //  padding: EdgeInsets.all(10),
                          //             decoration: BoxDecoration(
                          //                 color: context
                          //                             .watch<
                          //                                 LeadNewController>()
                          //                             .getisSelectedCsTag ==
                          //                         'Advocate'
                          //                     ? theme.primaryColor
                          //                     : Colors.white,
                          //                 border: Border.all(
                          //                     color: theme.primaryColor,
                          //                     width: 1),
                          //                 borderRadius:
                          //                     BorderRadius.circular(10)),
                          //             child: Column(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.center,
                          //               children: [
                          //                 Text("Advocate",
                          //                     maxLines: 8,
                          //                     overflow: TextOverflow.ellipsis,
                          //                     style: theme.textTheme.bodyText1
                          //                         ?.copyWith(
                          //                       fontSize: 12,
                          //                       color: context
                          //                                   .watch<
                          //                                       LeadNewController>()
                          //                                   .getisSelectedCsTag ==
                          //                               "Advocate"
                          //                           ? Colors.white
                          //                           : theme.primaryColor,
                          //                     ))
                          //               ],
                          //             ),
                          //           ),
                          //         ),

                          //         ///
                          //         InkWell(
                          //           onTap: () {
                          //             context
                          //                 .read<LeadNewController>()
                          //                 .selectCsTag("Celebrity");
                          //           },
                          //           child: Container(
                          //             width: Screens.width(context) * 0.2,
                          //             height:
                          //                 Screens.bodyheight(context) * 0.05,
                          //             //  padding: EdgeInsets.all(10),
                          //             decoration: BoxDecoration(
                          //                 color: context
                          //                             .watch<
                          //                                 LeadNewController>()
                          //                             .getisSelectedCsTag ==
                          //                         'Celebrity'
                          //                     ? theme.primaryColor
                          //                     : Colors.white,
                          //                 border: Border.all(
                          //                     color: theme.primaryColor,
                          //                     width: 1),
                          //                 borderRadius:
                          //                     BorderRadius.circular(10)),
                          //             child: Column(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.center,
                          //               children: [
                          //                 Text("Celebrity",
                          //                     maxLines: 8,
                          //                     overflow: TextOverflow.ellipsis,
                          //                     style: theme.textTheme.bodyText1
                          //                         ?.copyWith(
                          //                       fontSize: 12,
                          //                       color: context
                          //                                   .watch<
                          //                                       LeadNewController>()
                          //                                   .getisSelectedCsTag ==
                          //                               "Celebrity"
                          //                           ? Colors.white
                          //                           : theme.primaryColor,
                          //                     ))
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //     SizedBox(
                          //       height: Screens.bodyheight(context) * 0.01,
                          //     ),
                          //   ],
                          // ),
                          //

                          SizedBox(
                            height: Screens.bodyheight(context) * 0.015,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: Screens.width(context) * 0.03,
                                vertical: Screens.bodyheight(context) * 0.008),
                            width: Screens.width(context),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: theme.primaryColor)),
                            child: Column(
                              children: [
                                Container(
                                  width: Screens.width(context),
                                  child: Text(
                                    "Billing Address",
                                    style: theme.textTheme.headline6
                                        ?.copyWith(color: theme.primaryColor),
                                  ),
                                ),
                                TextFormField(
                                    controller: context
                                        .read<LeadNewController>()
                                        .mycontroller[2],
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Enter Address1";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Address1',
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
                                      border: UnderlineInputBorder(),
                                      // enabledBorder: UnderlineInputBorder(),
                                      // focusedBorder: UnderlineInputBorder(),
                                      errorBorder: UnderlineInputBorder(),
                                      focusedErrorBorder:
                                          UnderlineInputBorder(),
                                    )),
                                // SizedBox(
                                //   height: Screens.bodyheight(context) * 0.01,
                                // ),
                                TextFormField(
                                    controller: context
                                        .read<LeadNewController>()
                                        .mycontroller[3],
                                    // validator: (value) {
                                    //   if (value!.isEmpty) {
                                    //     return "Enter Address2";
                                    //   }
                                    //   return null;
                                    // },
                                    decoration: InputDecoration(
                                      labelText: 'Address2',
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
                                      border: UnderlineInputBorder(),
                                      // enabledBorder: UnderlineInputBorder(),
                                      // focusedBorder: UnderlineInputBorder(),
                                      errorBorder: UnderlineInputBorder(),
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
                                      width: Screens.width(context) * 0.4,
                                      child: TextFormField(
                                          controller: context
                                              .read<LeadNewController>()
                                              .mycontroller[17],
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Enter Area";
                                            }
                                            return null;
                                          },
                                          onTap: () {
                                            setState(() {
                                              context
                                                  .read<LeadNewController>()
                                                  .clearbool();
                                            });
                                          },
                                          onChanged: (v) {
                                            setState(() {
                                              context
                                                  .read<LeadNewController>()
                                                  .filterListArea(v);
                                              if (v.isEmpty) {
                                                context
                                                    .read<LeadNewController>()
                                                    .areabool = false;
                                              } else {
                                                context
                                                    .read<LeadNewController>()
                                                    .areabool = true;
                                              }
                                            });
                                          },
                                          decoration: InputDecoration(
                                            labelText: 'Area',
                                            border: UnderlineInputBorder(),
                                            labelStyle: theme
                                                .textTheme.bodyText1!
                                                .copyWith(color: Colors.grey),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                              //  when the TextFormField in unfocused
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                              //  when the TextFormField in focused
                                            ),
                                            errorBorder: UnderlineInputBorder(),
                                            focusedErrorBorder:
                                                UnderlineInputBorder(),
                                          )),
                                    ),
                                    SizedBox(
                                      width: Screens.width(context) * 0.4,
                                      child: TextFormField(
                                          controller: context
                                              .read<LeadNewController>()
                                              .mycontroller[5],
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Enter City";
                                            }
                                            return null;
                                          },
                                          onTap: () {
                                            setState(() {
                                              context
                                                  .read<LeadNewController>()
                                                  .clearbool();
                                            });
                                          },
                                          onChanged: (v) {
                                            setState(() {
                                              context
                                                  .read<LeadNewController>()
                                                  .filterListCity(v);
                                              if (v.isEmpty) {
                                                context
                                                    .read<LeadNewController>()
                                                    .citybool = false;
                                              } else {
                                                context
                                                    .read<LeadNewController>()
                                                    .citybool = true;
                                              }
                                            });
                                          },
                                          decoration: InputDecoration(
                                            labelText: 'City',
                                            border: UnderlineInputBorder(),
                                            labelStyle: theme
                                                .textTheme.bodyText1!
                                                .copyWith(color: Colors.grey),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                              //  when the TextFormField in unfocused
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                              //  when the TextFormField in focused
                                            ),
                                            errorBorder: UnderlineInputBorder(),
                                            focusedErrorBorder:
                                                UnderlineInputBorder(),
                                          )),
                                    ),
                                  ],
                                ),
                                Visibility(
                                  visible: context
                                      .read<LeadNewController>()
                                      .areabool,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height:
                                            Screens.bodyheight(context) * 0.01,
                                      ),
                                      context
                                              .read<LeadNewController>()
                                              .filterexistCusDataList
                                              .isEmpty
                                          ? Container()
                                          : Container(

                                              // color: Colors.amber,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                      color:
                                                          theme.primaryColor)),
                                              width: Screens.width(context),
                                              height:
                                                  Screens.bodyheight(context) *
                                                      0.2,
                                              child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount: context
                                                      .read<LeadNewController>()
                                                      .filterexistCusDataList
                                                      .length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int i) {
                                                    return InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          context
                                                              .read<
                                                                  LeadNewController>()
                                                              .areabool = false;
                                                          context
                                                                  .read<
                                                                      LeadNewController>()
                                                                  .mycontroller[17]
                                                                  .text =
                                                              context
                                                                  .read<
                                                                      LeadNewController>()
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
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            // color: Colors.red,
                                                            height: Screens
                                                                    .bodyheight(
                                                                        context) *
                                                                0.05,
                                                            width:
                                                                Screens.width(
                                                                    context),
                                                            child: Text(
                                                              "${context.watch<LeadNewController>().filterexistCusDataList[i].U_Area}",
                                                              style: theme
                                                                  .textTheme
                                                                  .bodyText1
                                                                  ?.copyWith(
                                                                      color: Colors
                                                                          .black),
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
                                  visible: context
                                      .read<LeadNewController>()
                                      .citybool,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height:
                                            Screens.bodyheight(context) * 0.01,
                                      ),
                                      context
                                              .read<LeadNewController>()
                                              .filterexistCusDataList
                                              .isEmpty
                                          ? Container()
                                          : Container(

                                              // color: Colors.amber,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                      color:
                                                          theme.primaryColor)),
                                              width: Screens.width(context),
                                              height:
                                                  Screens.bodyheight(context) *
                                                      0.2,
                                              child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount: context
                                                      .read<LeadNewController>()
                                                      .filterexistCusDataList
                                                      .length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int i) {
                                                    return InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          context.read<
                                                              LeadNewController>();

                                                          context
                                                              .read<
                                                                  LeadNewController>()
                                                              .citybool = false;
                                                          context
                                                                  .read<
                                                                      LeadNewController>()
                                                                  .mycontroller[5]
                                                                  .text =
                                                              context
                                                                  .read<
                                                                      LeadNewController>()
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
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            // color: Colors.red,
                                                            height: Screens
                                                                    .bodyheight(
                                                                        context) *
                                                                0.05,
                                                            width:
                                                                Screens.width(
                                                                    context),
                                                            child: Text(
                                                              "${context.watch<LeadNewController>().filterexistCusDataList[i].U_City}",
                                                              style: theme
                                                                  .textTheme
                                                                  .bodyText1
                                                                  ?.copyWith(
                                                                      color: Colors
                                                                          .black),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: Screens.width(context) * 0.4,
                                      child: TextFormField(
                                          controller: context
                                              .read<LeadNewController>()
                                              .mycontroller[4],
                                          onTap: () {
                                            setState(() {
                                              context
                                                  .read<LeadNewController>()
                                                  .clearbool();
                                            });
                                          },
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Enter Pincode";
                                            }
                                            return null;
                                          },
                                          onChanged: (v) {
                                            setState(() {
                                              context
                                                  .read<LeadNewController>()
                                                  .filterListPincode(v);
                                              if (v.isEmpty) {
                                                context
                                                    .read<LeadNewController>()
                                                    .pincodebool = false;
                                              } else {
                                                context
                                                    .read<LeadNewController>()
                                                    .pincodebool = true;
                                              }
                                            });
                                          },
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            new LengthLimitingTextInputFormatter(
                                                6),
                                          ],
                                          decoration: InputDecoration(
                                            labelText: 'Pincode',
                                            border: UnderlineInputBorder(),
                                            labelStyle: theme
                                                .textTheme.bodyText1!
                                                .copyWith(color: Colors.grey),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                              //  when the TextFormField in unfocused
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                              //  when the TextFormField in focused
                                            ),
                                            errorBorder: UnderlineInputBorder(),
                                            focusedErrorBorder:
                                                UnderlineInputBorder(),
                                          )),
                                    ),
                                    SizedBox(
                                      width: Screens.width(context) * 0.4,
                                      child: TextFormField(
                                          controller: context
                                              .read<LeadNewController>()
                                              .mycontroller[18],
                                          onTap: () {
                                            setState(() {
                                              context
                                                  .read<LeadNewController>()
                                                  .clearbool();
                                            });
                                          },
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Enter State";
                                            }
                                            return null;
                                          },
                                          onChanged: (v) {
                                            setState(() {
                                              context
                                                  .read<LeadNewController>()
                                                  .filterListState(v);
                                              if (v.isEmpty) {
                                                context
                                                    .read<LeadNewController>()
                                                    .statebool = false;
                                              } else {
                                                context
                                                    .read<LeadNewController>()
                                                    .statebool = true;
                                              }
                                            });
                                          },
                                          decoration: InputDecoration(
                                            labelText: 'State',
                                            border: UnderlineInputBorder(),
                                            labelStyle: theme
                                                .textTheme.bodyText1!
                                                .copyWith(color: Colors.grey),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                              //  when the TextFormField in unfocused
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                              //  when the TextFormField in focused
                                            ),
                                            errorBorder: UnderlineInputBorder(),
                                            focusedErrorBorder:
                                                UnderlineInputBorder(),
                                          )),
                                    ),
                                  ],
                                ),
                                Visibility(
                                  visible: context
                                      .read<LeadNewController>()
                                      .pincodebool,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height:
                                            Screens.bodyheight(context) * 0.01,
                                      ),
                                      context
                                              .read<LeadNewController>()
                                              .filterexistCusDataList
                                              .isEmpty
                                          ? Container()
                                          : Container(

                                              // color: Colors.amber,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                      color:
                                                          theme.primaryColor)),
                                              width: Screens.width(context),
                                              height:
                                                  Screens.bodyheight(context) *
                                                      0.2,
                                              child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount: context
                                                      .read<LeadNewController>()
                                                      .filterexistCusDataList
                                                      .length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int i) {
                                                    return InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          context
                                                              .read<
                                                                  LeadNewController>()
                                                              .pincodebool = false;
                                                          context.read<
                                                              LeadNewController>();

                                                          context
                                                                  .read<
                                                                      LeadNewController>()
                                                                  .mycontroller[4]
                                                                  .text =
                                                              context
                                                                  .read<
                                                                      LeadNewController>()
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
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            // color: Colors.red,
                                                            height: Screens
                                                                    .bodyheight(
                                                                        context) *
                                                                0.05,
                                                            width:
                                                                Screens.width(
                                                                    context),
                                                            child: Text(
                                                              "${context.watch<LeadNewController>().filterexistCusDataList[i].U_Pincode}",
                                                              style: theme
                                                                  .textTheme
                                                                  .bodyText1
                                                                  ?.copyWith(
                                                                      color: Colors
                                                                          .black),
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
                                  visible: context
                                      .read<LeadNewController>()
                                      .statebool,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height:
                                            Screens.bodyheight(context) * 0.01,
                                      ),
                                      context
                                              .read<LeadNewController>()
                                              .filterexistCusDataList
                                              .isEmpty
                                          ? Container()
                                          : Container(

                                              // color: Colors.amber,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                      color:
                                                          theme.primaryColor)),
                                              width: Screens.width(context),
                                              height:
                                                  Screens.bodyheight(context) *
                                                      0.2,
                                              child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount: context
                                                      .read<LeadNewController>()
                                                      .filterexistCusDataList
                                                      .length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int i) {
                                                    return InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          context.read<
                                                              LeadNewController>();

                                                          context
                                                              .read<
                                                                  LeadNewController>()
                                                              .statebool = false;
                                                          context
                                                                  .read<
                                                                      LeadNewController>()
                                                                  .mycontroller[18]
                                                                  .text =
                                                              context
                                                                  .read<
                                                                      LeadNewController>()
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
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            // color: Colors.red,
                                                            height: Screens
                                                                    .bodyheight(
                                                                        context) *
                                                                0.05,
                                                            width:
                                                                Screens.width(
                                                                    context),
                                                            child: Text(
                                                              "${context.watch<LeadNewController>().filterexistCusDataList[i].U_State}",
                                                              style: theme
                                                                  .textTheme
                                                                  .bodyText1
                                                                  ?.copyWith(
                                                                      color: Colors
                                                                          .black),
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
                                SizedBox(
                                  height: Screens.bodyheight(context) * 0.01,
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: Screens.bodyheight(context) * 0.015,
                          ),
//Ship
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: Screens.width(context) * 0.03,
                                vertical: Screens.bodyheight(context) * 0.008),
                            width: Screens.width(context),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: theme.primaryColor)),
                            child: Column(
                              children: [
                                Container(
                                  height: Screens.bodyheight(context) * 0.04,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: Screens.width(context) * 0.5,
                                        child: Text(
                                          "Shipping Address",
                                          style: theme.textTheme.headline6
                                              ?.copyWith(
                                                  color: theme.primaryColor),
                                        ),
                                      ),
                                      Checkbox(
                                        value: context
                                            .read<LeadNewController>()
                                            .value,
                                        onChanged: (value) {
                                          setState(() {
                                            context
                                                .read<LeadNewController>()
                                                .converttoShipping(value!);
                                            context
                                                .read<LeadNewController>()
                                                .value = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                TextFormField(
                                    controller: context
                                        .read<LeadNewController>()
                                        .mycontroller[19],
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
                                      focusedErrorBorder:
                                          UnderlineInputBorder(),
                                    )),
                                // SizedBox(
                                //   height: Screens.bodyheight(context) * 0.005,
                                // ),
                                TextFormField(
                                    controller: context
                                        .read<LeadNewController>()
                                        .mycontroller[20],
                                    // validator: (value) {
                                    //   if (value!.isEmpty) {
                                    //     return "Enter Address2";
                                    //   }
                                    //   return null;
                                    // },
                                    decoration: InputDecoration(
                                      labelText: 'Address2',
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
                                      width: Screens.width(context) * 0.4,
                                      child: TextFormField(
                                          controller: context
                                              .read<LeadNewController>()
                                              .mycontroller[21],
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Enter Area";
                                            }
                                            return null;
                                          },
                                          onTap: () {
                                            setState(() {
                                              context
                                                  .read<LeadNewController>()
                                                  .clearbool();
                                            });
                                          },
                                          onChanged: (v) {
                                            setState(() {
                                              context
                                                  .read<LeadNewController>()
                                                  .filterListArea(v);
                                              if (v.isEmpty) {
                                                context
                                                    .read<LeadNewController>()
                                                    .areabool = false;
                                              } else {
                                                context
                                                    .read<LeadNewController>()
                                                    .areabool = true;
                                              }
                                            });
                                          },
                                          decoration: InputDecoration(
                                            labelText: 'Area',
                                            border: UnderlineInputBorder(),
                                            labelStyle: theme
                                                .textTheme.bodyText1!
                                                .copyWith(color: Colors.grey),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                              //  when the TextFormField in unfocused
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                              //  when the TextFormField in focused
                                            ),
                                            errorBorder: UnderlineInputBorder(),
                                            focusedErrorBorder:
                                                UnderlineInputBorder(),
                                          )),
                                    ),
                                    SizedBox(
                                      width: Screens.width(context) * 0.4,
                                      child: TextFormField(
                                          controller: context
                                              .read<LeadNewController>()
                                              .mycontroller[22],
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Enter City";
                                            }
                                            return null;
                                          },
                                          onTap: () {
                                            setState(() {
                                              context
                                                  .read<LeadNewController>()
                                                  .clearbool();
                                            });
                                          },
                                          onChanged: (v) {
                                            setState(() {
                                              context
                                                  .read<LeadNewController>()
                                                  .filterListCity(v);
                                              if (v.isEmpty) {
                                                context
                                                    .read<LeadNewController>()
                                                    .citybool = false;
                                              } else {
                                                context
                                                    .read<LeadNewController>()
                                                    .citybool = true;
                                              }
                                            });
                                          },
                                          decoration: InputDecoration(
                                            labelText: 'City',
                                            border: UnderlineInputBorder(),
                                            labelStyle: theme
                                                .textTheme.bodyText1!
                                                .copyWith(color: Colors.grey),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                              //  when the TextFormField in unfocused
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                              //  when the TextFormField in focused
                                            ),
                                            errorBorder: UnderlineInputBorder(),
                                            focusedErrorBorder:
                                                UnderlineInputBorder(),
                                          )),
                                    ),
                                  ],
                                ),
                                Visibility(
                                  visible: context
                                      .read<LeadNewController>()
                                      .areabool,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height:
                                            Screens.bodyheight(context) * 0.01,
                                      ),
                                      context
                                              .read<LeadNewController>()
                                              .filterexistCusDataList
                                              .isEmpty
                                          ? Container()
                                          : Container(

                                              // color: Colors.amber,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                      color:
                                                          theme.primaryColor)),
                                              width: Screens.width(context),
                                              height:
                                                  Screens.bodyheight(context) *
                                                      0.2,
                                              child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount: context
                                                      .read<LeadNewController>()
                                                      .filterexistCusDataList
                                                      .length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int i) {
                                                    return InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          context
                                                              .read<
                                                                  LeadNewController>()
                                                              .areabool = false;
                                                          context
                                                                  .read<
                                                                      LeadNewController>()
                                                                  .mycontroller[21]
                                                                  .text =
                                                              context
                                                                  .read<
                                                                      LeadNewController>()
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
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            // color: Colors.red,
                                                            height: Screens
                                                                    .bodyheight(
                                                                        context) *
                                                                0.05,
                                                            width:
                                                                Screens.width(
                                                                    context),
                                                            child: Text(
                                                              "${context.watch<LeadNewController>().filterexistCusDataList[i].U_Area}",
                                                              style: theme
                                                                  .textTheme
                                                                  .bodyText1
                                                                  ?.copyWith(
                                                                      color: Colors
                                                                          .black),
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
                                  visible: context
                                      .read<LeadNewController>()
                                      .citybool,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height:
                                            Screens.bodyheight(context) * 0.01,
                                      ),
                                      context
                                              .read<LeadNewController>()
                                              .filterexistCusDataList
                                              .isEmpty
                                          ? Container()
                                          : Container(

                                              // color: Colors.amber,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                      color:
                                                          theme.primaryColor)),
                                              width: Screens.width(context),
                                              height:
                                                  Screens.bodyheight(context) *
                                                      0.2,
                                              child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount: context
                                                      .read<LeadNewController>()
                                                      .filterexistCusDataList
                                                      .length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int i) {
                                                    return InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          context.read<
                                                              LeadNewController>();

                                                          context
                                                              .read<
                                                                  LeadNewController>()
                                                              .citybool = false;
                                                          context
                                                                  .read<
                                                                      LeadNewController>()
                                                                  .mycontroller[22]
                                                                  .text =
                                                              context
                                                                  .read<
                                                                      LeadNewController>()
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
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            // color: Colors.red,
                                                            height: Screens
                                                                    .bodyheight(
                                                                        context) *
                                                                0.05,
                                                            width:
                                                                Screens.width(
                                                                    context),
                                                            child: Text(
                                                              "${context.watch<LeadNewController>().filterexistCusDataList[i].U_City}",
                                                              style: theme
                                                                  .textTheme
                                                                  .bodyText1
                                                                  ?.copyWith(
                                                                      color: Colors
                                                                          .black),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: Screens.width(context) * 0.4,
                                      child: TextFormField(
                                          controller: context
                                              .read<LeadNewController>()
                                              .mycontroller[23],
                                          onTap: () {
                                            setState(() {
                                              context
                                                  .read<LeadNewController>()
                                                  .clearbool();
                                            });
                                          },
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Enter Pincode";
                                            }
                                            return null;
                                          },
                                          onChanged: (v) {
                                            setState(() {
                                              context
                                                  .read<LeadNewController>()
                                                  .filterListPincode(v);
                                              if (v.isEmpty) {
                                                context
                                                    .read<LeadNewController>()
                                                    .pincodebool = false;
                                              } else {
                                                context
                                                    .read<LeadNewController>()
                                                    .pincodebool = true;
                                              }
                                            });
                                          },
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            new LengthLimitingTextInputFormatter(
                                                6),
                                          ],
                                          decoration: InputDecoration(
                                            labelText: 'Pincode',
                                            border: UnderlineInputBorder(),
                                            labelStyle: theme
                                                .textTheme.bodyText1!
                                                .copyWith(color: Colors.grey),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                              //  when the TextFormField in unfocused
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                              //  when the TextFormField in focused
                                            ),
                                            errorBorder: UnderlineInputBorder(),
                                            focusedErrorBorder:
                                                UnderlineInputBorder(),
                                          )),
                                    ),
                                    SizedBox(
                                      width: Screens.width(context) * 0.4,
                                      child: TextFormField(
                                          controller: context
                                              .read<LeadNewController>()
                                              .mycontroller[24],
                                          onTap: () {
                                            setState(() {
                                              context
                                                  .read<LeadNewController>()
                                                  .clearbool();
                                            });
                                          },
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Enter State";
                                            }
                                            return null;
                                          },
                                          onChanged: (v) {
                                            setState(() {
                                              context
                                                  .read<LeadNewController>()
                                                  .filterListState(v);
                                              if (v.isEmpty) {
                                                context
                                                    .read<LeadNewController>()
                                                    .statebool = false;
                                              } else {
                                                context
                                                    .read<LeadNewController>()
                                                    .statebool = true;
                                              }
                                            });
                                          },
                                          decoration: InputDecoration(
                                            labelText: 'State',
                                            border: UnderlineInputBorder(),
                                            labelStyle: theme
                                                .textTheme.bodyText1!
                                                .copyWith(color: Colors.grey),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                              //  when the TextFormField in unfocused
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                              //  when the TextFormField in focused
                                            ),
                                            errorBorder: UnderlineInputBorder(),
                                            focusedErrorBorder:
                                                UnderlineInputBorder(),
                                          )),
                                    ),
                                  ],
                                ),
                                Visibility(
                                  visible: context
                                      .read<LeadNewController>()
                                      .pincodebool,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height:
                                            Screens.bodyheight(context) * 0.01,
                                      ),
                                      context
                                              .read<LeadNewController>()
                                              .filterexistCusDataList
                                              .isEmpty
                                          ? Container()
                                          : Container(

                                              // color: Colors.amber,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                      color:
                                                          theme.primaryColor)),
                                              width: Screens.width(context),
                                              height:
                                                  Screens.bodyheight(context) *
                                                      0.2,
                                              child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount: context
                                                      .read<LeadNewController>()
                                                      .filterexistCusDataList
                                                      .length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int i) {
                                                    return InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          context
                                                              .read<
                                                                  LeadNewController>()
                                                              .pincodebool = false;
                                                          context.read<
                                                              LeadNewController>();

                                                          context
                                                                  .read<
                                                                      LeadNewController>()
                                                                  .mycontroller[23]
                                                                  .text =
                                                              context
                                                                  .read<
                                                                      LeadNewController>()
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
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            // color: Colors.red,
                                                            height: Screens
                                                                    .bodyheight(
                                                                        context) *
                                                                0.05,
                                                            width:
                                                                Screens.width(
                                                                    context),
                                                            child: Text(
                                                              "${context.watch<LeadNewController>().filterexistCusDataList[i].U_Pincode}",
                                                              style: theme
                                                                  .textTheme
                                                                  .bodyText1
                                                                  ?.copyWith(
                                                                      color: Colors
                                                                          .black),
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
                                  visible: context
                                      .read<LeadNewController>()
                                      .statebool,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height:
                                            Screens.bodyheight(context) * 0.01,
                                      ),
                                      context
                                              .read<LeadNewController>()
                                              .filterexistCusDataList
                                              .isEmpty
                                          ? Container()
                                          : Container(

                                              // color: Colors.amber,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                      color:
                                                          theme.primaryColor)),
                                              width: Screens.width(context),
                                              height:
                                                  Screens.bodyheight(context) *
                                                      0.2,
                                              child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount: context
                                                      .read<LeadNewController>()
                                                      .filterexistCusDataList
                                                      .length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int i) {
                                                    return InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          context.read<
                                                              LeadNewController>();

                                                          context
                                                              .read<
                                                                  LeadNewController>()
                                                              .statebool = false;
                                                          context
                                                                  .read<
                                                                      LeadNewController>()
                                                                  .mycontroller[24]
                                                                  .text =
                                                              context
                                                                  .read<
                                                                      LeadNewController>()
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
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            // color: Colors.red,
                                                            height: Screens
                                                                    .bodyheight(
                                                                        context) *
                                                                0.05,
                                                            width:
                                                                Screens.width(
                                                                    context),
                                                            child: Text(
                                                              "${context.watch<LeadNewController>().filterexistCusDataList[i].U_State}",
                                                              style: theme
                                                                  .textTheme
                                                                  .bodyText1
                                                                  ?.copyWith(
                                                                      color: Colors
                                                                          .black),
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
                                SizedBox(
                                  height: Screens.bodyheight(context) * 0.01,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Screens.bodyheight(context) * 0.02,
                          ),
                          // TextFormField(
                          //     controller: context
                          //         .read<LeadNewController>()
                          //         .mycontroller[8],
                          //     // validator: (value) {
                          //     //   if (value!.isEmpty) {
                          //     //     return "Enter Head Count";
                          //     //   }
                          //     //   return null;
                          //     // },
                          //     keyboardType: TextInputType.number,
                          //     decoration: InputDecoration(
                          //       hintText: 'Head Count',
                          //       border: UnderlineInputBorder(),
                          //       enabledBorder: UnderlineInputBorder(),
                          //       focusedBorder: UnderlineInputBorder(),
                          //       errorBorder: UnderlineInputBorder(),
                          //       focusedErrorBorder: UnderlineInputBorder(),
                          //     )),
                          // SizedBox(
                          //   height: Screens.bodyheight(context) * 0.005,
                          // ),
                          // TextFormField(
                          //     controller: context
                          //         .read<LeadNewController>()
                          //         .mycontroller[9],
                          //     // validator: (value) {
                          //     //   if (value!.isEmpty) {
                          //     //     return "Enter Max Budget";
                          //     //   }
                          //     //   return null;
                          //     // },
                          //     keyboardType: TextInputType.number,
                          //     decoration: InputDecoration(
                          //       hintText: 'Max Budget',
                          //       border: UnderlineInputBorder(),
                          //       enabledBorder: UnderlineInputBorder(),
                          //       focusedBorder: UnderlineInputBorder(),
                          //       errorBorder: UnderlineInputBorder(),
                          //       focusedErrorBorder: UnderlineInputBorder(),
                          //     )),
                          // SizedBox(
                          //   height: Screens.bodyheight(context) * 0.02,
                          // ),

                          // //Gender
                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     Text(
                          //       context
                          //                   .read<LeadNewController>()
                          //                   .validateGender ==
                          //               true
                          //           ? "Gender *"
                          //           : "Gender",
                          //       style: context
                          //                   .read<LeadNewController>()
                          //                   .validateGender ==
                          //               true
                          //           ? theme.textTheme.bodyText1
                          //               ?.copyWith(color: Colors.red)
                          //           : theme.textTheme.bodyText1,
                          //     ),
                          //     SizedBox(
                          //       height: Screens.bodyheight(context) * 0.01,
                          //     ),
                          //     Row(
                          //       mainAxisAlignment:
                          //           MainAxisAlignment.spaceBetween,
                          //       children: [
                          //         InkWell(
                          //           onTap: () {
                          //             context
                          //                 .read<LeadNewController>()
                          //                 .selectGender("Male");
                          //           },
                          //           child: Container(
                          //             width: Screens.width(context) * 0.29,
                          //             height:
                          //                 Screens.bodyheight(context) * 0.06,
                          //             //  padding: EdgeInsets.all(10),
                          //             decoration: BoxDecoration(
                          //                 color: context
                          //                             .watch<
                          //                                 LeadNewController>()
                          //                             .getisSelectedGender ==
                          //                         'Male'
                          //                     ? theme.primaryColor
                          //                     : Colors.white,
                          //                 border: Border.all(
                          //                     color: theme.primaryColor,
                          //                     width: 1),
                          //                 borderRadius:
                          //                     BorderRadius.circular(10)),
                          //             child: Column(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.center,
                          //               children: [
                          //                 Text("Male",
                          //                     maxLines: 8,
                          //                     overflow: TextOverflow.ellipsis,
                          //                     style: theme.textTheme.bodyText1
                          //                         ?.copyWith(
                          //                       color: context
                          //                                   .watch<
                          //                                       LeadNewController>()
                          //                                   .getisSelectedGender ==
                          //                               "Male"
                          //                           ? Colors.white
                          //                           : theme.primaryColor,
                          //                     ))
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //         InkWell(
                          //           onTap: () {
                          //             context
                          //                 .read<LeadNewController>()
                          //                 .selectGender("Female");
                          //           },
                          //           child: Container(
                          //             width: Screens.width(context) * 0.29,
                          //             height:
                          //                 Screens.bodyheight(context) * 0.06,
                          //             //  padding: EdgeInsets.all(10),
                          //             decoration: BoxDecoration(
                          //                 color: context
                          //                             .watch<
                          //                                 LeadNewController>()
                          //                             .getisSelectedGender ==
                          //                         'Female'
                          //                     ? theme.primaryColor
                          //                     : Colors.white,
                          //                 border: Border.all(
                          //                     color: theme.primaryColor,
                          //                     width: 1),
                          //                 borderRadius:
                          //                     BorderRadius.circular(10)),
                          //             child: Column(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.center,
                          //               children: [
                          //                 Text("Female",
                          //                     maxLines: 8,
                          //                     overflow: TextOverflow.ellipsis,
                          //                     style: theme.textTheme.bodyText1
                          //                         ?.copyWith(
                          //                       color: context
                          //                                   .watch<
                          //                                       LeadNewController>()
                          //                                   .getisSelectedGender ==
                          //                               "Female"
                          //                           ? Colors.white
                          //                           : theme.primaryColor,
                          //                     ))
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //         InkWell(
                          //           onTap: () {
                          //             context
                          //                 .read<LeadNewController>()
                          //                 .selectGender("Other");
                          //           },
                          //           child: Container(
                          //             width: Screens.width(context) * 0.29,
                          //             height:
                          //                 Screens.bodyheight(context) * 0.06,
                          //             //  padding: EdgeInsets.all(10),
                          //             decoration: BoxDecoration(
                          //                 color: context
                          //                             .watch<
                          //                                 LeadNewController>()
                          //                             .getisSelectedGender ==
                          //                         'Other'
                          //                     ? theme.primaryColor
                          //                     : Colors.white,
                          //                 border: Border.all(
                          //                     color: theme.primaryColor,
                          //                     width: 1),
                          //                 borderRadius:
                          //                     BorderRadius.circular(10)),
                          //             child: Column(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.center,
                          //               children: [
                          //                 Text("Other",
                          //                     maxLines: 8,
                          //                     overflow: TextOverflow.ellipsis,
                          //                     style: theme.textTheme.bodyText1
                          //                         ?.copyWith(
                          //                       color: context
                          //                                   .watch<
                          //                                       LeadNewController>()
                          //                                   .getisSelectedGender ==
                          //                               "Other"
                          //                           ? Colors.white
                          //                           : theme.primaryColor,
                          //                     ))
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ],
                          // ),

                          // //age group
                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     SizedBox(
                          //       height: Screens.bodyheight(context) * 0.03,
                          //     ),
                          //     Text(
                          //       context.read<LeadNewController>().validateAge ==
                          //               true
                          //           ? "Age Group *"
                          //           : "Age Group",
                          //       style: context
                          //                   .read<LeadNewController>()
                          //                   .validateAge ==
                          //               true
                          //           ? theme.textTheme.bodyText1
                          //               ?.copyWith(color: Colors.red)
                          //           : theme.textTheme.bodyText1,
                          //     ),
                          //     SizedBox(
                          //       height: Screens.bodyheight(context) * 0.01,
                          //     ),
                          //     Row(
                          //       mainAxisAlignment:
                          //           MainAxisAlignment.spaceBetween,
                          //       children: [
                          //         InkWell(
                          //           onTap: () {
                          //             context
                          //                 .read<LeadNewController>()
                          //                 .selectage("20-30");
                          //           },
                          //           child: Container(
                          //             width: Screens.width(context) * 0.29,
                          //             height:
                          //                 Screens.bodyheight(context) * 0.06,
                          //             //  padding: EdgeInsets.all(10),
                          //             decoration: BoxDecoration(
                          //                 color: context
                          //                             .watch<
                          //                                 LeadNewController>()
                          //                             .getisSelectedAge ==
                          //                         '20-30'
                          //                     ? theme.primaryColor
                          //                     : Colors.white,
                          //                 border: Border.all(
                          //                     color: theme.primaryColor,
                          //                     width: 1),
                          //                 borderRadius:
                          //                     BorderRadius.circular(10)),
                          //             child: Column(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.center,
                          //               children: [
                          //                 Text("20-30",
                          //                     maxLines: 8,
                          //                     overflow: TextOverflow.ellipsis,
                          //                     style: theme.textTheme.bodyText1
                          //                         ?.copyWith(
                          //                       color: context
                          //                                   .watch<
                          //                                       LeadNewController>()
                          //                                   .getisSelectedAge ==
                          //                               "20-30"
                          //                           ? Colors.white
                          //                           : theme.primaryColor,
                          //                     ))
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //         InkWell(
                          //           onTap: () {
                          //             context
                          //                 .read<LeadNewController>()
                          //                 .selectage("30-40");
                          //           },
                          //           child: Container(
                          //             width: Screens.width(context) * 0.29,
                          //             height:
                          //                 Screens.bodyheight(context) * 0.06,
                          //             //  padding: EdgeInsets.all(10),
                          //             decoration: BoxDecoration(
                          //                 color: context
                          //                             .watch<
                          //                                 LeadNewController>()
                          //                             .getisSelectedAge ==
                          //                         '30-40'
                          //                     ? theme.primaryColor
                          //                     : Colors.white,
                          //                 border: Border.all(
                          //                     color: theme.primaryColor,
                          //                     width: 1),
                          //                 borderRadius:
                          //                     BorderRadius.circular(10)),
                          //             child: Column(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.center,
                          //               children: [
                          //                 Text("30-40",
                          //                     maxLines: 8,
                          //                     overflow: TextOverflow.ellipsis,
                          //                     style: theme.textTheme.bodyText1
                          //                         ?.copyWith(
                          //                       color: context
                          //                                   .watch<
                          //                                       LeadNewController>()
                          //                                   .getisSelectedAge ==
                          //                               "30-40"
                          //                           ? Colors.white
                          //                           : theme.primaryColor,
                          //                     ))
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //         InkWell(
                          //           onTap: () {
                          //             context
                          //                 .read<LeadNewController>()
                          //                 .selectage("40-50");
                          //           },
                          //           child: Container(
                          //             width: Screens.width(context) * 0.29,
                          //             height:
                          //                 Screens.bodyheight(context) * 0.06,
                          //             //  padding: EdgeInsets.all(10),
                          //             decoration: BoxDecoration(
                          //                 color: context
                          //                             .watch<
                          //                                 LeadNewController>()
                          //                             .getisSelectedAge ==
                          //                         '40-50'
                          //                     ? theme.primaryColor
                          //                     : Colors.white,
                          //                 border: Border.all(
                          //                     color: theme.primaryColor,
                          //                     width: 1),
                          //                 borderRadius:
                          //                     BorderRadius.circular(10)),
                          //             child: Column(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.center,
                          //               children: [
                          //                 Text("40-50",
                          //                     maxLines: 8,
                          //                     overflow: TextOverflow.ellipsis,
                          //                     style: theme.textTheme.bodyText1
                          //                         ?.copyWith(
                          //                       color: context
                          //                                   .watch<
                          //                                       LeadNewController>()
                          //                                   .getisSelectedAge ==
                          //                               "40-50"
                          //                           ? Colors.white
                          //                           : theme.primaryColor,
                          //                     ))
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //     SizedBox(
                          //       height: Screens.bodyheight(context) * 0.01,
                          //     ),
                          //     InkWell(
                          //       onTap: () {
                          //         context
                          //             .read<LeadNewController>()
                          //             .selectage("50>");
                          //       },
                          //       child: Container(
                          //         width: Screens.width(context) * 0.29,
                          //         height: Screens.bodyheight(context) * 0.06,
                          //         //  padding: EdgeInsets.all(10),
                          //         decoration: BoxDecoration(
                          //             color: context
                          //                         .watch<LeadNewController>()
                          //                         .getisSelectedAge ==
                          //                     '50>'
                          //                 ? theme.primaryColor
                          //                 : Colors.white,
                          //             border: Border.all(
                          //                 color: theme.primaryColor, width: 1),
                          //             borderRadius: BorderRadius.circular(10)),
                          //         child: Column(
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //           children: [
                          //             Text("50>",
                          //                 maxLines: 8,
                          //                 overflow: TextOverflow.ellipsis,
                          //                 style: theme.textTheme.bodyText1
                          //                     ?.copyWith(
                          //                   color: context
                          //                               .watch<
                          //                                   LeadNewController>()
                          //                               .getisSelectedAge ==
                          //                           "50>"
                          //                       ? Colors.white
                          //                       : theme.primaryColor,
                          //                 ))
                          //           ],
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),

                          // //come with as
                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     SizedBox(
                          //       height: Screens.bodyheight(context) * 0.03,
                          //     ),
                          //     Text(
                          //       context
                          //                   .read<LeadNewController>()
                          //                   .validateComas ==
                          //               true
                          //           ? "Came as *"
                          //           : "Came as",
                          //       style: context
                          //                   .read<LeadNewController>()
                          //                   .validateComas ==
                          //               true
                          //           ? theme.textTheme.bodyText1
                          //               ?.copyWith(color: Colors.red)
                          //           : theme.textTheme.bodyText1,
                          //     ),
                          //     SizedBox(
                          //       height: Screens.bodyheight(context) * 0.01,
                          //     ),
                          //     Row(
                          //       mainAxisAlignment:
                          //           MainAxisAlignment.spaceBetween,
                          //       children: [
                          //         InkWell(
                          //           onTap: () {
                          //             context
                          //                 .read<LeadNewController>()
                          //                 .selectComeas("Family");
                          //           },
                          //           child: Container(
                          //             width: Screens.width(context) * 0.29,
                          //             height:
                          //                 Screens.bodyheight(context) * 0.06,
                          //             //  padding: EdgeInsets.all(10),
                          //             decoration: BoxDecoration(
                          //                 color: context
                          //                             .watch<
                          //                                 LeadNewController>()
                          //                             .getisSelectedcomeas ==
                          //                         'Family'
                          //                     ? theme.primaryColor
                          //                     : Colors.white,
                          //                 border: Border.all(
                          //                     color: theme.primaryColor,
                          //                     width: 1),
                          //                 borderRadius:
                          //                     BorderRadius.circular(10)),
                          //             child: Column(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.center,
                          //               children: [
                          //                 Text("Family",
                          //                     maxLines: 8,
                          //                     overflow: TextOverflow.ellipsis,
                          //                     style: theme.textTheme.bodyText1
                          //                         ?.copyWith(
                          //                       color: context
                          //                                   .watch<
                          //                                       LeadNewController>()
                          //                                   .getisSelectedcomeas ==
                          //                               "Family"
                          //                           ? Colors.white
                          //                           : theme.primaryColor,
                          //                     ))
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //         InkWell(
                          //           onTap: () {
                          //             context
                          //                 .read<LeadNewController>()
                          //                 .selectComeas("Individual");
                          //           },
                          //           child: Container(
                          //             width: Screens.width(context) * 0.29,
                          //             height:
                          //                 Screens.bodyheight(context) * 0.06,
                          //             //  padding: EdgeInsets.all(10),
                          //             decoration: BoxDecoration(
                          //                 color: context
                          //                             .watch<
                          //                                 LeadNewController>()
                          //                             .getisSelectedcomeas ==
                          //                         'Individual'
                          //                     ? theme.primaryColor
                          //                     : Colors.white,
                          //                 border: Border.all(
                          //                     color: theme.primaryColor,
                          //                     width: 1),
                          //                 borderRadius:
                          //                     BorderRadius.circular(10)),
                          //             child: Column(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.center,
                          //               children: [
                          //                 Text("Individual",
                          //                     maxLines: 8,
                          //                     overflow: TextOverflow.ellipsis,
                          //                     style: theme.textTheme.bodyText1
                          //                         ?.copyWith(
                          //                       color: context
                          //                                   .watch<
                          //                                       LeadNewController>()
                          //                                   .getisSelectedcomeas ==
                          //                               "Individual"
                          //                           ? Colors.white
                          //                           : theme.primaryColor,
                          //                     ))
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //         InkWell(
                          //           onTap: () {
                          //             context
                          //                 .read<LeadNewController>()
                          //                 .selectComeas("Friends");
                          //           },
                          //           child: Container(
                          //             width: Screens.width(context) * 0.29,
                          //             height:
                          //                 Screens.bodyheight(context) * 0.06,
                          //             //  padding: EdgeInsets.all(10),
                          //             decoration: BoxDecoration(
                          //                 color: context
                          //                             .watch<
                          //                                 LeadNewController>()
                          //                             .getisSelectedcomeas ==
                          //                         'Friends'
                          //                     ? theme.primaryColor
                          //                     : Colors.white,
                          //                 border: Border.all(
                          //                     color: theme.primaryColor,
                          //                     width: 1),
                          //                 borderRadius:
                          //                     BorderRadius.circular(10)),
                          //             child: Column(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.center,
                          //               children: [
                          //                 Text("Friends",
                          //                     maxLines: 8,
                          //                     overflow: TextOverflow.ellipsis,
                          //                     style: theme.textTheme.bodyText1
                          //                         ?.copyWith(
                          //                       color: context
                          //                                   .watch<
                          //                                       LeadNewController>()
                          //                                   .getisSelectedcomeas ==
                          //                               "Friends"
                          //                           ? Colors.white
                          //                           : theme.primaryColor,
                          //                     ))
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //     SizedBox(
                          //       height: Screens.bodyheight(context) * 0.01,
                          //     ),
                          //     InkWell(
                          //       onTap: () {
                          //         context
                          //             .read<LeadNewController>()
                          //             .selectComeas("Corporate");
                          //       },
                          //       child: Container(
                          //         width: Screens.width(context) * 0.29,
                          //         height: Screens.bodyheight(context) * 0.06,
                          //         //  padding: EdgeInsets.all(10),
                          //         decoration: BoxDecoration(
                          //             color: context
                          //                         .watch<LeadNewController>()
                          //                         .getisSelectedcomeas ==
                          //                     'Corporate'
                          //                 ? theme.primaryColor
                          //                 : Colors.white,
                          //             border: Border.all(
                          //                 color: theme.primaryColor, width: 1),
                          //             borderRadius: BorderRadius.circular(10)),
                          //         child: Column(
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //           children: [
                          //             Text("Corporate",
                          //                 maxLines: 8,
                          //                 overflow: TextOverflow.ellipsis,
                          //                 style: theme.textTheme.bodyText1
                          //                     ?.copyWith(
                          //                   color: context
                          //                               .watch<
                          //                                   LeadNewController>()
                          //                               .getisSelectedcomeas ==
                          //                           "Corporate"
                          //                       ? Colors.white
                          //                       : theme.primaryColor,
                          //                 ))
                          //           ],
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),

                          // //nextbtn
                          Align(
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              width: Screens.width(context) * 0.3,
                              height: Screens.bodyheight(context) * 0.07,
                              child: ElevatedButton(
                                  onPressed: () {
                                    // provi.pageController.animateToPage(++provi.pageChanged,
                                    //     duration: Duration(milliseconds: 250),
                                    //     curve: Curves.bounceIn);
                                    context
                                        .read<LeadNewController>()
                                        .firstPageNextBtn();
                                    log("oldcutomer: " +
                                        context
                                            .read<LeadNewController>()
                                            .oldcutomer
                                            .toString());
                                  },
                                  child: Icon(Icons.navigate_next)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
    );
    //       }
    //     );
    //   }
    // );
  }

  List<Widget> listContainersRefferes(
    ThemeData theme,
  ) {
    return List.generate(
      context.read<LeadNewController>().getenqReffList.length,
      (index) => InkWell(
        onTap: () {
          // context.read<NewEnqController>(). isSelectedenquirytype = context.read<NewEnqController>()
          // .getenqReffList[index].Name.toString();
          context.read<LeadNewController>().selectEnqReffers(
              context
                  .read<LeadNewController>()
                  .getenqReffList[index]
                  .Name
                  .toString(),
              context.read<LeadNewController>().getenqReffList[index].Name!);
        },
        child: Container(
          width: Screens.width(context) * 0.4,
          height: Screens.bodyheight(context) * 0.06,
          //  padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: context
                          .read<LeadNewController>()
                          .getisSelectedenquiryReffers ==
                      context
                          .read<LeadNewController>()
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
                      .read<LeadNewController>()
                      .getenqReffList[index]
                      .Name
                      .toString(),
                  maxLines: 8,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyText1?.copyWith(
                    color: context
                                .read<LeadNewController>()
                                .getisSelectedenquiryReffers ==
                            context
                                .read<LeadNewController>()
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

  List<Widget> listContainersCustomertags(
    ThemeData theme,
  ) {
    return List.generate(
      context.watch<LeadNewController>().getcusReffList.length,
      (index) => InkWell(
        onTap: () {
          // context.read<NewEnqController>(). isSelectedenquirytype = context.read<NewEnqController>()
          // .getenqReffList[index].Name.toString();
          context.read<LeadNewController>().selectEnqReffers(
              context
                  .read<LeadNewController>()
                  .getcusReffList[index]
                  .tagname
                  .toString(),
              context.read<LeadNewController>().getcusReffList[index].tagname!);
        },
        child: Container(
          width: Screens.width(context) * 0.2,
          height: Screens.bodyheight(context) * 0.05,
          //  padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: context
                          .watch<LeadNewController>()
                          .getisSelectedenquiryReffers ==
                      context
                          .read<LeadNewController>()
                          .getcusReffList[index]
                          .tagname
                          .toString()
                  ? Color(0xffB299A5) //theme.primaryColor.withOpacity(0.5)
                  : Colors.white,
              border: Border.all(color: theme.primaryColor, width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  context
                      .watch<LeadNewController>()
                      .getcusReffList[index]
                      .tagname
                      .toString(),
                  maxLines: 8,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyText1?.copyWith(
                    color: context
                                .watch<LeadNewController>()
                                .getisSelectedenquiryReffers ==
                            context
                                .read<LeadNewController>()
                                .getcusReffList[index]
                                .tagname
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
