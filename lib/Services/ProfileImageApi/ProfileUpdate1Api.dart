// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'dart:convert';
import 'package:sellerkit/Constant/DataBaseConfig.dart';
import 'package:sellerkit/Models/NewProfileModel/ProfileUpdate1Model.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';

class ProfileUpdateApi1 {
  static Future<ProfileUpdateModel1> getData() async {
    int resCode = 500;
    try {
      final response = await http.post(Uri.parse(Url.queryApi + "SellerKit"),

          // Url.queryApi + 'SellerKit'),
          // ('http://164.52.214.147:47182/api/SellerKit'),

          headers: {
            "content-type": "application/json",
          },
          body: jsonEncode({
            "constr":
                "Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
            "query": "exec SK_GET_STORAGE_FOLDER  '${ConstantValues.slpcode}'"
          }));

      resCode = response.statusCode;
      print(response.statusCode.toString());
      print("SK_GET_STORAGE_FOLDER "+json.decode(response.body).toString());
      if (response.statusCode == 200) {
        return ProfileUpdateModel1.fromJson(
            json.decode(response.body), resCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return ProfileUpdateModel1.error('Error', resCode);
      }
    } catch (e) {
      print("Exception: " + e.toString());
      return ProfileUpdateModel1.error(e.toString(), resCode);
    }
  }
}
