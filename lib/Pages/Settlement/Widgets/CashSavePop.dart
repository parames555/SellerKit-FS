// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../Constant/Screen.dart';
import '../../../../Controller/EnquiryController/EnquiryUserContoller.dart';
import '../../../Controller/SettlementController/SettlementController.dart';
import 'SettlementSuccessBox.dart';

class CashAlertBox extends StatefulWidget {
  CashAlertBox({
    Key? key,
  }) : super(key: key);
  // final int indx;
  @override
  State<CashAlertBox> createState() => CashAlertBoxState();
}

class CashAlertBoxState extends State<CashAlertBox> {
  @override
  void initState() {
    setState(() {
          context.read<SettlementController>().settleTocash = null;

    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      insetPadding: EdgeInsets.all(10),
      contentPadding: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: enqDetailsPage(context, theme),
    );
  }

  Container enqDetailsPage(BuildContext context, ThemeData theme) {
    return Container(
      //  color: Colors.black12,
      // height: Screens.bodyheight(context) * 0.4,
      width: Screens.width(context),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: Screens.width(context),
              height: Screens.bodyheight(context) * 0.06,
              child: ElevatedButton(
                  onPressed: () {
                    // context.read<LeadTabController>().viweDetailsClicked();
                  },
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(
                        // fontSize: 12,
                        ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )), //Radius.circular(6)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Settlement Details",
                      ),
                    ],
                  )),
            ),
            Container(
              padding: EdgeInsets.only(
                left: Screens.width(context) * 0.05,
                right: Screens.width(context) * 0.05,
                top: Screens.bodyheight(context) * 0.03,
                bottom: Screens.bodyheight(context) * 0.03,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: Screens.bodyheight(context) * 0.02,
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Total Amount Rs.${context.read<SettlementController>().totalcash()}",
                      style: theme.textTheme.bodySmall!
                          .copyWith(color: Colors.grey),
                    ),
                  ),
                  Container(
                    width: Screens.width(context),
                    child: DropdownButton(
                      hint: Text("Settlement"),
                      // value: context.read<EnquiryUserContoller>(). valueChosedReason,
                      //dropdownColor:Colors.green,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 30,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      isExpanded: true,
                      value: context.read<SettlementController>().settleTocash,
                      onChanged: (val) {
                        setState(() {
                          context
                              .read<SettlementController>()
                              .chooseSettleToCash(val.toString());
                        });
                      },
                      items: <String>[
                        "HDFC BANK",
                        "CANARA BANK",
                        "AXIS BANK",
                        "SBI BANK",
                      ].map((String value) {
                        return DropdownMenuItem(
                            value: value, child: Text(value.toString()));
                      }).toList(),
                    ),
                  ),
                  TextFormField(
                      // controller: context
                      //     .read<NewCollectionContoller>()
                      //     .mycontroller[6],
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return "Enter Reference";
                      //   }
                      //   return null;
                      // },
                      decoration: InputDecoration(
                    labelText: 'Reference',
                    labelStyle:
                        theme.textTheme.bodyText1!.copyWith(color: Colors.grey),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      //  when the TextFormField in unfocused
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      //  when the TextFormField in focused
                    ),
                    border: UnderlineInputBorder(),
                    // enabledBorder: UnderlineInputBorder(),
                    // focusedBorder: UnderlineInputBorder(),
                    errorBorder: UnderlineInputBorder(),
                    focusedErrorBorder: UnderlineInputBorder(),
                  ))
                ],
              ),
            ),
            Container(
              width: Screens.width(context),
              height: Screens.bodyheight(context) * 0.06,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => SettlementSuccessPage()));

                  // context
                  //     .read<EnquiryUserContoller>()
                  //     .mapValuesToLead(widget.indx);
                },
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(
                      // fontSize: 12,
                      ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )), //Radius.circular(6)
                ),
                child: Text(
                  "Save",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
