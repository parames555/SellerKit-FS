// ignore_for_file: unused_element, unnecessary_new, avoid_print

import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Controller/ConfigurationController/ConfigurationController.dart';
import 'package:sellerkit/Controller/DownLoadController/DownloadController.dart';
import 'package:sellerkit/Controller/EnquiryController/EnquiryMngController.dart';
import 'package:sellerkit/Controller/EnquiryController/EnquiryUserContoller.dart';
import 'package:sellerkit/Controller/EnquiryController/NewEnqController.dart';
import 'package:sellerkit/Controller/LeadController/LeadNewController.dart';
import 'package:sellerkit/Controller/NewProfileController/NewProfileController.dart';
import 'package:sellerkit/Controller/NotificationController/NotificationController.dart';
import 'package:sellerkit/Controller/StockAvailabilityController/StockListController.dart';
import 'package:sellerkit/Controller/WalkinController/WalkinController.dart';
import 'package:sellerkit/DBHelper/DBHelper.dart';
import 'package:sellerkit/Themes/themes_const.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'Constant/AllRoutes.dart';
import 'Controller/CollectionController/CollectionController.dart';
import 'Controller/CollectionController/NewCollectionEntryCotroller.dart';
import 'Controller/DayStartEndController/DayStartEndController.dart';
import 'Controller/LeadController/TabLeadController.dart';
import 'Controller/MyCustomerController/AccountsController.dart';
import 'Controller/MyCustomerController/NewCustomerController.dart';
import 'Controller/PriceListController/PriceListController.dart';
import 'Controller/SettlementController/SettlementController.dart';
import 'Controller/SiteInController/SiteInController.dart';
import 'Controller/SiteOutController/SiteOutController.dart';
import 'Controller/VisitplanController/NewVisitController.dart';
import 'Controller/VisitplanController/VisitPlanController.dart';
import 'DBHelper/DBOperation.dart';
import 'DBModel/NotificationModel.dart';
import 'Pages/Configuration/ConfigurationPage.dart';
import 'Services/LocalNotification/LocalNotification.dart';
import 'Services/PostQueryApi/NotificationApi/NotificationApi.dart';
import 'Themes/theme_manager.dart';
import 'package:provider/provider.dart';

Database? db;
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  List<NotificationModel> notify = [];
  await createDB();
  Config config2 = Config();
  await NotificationUpdateApi.getData(
      docEntry: int.parse(message.data['DocEntry'].toString()),
      deliveryDT: config2.currentDate(),
      readDT: 'null',
      deviceCode: 'null');
  if (message.notification!.android!.imageUrl != null) {
    notify.add(NotificationModel(
        docEntry: int.parse(message.data['DocEntry'].toString()),
        titile: message.notification!.title,
        description: message.notification!.body!,
        receiveTime: config2.currentDate(),
        seenTime: '0',
        imgUrl: message.notification!.android!.imageUrl.toString(),
        naviScn: message.data['NaviScreen'].toString()));
    await DBOperation.insertNotification(notify, db!);
  } else {
    notify.add(NotificationModel(
        docEntry: int.parse(message.data['DocEntry'].toString()),
        titile: message.notification!.title,
        description: message.notification!.body!,
        receiveTime: config2.currentDate(),
        seenTime: '0',
        imgUrl: 'null',
        naviScn: message.data['NaviScreen'].toString()));
    await DBOperation.insertNotification(notify, db!);
  }
}

Future createDB() async {
  await DBHelper.getInstance().then((value) {
    print("Created...");
    db = value;
  });
}
// await dbHelper2.insertNotify(notifiModel);
//  List<NotificationModel> notify = [];

//  notify.add(
//   NotificationModel(
//     docEntry: int.parse(message.data['DocEntry'].toString()),
//     titile: message.notification!.title,
//     description: message.notification!.body!,
//     receiveTime: config2.currentDate(),
//     seenTime: '0', ));

LocalNotificationService localNotificationService =
    new LocalNotificationService();
Config config = Config();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

onReciveFCM() async {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    List<NotificationModel> notify = [];
    if (message.notification != null) {
      localNotificationService.showNitification(
          titile: message.notification!.title,
          msg: message.notification!.body,
          message: message);

      NotificationUpdateApi.getData(
          docEntry: int.parse(message.data['DocEntry'].toString()),
          deliveryDT: config.currentDate(),
          readDT: 'null',
          deviceCode: 'null');

      if (message.notification!.android!.imageUrl != null) {
        // log(message.data['DocEntry'].toString());
        // log(message.data['NaviScreen'].toString());

        notify.add(NotificationModel(
            docEntry: int.parse(message.data['DocEntry'].toString()),
            titile: message.notification!.title,
            description: message.notification!.body!,
            receiveTime: config.currentDate(),
            seenTime: '0',
            imgUrl: message.notification!.android!.imageUrl.toString(),
            naviScn: message.data['NaviScreen'].toString()));
        DBOperation.insertNotification(notify, db!);
      } else {
        log(message.data['DocEntry'].toString());
        log(message.data['NaviScreen'].toString());
        notify.add(NotificationModel(
            docEntry: int.parse(message.data['DocEntry'].toString()),
            titile: message.notification!.title,
            description: message.notification!.body!,
            receiveTime: config.currentDate(),
            seenTime: '0',
            imgUrl: 'null',
            naviScn: message.data['NaviScreen'].toString()));
        DBOperation.insertNotification(notify, db!);
      }
    }
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await localNotificationService.flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(localNotificationService.channel);
  onReciveFCM();
  testMethod();
  runApp(const MyApp());
}

testMethod(){
  log("AAAA");
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      key: navigatorKey,
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeManager()),
        ChangeNotifierProvider(create: (_) => ConfigurationContoller()),
        ChangeNotifierProvider(create: (_) => DownLoadController()),
        ChangeNotifierProvider(create: (_) => PriceListController()),
        ChangeNotifierProvider(create: (_) => StockListController()),
        ChangeNotifierProvider(create: (_) => EnquiryMangerContoller()),
        ChangeNotifierProvider(create: (_) => EnquiryUserContoller()),
        ChangeNotifierProvider(create: (_) => NewEnqController()),
        ChangeNotifierProvider(create: (_) => WalkinController()),
        ChangeNotifierProvider(create: (_) => LeadTabController()),
        ChangeNotifierProvider(create: (_) => LeadNewController()),
        ChangeNotifierProvider(create: (_) => NewProfileController()),
        ChangeNotifierProvider(create: (_) => NotificationContoller()),
        ChangeNotifierProvider(create: (_) => ColletionContoller()),
        ChangeNotifierProvider(create: (_) => NewCollectionContoller()),
        ChangeNotifierProvider(create: (_) => AccountsContoller()),
        ChangeNotifierProvider(create: (_) => NewCustomerContoller()),
        ChangeNotifierProvider(create: (_) => NewVisitplanController()),
        ChangeNotifierProvider(create: (_) => VisitplanController()),
        ChangeNotifierProvider(create: (_) => DayStartEndController()),
        ChangeNotifierProvider(create: (_) => SettlementController()),//SiteInController
        ChangeNotifierProvider(create: (_) => SiteInController()),//SiteOutController
        ChangeNotifierProvider(create: (_) => SiteOutController()),

      ],
      child: Consumer<ThemeManager>(builder: (context, themes, Widget? child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Seller kit',
          theme: themes.selectedTheme == 'merron'
              ? merronTheme(context)
              : themes.selectedTheme == 'blue'
                  ? blueTheme(context)
                  : orangeTheme(context),
          home: ConfigurationPage(),
          getPages: Routes.allRoutes,
        );
      }),
    );
  }
}
