// ignore_for_file: empty_catches, unused_local_variable, unnecessary_new, prefer_interpolation_to_compose_strings, unnecessary_null_comparison, avoid_print, prefer_const_constructors, sort_child_properties_last

import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Constant/AppConstant.dart';
import '../../Constant/ConstantRoutes.dart';
import '../../Constant/ConstantSapValues.dart';
import '../../Constant/Helper.dart';
import '../../DBHelper/DBHelper.dart';
import '../../Models/LoginModel/LoginModel.dart';
import '../../Services/LoginApi/LoginApi.dart';
import '../../Services/URL/LocalUrl.dart';
import '../../Services/VersionApi/VersionApi.dart';

class ConfigurationContoller extends ChangeNotifier {
  Config config = Config();
  PostLoginData postLoginData = new PostLoginData();
    //fcm
  String token = '';
  final firebaseMessaging = FirebaseMessaging.instance;

     Future<void> fetss()async{
  
  }

    setURL() async {
    String? getUrl = await HelperFunctions.getHostDSP();
    ConstantValues.userNamePM = await HelperFunctions.getUserName();
    // log("getUrl $getUrl");
    // log("userNamePM ${ConstantValues.userNamePM}");

    Url.queryApi = "http://$getUrl:19979/api/";
  }

  Future<String?> getToken()async{
      return await  firebaseMessaging.getToken();
   }

  checkStartingPage() async {
    //  print(await HelperFunctions.getOnBoardSharedPreference());
    //  await DBOperation.createDB();
    await HelperFunctions.getOnBoardSharedPreference().then((value) {});
    if (await HelperFunctions.getOnBoardSharedPreference() == true) {
      Get.offAllNamed(ConstantRoutes.splash);
    } else {
      Get.offAllNamed(ConstantRoutes.onBoard);
    }
  }

 Future<void> checkBeforeLoginApi(BuildContext context) async {
  await  setURL();
    String? deviceID = await HelperFunctions.getDeviceIDSharedPreference();
    String? licenseKey = await HelperFunctions.getLicenseKeySharedPreference();
    String? userCode = await HelperFunctions.getLogginUserCodeSharedPreference();
    bool? isLoggedIn =   await HelperFunctions.getUserLoggedInSharedPreference(); 
    token =(await getToken())!;
    //print("FCM Token: $token");
    await HelperFunctions.saveFCMTokenSharedPreference(token);
    // log("licenseKey:::" + licenseKey.toString());
  //  String? fcmToken = await HelperFunctions.getFCMTokenSharedPreference();
  //   log("Token:::" + fcmToken.toString());
    postLoginData.deviceCode = deviceID;
    postLoginData.licenseKey = licenseKey;
    postLoginData.username = userCode;
    postLoginData.fcmToken = token;
   // print("isLoggedIn111: "+isLoggedIn.toString());
      if (deviceID == null) {
      deviceID = await PlatformDeviceId.getDeviceId;
      HelperFunctions.saveDeviceIDSharedPreference(deviceID!);

      checkLicenseKey(licenseKey,isLoggedIn);
    } else {
      checkLicenseKey(licenseKey,isLoggedIn);
     }
 
    
  }

  checkLicenseKey(String? licenseKey,bool? isLoggedIn) {
   // print("isLoggedIn: "+isLoggedIn.toString());
    if ((isLoggedIn == false || isLoggedIn == null)) {//&& licenseKey == null
      Get.offAllNamed(ConstantRoutes.login);
    } else if((isLoggedIn == true || isLoggedIn != null) ){//&& licenseKey != null
      callLoginApi();
    }
  }

  String exceptionOnApiCall = '';
  String get getexceptionOnApiCall => exceptionOnApiCall;
  bool isLoading = true;
  bool get getisLoading => isLoading;

  callLoginApi() async {
    await LoginAPi.getData(postLoginData).then((value) async {
      if (value.resCode! >= 200 && value.resCode! <= 210) {
        if (value.loginstatus!.toLowerCase().contains('success') &&
            value.data != null) {
          await HelperFunctions.saveLicenseKeySharedPreference(
              value.data!.licenseKey);
          await HelperFunctions.saveSapUrlSharedPreference(
              value.data!.endPointUrl);
          await HelperFunctions.saveSessionIDSharedPreference(
              value.data!.sessionID);
          await HelperFunctions.saveUserIDSharedPreference(value.data!.UserID);
          await HelperFunctions.saveUserLoggedInSharedPreference(true);
           await HelperFunctions.getFSTNameSharedPreference().then((value) {
          if (value != null) {
          ConstantValues.firstName = value;
          notifyListeners();
          }
          });

          await HelperFunctions.saveuserDB(value.data!.userDB);
            await HelperFunctions.savedbUserName(value.data!.dbUserName);
            await HelperFunctions.savedbPassword(value.data!.dbPassword);

             await HelperFunctions.saveUserType(value.data!.userType);
             await HelperFunctions.saveSlpCode(value.data!.slpcode);

             
          Get.offAllNamed(ConstantRoutes.download);
        } else if (value.loginstatus!.toLowerCase().contains("failed") &&
            value.data == null) {
          isLoading = false;
          exceptionOnApiCall = value.loginMsg!;
          notifyListeners();
        }
      } else if (value.resCode! >= 400 && value.resCode! <= 410) {
        isLoading = false;
        exceptionOnApiCall = value.excep!;
        notifyListeners();
      } else {
        if (value.excep == 'No route to host') {
          isLoading = false;
          isLoading = false;
          exceptionOnApiCall = "Check your internet connectivity..!!";
        } else {
          isLoading = false;
          isLoading = false;
          exceptionOnApiCall = "Something went wrong..!!";
        }
        notifyListeners();
      }
    });
  }

  //




}

//  checkStartingPage()async{
//   //  print(await HelperFunctions.getOnBoardSharedPreference());
//   //  print(await HelperFunctions.getUserLoggedInSharedPreference());
//     if( await HelperFunctions.getOnBoardSharedPreference()==true && 
//      await HelperFunctions.getUserLoggedInSharedPreference()== true &&
//  (await HelperFunctions.getDownloadedSharedPreference()== null ||
//  await HelperFunctions.getDownloadedSharedPreference()== false)
//      ){
    
//       Get.offAllNamed(ConstantRoutes.download);
//     }
//     else if(await HelperFunctions.getOnBoardSharedPreference()==true && 
//       await HelperFunctions.getUserLoggedInSharedPreference()== true &&
//     await HelperFunctions.getDownloadedSharedPreference()== true ){
//       Get.offAllNamed(ConstantRoutes.dashboard);
//     }
//     else if(await HelperFunctions.getOnBoardSharedPreference()==true && 
//     (await HelperFunctions.getUserLoggedInSharedPreference()== null || 
//     await HelperFunctions.getUserLoggedInSharedPreference()== false) ){
//       Get.offAllNamed(ConstantRoutes.login);
//     }else {
//        Get.offAllNamed(ConstantRoutes.onBoard);
//     }
//   }