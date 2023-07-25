// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import '../../Models/LoginModel/LoginModel.dart';
import 'package:http/http.dart' as http;

import '../URL/LocalUrl.dart';

class LoginAPi {
  static Future<LoginModel> getData(PostLoginData postLoginData) async {
    int resCode = 500;

    // log("lickey: "+postLoginData.licenseKey!.isEmpty.toString());
    //    log("Loginapi new: "+jsonEncode({
    //         "deviceCode": "${postLoginData.deviceCode}",
    //         "userName":"${postLoginData.username}",
    //         "password": postLoginData.password.toString().isEmpty || postLoginData.password == null?"null":"${postLoginData.password}",
    //         "licenseKey":postLoginData.licenseKey.toString().isEmpty  || postLoginData.licenseKey == null?"null": "${postLoginData.licenseKey}",
    //        "fcmToken":"${postLoginData.fcmToken}"
    //       }));
    try {
    //  log("${Url.queryApi}SellerKit/Auth");
      final response = await http.post(
          Uri.parse(
              "${Url.queryApi}SellerKit/Auth"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "deviceCode": "${postLoginData.deviceCode}",
            "userName":"${postLoginData.username}",
            "password": postLoginData.password.toString().isEmpty || postLoginData.password == null?"null":"${postLoginData.password}",
            "licenseKey":postLoginData.licenseKey.toString().isEmpty  || postLoginData.licenseKey == null?"null": "${postLoginData.licenseKey}",
           "fcmToken":"${postLoginData.fcmToken}"
          }));
   
  //  log("body: "+  jsonEncode({
  //           "deviceCode": "${postLoginData.deviceCode}",
  //           "userName":"${postLoginData.username}",
  //           "password": postLoginData.password.toString().isEmpty || postLoginData.password == null?"null":"${postLoginData.password}",
  //           "licenseKey":postLoginData.licenseKey.toString().isEmpty  || postLoginData.licenseKey == null?"null": "${postLoginData.licenseKey}",
  //          "fcmToken":"${postLoginData.fcmToken}"
  //         }));
  //     log("${response.statusCode}");
  //     log("${response.body}");

      resCode = response.statusCode;
      if (response.statusCode == 200) {
        Map data = json.decode(response.body);
        if (data["token"] != null) {}
        return LoginModel.fromJson(
            json.decode(response.body.toString()), resCode);
      } else {
       // print("Error: error");
        return LoginModel.issue(resCode, "Something went wrong..!!");
      }
    } catch (e) {
     // print("Catch:"+e.toString());
      return LoginModel.issue(resCode, "$e");
    }
  }
}
