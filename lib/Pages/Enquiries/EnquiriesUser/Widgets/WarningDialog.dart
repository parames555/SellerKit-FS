// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import '../../../../Constant/ConstantSapValues.dart';
import '../../../../Constant/Screen.dart';
import '../../../../Controller/EnquiryController/EnquiryMngController.dart';
import '../../../../Controller/EnquiryController/EnquiryUserContoller.dart';
import '../../../../Controller/LeadController/TabLeadController.dart';

class WarningDialog extends StatefulWidget {
  WarningDialog({
    Key? key,
  }) : super(key: key);
  @override
  State<WarningDialog> createState() => AssignedToDialogUserState();
}

class AssignedToDialogUserState extends State<WarningDialog> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
        insetPadding: EdgeInsets.all(10),
        contentPadding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: statusRespPage(context, theme));
  }

  Container statusRespPage(BuildContext context, ThemeData theme) {
    return Container(
      width: Screens.width(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: Screens.width(context),
            height: Screens.bodyheight(context) * 0.06,
            child: ElevatedButton(
                onPressed: () {},
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
                child: Text(
                  "Alert",
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
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                    child: Text(
                  "This Customer has an open ${EnquiryUserContoller.typeOfDataCus} with ${EnquiryUserContoller.typeOfDataCusBranch} branch..!!",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyText1?.copyWith(
                      //color:Colors.green
                      ),
                )),
                SizedBox(
                  height: Screens.bodyheight(context) * 0.01,
                ),
                Center(
                    child: Text(
                  "Click open to view this details",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall?.copyWith(
                      //color:Colors.green
                      ),
                )),
                SizedBox(
                  height: Screens.bodyheight(context) * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        // context.read<EnquiryUserContoller>().checkDialogCon();
                        Navigator.pop(context);
                        context
                            .read<EnquiryUserContoller>()
                            .isAnotherBranchEnq = false;
                        context.read<EnquiryUserContoller>().resetAll(context);
                      },
                      child: Text(
                        "Cancel",
                        style: theme.textTheme.bodyText1
                            ?.copyWith(color: Colors.white),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              theme.primaryColor)),
                    ),
                    TextButton(
                      onPressed: () {
                        //print(EnquiryUserContoller.typeOfDataCusBranch);
                        ///context.read<EnquiryUserContoller>().checkDialogCon();
                        if (EnquiryUserContoller.typeOfDataCus == "Enquiry") {
                         // if (ConstantValues.sapUser != 'Manager') {
                            displayUserEnqDialog();
                         // }
                          //  else {
                          //   displayMngrEnqDialog();
                          // }
                        } else {
                          callLeadPage();
                        }
                      },
                      child: Text(
                        "Open",
                        style: theme.textTheme.bodyText1
                            ?.copyWith(color: Colors.white),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              theme.primaryColor)),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  displayMngrEnqDialog() {
    if (EnquiryMangerContoller.typeOfDataCusBranch == 'this') {
      context.read<EnquiryMangerContoller>().isAnotherBranchEnq = false;
      Navigator.pop(context);
      context.read<EnquiryMangerContoller>().callDialog(context, 0);
    } else {
      context.read<EnquiryMangerContoller>().isAnotherBranchEnq = true;
      Navigator.pop(context);
      context.read<EnquiryMangerContoller>().callDialog(context, 0);
    }
  }

  displayUserEnqDialog() {
    if (EnquiryUserContoller.typeOfDataCusBranch == 'this') {
      context.read<EnquiryUserContoller>().isAnotherBranchEnq = false;
      Navigator.pop(context);
      context.read<EnquiryUserContoller>().callDialog(context, 0);
    } else {
      context.read<EnquiryUserContoller>().isAnotherBranchEnq = true;
      Navigator.pop(context);
      context.read<EnquiryUserContoller>().callDialog(context, 0);
    }
  }

  callLeadPage() {
    print("Lead");
    if (EnquiryUserContoller.typeOfDataCusBranch == 'this') {
      LeadTabController.comeFromEnq = EnquiryUserContoller.enqDataprev;
      LeadTabController.isSameBranch = true;
      Navigator.pop(context);
      Get.toNamed(ConstantRoutes.leadstab);
    } else {
      //  Navigator.pop(context);
      // Get.toNamed(ConstantRoutes.leads);
      LeadTabController.comeFromEnq = EnquiryUserContoller.enqDataprev;
      LeadTabController.isSameBranch = false;
      Navigator.pop(context);
      Get.toNamed(ConstantRoutes.leadstab);
    }
  }
}
