// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Controller/DownLoadController/DownloadController.dart';
import 'package:sellerkit/Pages/Challenges/Widgets/SearchWidgets.dart';
import 'package:sellerkit/Pages/OfferZone/OfferPopup.dart';
import 'package:sellerkit/Widgets/Appbar.dart';
import '../../../Constant/Screen.dart';
import '../../../Constant/padings.dart';
import '../../../Controller/OfferZoneController/OfferZoneController.dart';
import '../../../Widgets/Navi3.dart';

class OfferZone extends StatefulWidget {
  const OfferZone({Key? key}) : super(key: key);

  @override
  State<OfferZone> createState() => OfferZoneState();
}

class OfferZoneState extends State<OfferZone> {
  var keys;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Paddings paddings = Paddings();
  @override
  Widget build(BuildContext context) {
    final themes = Theme.of(context);
    return Scaffold(
        key: scaffoldKey,
        drawer: drawer3(context),
        appBar: appbar("Offer Zone", themes, context),
        body: ChangeNotifierProvider<OfferZoneController>(
            create: (context) => OfferZoneController(),
            builder: (context, child) {
              return Consumer<OfferZoneController>(
                  builder: (BuildContext context, prdOffZ, Widget? child) {
                return SafeArea(
                    child:
                             prdOffZ.getofferzone.isEmpty 
                        ? Center(
                            child: Text("No data found")
                          //   CircularProgressIndicator(
                          //   color: themes.primaryColor,
                          // )
                          )
                        :
                    Column(
                              children: [
                                 Container(
               height: Screens.bodyheight(context) * 0.06,
               decoration: BoxDecoration(
                 color: themes.primaryColor
                     .withOpacity(0.1), //Colors.grey[200],
                 borderRadius: BorderRadius.circular(
                     Screens.width(context) * 0.02),
               ),
               child: TextField(
                 autocorrect: false,
                 onChanged: (v) {
                 prdOffZ.offerfilterList(v);
                 },
                 decoration: InputDecoration(
                   filled: false,
                   hintText: 'Search Here!!..',
                   enabledBorder: InputBorder.none,
                   focusedBorder: InputBorder.none,
                   prefixIcon: IconButton(
                     icon: const Icon(Icons.search),
                     onPressed: () {
                       FocusScopeNode focus = FocusScope.of(context);
                       if (!focus.hasPrimaryFocus) {
                         focus.unfocus();
                       }
                     }, //
                     color: themes.primaryColor,
                   ),
                   contentPadding: const EdgeInsets.symmetric(
                     vertical: 12,
                     horizontal: 5,
                   ),
                 ),
               ),
             ),
                                // SearchWidget(
                                //   themes: themes,
                                // ),
                                SizedBox(
                                  height: Screens.bodyheight(context) * 0.01,
                                ), 
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: () {
                              return prdOffZ.refreshData();
                            },
                            child: ListView.builder(
                              itemCount: prdOffZ.getofferviewAll.length,
                              itemBuilder:
                                  (BuildContext context, int i) {
                                keys = prdOffZ.getofferviewAll.toList();

                                return InkWell(
                                    onDoubleTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (_) =>
                                              DiviceDialogBox(
                                                theme: themes,
                                                popvalues: keys,
                                                i: i,
                                              ));
                                    },
                                    child:
                                        AnimationConfiguration
                                            .staggeredList(
                                                position: i,
                                                duration:
                                                    const Duration(
                                                        milliseconds:
                                                            400),
                                                child: SlideAnimation(
                                                    verticalOffset:
                                                        100.0,
                                                    child:
                                                        FlipAnimation(
                                                      child: Card(
                                                        elevation: 4,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    10)),
                                                        child:
                                                            Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    10),
                                                          ),
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                padding:
                                                                    EdgeInsets.only(
                                                                  left: Screens.width(context) *
                                                                      0.01,
                                                                  right:
                                                                      Screens.width(context) * 0.01,
                                                                  top: Screens.bodyheight(context) *
                                                                      0.01,
                                                                  bottom:
                                                                      Screens.bodyheight(context) * 0.001,
                                                                ),
                                                                width: Screens.width(
                                                                    context),
                                                                child:
                                                                    Text(
                                                                  keys[i]
                                                                      .item
                                                                      .toString(),
                                                                  style: themes
                                                                      .textTheme
                                                                      .bodyText1
                                                                      ?.copyWith(),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: Screens.bodyheight(context) *
                                                                    0.01,
                                                              ),
                                                              Container(
                                                                padding:
                                                                    EdgeInsets.only(
                                                                  left: Screens.width(context) *
                                                                      0.01,
                                                                  right:
                                                                      Screens.width(context) * 0.01,
                                                                  top: Screens.bodyheight(context) *
                                                                      0.001,
                                                                  bottom:
                                                                      Screens.bodyheight(context) * 0.001,
                                                                ),
                                                                width: Screens.width(
                                                                    context),
                                                                child:
                                                                    Text(
                                                                  keys[i]
                                                                      .discoutDetails
                                                                      .toString(),
                                                                  style: themes
                                                                      .textTheme
                                                                      .bodyText1
                                                                      ?.copyWith(),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: Screens.bodyheight(context) *
                                                                    0.01,
                                                              ),
                                                              Container(
                                                                height: Screens.bodyheight(context) *
                                                                    0.05,
                                                                padding:
                                                                    EdgeInsets.all(2),
                                                                alignment:
                                                                    Alignment.center,
                                                                width: Screens.width(
                                                                    context),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius: BorderRadius.only(
                                                                      bottomLeft: Radius.circular(10),
                                                                      bottomRight: Radius.circular(10)),
                                                                  color:
                                                                      themes.primaryColor,
                                                                ),
                                                                child:
                                                                    Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Container(
                                                                      padding: EdgeInsets.symmetric(horizontal: Screens.width(context) * 0.01),
                                                                      width: Screens.width(context) * 0.5,
                                                                      //s color: Colors.blue,
                                                                      child: Text(
                                                                        keys[i].validTill.toString(),
                                                                        style: themes.textTheme.bodyText1?.copyWith(color: Colors.white),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      alignment: Alignment.centerRight,
                                                                      padding: EdgeInsets.symmetric(horizontal: Screens.width(context) * 0.02),
                                                                      width: Screens.width(context) * 0.4,
                                                                      //color: Colors.green,
                                                                      child: Text(
                                                                        keys[i].incentive.toString(),
                                                                        style: themes.textTheme.bodyText1?.copyWith(color: Colors.white),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ))));
                              },
                            ),
                          ),
                        )
                              ],
                            ),
                          );
              });
            }));
  }
}
