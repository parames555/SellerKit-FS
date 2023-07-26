// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_string_interpolations, unnecessary_brace_in_string_interps

import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Controller/ConfigurationController/ConfigurationController.dart';
import '../../Constant/AppConstant.dart';

class ConfigurationPage extends StatefulWidget {
  ConfigurationPage({Key? key}) : super(key: key);

  @override
  State<ConfigurationPage> createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  StreamSubscription? _intentDataStreamSubscription;
  List<SharedMediaFile>? _sharedFiles;
  String? _sharedText;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    ///  print("object");
    // For sharing or opening urls/text coming from outside the app while the app is in the memory
    _intentDataStreamSubscription =
        ReceiveSharingIntent.getTextStream().listen((value) {
      setState(() {
        _sharedText = value;
      });
      log("getTextStream: ${value}, ${_sharedText}");
      print("getTextStream: ${value}, ${_sharedText}");
    }, onError: (err) {
      print("getLinkStream error: $err");
    });

    // For sharing or opening urls/text coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialText().then((value) {
      setState(() {
        _sharedText = value;
      });
      log("getTextStream: ${value}, ${_sharedText}");
      print("getTextStream: ${value}, ${_sharedText}");
    });

    if (_sharedText == null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
         context.read<ConfigurationContoller>().checkStartingPage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: Screens.width(context),
          height: Screens.fullHeight(context),
        ));
  }
}
