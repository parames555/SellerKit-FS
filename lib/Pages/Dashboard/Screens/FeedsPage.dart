// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:async';
// import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../Constant/Screen.dart';
import '../../../Constant/padings.dart';
import '../../../Controller/DashBoardController/DashBoardController.dart';
import 'NewFeedContainer.dart';

class FeedsPage extends StatefulWidget {
  FeedsPage({Key? key, required this.pvdDSBD}) : super(key: key);
  DashBoardController pvdDSBD;
  @override
  State<FeedsPage> createState() => _FeedsPageState();
}

class _FeedsPageState extends State<FeedsPage> {
  StreamController<Widget> overlayController =
      StreamController<Widget>.broadcast();
  Paddings paddings = Paddings();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        Container(
          width: Screens.width(context),
          height: Screens.bodyheight(context),
          padding: paddings.padding3(context),
          child: Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: (){
                   return  widget.pvdDSBD.refreshFeeds();
                  },
                  child: ListView.builder(
                    itemCount: widget.pvdDSBD.feedData.length,
                    itemBuilder: (BuildContext context, int i) {
                      return
                          //     FeedContainer(
                          //   selected: '\u{1F44D}',
                          //   feedData:  widget.pvdDSBD.feedData[i],
                          //   pvdDSBD: widget.pvdDSBD,
                          // );

                          FeedContainerNew(
                            feedData:  widget.pvdDSBD.feedData[i],
                            pvdDSBD: widget.pvdDSBD,
                            selected: '\u{1F44D}',
                            );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),

            Visibility(
              visible: widget.pvdDSBD.getreactionvisible,
              child: Container(
                alignment: Alignment.center,
                width:  Screens.width(context),
                height: Screens.fullHeight(context),
                child: Lottie.asset("Assets/91069-like.json",
                 animate: true,
                 repeat: true,
                 height: Screens.fullHeight(context),
                 width: Screens.width(context) ),
              ),
            )
      ],
    );
  }
}
