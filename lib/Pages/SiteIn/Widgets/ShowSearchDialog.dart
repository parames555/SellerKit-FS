// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../Constant/Screen.dart';
import '../../../Controller/SiteInController/SiteInController.dart';
import '../../../Controller/VisitplanController/NewVisitController.dart';

class SiteInShowDialog extends StatefulWidget {
  SiteInShowDialog({Key? key}) : super(key: key);
  @override
  State<SiteInShowDialog> createState() => ShowSearchDialogState();
}

class ShowSearchDialogState extends State<SiteInShowDialog> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      content: Container(
        width: Screens.width(context),
        height: Screens.bodyheight(context) * 0.5,
        child: Column(
          children: [
            TextFormField(
                controller:  context.read<SiteInController>().mycontroller[12],
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Required *";
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    context
                        .read<SiteInController>()
                        .filterListPurposeOfVisit(value);
                  });
                },
                decoration: InputDecoration(
                    hintText: 'Search here',
                    border: UnderlineInputBorder(),
                    enabledBorder: UnderlineInputBorder(),
                    focusedBorder: UnderlineInputBorder(),
                    errorBorder: UnderlineInputBorder(),
                    focusedErrorBorder: UnderlineInputBorder(),
                    // suffixIcon: InkWell(
                    //     onTap: () {},
                    //     child: Icon(Icons.search, color: theme.primaryColor)
                    //     )
                        )),
            Expanded(
              child: ListView.builder(
                itemCount: context
                    .watch<SiteInController>()
                    .filterpurposeofVisitList
                    .length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      context.read<SiteInController>().iscateSeleted(
                          context,
                          context
                              .read<SiteInController>()
                              .filterpurposeofVisitList[index].purpose);
                    },
                    child: Container(
                      width: Screens.width(context),
                      padding: EdgeInsets.all(5),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        width: Screens.width(context),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${context
                                .watch<SiteInController>()
                                .filterpurposeofVisitList[index].purpose}"),
                            Divider()
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}