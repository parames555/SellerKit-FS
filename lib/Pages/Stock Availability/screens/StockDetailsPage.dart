// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/Screen.dart';
import '../../../Constant/padings.dart';
import '../../../Controller/StockAvailabilityController/StockListController.dart';
import '../../../Widgets/Appbar.dart';
import '../../../Widgets/Navi3.dart';

class ListStockAvailability extends StatefulWidget {
  const ListStockAvailability({Key? key}) : super(key: key);

  @override
  State<ListStockAvailability> createState() => ListStockAvailabilityState();
}

class ListStockAvailabilityState extends State<ListStockAvailability> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //context.read<StockListController>().getDataFromDB();
    });
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Paddings paddings = Paddings();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
        key: scaffoldKey,
        appBar: appbar("Stock List", theme, context),
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
                 context.read<StockListController>().filterList(v);
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
                //             .watch<StockListController>()
                //             .getisLoadingListView ==
                //         true
                //     ? SkeletonListView(
                //         itemCount: 10,
                //         scrollable: true,
                //       )
                //     :
                     ListView.builder(
                        itemCount: context
                            .watch<StockListController>()
                            .getlistPriceAvail
                            .length,
                        itemBuilder: (BuildContext context, int i) {
                          return InkWell(
                            onTap: () {
                              // print(context.read<StockListController>().getlistPriceAvail[i].itemCode);
                              context
                                  .read<StockListController>()
                                  .callItemMasterPriceUpdateNew(
                                      context
                                          .read<StockListController>()
                                          .getlistPriceAvail[i]
                                          .itemCode!,
                                      context
                                          .read<StockListController>()
                                          .getlistPriceAvail[i]
                                          .IMId!,
                                      i);
                            },
                            child: Card(
                              elevation: 5,
                              child: context.watch<StockListController>().getlistPriceAvail[i].isselected==1?
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
                                              "Item code: ${context.watch<StockListController>().getlistPriceAvail[i].itemCode}",
                                              style: theme.textTheme.bodyText1
                                                  ?.copyWith(
                                                      color:
                                                          theme.primaryColor)),
                                        ),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          width: Screens.width(context) * 0.4,
                                          child: Text(
                                            context.watch<StockListController>().subtractDateTime(context.watch<StockListController>().getlistPriceAvail[i].refreshedRecordDate!),
                                         //   " ${context.watch<StockListController>().getlistPriceAvail[i].refreshedRecordDate}",
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
                                              "${context.watch<StockListController>().getlistPriceAvail[i].itemName}",
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
                                         // ConstantValues.sapUser=='Manager'?
                                          "Whs: ${context.watch<StockListController>().getlistPriceAvail[i].whsStock!.toStringAsFixed(0)}",
                                      // :'', 
                                         style: theme.textTheme.bodyText1
                                              ?.copyWith(
                                          color:
                                              theme.primaryColor),
                                        ),
                                        ),

                                           Container(
                                           alignment: Alignment.centerRight,
                                           child: Text(
                                             "Outlet: ${context.watch<StockListController>().getlistPriceAvail[i].storeStock!.toStringAsFixed(0)}",
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
