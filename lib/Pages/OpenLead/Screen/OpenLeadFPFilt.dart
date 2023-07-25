import 'package:flutter/material.dart';

import '../../../Constant/Screen.dart';
import '../../../Controller/OpenLeadController/OpenLeadController.dart';
import '../Widegts/OpenLeadFDP.dart';

class ListViewOpenLead extends StatelessWidget {
   ListViewOpenLead({
    Key? key,
    required this.theme,
    required this.prdFUP
  }) : super(key: key);
OpenLeadController prdFUP;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
                  width: Screens.width(context),
                  height: Screens.bodyheight(context),
                  padding: EdgeInsets.symmetric(
                      horizontal: Screens.width(context) * 0.02,
                      vertical: Screens.bodyheight(context) * 0.01),
                  child: Column(
                    children: [
                      InkWell(
    onTap: (){
         prdFUP.getDistinct();
      prdFUP.firstPageNextBtn();
    },
    child: Container(
      height: Screens.bodyheight(context) * 0.06,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
              Screens.width(context) * 0.01),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.7),
              spreadRadius: 3,
              blurRadius: 4,
              offset:
                  Offset(0, 3), // changes position of shadow
            ),
          ]),
      child: TextField(
        onTap: (){
           prdFUP.getDistinct();
          prdFUP.firstPageNextBtn();
        },
        autocorrect: false,
        readOnly: true,
        onChanged: (v) {},
        decoration: InputDecoration(
          filled: false,
          hintText: 'All',
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          suffixIcon: Icon(
            Icons.filter_alt,
            color: theme.primaryColor,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 5,
          ),
        ),
      ),
    ),
                      ),
                      SizedBox(
    height: Screens.bodyheight(context) * 0.015,
                      ),
                      Expanded(
    child: ListView.builder(
      itemCount: prdFUP.getOpenLeadDataF.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onDoubleTap: () {
            showDialog<dynamic>(
                    context: context,
                    builder: (_) {
                      return OpenLeadFDP(index:index,followUPListData: prdFUP.getOpenLeadDataF[index]);
                    });
          },
          onLongPress: () {
             showDialog<dynamic>(
                  context: context,
                  builder: (_) {
                    return OpenLeadFDP(index:index,followUPListData: prdFUP.getOpenLeadDataF[index]);
                  });
          },
          child: Container(
            padding: EdgeInsets.symmetric(
                      // horizontal: Screens.width(context) * 0.02,
                      vertical: Screens.bodyheight(context) * 0.01),
            width: Screens.width(context),
            // padding: EdgeInsets.symmetric(
            //     horizontal: Screens.width(context) * 0.02,
            //     vertical: Screens.bodyheight(context) * 0.006),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal:
                          Screens.width(context) * 0.02,
                      vertical:
                          Screens.bodyheight(context) *
                              0.006),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius:
                          BorderRadius.circular(8),
                      border: Border.all(
                          color: Colors.black26)),
                  width: Screens.width(context),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: Screens.width(context) *
                                0.4,
                            child: Text(
                              "Customer",
                              style: theme
                                  .textTheme.bodyText2
                                  ?.copyWith(
                                      color: Colors.grey),
                            ),
                          ),
                          Container(
                            width: Screens.width(context) *
                                0.4,
                            child: Text(
                              "",
                              style: theme
                                  .textTheme.bodyText2
                                  ?.copyWith(
                                      color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: Screens.width(context) *
                                0.4,
                            child: Text("${prdFUP.getOpenLeadDataF[index].Customer}",
                                style: theme
                                    .textTheme.bodyText2
                                    ?.copyWith(
                                  color: theme.primaryColor,
                                )),
                          ),
                          Container(
                            width: Screens.width(context) *
                                0.4,
                            alignment:
                                Alignment.centerRight,
                            child: Text("# ${prdFUP.getOpenLeadDataF[index].LeadDocNum}",
                                style: theme
                                    .textTheme.bodyText2
                                    ?.copyWith(
                                  color: theme.primaryColor,
                                )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height:
                            Screens.bodyheight(context) *
                                0.01,
                      ),
                      Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: Screens.width(context),
                            child: Text(
                              "Product",
                              style: theme
                                  .textTheme.bodyText2
                                  ?.copyWith(
                                      color: Colors.grey),
                            ),
                          ),
                          Container(
                            width: Screens.width(context),
                            child: Text("${prdFUP.getOpenLeadDataF[index].Product}",
                                style: theme
                                    .textTheme.bodyText2),
                          ),
                        ],
                      ),
                      SizedBox(
                        height:
                            Screens.bodyheight(context) *
                                0.01,
                      ),
                     Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: Screens.width(context) * 0.4,
                child: Text("Next Follow up",
                    style: theme.textTheme.bodyText2
                        ?.copyWith(color: Colors.grey)),
              ),
              Container(
                width: Screens.width(context) * 0.4,
                //color: Colors.red,
                alignment: Alignment.centerRight,
                child: Text("Order Value",
                    style: theme.textTheme.bodyText2
                        ?.copyWith(color: Colors.grey)),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: Screens.width(context) * 0.4,
                child: Text(
                  prdFUP.config.alignDate(
                  "${prdFUP.getOpenLeadDataF[index].FollowupDate}"),
                    style: theme.textTheme.bodyText2
                        ?.copyWith()),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  alignment: Alignment.centerRight,
                  width: Screens.width(context) * 0.4,
                  child: Text(
                    prdFUP.config.slpitCurrency("${prdFUP.getOpenLeadDataF[index].DocTotal!.toStringAsFixed(0)}"),
                      style: theme.textTheme.bodyText2
                          ?.copyWith()),
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
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                left:
                                    Screens.width(context) *
                                        0.02,
                                right:
                                    Screens.width(context) *
                                        0.02,
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.green[200],
                                  borderRadius:
                                      BorderRadius.circular(
                                          4)),
                              child: Text(
                                  "${prdFUP.getOpenLeadDataF[index].LastFollowupStatus} ",
                                  style: theme
                                      .textTheme.bodyText2
                                      ?.copyWith(
                                    color:
                                        Colors.green[700],
                                  )),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height:
                            Screens.bodyheight(context) *
                                0.01,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        width: Screens.width(context),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(4)),
                          child: Text( prdFUP.getOpenLeadDataF[index].LastFollowupDate!=''?
              prdFUP.config.subtractDateTime("${prdFUP.getOpenLeadDataF[index].LastFollowupDate}") :'',
                              style: theme
                                  .textTheme.bodyText2
                                  ?.copyWith(
                                color: Colors.grey,
                              )),
                        ),
                      )
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
                    ],
                  ),
                );
  }
}