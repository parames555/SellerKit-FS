// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';

import '../../../Constant/Screen.dart';
import '../../../Constant/padings.dart';
import '../../../Controller/DayStartEndController/DayStartEndController.dart';
import '../../../Widgets/Appbar.dart';
import '../../../Widgets/Navi3.dart';
import '../../../Widgets/SucessDialagBox.dart';

class cameraPage extends StatefulWidget {
  const cameraPage({Key? key});

  @override
  State<cameraPage> createState() => _cameraPageState();
}

class _cameraPageState extends State<cameraPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Paddings paddings = Paddings();

  @override
  void initState() {
    // TODO: implement initState

// callKpiApi();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        context.read<DayStartEndController>().ima = null;
        context.read<DayStartEndController>().clearAll();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      key: scaffoldKey,
      appBar: appbar("", theme, context),
      drawer: drawer3(context),
      body: Column(
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
                  height: Screens.bodyheight(context) * 0.894,
                  padding: EdgeInsets.symmetric(
                      horizontal: Screens.width(context) * 0.015,
                      vertical: Screens.bodyheight(context) * 0.005),
                  child: context.watch<DayStartEndController>().ima != null
                      ? Image.file(context.read<DayStartEndController>().ima!)
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  context
                                      .read<DayStartEndController>()
                                      .imagetoBinary(ImageSource.camera);
                                });
                              },
                              child: Container(
                                  //  color: Colors.grey,
                                  width: Screens.width(context) * 0.2,
                                  height: Screens.bodyheight(context) * 0.1,
                                  child: IconButton(
                                      iconSize: 56,
                                      onPressed: () {
                                        context
                                            .read<DayStartEndController>()
                                            .imagetoBinary(ImageSource.camera);
                                      },
                                      icon: Icon(
                                        Icons.photo_camera,
                                        color: Colors.grey,
                                      ))),
                            ),
                          ],
                        ))),
          Container(
            width: Screens.width(context),
            height: Screens.bodyheight(context) * 0.077,
            padding: EdgeInsets.symmetric(
                horizontal: Screens.width(context) * 0.015,
                vertical: Screens.bodyheight(context) * 0.005),
            child: ElevatedButton(
                onPressed: () async {
                  context
                      .read<DayStartEndController>()
                      .validateDayStart(context);
                  // Get.toNamed(ConstantRoutes.cameraPage);
                },
                style: ElevatedButton.styleFrom(
                  primary: theme.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Confirm')),
          ),
        ],
      ),
    );
  }
}
