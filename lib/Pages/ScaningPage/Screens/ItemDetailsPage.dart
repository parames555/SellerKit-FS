import 'package:flutter/material.dart';

import '../../../Widgets/Appbar.dart';
import '../../../Widgets/Navi3.dart';

class ItemDetailsPage extends StatefulWidget {
  const ItemDetailsPage({Key? key}) : super(key: key);

  @override
  State<ItemDetailsPage> createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
         appBar: appbar("Scanning Page", theme, context),
        drawer: drawer3(context),
      body: Container(
        
      ));
  }
}