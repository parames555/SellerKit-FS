// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:sellerkit/Models/ConfirmPwdModel.dart/ConfirmModel.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';

import 'package:http/http.dart' as http;


class ConfirmPwdAPi {
 static Future<ConfirmPwdModel> getConfirmPwdData(String userCode,String licenKey,String pwd) async {
    int resCode = 500;
    try {
      final response = await http.post(
          Uri.parse( "${Url.queryApi}SellerKit/UpdatePassword"),
            //"http://216.48.186.108:19979/api/SellerKit/UpdatePassword"
        
              
               headers: {
            "content-type": "application/json",
          },
          body: jsonEncode({
    "userCode":"$userCode",
    "licenKey":"$licenKey",
    "password":"$pwd"
}));
      resCode = response.statusCode;
     print("object confirmpassword  API:" + response.statusCode.toString());
      print("confirmpassword new: " + json.decode(response.body).toString());
print("confimn body"+jsonEncode({
    "userCode":"$userCode",
    "licenKey":"$licenKey",
    "password":"$pwd"
}));
      if (response.statusCode == 200) {
     return ConfirmPwdModel.fromJson(
            json.decode(response.body.toString()), resCode);
      } else {
        print("Error: error");
        return ConfirmPwdModel.error ( "Something went wrong..!!",resCode);
      }
   }  catch (e) {
      print(e.toString());
      return ConfirmPwdModel.error ( "$e",resCode);
    }
  }
}
