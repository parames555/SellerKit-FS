// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:sellerkit/Constant/Screen.dart';
import '../../../Constant/padings.dart';
import '../../../Controller/OpenLeadController/OpenLeadController.dart';

class FilterOpenLeadPage extends StatefulWidget {
   FilterOpenLeadPage({Key? key ,required this.openLeadController}) : super(key: key);

OpenLeadController openLeadController;
  @override
  State<FilterOpenLeadPage> createState() => FilterOpenLeadPageState();
}

class FilterOpenLeadPageState extends State<FilterOpenLeadPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    });
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Paddings paddings = Paddings();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return 

      Container(
        padding: paddings.padding2(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: Screens.width(context),
              height: Screens.bodyheight(context)*0.85,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: theme.primaryColor.withOpacity(0.3)),
                                borderRadius: BorderRadius.circular(8)),
                            width: Screens.width(context),
                            //height: Screens.bodyheight(context) * 0.26,
                            padding: EdgeInsets.symmetric(
                                horizontal: Screens.width(context) * 0.015,
                                vertical: Screens.bodyheight(context) * 0.005),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    "Brand",
                                    style: theme.textTheme.subtitle1?.copyWith(
                                        color: theme.primaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: Screens.bodyheight(context)*0.01,
                                ),
                                SizedBox(
                                    width: Screens.width(context),
                                    child: Wrap(
                                        spacing:
                                            10.0, // gap between adjacent chips
                                        runSpacing: 10.0, // gap between lines
                                        children: listContainers(
                                            theme,
                                          widget.openLeadController))),
                                SizedBox(
                                  height: Screens.bodyheight(context) * 0.02,
                                ),
                                InkWell(
                                  onTap: () {
                                    print("object");
                                      widget.openLeadController.isbrandViewclick = true;
                                    widget.openLeadController.getviewAll("Brand");
                                  },
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    width: Screens.width(context),
                                    child:   Text(
                                      "View All",
                                      style: theme.textTheme.bodyText1?.copyWith(
                                          fontSize: 16, color: Colors.grey),
                                    ),
                                  ),
                                )
                              ],
                            ))),
                //new ch
                
        Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: theme.primaryColor.withOpacity(0.3)),
                                borderRadius: BorderRadius.circular(8)),
                            width: Screens.width(context),
                            //height: Screens.bodyheight(context) * 0.26,
                            padding: EdgeInsets.symmetric(
                                horizontal: Screens.width(context) * 0.015,
                                vertical: Screens.bodyheight(context) * 0.005),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    "Group Property",
                                    style: theme.textTheme.subtitle1?.copyWith(
                                        color: theme.primaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: Screens.bodyheight(context)*0.01,
                                ),
                                SizedBox(
                                    width: Screens.width(context),
                                    child: Wrap(
                                        spacing:
                                            10.0, // gap between adjacent chips
                                        runSpacing: 10.0, // gap between lines
                                        children: listGpPty(
                                            theme,
                                          widget.openLeadController))),
                                SizedBox(
                                  height: Screens.bodyheight(context) * 0.02,
                                ),
                                InkWell(
                                  onTap: () {
                                     widget.openLeadController.isgrpPropViewclick  = true;
                                   widget.openLeadController.getviewAll("GroupProperty");
                                  },
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    width: Screens.width(context),
                                    child:   Text(
                                      "View All",
                                      style: theme.textTheme.bodyText1?.copyWith(
                                          fontSize: 16, color: Colors.grey),
                                    ),
                                  ),
                                )
                              ],
                            ))),


                             Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: theme.primaryColor.withOpacity(0.3)),
                                borderRadius: BorderRadius.circular(8)),
                            width: Screens.width(context),
                            //height: Screens.bodyheight(context) * 0.26,
                            padding: EdgeInsets.symmetric(
                                horizontal: Screens.width(context) * 0.015,
                                vertical: Screens.bodyheight(context) * 0.005),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    "Group Segment",
                                    style: theme.textTheme.subtitle1?.copyWith(
                                        color: theme.primaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: Screens.bodyheight(context)*0.01,
                                ),
                                SizedBox(
                                    width: Screens.width(context),
                                    child: Wrap(
                                        spacing:
                                            10.0, // gap between adjacent chips
                                        runSpacing: 10.0, // gap between lines
                                        children: listGpSeg(
                                            theme,
                                          widget.openLeadController))),
                                SizedBox(
                                  height: Screens.bodyheight(context) * 0.02,
                                ),
                                InkWell(
                                  onTap: () {
                                     widget.openLeadController.isgrpSegmViewclick = true;
                                    widget.openLeadController.getviewAll("GroupSegment");
                                  },
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    width: Screens.width(context),
                                    child:   Text(
                                      "View All",
                                      style: theme.textTheme.bodyText1?.copyWith(
                                          fontSize: 16, color: Colors.grey),
                                    ),
                                  ),
                                )
                              ],
                            ))),

                             Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: theme.primaryColor.withOpacity(0.3)),
                                borderRadius: BorderRadius.circular(8)),
                            width: Screens.width(context),
                            //height: Screens.bodyheight(context) * 0.26,
                            padding: EdgeInsets.symmetric(
                                horizontal: Screens.width(context) * 0.015,
                                vertical: Screens.bodyheight(context) * 0.005),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    "Division",
                                    style: theme.textTheme.subtitle1?.copyWith(
                                        color: theme.primaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: Screens.bodyheight(context)*0.01,
                                ),
                                SizedBox(
                                    width: Screens.width(context),
                                    child: Wrap(
                                        spacing:
                                            10.0, // gap between adjacent chips
                                        runSpacing: 10.0, // gap between lines
                                        children: listDivision(
                                            theme,
                                          widget.openLeadController))),
                                SizedBox(
                                  height: Screens.bodyheight(context) * 0.02,
                                ),
                                InkWell(
                                  onTap: () {
                                     widget.openLeadController.isDivisViewclick = true;
                                  widget.openLeadController.getviewAll("Division");
                                  },
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    width: Screens.width(context),
                                    child:   Text(
                                      "View All",
                                      style: theme.textTheme.bodyText1?.copyWith(
                                          fontSize: 16, color: Colors.grey),
                                    ),
                                  ),
                                )
                              ],
                            ))),
                             Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: theme.primaryColor.withOpacity(0.3)),
                                borderRadius: BorderRadius.circular(8)),
                            width: Screens.width(context),
                            //height: Screens.bodyheight(context) * 0.26,
                            padding: EdgeInsets.symmetric(
                                horizontal: Screens.width(context) * 0.015,
                                vertical: Screens.bodyheight(context) * 0.005),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    "Branch",
                                    style: theme.textTheme.subtitle1?.copyWith(
                                        color: theme.primaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: Screens.bodyheight(context)*0.01,
                                ),
                                SizedBox(
                                    width: Screens.width(context),
                                    child: Wrap(
                                        spacing:
                                            10.0, // gap between adjacent chips
                                        runSpacing: 10.0, // gap between lines
                                        children: listBranch(
                                            theme,
                                          widget.openLeadController))),
                                SizedBox(
                                  height: Screens.bodyheight(context) * 0.02,
                                ),
                                InkWell(
                                  onTap: () {
                                     widget.openLeadController.isBrnchViewclick = true;
                                    widget.openLeadController.getviewAll("Branch");
                                  },
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    width: Screens.width(context),
                                    child:   Text(
                                      "View All",
                                      style: theme.textTheme.bodyText1?.copyWith(
                                          fontSize: 16, color: Colors.grey),
                                    ),
                                  ),
                                )
                              ],
                            ))),
                             Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: theme.primaryColor.withOpacity(0.3)),
                                borderRadius: BorderRadius.circular(8)),
                            width: Screens.width(context),
                            //height: Screens.bodyheight(context) * 0.26,
                            padding: EdgeInsets.symmetric(
                                horizontal: Screens.width(context) * 0.015,
                                vertical: Screens.bodyheight(context) * 0.005),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    "Sales Executive",
                                    style: theme.textTheme.subtitle1?.copyWith(
                                        color: theme.primaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: Screens.bodyheight(context)*0.01,
                                ),
                                SizedBox(
                                    width: Screens.width(context),
                                    child: Wrap(
                                        spacing:
                                            10.0, // gap between adjacent chips
                                        runSpacing: 10.0, // gap between lines
                                        children: listSalesExec(
                                            theme,
                                          widget.openLeadController))),
                                SizedBox(
                                  height: Screens.bodyheight(context) * 0.02,
                                ),
                                InkWell(
                                  onTap: () {
                                     widget.openLeadController.isSalesExecViewclick = true;
                                    widget.openLeadController.getviewAll("SalesExecutive");
                                  },
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    width: Screens.width(context),
                                    child:   Text(
                                      "View All",
                                      style: theme.textTheme.bodyText1?.copyWith(
                                          fontSize: 16, color: Colors.grey),
                                    ),
                                  ),
                                )
                              ],
                            ))),
                             Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: theme.primaryColor.withOpacity(0.3)),
                                borderRadius: BorderRadius.circular(8)),
                            width: Screens.width(context),
                            //height: Screens.bodyheight(context) * 0.26,
                            padding: EdgeInsets.symmetric(
                                horizontal: Screens.width(context) * 0.015,
                                vertical: Screens.bodyheight(context) * 0.005),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    "Branch Manager",
                                    style: theme.textTheme.subtitle1?.copyWith(
                                        color: theme.primaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: Screens.bodyheight(context)*0.01,
                                ),
                                SizedBox(
                                    width: Screens.width(context),
                                    child: Wrap(
                                        spacing:
                                            5.0, // gap between adjacent chips
                                        runSpacing: 5.0, // gap between lines
                                        children: listBranchMang(
                                            theme,
                                          widget.openLeadController))),
                                SizedBox(
                                  height: Screens.bodyheight(context) * 0.02,
                                ),
                                InkWell(
                                  onTap: () {
                                     widget.openLeadController.isBrnchMangViewclick = true;
                                  widget.openLeadController.getviewAll("BranchManager");

                                  },
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    width: Screens.width(context),
                                    child:   Text(
                                      "View All",
                                      style: theme.textTheme.bodyText1?.copyWith(
                                          fontSize: 16, color: Colors.grey),
                                    ),
                                  ),
                                )
                              ],
                            ))),

    Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: theme.primaryColor.withOpacity(0.3)),
                                borderRadius: BorderRadius.circular(8)),
                            width: Screens.width(context),
                            //height: Screens.bodyheight(context) * 0.26,
                            padding: EdgeInsets.symmetric(
                                horizontal: Screens.width(context) * 0.015,
                                vertical: Screens.bodyheight(context) * 0.005),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    "Regional Manager",
                                    style: theme.textTheme.subtitle1?.copyWith(
                                        color: theme.primaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: Screens.bodyheight(context)*0.01,
                                ),
                                SizedBox(
                                    width: Screens.width(context),
                                    child: Wrap(
                                        spacing:
                                            10.0, // gap between adjacent chips
                                        runSpacing: 10.0, // gap between lines
                                        children: listRegMang(
                                            theme,
                                          widget.openLeadController))),
                                SizedBox(
                                  height: Screens.bodyheight(context) * 0.02,
                                ),
                                InkWell(
                                  onTap: () {
                                     widget.openLeadController.isReginlMangViewclick = true;
                                     widget.openLeadController.getviewAll("RegionalManager");

                                  },
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    width: Screens.width(context),
                                    child:   Text(
                                      "View All",
                                      style: theme.textTheme.bodyText1?.copyWith(
                                          fontSize: 16, color: Colors.grey),
                                    ),
                                  ),
                                )
                              ],
                            ))),

         
                  ],
                ),
              ),
            ),

          
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                   SizedBox(
                  width: Screens.width(context)*0.2,
                  height: Screens.bodyheight(context)*0.065,

                  child: ElevatedButton(
                      onPressed: () {
                  showSearchDialogBox(context,widget.openLeadController);
                      },
                      onLongPress: (){

                      },
                      style: ElevatedButton.styleFrom(
                        primary: theme.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Icon(Icons.search)//const Text('Search')
                      ),
                ),
                SizedBox(
                  width: Screens.width(context)*0.5,
                  height: Screens.bodyheight(context)*0.065,

                  child: ElevatedButton(
                      onPressed: () {
                         widget.openLeadController.viewListOpnLead();
                      },
                    
                      style: ElevatedButton.styleFrom(
                        primary: theme.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Search')),
                ),
                   SizedBox(
                  width: Screens.width(context)*0.2,
                  height: Screens.bodyheight(context)*0.065,
                  child: ElevatedButton(
                      onPressed:  widget.openLeadController.clearbtn == true?null: (){
                       widget.openLeadController.clearAllDataSelect();
                     //   widget.openLeadController.clearAllData();
                      },
                     
                      style: ElevatedButton.styleFrom(
                        primary: theme.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Icon(Icons.filter_alt_off)//const Text('Clear')
                      ),
                ),
              ],
            )
          ],
        ),
      );
  
   // );
  }

  Widget buildSlideLabel(String value, ThemeData theme) => Text(
        value.toString(),
        style: theme.textTheme.bodyText1?.copyWith(color: Colors.grey),
      );

  List<Widget> listContainers(
    ThemeData theme,
   OpenLeadController openLeadController,
  ) {
    if (openLeadController.getBrandData.length <= 9) {
      return List.generate(
       openLeadController. getBrandData.length,
        (index) => StatefulBuilder(
          builder: (context,st) {
            return GestureDetector(
              onTap: () {
                //  openLeadController.isselectedBrand(index);
                openLeadController.isselectedBrand(index);
              },
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color:openLeadController. getBrandData[index].color == 1
                        ? theme.primaryColor
                        : Colors.white,
                    border: Border.all(color: theme.primaryColor, width: 1),
                    borderRadius:BorderRadius.circular(5)),
                child: Text(openLeadController.getBrandData[index].discColumn!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyText1?.copyWith(
                      fontSize: 12,
                      color: openLeadController.getBrandData[index].color == 1
                          ? Colors.white
                          : theme.primaryColor,
                    )),
              ),
            );
          }
        ),
      );
    } else {
      return List.generate(
        9,
        (index) => GestureDetector(
          onTap: () {
            //  openLeadController.isselectedBrand(index);
           openLeadController.isselectedBrand(index);
          },
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: openLeadController. getBrandData[index].color == 1
                    ? theme.primaryColor
                    : Colors.white,
                border: Border.all(color: theme.primaryColor, width: 1),
                borderRadius:BorderRadius.circular(5)),
            child: Text( openLeadController.getBrandData[index].discColumn!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyText1?.copyWith(
                  fontSize: 12,
                  color: openLeadController.getBrandData[index].color == 1
                      ? Colors.white
                      : theme.primaryColor,
                )),
          ),
        ),
      );
    }
  }

    List<Widget> listGpPty(
    ThemeData theme,
    OpenLeadController openLeadController,
  ) {
    if (openLeadController.getGroupProperty.length <= 9) {
      return List.generate(
        openLeadController.getGroupProperty.length,
        (index) => GestureDetector(
          onTap: () {
            //  openLeadController.isselectedBrand(index);
            openLeadController.isselectedGropPropM(index);
          },
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: openLeadController.getGroupProperty[index].color == 1
                    ? theme.primaryColor
                    : Colors.white,
                border: Border.all(color: theme.primaryColor, width: 1),
                borderRadius: BorderRadius.circular(5)),
            child: Text(openLeadController.getGroupProperty[index].discColumn!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyText1?.copyWith(
                  fontSize: 12,
                  color:openLeadController.getGroupProperty[index].color == 1
                      ? Colors.white
                      : theme.primaryColor,
                )),
          ),
        ),
      );
    } else {
      return List.generate(
        9,
        (index) => GestureDetector(
          onTap: () {
            //  openLeadController.isselectedBrand(index);
            openLeadController.isselectedGropPropM(index);
          },
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: openLeadController.getGroupProperty[index].color == 1
                    ? theme.primaryColor
                    : Colors.white,
                border: Border.all(color: theme.primaryColor, width: 1),
                borderRadius: BorderRadius.circular(5)),
            child: Text(openLeadController.getGroupProperty[index].discColumn!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyText1?.copyWith(
                  fontSize: 12,
                  color:openLeadController.getGroupProperty[index].color == 1
                      ? Colors.white
                      : theme.primaryColor,
                )),
          ),
        ),
      );
    }
  }

   List<Widget> listGpSeg(
    ThemeData theme,
    OpenLeadController openLeadController,
  ) {
    if (openLeadController.getgroupSegment.length <= 9) {
      return List.generate(
        openLeadController.getgroupSegment.length,
        (index) => GestureDetector(
          onTap: () {
            //  openLeadController.isselectedBrand(index);
            openLeadController.isselectedGropSegmtM(index);
          },
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: openLeadController.getgroupSegment[index].color == 1
                    ? theme.primaryColor
                    : Colors.white,
                border: Border.all(color: theme.primaryColor, width: 1),
                borderRadius: BorderRadius.circular(5)),
            child: Text(openLeadController.getgroupSegment[index].discColumn!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyText1?.copyWith(
                  fontSize: 12,
                  color:openLeadController.getgroupSegment[index].color == 1
                      ? Colors.white
                      : theme.primaryColor,
                )),
          ),
        ),
      );
    } else {
      return List.generate(
        9,
        (index) => GestureDetector(
          onTap: () {
            //  openLeadController.isselectedBrand(index);
          openLeadController.isselectedGropSegmtM(index);
          },
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: openLeadController.getgroupSegment[index].color == 1
                    ? theme.primaryColor
                    : Colors.white,
                border: Border.all(color: theme.primaryColor, width: 1),
                borderRadius:BorderRadius.circular(5)),
            child: Text(openLeadController.getgroupSegment[index].discColumn!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyText1?.copyWith(
                  fontSize: 12,
                  color:openLeadController.getgroupSegment[index].color == 1
                      ? Colors.white
                      : theme.primaryColor,
                )),
          ),
        ),
      );
    }
  }

   List<Widget> listDivision(
    ThemeData theme,
    OpenLeadController openLeadController,
  ) {
    if (openLeadController.getDivisionData.length <= 9) {
      return List.generate(
        openLeadController.getDivisionData.length,
        (index) => GestureDetector(
          onTap: () {
            //  openLeadController.isselectedBrand(index);
           openLeadController.isselectedDivisionM(index);
          },
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: openLeadController.getDivisionData[index].color == 1
                    ? theme.primaryColor
                    : Colors.white,
                border: Border.all(color: theme.primaryColor, width: 1),
                borderRadius:BorderRadius.circular(5)),
            child: Text(openLeadController.getDivisionData[index].discColumn!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyText1?.copyWith(
                  fontSize: 12,
                  color:openLeadController.getDivisionData[index].color == 1
                      ? Colors.white
                      : theme.primaryColor,
                )),
          ),
        ),
      );
    } else {
      return List.generate(
        9,
        (index) => GestureDetector(
          onTap: () {
            //  openLeadController.isselectedBrand(index);
             openLeadController.isselectedDivisionM(index);
          },
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: openLeadController.getDivisionData[index].color == 1
                    ? theme.primaryColor
                    : Colors.white,
                border: Border.all(color: theme.primaryColor, width: 1),
                borderRadius:BorderRadius.circular(5)),
            child: Text(openLeadController.getDivisionData[index].discColumn!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyText1?.copyWith(
                  fontSize: 12,
                  color:openLeadController.getDivisionData[index].color == 1
                      ? Colors.white
                      : theme.primaryColor,
                )),
          ),
        ),
      );
    }
  }

     List<Widget> listBranch(
    ThemeData theme,
    OpenLeadController openLeadController,
  ) {
    if (openLeadController.getBranchData.length <= 9) {
      return List.generate(
        openLeadController.getBranchData.length,
        (index) => GestureDetector(
          onTap: () {
            //  openLeadController.isselectedBrand(index);
           openLeadController.isselectedBranchM(index);
          },
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: openLeadController.getBranchData[index].color == 1
                    ? theme.primaryColor
                    : Colors.white,
                border: Border.all(color: theme.primaryColor, width: 1),
                borderRadius:BorderRadius.circular(5)),
            child: Text(openLeadController.getBranchData[index].discColumn!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyText1?.copyWith(
                  fontSize: 12,
                  color:openLeadController.getBranchData[index].color == 1
                      ? Colors.white
                      : theme.primaryColor,
                )),
          ),
        ),
      );
    } else {
      return List.generate(
        9,
        (index) => GestureDetector(
          onTap: () {
            //  openLeadController.isselectedBrand(index);
              openLeadController.isselectedBranchM(index);
          },
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: openLeadController.getBranchData[index].color == 1
                    ? theme.primaryColor
                    : Colors.white,
                border: Border.all(color: theme.primaryColor, width: 1),
                borderRadius:BorderRadius.circular(5)),
            child: Text(openLeadController.getBranchData[index].discColumn!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyText1?.copyWith(
                  fontSize: 12,
                  color:openLeadController.getBranchData[index].color == 1
                      ? Colors.white
                      : theme.primaryColor,
                )),
          ),
        ),
      );
    }
  }

    List<Widget> listSalesExec(
    ThemeData theme,
    OpenLeadController openLeadController,
  ) {
    if (openLeadController.getsalesExecutiveData.length <= 9) {
      return List.generate(
        openLeadController.getsalesExecutiveData.length,
        (index) => GestureDetector(
          onTap: () {
            //  openLeadController.isselectedBrand(index);
             openLeadController.isselectedSalesExeM(index);
          },
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: openLeadController.getsalesExecutiveData[index].color == 1
                    ? theme.primaryColor
                    : Colors.white,
                border: Border.all(color: theme.primaryColor, width: 1),
                borderRadius:BorderRadius.circular(5)),
            child: Text(openLeadController.getsalesExecutiveData[index].discColumn!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyText1?.copyWith(
                  fontSize: 12,
                  color:openLeadController.getsalesExecutiveData[index].color == 1
                      ? Colors.white
                      : theme.primaryColor,
                )),
          ),
        ),
      );
    } else {
      return List.generate(
        9,
        (index) => GestureDetector(
          onTap: () {
            //  openLeadController.isselectedBrand(index);
             openLeadController.isselectedSalesExeM(index);
          },
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: openLeadController.getsalesExecutiveData[index].color == 1
                    ? theme.primaryColor
                    : Colors.white,
                border: Border.all(color: theme.primaryColor, width: 1),
                borderRadius:BorderRadius.circular(5)),
            child: Text(openLeadController.getsalesExecutiveData[index].discColumn!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyText1?.copyWith(
                  fontSize: 12,
                  color:openLeadController.getsalesExecutiveData[index].color == 1
                      ? Colors.white
                      : theme.primaryColor,
                )),
          ),
        ),
      );
    }
  }

     List<Widget> listBranchMang(
    ThemeData theme,
    OpenLeadController openLeadController,
  ) {
    if (openLeadController.getbranchManagerData.length <= 9) {
      return List.generate(
        openLeadController.getbranchManagerData.length,
        (index) => GestureDetector(
          onTap: () {
            //  openLeadController.isselectedBrand(index);
            openLeadController. isselectedBrnMagM(index);
          },
          child: Container(
          //  alignment: Alignment.center,
           // width: Screens.width(context) ,
           // height: Screens.bodyheight(context) * 0.06,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: openLeadController.getbranchManagerData[index].color == 1
                    ? theme.primaryColor
                    : Colors.white,
                border: Border.all(color: theme.primaryColor, width: 1),
                borderRadius:BorderRadius.circular(5)),
            child: Text(openLeadController.getbranchManagerData[index].discColumn!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyText1?.copyWith(
                  fontSize: 12,
                  color:openLeadController.getbranchManagerData[index].color == 1
                      ? Colors.white
                      : theme.primaryColor,
                )),
          ),
        ),
      );
    } else {
      return List.generate(
        9,
        (index) => GestureDetector(
          onTap: () {
            //  openLeadController.isselectedBrand(index);
          openLeadController. isselectedBrnMagM(index);
          },
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: openLeadController.getbranchManagerData[index].color == 1
                    ? theme.primaryColor
                    : Colors.white,
                border: Border.all(color: theme.primaryColor, width: 1),
                borderRadius:BorderRadius.circular(5)),
            child: Text(openLeadController.getbranchManagerData[index].discColumn!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyText1?.copyWith(
                  fontSize: 12,
                  color:openLeadController.getbranchManagerData[index].color == 1
                      ? Colors.white
                      : theme.primaryColor,
                )),
          ),
        ),
      );
    }
  }

  
     List<Widget> listRegMang(
    ThemeData theme,
    OpenLeadController openLeadController,
  ) {
    if (openLeadController.getRegionalManager.length <= 9) {
      return List.generate(
        openLeadController.getRegionalManager.length,
        (index) => GestureDetector(
          onTap: () {
            //  openLeadController.isselectedBrand(index);
            openLeadController.isselectedRegMagM(index);
          },
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: openLeadController.getRegionalManager[index].color == 1
                    ? theme.primaryColor
                    : Colors.white,
                border: Border.all(color: theme.primaryColor, width: 1),
                borderRadius:BorderRadius.circular(5)),
            child: Text(openLeadController.getRegionalManager[index].discColumn!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyText1?.copyWith(
                  fontSize: 12,
                  color:openLeadController.getRegionalManager[index].color == 1
                      ? Colors.white
                      : theme.primaryColor,
                )),
          ),
        ),
      );
    } else {
      return List.generate(
        9,
        (index) => GestureDetector(
          onTap: () {
            //  openLeadController.isselectedBrand(index);
              openLeadController.isselectedRegMagM(index);
          },
          child: Container(
           
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: openLeadController.getRegionalManager[index].color == 1
                    ? theme.primaryColor
                    : Colors.white,
                border: Border.all(color: theme.primaryColor, width: 1),
                borderRadius:BorderRadius.circular(5)),
            child: Text(openLeadController.getRegionalManager[index].discColumn!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyText1?.copyWith(
                  fontSize: 12,
                  color:openLeadController.getRegionalManager[index].color == 1
                      ? Colors.white
                      : theme.primaryColor,
                )),
          ),
        ),
      );
    }
  }

   void showSearchDialogBox(BuildContext context,OpenLeadController openLeadController,) {
    showDialog<dynamic>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            final theme = Theme.of(context);
            return AlertDialog(
              content: Container(
                //  color: Colors.black12,
                // height: Screens.heigth(context) * 0.4,
                width: Screens.width(context) * 0.8,
                child: Form(
                  key: openLeadController.searchKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                          controller: openLeadController.searchcon,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Required *";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: 'Search here',
                              border: UnderlineInputBorder(),
                              enabledBorder: UnderlineInputBorder(),
                              focusedBorder: UnderlineInputBorder(),
                              errorBorder: UnderlineInputBorder(),
                              focusedErrorBorder: UnderlineInputBorder(),
                              suffixIcon: InkWell(
                                  onTap: () {
                                   openLeadController.validateSearch(context);
                                  },
                                  child: Icon(Icons.search,
                                      color: theme.primaryColor)))),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

}
