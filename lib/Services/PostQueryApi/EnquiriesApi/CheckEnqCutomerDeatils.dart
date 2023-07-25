// ignore_for_file: unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Constant/DataBaseConfig.dart';
import '../../../Models/PostQueryModel/EnquiriesModel/CheckEnqCusDetailsModel.dart';

class CheckEnqDetailsApi {
  static Future<CheckEnqDetailsModel> getData(sapUserId, phoneNO) async {
    int resCode = 500;
    try {
      final response = await http.post(
          Uri.parse(Url.queryApi + 'SellerKit'),
          headers: {
            "content-type": "application/json",
          },
          body: jsonEncode({
            "constr":"Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
            "query": "exec sk_get_check_customer '${phoneNO}','${ConstantValues.slpcode}'"
          }));

          log(jsonEncode({
            "constr":"Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
            "query": "exec sk_get_check_customer '${phoneNO}','${ConstantValues.slpcode}'"
          }));
      resCode = response.statusCode;
      print(response.statusCode.toString());
      print("sk_get_check_customer "+json.decode(response.body).toString());
      if (response.statusCode == 200) {
        return CheckEnqDetailsModel.fromJson(json.decode(response.body), resCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return CheckEnqDetailsModel.error("Error", resCode);
      }
    } catch (e) {
      print("Exception: " + e.toString());
      return CheckEnqDetailsModel.error(e.toString(), resCode);
    }
  }
}
