// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sellerkit/Widgets/Appbar.dart';
import '../../../Constant/Screen.dart';
import '../../../Constant/padings.dart';
import '../../../Widgets/Navi3.dart';
import '../Widgets/SearchWidgets.dart';

class Challenges extends StatefulWidget {
  const Challenges({Key? key}) : super(key: key);

  @override
  State<Challenges> createState() => _ChallengesState();
}

class _ChallengesState extends State<Challenges> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Paddings paddings = Paddings();
  @override
  Widget build(BuildContext context) {
    final themes = Theme.of(context);
    return Scaffold(
        key: scaffoldKey,
        drawer: drawer3(context),
        appBar: appbar("Challenges",themes,context),
        body: Container(
          padding: paddings.padding2(context),
          child: Column(
            children: [
              SearchWidget(themes: themes),
              SizedBox(
                height: Screens.bodyheight(context) * 0.01,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int i) {
                    return AnimationConfiguration.staggeredList(
                        position: i,
                        duration: const Duration(milliseconds: 400),
                        child: SlideAnimation(
                            verticalOffset: 100.0,
                            child: FlipAnimation(
                              child: Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    // color: Colors.red,
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                          left: Screens.width(context) * 0.01,
                                          right: Screens.width(context) * 0.01,
                                          top: Screens.bodyheight(context) *
                                              0.001,
                                          bottom: Screens.bodyheight(context) *
                                              0.001,
                                        ),
                                        width: Screens.width(context),
                                        //color: Colors.red,
                                        child: Text(
                                          "Challenge 1",
                                          style: themes.textTheme.bodyText1
                                              ?.copyWith(),
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            Screens.bodyheight(context) * 0.01,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                          left: Screens.width(context) * 0.01,
                                          right: Screens.width(context) * 0.01,
                                          top: Screens.bodyheight(context) *
                                              0.001,
                                          bottom: Screens.bodyheight(context) *
                                              0.001,
                                        ),
                                        width: Screens.width(context),
                                        //  color: Colors.red,
                                        child: Text("LG 52% Special Sellout"),
                                      ),
                                      Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  Screens.width(context) * 0.1),
                                          child: Divider(
                                            color: Colors.grey[300],
                                            thickness: 1,
                                          )),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    Screens.width(context) *
                                                        0.02),
                                            width: Screens.width(context) * 0.4,
                                            //s color: Colors.blue,
                                            child: Text("58%"),
                                          ),
                                          Container(
                                            alignment: Alignment.centerRight,
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    Screens.width(context) *
                                                        0.02),
                                            width: Screens.width(context) * 0.4,
                                            //color: Colors.green,
                                            child: Text("Rs.28000.00"),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            Screens.bodyheight(context) * 0.01,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(8),
                                        alignment: Alignment.center,
                                        width: Screens.width(context),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10)),
                                          color: themes.primaryColor,
                                        ),
                                        child: Text(
                                          "Manager",
                                          style: themes.textTheme.bodyText1
                                              ?.copyWith(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )));
                  },
                ),
              )
            ],
          ),
        ));
  }
}
