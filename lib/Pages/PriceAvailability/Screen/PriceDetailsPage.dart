// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/Screen.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Constant/padings.dart';
import '../../../Controller/PriceListController/PriceListController.dart';
import '../../../Widgets/Appbar.dart';
import '../../../Widgets/Navi3.dart';

class ListPriceAvailability extends StatefulWidget {
  const ListPriceAvailability({Key? key}) : super(key: key);

  @override
  State<ListPriceAvailability> createState() => PriceAvailability2State();
}

class PriceAvailability2State extends State<ListPriceAvailability> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //context.read<PriceListController>().getDataFromDB();
    });
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Paddings paddings = Paddings();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
        key: scaffoldKey,
        appBar: appbar("Price Availability", theme, context),
        drawer: drawer3(context),
        body: Container(
          width: Screens.width(context),
          height: Screens.bodyheight(context),
          padding: paddings.padding2(context),
          child: Column(
            children: [
              SizedBox(height: Screens.bodyheight(context)*0.01,),
             // SearchWidget(themes: theme),
             Container(
               height: Screens.bodyheight(context) * 0.06,
               decoration: BoxDecoration(
                 color: theme.primaryColor
                     .withOpacity(0.1), //Colors.grey[200],
                 borderRadius: BorderRadius.circular(
                     Screens.width(context) * 0.02),
               ),
               child: TextField(
                 autocorrect: false,
                 onChanged: (v) {
                 context.read<PriceListController>().filterList(v);
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
                     color: theme.primaryColor,
                   ),
                   contentPadding: const EdgeInsets.symmetric(
                     vertical: 12,
                     horizontal: 5,
                   ),
                 ),
               ),
             ),
               SizedBox(height: Screens.bodyheight(context)*0.005,),
              Expanded(
                child: 
                // context
                //             .watch<PriceListController>()
                //             .getisLoadingListView ==
                //         true
                //     ? SkeletonListView(
                //         itemCount: 10,
                //         scrollable: true,
                //       )
                //     :
                     ListView.builder(
                        itemCount: context
                            .watch<PriceListController>()
                            .getlistPriceAvail
                            .length,
                        itemBuilder: (BuildContext context, int i) {
                          return InkWell(
                            onTap: () {
                              // print(context.read<PriceListController>().getlistPriceAvail[i].itemCode);
                              context
                                  .read<PriceListController>()
                                  .callItemMasterPriceUpdateNew(
                                      context
                                          .read<PriceListController>()
                                          .getlistPriceAvail[i]
                                          .itemCode!,
                                      context
                                          .read<PriceListController>()
                                          .getlistPriceAvail[i]
                                          .IMId!,
                                      i);
                            },
                            child: Card(
                              elevation: 5,
                              child: context.watch<PriceListController>().getlistPriceAvail[i].isselected==1?
                              Container(
                                width: Screens.width(context),
                                 padding: EdgeInsets.symmetric(
                                    vertical:
                                        Screens.bodyheight(context) * 0.05,
                                    horizontal: Screens.width(context) * 0.02),
                              child: Center(
                                child: CircularProgressIndicator(strokeWidth: 2,),
                              ),
                              )
                              :
                              Container(
                                width: Screens.width(context),
                                padding: EdgeInsets.symmetric(
                                    vertical:
                                        Screens.bodyheight(context) * 0.01,
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
                                              "Item code: ${context.watch<PriceListController>().getlistPriceAvail[i].itemCode}",
                                              style: theme.textTheme.bodyText1
                                                  ?.copyWith(
                                                      color:
                                                          theme.primaryColor)),
                                        ),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          width: Screens.width(context) * 0.4,
                                          child: Text(
                                            context.watch<PriceListController>().subtractDateTime(context.watch<PriceListController>().getlistPriceAvail[i].refreshedRecordDate!),
                                         //   " ${context.watch<PriceListController>().getlistPriceAvail[i].refreshedRecordDate}",
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
                                      height:
                                          Screens.bodyheight(context) * 0.01,
                                    ),
                                       Container(
                                        //  color: Colors.red,
                                          width: Screens.width(context) ,
                                          child: Text(
                                              "${context.watch<PriceListController>().getlistPriceAvail[i].itemName}",
                                              style: theme.textTheme.bodyText1
                                                  ?.copyWith(
                                                      //color: theme.primaryColor
                                                      )),
                                        ),
                                         SizedBox(
                                      height:
                                          Screens.bodyheight(context) * 0.01,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          ConstantValues.sapUserType.toLowerCase()=='manager'?
                                          "${context.watch<PriceListController>().getlistPriceAvail[i].mgrPrice}"
                                       :'', 
                                         style: theme.textTheme.bodyText1
                                              ?.copyWith(
                                          color:
                                              theme.primaryColor),
                                        ),
                                        ),

                                           Container(
                                           alignment: Alignment.centerRight,
                                           child: Text(
                                             "${context.watch<PriceListController>().getlistPriceAvail[i].slpPrice}",
                                             style: theme.textTheme.bodyText1
                                                 ?.copyWith(
                                             color:
                                                 theme.primaryColor),
                                           ),
                                        ),
                                    
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                          //)));
                        },
                      ),
              )
            ],
          ),
        ));
  }
}
