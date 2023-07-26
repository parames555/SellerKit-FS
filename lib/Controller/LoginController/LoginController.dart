// ignore_for_file: unnecessary_new, prefer_interpolation_to_compose_strings, unrelated_type_equality_checks, unnecessary_brace_in_string_interps

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/Helper.dart';
import 'package:sellerkit/Services/LoginApi/LoginApi.dart';
import 'package:share/share.dart';
import '../../Constant/Configuration.dart';
import '../../Constant/ConstantSapValues.dart';
import '../../Models/LoginModel/LoginModel.dart';
import '../../Services/TestApi/TestApi.dart';
import '../../Services/URL/LocalUrl.dart';

class LoginController extends ChangeNotifier {
  LoginController() {
    getHost();
  }

  Config config = new Config();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List<TextEditingController> mycontroller =
      List.generate(15, (i) => TextEditingController());
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  GlobalKey<FormState> formkey2 = GlobalKey<FormState>();
  bool hidePassword = true;
  bool isLoading = false;
  bool erroMsgVisble = false;
  bool settingError = false;

  String errorMsh = '';
  static bool loginPageScrn = false;

  bool get getHidepassword => hidePassword;
  bool get getIsLoading => isLoading;
  bool get geterroMsgVisble => erroMsgVisble;
  bool get getsettingError => settingError;

  String get getErrorMshg => errorMsh;

  void obsecure() {
    hidePassword = !hidePassword;
    notifyListeners();
  }

  showLoginDialog(BuildContext context) {
    config.msgDialog(context, '', '');
  }

  validateLogin(BuildContext context) async {
    //HelperFunctions.clearHost();
    if (formkey.currentState!.validate()) {
      disableKeyBoard(context);
      isLoading = true;
      log("is is is ");
      notifyListeners();
      PostLoginData postLoginData = new PostLoginData();
      postLoginData.deviceCode =
          await HelperFunctions.getDeviceIDSharedPreference();
      postLoginData.licenseKey =
          await HelperFunctions.getLicenseKeySharedPreference();
      postLoginData.fcmToken =
          await HelperFunctions.getFCMTokenSharedPreference();
      // log("fcmmmm: "+postLoginData.fcmToken.toString());
      postLoginData.username = mycontroller[0].text;
      postLoginData.password = mycontroller[1].text;

      LoginAPi.getData(postLoginData).then((value) async {
        if (value.resCode! >= 200 && value.resCode! <= 200) {
          if (value.loginstatus!.toLowerCase().contains('success') &&
              value.data != null) {
            isLoading = false;
            erroMsgVisble = false;
            errorMsh = '';
            ConstantValues.userNamePM = mycontroller[0].text;
            await HelperFunctions.saveUserName(mycontroller[0].text);
            await HelperFunctions.saveLicenseKeySharedPreference(
                value.data!.licenseKey);
            await HelperFunctions.saveLogginUserCodeSharedPreference(
                mycontroller[0].text);
            await HelperFunctions.saveSapUrlSharedPreference(
                value.data!.endPointUrl);
            await HelperFunctions.saveSessionIDSharedPreference(
                value.data!.sessionID);
            await HelperFunctions.saveUserIDSharedPreference(
                value.data!.UserID);
            await HelperFunctions.saveUserLoggedInSharedPreference(true);

            await HelperFunctions.saveuserDB(value.data!.userDB);
            await HelperFunctions.savedbUserName(value.data!.dbUserName);
            await HelperFunctions.savedbPassword(value.data!.dbPassword);

            await HelperFunctions.saveUserType(value.data!.userType);
            await HelperFunctions.saveSlpCode(value.data!.slpcode);

            mycontroller[0].clear();
            mycontroller[1].clear();
            notifyListeners();
            Get.offAllNamed(ConstantRoutes.download);
          } else if (value.loginstatus!.toLowerCase().contains("failed") &&
              value.data == null) {
            isLoading = false;
            erroMsgVisble = true;
            errorMsh = value.loginMsg!;
            notifyListeners();
          }
        } else {
          if (value.excep == 'No route to host') {
            isLoading = false;
            erroMsgVisble = true;
            errorMsh = 'Check your Internet Connection...!!';
          } else {
            isLoading = false;
            erroMsgVisble = true;
            errorMsh = 'Something went wrong try again...!!';
          }
          notifyListeners();
        }
      });
      // Get.offAllNamed(ConstantRoutes.dashboard);
    }
  }

  showShare(String deviceID) {
    Share.share(
      'Dear Sir/Madam,\n  Kindly Register My Mobile For Sellerkit App,\n My Device ID : \n $deviceID \n Thanks & Regards',
    );
  }

  disableKeyBoard(BuildContext context) {
    FocusScopeNode focus = FocusScope.of(context);
    if (!focus.hasPrimaryFocus) {
      focus.unfocus();
    }
  }

  // testApi()async{
  //  await TestApi.getData();
  // }

  getHost() async {
    mycontroller[2].clear();
    String? host = await HelperFunctions.getHostDSP();
    log("host ${host}");
    if (host != null) {
      settingError = false;
      erroMsgVisble = false;
      mycontroller[2].text = host;
    }
    if (host == null) {
      erroMsgVisble = true;
      settingError = true;
      errorMsh = "Complete the setup..!!";
      notifyListeners();
    }
  }

  void settingvalidate(BuildContext context) async {
    if (formkey2.currentState!.validate()) {
      HelperFunctions.saveHostSP(mycontroller[2].text);
      erroMsgVisble = false;
      settingError = false;
      setURL();
      notifyListeners();
      Navigator.pop(context);
    }
  }

  setURL() async {
    String? getUrl = await HelperFunctions.getHostDSP();
    String hostip = '';
    for (int i = 0; i < getUrl!.length; i++) {
      if (getUrl[i] == ":") {
        break;
      }
      // log("for ${hostip}");
      hostip = hostip + getUrl[i];
    }
    // log("for last ${hostip}");
    HelperFunctions.savehostIP(hostip);
    ConstantValues.userNamePM = await HelperFunctions.getUserName();
    Url.queryApi = "http://$getUrl:19979/api/";
  }
}
