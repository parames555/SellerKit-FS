// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Controller/FollowupController/FollowUPController.dart';
import '../../../Widgets/Navi3.dart';
import '../widgets/FollowUPCommingPage.dart';
import '../widgets/FollowUPODue.dart';

class FollowUpTab extends StatefulWidget {
  FollowUpTab({Key? key}) : super(key: key);

  @override
  State<FollowUpTab> createState() => _FollowUpTabState();
}

class _FollowUpTabState extends State<FollowUpTab>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Overdue'),
    Tab(text: 'Upcoming'),
  ];
  TabController? controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = new TabController(vsync: this, length: 2, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: theme.primaryColor,
          bottom: TabBar(
            controller: controller,
            tabs: myTabs,
          ),
          title: Text('Followup'),
        ),
        drawer: drawer3(context),
        body: ChangeNotifierProvider<FollowupController>(
            create: (context) => FollowupController(),
            builder: (context, child) {
              return Consumer<FollowupController>(
                  builder: (BuildContext context, prdFUP, Widget? child) {
                return (prdFUP.getisLoading == true &&
                        prdFUP.getexcepMsg.isEmpty)
                    ? Center(child: CircularProgressIndicator())
                    : (prdFUP.getisLoading == false &&
                            prdFUP.getexcepMsg.isNotEmpty)
                        ? Center(child: Text(prdFUP.getexcepMsg))
                        : TabBarView(controller: controller, children: [
                            FollowUPODue(prdFUP: prdFUP),
                            FollowUPComming(prdFUP: prdFUP)
                          ]);
              });
            }));
  }
}
