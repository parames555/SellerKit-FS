// ignore_for_file: unnecessary_new, prefer_const_constructors, unnecessary_string_interpolations, prefer_interpolation_to_compose_strings, avoid_print
import 'dart:developer';
import 'dart:io';
import 'package:charts_flutter/flutter.dart' as charts;
// import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:screen_capture_event/screen_capture_event.dart';
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/DBHelper/DBHelper.dart';
import 'package:sellerkit/Services/LocalNotification/LocalNotification.dart';
import 'package:sellerkit/Services/LogoutApi/LogoutApi.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../Constant/ConstantRoutes.dart';
import '../../Constant/ConstantSapValues.dart';
import '../../Constant/Helper.dart';
import '../../Constant/Screen.dart';
import '../../Models/DashBoardModels/SegementWiseModel.dart';
import '../../Models/DashBoardModels/TargetAchievementsModel.dart';
import '../../Models/GridContainerModels/GridContainerModel.dart';
import '../../Models/KpiModel/KpiModel.dart';
import '../../Models/PostQueryModel/FeedsModel/FeedsModel.dart';
import '../../Services/DashBoardApi/FeedsApi/FeedsApi.dart';
import '../../Services/DashBoardApi/FeedsApi/ReactionApi.dart';
import '../../Services/DashBoardApi/KpiApi/KpiApi.dart';
import '../../Services/URL/LocalUrl.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class DashBoardController extends ChangeNotifier {
  LocalNotificationService localNotificationService =  LocalNotificationService();
final ScreenCaptureEvent screenListener = ScreenCaptureEvent();
  Config config =  Config();
  DashBoardController() {
 //  getUnSeenNotify();
     //setURL();
    if(isLogout == false){
     getDefaultValues();
    }else if(isLogout == true){
     logoutSession();
    }
   //onReciveFCM();
   trackScreenShot();
  }

  var text;
List<File> file  = [];
  trackScreenShot(){
        screenListener.addScreenRecordListener((recorded) {
        ///Recorded was your record status (bool)
            text = recorded ? "Start Recording" : "Stop Recording";
    });

    screenListener.addScreenShotListener((filePath) {
        ///filePath only available for Android
            text = "Screenshot stored on : $filePath";
            file.add(File(filePath));
    });

    ///You can add multiple listener ^-^
    screenListener.addScreenRecordListener((recorded) {
        print("Hi i'm 2nd Screen Record listener");
    });
    screenListener.addScreenShotListener((filePath) {
        print("Wohooo i'm 2nd Screenshot listener");
    });

    screenListener.watch();
  }

    setURL() async {
    String? getUrl = await HelperFunctions.getHostDSP();
    Url.queryApi = "http://$getUrl/api/";
  }

  // int? unSeenNotify;
  // int get getunSeenNotify=>unSeenNotify!=null?unSeenNotify!:0;

//   onReciveFCM(){
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       List<NotificationModel> notify = [];
//   if (message.notification != null) {
//    localNotificationService.showNitification(titile:message.notification!.title,msg:message.notification!.body);
//  notify.add(
//   NotificationModel(
//     docEntry: int.parse(message.data['DocEntry'].toString()),
//     titile: message.notification!.title, 
//     description: message.notification!.body!, 
//     receiveTime: config.currentDate(), 
//     seenTime: '0', ));
    
//   dbHelper.insertNotification(notify);
//    NotificationUpdateApi.getData(
//     docEntry: int.parse(message.data['DocEntry'].toString()),
//     deliveryDT: config.currentDate(),
//     readDT: 'null',
//     deviceCode: 'null'
//   );
//   print("repeat 1 dash");
//   }
// });
// }

@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }



// getUnSeenNotify()
// async{
//   unSeenNotify = await dbHelper.getUnSeenNotificationCount();
//   notifyListeners();
// }
  static bool isLogout = false;

  logoutSession()async{
    //  HelperFunctions.clearLicenseKeyDSharedPref();
    //  HelperFunctions.clearUserCodeDSharedPref();
    
    HelperFunctions.clearUserLoggedInSharedPref();
    HelperFunctions.clearUserName();
     LogoutAPi.getData().then((value) {
     isLogout = false;
     Get.offAllNamed(ConstantRoutes.login);
     });
  }

//  Future<void> listener( int j) async{
//     log("ssdasdasdada $j");
//     for (int i = 0; i < feedData2.length; i++) {
  //log("i $i");
  //   if (i != j) {
  // log("i!=j: $i");
  // FijkState? state = feedData2[i].player!.state;
  // if (state == FijkState.started) {
  //   if( feedData2[i].player!=null){
  //     feedData2[i].player!.pause();
  //  log("sate::: ${feedData2[i].player!.state}");
  //   }
  // } else if (state == FijkState.paused) {
  //  feedData2[i].player!.start();
  // } else if (state == FijkState.completed) {
  //   feedData2[i].player!.start();
  // }

  // }
  // if(i != j){
  //   if( feedData2[i].player!=null){
  //     await feedData2[i].player!.pause();
  //  log("if sate $i::: ${feedData2[i].player!.state}");
  //   }
  // }
  // else{
  //    if( feedData2[i].player!=null){
  //  log("else sate $i::: ${feedData2[i].player!.state}");
  //   }
  // }
  //   }
  // }

  String data = '';

  int feedint = 0;

  value() {
    data = 'final';
  }

  WebViewController? controllerGlobal;
  final LocalAuthentication auth = LocalAuthentication();

  checkAuth() async {
    try {
      final bool didAuthenticate = await auth.authenticate(
          localizedReason: 'Please authenticate to show account balance',
          options: const AuthenticationOptions(useErrorDialogs: false));
    } on PlatformException catch (e) {
      if (e.code == auth_error.notEnrolled) {
        print("if: " + e.code.toString());
      } else if (e.code == auth_error.lockedOut ||
          e.code == auth_error.permanentlyLockedOut) {
        print("else if: " + e.code.toString());
      } else {
        print("else: ");
      }
    }
  }

  Future<int> getDefaultValues() async {
    int i = 0;
    await HelperFunctions.getSapURLSharedPreference().then((value) {
      if (value != null) {
        Url.SLUrl = value;
      }
      i = i + 1;
    });
    await HelperFunctions.getSlpCode().then((value) {
      if (value != null) {
        ConstantValues.slpcode = value;
     
      }
      i = i + 1;
    });
    await HelperFunctions.getSessionIDSharedPreference().then((value) {
      if (value != null) {
        ConstantValues.sapSessions = value;
      }
      i = i + 1;
    });

    await HelperFunctions.getFSTNameSharedPreference().then((value) {
      if (value != null) {
        ConstantValues.firstName = value;
        notifyListeners();
      }
    });

    await HelperFunctions.getmProfilePicSharedPreference().then((value) {
      if (value != null) {
        ConstantValues.profilepic = value;
      }
    });
    await HelperFunctions.getLSTNameSharedPreference().then((value) {
      if (value != null) {
        ConstantValues.lastName = value;
      }
    });
    await HelperFunctions.getemailSharedPreference().then((value) {
      if (value != null) {
        ConstantValues.mailId = value;
      }
    });
    await HelperFunctions.getmobileSharedPreference().then((value) {
      if (value != null) {
        ConstantValues.phoneNum = value;
      }
    });
    await HelperFunctions.getBranchSharedPreference().then((value) {
      if (value != null) {
        ConstantValues.branch = value;
      }
    });
    await HelperFunctions.getDeviceIDSharedPreference().then((value) {
      if (value != null) {
        ConstantValues.deviceId = value;
      }
    });
    await HelperFunctions.getManagerPhoneSharedPreference().then((value) {
      if (value != null) {
        ConstantValues.managerPhonenum = value;
      }
    });

        await HelperFunctions.getUserType().then((value) {
      if (value != null) {
        ConstantValues.sapUserType  = value;
      }
    });
//
// log("Profile pic : ${ConstantValues.profilepic}");
// log("firstName : ${ConstantValues.firstName}");
    notifyListeners();
    await callFeedsApi();
    await callKpiApi();
    notifyListeners();
    return i;
  }

  BuildContext? context;
  List<charts.Series<TargetAchievmentModel, String>> createSampleData() {
    final desktopSalesData = [
      new TargetAchievmentModel('2014', 5),
      new TargetAchievmentModel('2015', 25),
      new TargetAchievmentModel('2016', 100),
      new TargetAchievmentModel('2017', 75),
    ];

    final tableSalesData = [
      new TargetAchievmentModel('2014', 25),
      new TargetAchievmentModel('2015', 50),
      new TargetAchievmentModel('2016', 10),
      new TargetAchievmentModel('2017', 20),
    ];

    return [
      new charts.Series<TargetAchievmentModel, String>(
        id: 'Desktop',
        domainFn: (TargetAchievmentModel sales, _) => sales.year,
        measureFn: (TargetAchievmentModel sales, _) => sales.sales,
        data: desktopSalesData,
      ),
      new charts.Series<TargetAchievmentModel, String>(
        id: 'Tablet',
        domainFn: (TargetAchievmentModel sales, _) => sales.year,
        measureFn: (TargetAchievmentModel sales, _) => sales.sales,
        data: tableSalesData,
      ),
    ];
  }

  ////
  Map<String, double> dataMap = {
    "STAB": 40,
    "SBS": 40,
    "DC": 20,
    "FF": 20,
  };

  List<charts.Series<SegmentWiseModel, DateTime>> createSampleData2() {
    final us_data = [
      new SegmentWiseModel(new DateTime(2017, 9, 19), 5),
      new SegmentWiseModel(new DateTime(2017, 9, 26), 25),
      new SegmentWiseModel(new DateTime(2017, 10, 3), 78),
      new SegmentWiseModel(new DateTime(2017, 10, 10), 54),
    ];

    final uk_data = [
      new SegmentWiseModel(new DateTime(2017, 9, 19), 15),
      new SegmentWiseModel(new DateTime(2017, 9, 26), 33),
      new SegmentWiseModel(new DateTime(2017, 10, 3), 68),
      new SegmentWiseModel(new DateTime(2017, 10, 10), 48),
    ];

    return [
      new charts.Series<SegmentWiseModel, DateTime>(
        id: 'US Sales',
        domainFn: (SegmentWiseModel sales, _) => sales.time,
        measureFn: (SegmentWiseModel sales, _) => sales.sales,
        data: us_data,
      ),
      new charts.Series<SegmentWiseModel, DateTime>(
        id: 'UK Sales',
        domainFn: (SegmentWiseModel sales, _) => sales.time,
        measureFn: (SegmentWiseModel sales, _) => sales.sales,
        data: uk_data,
      )
    ];
  }

  List<GridConValue> data21 = [
    GridConValue("New customers", "45", 'fcedee'),
    GridConValue("Repeated", "13", 'ebf4fa'),
    GridConValue("Institution Customers", "4", 'ebfaef'),
  ];

  DateTime? currentBackPressTime;
  Future<bool> onbackpress() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
    //  print("are you sure");
      const snackBar = SnackBar(
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red,
        content: Text(
          'Are you want to exit press again!!..',
          style: TextStyle(color: Colors.white),
        ),
      );
      ScaffoldMessenger.of(context!).showSnackBar(snackBar);
      return Future.value(false);
    }
    ScaffoldMessenger.of(context!).removeCurrentSnackBar();
    return Future.value(true);
  }

  //// Feeds controller

  // List<FijkPlayer> player2 = [];
  String feedsApiExcp = '';
  String get getfeedsApiExcp => feedsApiExcp;
  bool isloading = false;
  bool get getisloading => isloading;
  List<FeedsModalData> feedData = [];
  List<FeedsModalData> get getfeedData => feedData;

  // List<FeedsModalData> feedData2 = [];
  // List<FeedsModalData> get getfeedData2 => feedData;
  callFeedsApi() async {
    isloading = true;
    notifyListeners();
    await FeedsApi.getData(ConstantValues.slpcode).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.leadcheckdata != null) {
          feedData = value.leadcheckdata!;
          isloading = false;
          log("cames");
          evictImage(feedData[0].ProfilePic!);
          //iniS();
          // initializedData();
          notifyListeners();
        } else {
          feedsApiExcp = 'Something went wrong try again...!!';
          isloading = false;
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        feedsApiExcp = 'Something went wrong try again...!!';
        isloading = false;
        notifyListeners();
      } else if (value.stcode == 500) {
        if (value.exception == 'No route to host') {
          feedsApiExcp = 'Something went wrong try again...!!';
          isloading = false;
          notifyListeners();
        } else {
          feedsApiExcp = 'Something went wrong try again...!!';
          isloading = false;
          notifyListeners();
        }
      }
      notifyListeners();
    });
  }

  void evictImage(String url) {
    final NetworkImage provider = NetworkImage(url);
    provider.evict().then<void>((bool success) {
      if (success) debugPrint('removed image!');
    });
  }

  // initializedData() {
  //   int ip = 0;
  //   log("Videoooooo11111");
  //   for (int i = 0; i < feedData.length; i++) {
  //     if (feedData[i].MediaType == "Video") {
  //       // FijkPlayer player = new FijkPlayer();

  //       log("Videoooooo2222");
  // player2.add(player);
  // player2[ip].setDataSource(
  //     //"http://216.48.186.108:19977/SK/s1.mp4",
  //     feedData[i].MediaURL1.toString(),
  //     // "http://216.48.186.108:19977/SK/%E0%AE%A4%E0%AE%AE%E0%AE%BF%E0%AE%B4%E0%AF%8D%20%20%E0%AE%A8%E0%AE%BE%E0%AE%9F%E0%AF%86%E0%AE%99%E0%AF%8D%E0%AE%95%E0%AF%81%E0%AE%AE%E0%AF%8D%20SATHYA.mp4",
  //     showCover: true,
  //     autoPlay: false);

  //     player2[ip].addListener(()=>listener(i));

  //   feedData2.add(FeedsModalData(
  //     FeedsID: feedData[i].FeedsID,
  //     CreatedDate: feedData[i].CreatedDate,
  //     Title: feedData[i].Title,
  //     Description: feedData[i].Description,
  //     MediaType: feedData[i].MediaType,
  //     MediaURL1: feedData[i].MediaURL1,
  //     MediaURL2: feedData[i].MediaURL2,
  //     MediaURL3: feedData[i].MediaURL3,
  //     ValidTill: feedData[i].ValidTill,
  //     UserCode: feedData[i].UserCode,
  //     Reaction: feedData[i].Reaction,
  //     ProfilePic: feedData[i].ProfilePic,
  //     CreatedBy: feedData[i].CreatedBy,
  //     //player: player2[ip]
  //   ));
  //   ip = ip + 1;
  // } else {
  //   log("Videoooooo333333");

  //   feedData2.add(FeedsModalData(
  //         FeedsID: feedData[i].FeedsID,
  //         CreatedDate: feedData[i].CreatedDate,
  //         Title: feedData[i].Title,
  //         Description: feedData[i].Description,
  //         MediaType: feedData[i].MediaType,
  //         MediaURL1: feedData[i].MediaURL1,
  //         MediaURL2: feedData[i].MediaURL2,
  //         MediaURL3: feedData[i].MediaURL3,
  //         ValidTill: feedData[i].ValidTill,
  //         UserCode: feedData[i].UserCode,
  //         Reaction: feedData[i].Reaction,
  //         ProfilePic: feedData[i].ProfilePic,
  //         CreatedBy: feedData[i].CreatedBy,
  //       ));
  //     }
  //   }

  //   ///

  //   log("ssss: " + feedData2.map((e) => e.toMap()).toList().toString());
  // }

  //  iniS(){
  //   int ip=0;
  //      for(int i=0; i<feedData.length; i++){
  //     if( feedData[i].MediaType == "Video"){
  //       player2.add(player);
  //       player2[ip].setDataSource(
  //         "http://216.48.186.108:19977/SK/%E0%AE%A4%E0%AE%AE%E0%AE%BF%E0%AE%B4%E0%AF%8D%20%20%E0%AE%A8%E0%AE%BE%E0%AE%9F%E0%AF%86%E0%AE%99%E0%AF%8D%E0%AE%95%E0%AF%81%E0%AE%AE%E0%AF%8D%20SATHYA.mp4",
  //          showCover: true, autoPlay: false);
  //       ip = ip+1;
  //   }}
  //  }

  Future<void> launchUrlInBrowser(String url) async {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  List<Emojis> emoji = [
    Emojis(key: '1F600', value: '\u{1F600}'),
    Emojis(key: '1F606', value: '\u{1F606}'),
    Emojis(key: '1F923', value: '\u{1F923}'),
    Emojis(key: '1F914', value: '\u{1F914}'),
    Emojis(key: '1F910', value: '\u{1F910}'),
    Emojis(key: '1F922', value: '\u{1F922}'),
    Emojis(key: '1F61F', value: '\u{1F61F}'),
    Emojis(key: '1F633', value: '\u{1F633}'),
    Emojis(key: '1F621', value: '\u{1F621}'),
    Emojis(key: '1F49B', value: '\u{1F49B}'),
    Emojis(key: '1F44C', value: '\u{1F44C}'),
    Emojis(key: '1F44D', value: '\u{1F44D}'),
    Emojis(key: '1F44F', value: '\u{1F44F}'),
    Emojis(key: '1F600', value: '\u{1F600}'),
    Emojis(key: '1F64f', value: '\u{1F64f}'),

  
  
  ];

  List<String> listEmoji = [
    '0x1F600',
    '0x1F606',
    '0x1F923',
    '0x1F914',
    '0x1F910',
    '0x1F922',
    '0x1F61F',
    '0x1F633',
    '0x1F621',
    '0x1F49B',
    '0x1F44C',
    '0x1F44D',
    '0x1F44F',
    '0x1F64f'
  ];
  bool reactionvisible = false;
  bool get getreactionvisible => reactionvisible;

  getsselectedEmojies(BuildContext context, FeedsModalData feedData, int i) {
    Navigator.pop(context);
    // selectedEmoji = listEmoji[i];
    feedData.Reaction = listEmoji[i];
    reactionvisible = true;
    log("data: "+ feedData.Reaction.toString());
    notifyListeners();
   callReactionApi(feedData.FeedsID!, feedData.Reaction!);
  }

  showBottomSheet(BuildContext context, FeedsModalData feedData) {
    final width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    //nznznz
    showModalBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 0),
          child: SingleChildScrollView(
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Column(
                children: [
                  Container(
                    width: Screens.width(context),
                    height: Screens.bodyheight(context) * 0.35,
                    child: GridView.builder(
                        itemCount: listEmoji.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            childAspectRatio: 2, //heightofcontainer
                            crossAxisSpacing: 0, //width
                            mainAxisSpacing: 4), //spacebeetweenheight,
                        itemBuilder: (BuildContext ctx, i) {
                          return Card(
                            elevation: 2,
                            shadowColor: Colors.red,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  getsselectedEmojies(context, feedData, i);
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Text(String.fromCharCode(int.parse("${listEmoji[i]}")),
                                            style: theme.textTheme.headline6
                                                ?.copyWith(
                                                    color: theme
                                                        .primaryColor))), //
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
          ),
        ),
        // )),
      ),
    );
  }

  callReactionApi(int feedid, String reaction) async {
   await ReactionApi.getData(feedid, reaction).then((value) {
      Future.delayed(Duration(seconds: 3),(){
        reactionvisible = false;
       notifyListeners();
      });
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.userLtData != null) {
        } else {}
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
      } else {}
    });
  }

  Future<void> refreshFeeds() async {
    feedData.clear();
    notifyListeners();
    callFeedsApi();
  }

  ////kpi controller

  List<KpiModelData> kpiData = [];

  List<KpiModelData> get getKpiData => kpiData;
  bool exception = false;

  Future<void> swipeRefreshIndiactor() async {
    kpiData.clear();
    notifyListeners();
    callKpiApi();
  }

  callKpiApi() async {
    await KpiApi.sampleDetails().then((value) {
      if (value.resCode! >= 200 && value.resCode! <= 210) {
        if (value.data != null) {
          kpiData = value.data!;
          notifyListeners();
        } else if (value.data == null) {}
      } else {}
    });
  }


}

class Emojis{
  String? key;
  String? value;
  Emojis({required this.key,required this.value});
}
