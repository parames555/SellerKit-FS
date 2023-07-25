// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, unnecessary_new

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../Constant/Screen.dart';
import '../../../Constant/Configuration.dart';
import '../../../Controller/LeadController/TabLeadController.dart';
import '../../../Models/PostQueryModel/LeadsCheckListModel/GetAllLeadModel.dart';
import '../../../Models/PostQueryModel/LeadsCheckListModel/GetLeadSummary.dart';
import '../../Enquiries/EnquiriesUser/Widgets/GlobalKeys.dart';
import 'FollowDialog.dart';

class OpenLeadPage extends StatefulWidget {
  const OpenLeadPage({Key? key,
      required this.theme,
      required this.leadOpenAllData,
      required this.leadSummaryOpen,
      required this.provi
      })
      : super(key: key);

  final ThemeData theme;

  final List<GetAllLeadData> leadOpenAllData;

  final List<SummaryLeadData> leadSummaryOpen;

  final LeadTabController provi;

  @override
  State<OpenLeadPage> createState() => _OpenLeadPageState();
}

class _OpenLeadPageState extends State<OpenLeadPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.red,
      width: Screens.width(context),
      height: Screens.bodyheight(context),
      padding: EdgeInsets.symmetric(
          horizontal: Screens.width(context) * 0.03,
          vertical: Screens.bodyheight(context) * 0.02),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: Screens.width(context) * 0.02,
            ),
            width: Screens.width(context),
           // height: Screens.bodyheight(context) * 0.16,
            padding: EdgeInsets.symmetric(
                horizontal: Screens.width(context) * 0.03,
                vertical: Screens.bodyheight(context) * 0.02),
            decoration: BoxDecoration(
                color: widget.theme.primaryColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black26)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize:MainAxisSize.min,
              children: [
                Container(
                  child: Text("Open Orders",
                    // "${widget.leadSummaryOpen[0].Caption}",
                    style: widget.theme.textTheme.bodyText1
                        ?.copyWith(color: widget.theme.primaryColor),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        width: Screens.width(context) * 0.4,
                        child: Text(
                          "₹ " +
                              Config.k_m_b_generator(
                                  widget.leadSummaryOpen[0].Value!.toStringAsFixed(0)),
                          //NumberFormatter.formatter(leadSummaryOpen[0].Value!.toStringAsFixed(0))
                          //context.read<LeadTabController>().config.
                          //"₹ ${leadSummaryOpen[0].Value}"),
                          style: widget.theme.textTheme.headline6,
                        )),
                    Container(
                      alignment: Alignment.centerRight,
                      width: Screens.width(context) * 0.4,
                      child: Text(
                          widget.leadSummaryOpen[0].column!.toStringAsFixed(0) +
                              " Orders"),
                    )
                  ],
                ),
                Container(
                  alignment: Alignment.centerRight,
                  width: Screens.width(context),
                  child: Text(
                    "Target ₹ " +
                        Config.k_m_b_generator(
                            widget.leadSummaryOpen[0].Target!.toStringAsFixed(0)),
                    //     style: theme.textTheme.bodyText1?.copyWith(
                    //   //color: Colors.grey
                    //   fontWeight: FontWeight.w400
                    // ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: Screens.bodyheight(context) * 0.008,
          ),
          Expanded(
            child: RefreshIndicator(
              // key: new GlobalKey<RefreshIndicatorState>(),
                //  key: RIKeys.riKey6,
                onRefresh: (){
                   return context.read<LeadTabController>().swipeRefreshIndiactor();
                  },
              child: ListView.builder(
                itemCount: widget.leadOpenAllData.length,
                itemBuilder: (BuildContext context, int i) {
                  return InkWell(
                    onTap: (){
                      // print("lead entry: "+widget.leadOpenAllData[i].LeadDocEntry.toString());
                      //    print("lead entry: "+widget.leadOpenAllData[i].Mobile .toString());
                    },
                    onDoubleTap: () {
                       showDialog<dynamic>(
                            context: context,
                            builder: (_) {
                              widget.provi.updateFollowUpDialog = false;
                             // context.read<LeadTabController>().resetValues();
                              return FollowDialog( index: i,);
                            }).then((value) {
                              setState(() {
                                widget.provi.refershAfterClosedialog();
                              widget.provi.callGetAllApi();
                               widget.provi.callSummaryApi();
                              });
                            });
                    },
                    onLongPress: (){
                       showDialog<dynamic>(
                            context: context,
                            builder: (_) {
                              widget.provi.updateFollowUpDialog = false;
                             // context.read<LeadTabController>().resetValues();
                              return FollowDialog( index: i,);
                            }).then((value) {
                              setState(() {
                               widget.provi.refershAfterClosedialog();
                               widget.provi.callGetAllApi();
                               widget.provi.callSummaryApi();
                              });
                           
                            });
                    },
                    child: Container(
                      width: Screens.width(context),
                      padding: EdgeInsets.symmetric(
                          horizontal: Screens.width(context) * 0.02,
                          vertical: Screens.bodyheight(context) * 0.006),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: Screens.width(context) * 0.02,
                                vertical: Screens.bodyheight(context) * 0.006),
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.black26)
                                // border: Border(bottom: BorderSide(color: Colors.black38))
                                ),
                            width: Screens.width(context),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: Screens.width(context) * 0.4,
                                      child: Text(
                                        "Customer",
                                        style: widget.theme.textTheme.bodyText2
                                            ?.copyWith(color: Colors.grey),
                                      ),
                                    ),
                                    Container(
                                      width: Screens.width(context) * 0.4,
                                      child: Text(
                                        "",
                                        style: widget.theme.textTheme.bodyText2
                                            ?.copyWith(color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: Screens.width(context) * 0.4,
                                      child: Text(
                                          "${widget.leadOpenAllData[i].CustomerName}", //  "${context.watch<EnquiryUserContoller>().getopenEnqData[i].CardName}",
                                          style:
                                              widget.theme.textTheme.bodyText2?.copyWith(
                                            color: widget.theme.primaryColor,
                                            // fontWeight: FontWeight.bold
                                          )),
                                    ),
                                    Container(
                                      width: Screens.width(context) * 0.4,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                          //context
                                          // leadOpenAllData[i].DocDate!.isEmpty?'':
                                          //  context.read<LeadTabController>().config.alignDate(
                                          "#${widget.leadOpenAllData[i].LeadNum}",
                                          //),//         // .watch<EnquiryUserContoller>()
                                          // .config
                                          // .alignDate(
                                          //     "${context.watch<EnquiryUserContoller>().getopenEnqData[i].EnqDate}"),
                                          style:
                                              widget.theme.textTheme.bodyText2?.copyWith(
                                            color: widget.theme.primaryColor,
                                            //fontWeight: FontWeight.bold
                                          )),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: Screens.bodyheight(context) * 0.01,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: Screens.width(context),
                                      child: Text(
                                        "Product",
                                        style: widget.theme.textTheme.bodyText2
                                            ?.copyWith(color: Colors.grey),
                                      ),
                                    ),
                                    Container(
                                      width: Screens.width(context),
                                      // color: Colors.red,
                                      child: Text("${widget.leadOpenAllData[i].Product}",
                                          style: widget.theme.textTheme.bodyText2
                                          //?.copyWith(color: Colors.grey),
                                          ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: Screens.bodyheight(context) * 0.01,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: Screens.width(context) * 0.4,
                                      // color: Colors.red,
                                      child: Text(
                                          "Order Date", //  "Looking for ${context.watch<EnquiryUserContoller>().getopenEnqData[i].Lookingfor}",
                                          style:
                                              widget.theme.textTheme.bodyText2?.copyWith(
                                                  //color:theme.primaryColor,
                                                  //fontWeight: FontWeight.bold
                                                  color: Colors.grey)),
                                    ),
                                    Container(
                                      width: Screens.width(context) * 0.4,
                                      //color: Colors.red,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                          "Order Value", //  "₹ ${context.watch<EnquiryUserContoller>().getopenEnqData[i].PotentialValue}",
                                          style:
                                              widget.theme.textTheme.bodyText2?.copyWith(
                                                  //color:theme.primaryColor,
                                                  //fontWeight: FontWeight.bold
                                                  color: Colors.grey)),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: Screens.width(context) * 0.4,
                                      child: Text(
                                          widget.leadOpenAllData[i].NextFollowup!.isEmpty
                                              ? ''
                                              : context
                                                  .read<LeadTabController>()
                                                  .config
                                                  .alignDate(
                                                      "${widget.leadOpenAllData[i].NextFollowup}"), //  "Looking for ${context.watch<EnquiryUserContoller>().getopenEnqData[i].Lookingfor}",
                                          style:
                                              widget.theme.textTheme.bodyText2?.copyWith(
                                                  //color:theme.primaryColor,
                                                  //fontWeight: FontWeight.bold
                                                  )),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        var format = NumberFormat.currency(
                                          name: "INR",
                                          locale: 'en_IN',
                                          decimalDigits:
                                              0, // change it to get decimal places
                                          symbol: '₹ ',
                                        );
                                        String formattedCurrency =
                                            format.format(30000);
                                        print(formattedCurrency);
                                      },
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        width: Screens.width(context) * 0.4,
                                        child: Text(
                                            widget.leadOpenAllData[i].Value == -1
                                                ? ""
                                                : context
                                                    .read<LeadTabController>()
                                                    .config
                                                    .slpitCurrency(widget.leadOpenAllData[
                                                            i]
                                                        .Value!
                                                        .toStringAsFixed(
                                                            0)), //  "₹ ${context.watch<EnquiryUserContoller>().getopenEnqData[i].PotentialValue}",
                                            style: widget.theme.textTheme.bodyText2
                                                ?.copyWith(
                                                    //color:theme.primaryColor,
                                                    //fontWeight: FontWeight.bold
                                                    )),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: Screens.bodyheight(context) * 0.01,
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  width: Screens.width(context),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                          left: Screens.width(context) * 0.02,
                                          right: Screens.width(context) * 0.02,
                                        ),
                                        decoration: BoxDecoration(
                                            color: Colors.green[200],
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        child: Text(
                                            widget.leadOpenAllData[i]
                                                    .LastUpdateTime!
                                                    .isEmpty
                                                ? ''
                                                : "${widget.leadOpenAllData[i].LastUpdateMessage}",
                                            style: widget.theme.textTheme.bodyText2
                                                ?.copyWith(
                                              //color:theme.primaryColor,
                                              color: Colors.green[700],
                                              // fontWeight: FontWeight.bold
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: Screens.bodyheight(context) * 0.01,
                                ),

                                Container(
                                  // color: Colors.green[200],
                                  alignment: Alignment.centerLeft,
                                  width: Screens.width(context),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Text(
                                        widget.leadOpenAllData[i].LastUpdateTime!.isEmpty
                                            ? ''
                                            : "Last Updated: " +
                                                context
                                                    .watch<LeadTabController>()
                                                    .config
                                                    .subtractDateTime(
                                                        "${widget.leadOpenAllData[i].LastUpdateTime}"), //     "${context.watch<EnquiryUserContoller>().getopenEnqData[i].Status}",
                                        style:
                                            widget.theme.textTheme.bodyText2?.copyWith(
                                          color: Colors.grey,
                                          // color: Colors.green[700],
                                          // fontWeight: FontWeight.bold
                                        )),
                                  ),
                                )

                                // Container(
                                //     padding: EdgeInsets.symmetric(
                                //         horizontal: Screens.width(context) * 0.1),
                                //     child: Divider(
                                //       thickness: 1,
                                //     ))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
