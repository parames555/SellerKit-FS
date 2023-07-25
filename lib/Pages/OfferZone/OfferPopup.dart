// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Controller/OfferZoneController/OfferZoneController.dart';

import '../../Models/OfferZone/OfferZoneModel.dart';

class DiviceDialogBox extends StatelessWidget {
  DiviceDialogBox(
      {Key? key, required this.theme, required this.i, required this.popvalues})
      : super(key: key);
  final ThemeData theme;
  List<OfferZoneData> popvalues = [];
  int i;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
        insetPadding: EdgeInsets.all(10),
        // insetPadding: EdgeInsets.all(6),
        contentPadding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: theme.primaryColor)),
        content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  padding: EdgeInsets.only(
                    top: Screens.bodyheight(context) * 0.02,
                    left: Screens.bodyheight(context) * 0.02,
                    right: Screens.bodyheight(context) * 0.02,
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "${popvalues[i].item}",
                          style: theme.textTheme.bodyText1
                              ?.copyWith(color: theme.primaryColor),
                        ),
                        SizedBox(
                          height: Screens.bodyheight(context) * 0.02,
                        ),
                        Text(
                          "${popvalues[i].offerName}",
                          style: theme.textTheme.bodySmall
                              ?.copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: Screens.bodyheight(context) * 0.02,
                        ),
                        Text(
                          "${popvalues[i].offerDetails}",
                          style: theme.textTheme.bodySmall
                              ?.copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: Screens.bodyheight(context) * 0.03,
                        ),
                        Text(
                          "${popvalues[i].discoutDetails}",
                          style: theme.textTheme.bodyText1?.copyWith(),
                        ),
                      ])),
              SizedBox(
                height: Screens.bodyheight(context) * 0.02,
              ),
              Container(
                  height: Screens.bodyheight(context) * 0.05,
                  padding: EdgeInsets.all(6),
                  alignment: Alignment.center,
                  width: Screens.width(context),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5)),
                    color: theme.primaryColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Screens.width(context) * 0.02),
                        width: Screens.width(context) * 0.5,
                        child: Text(
                          "${popvalues[i].validTill}",
                          style: theme.textTheme.bodyText1
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.symmetric(
                            horizontal: Screens.width(context) * 0.02),
                        width: Screens.width(context) * 0.2,
                        //color: Colors.green,
                        child: Text(
                          "${popvalues[i].incentive}",
                          style: theme.textTheme.bodyText1
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  )),
            ]));
  }
}
