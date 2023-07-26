// ignore_for_file: unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/DataBaseConfig.dart';
import '../../../Models/PostQueryModel/FollowUPModel.dart/FollowUPModel.dart';

class FollowUPListApi {
  static Future<FollowUPListModel> getData(sapUserId) async {
    int resCode = 500;
    try {
      final response = await http.post(
          Uri.parse(Url.queryApi + 'SellerKit'),
          headers: {
            "content-type": "application/json",
          },
          body: jsonEncode({
            "constr":"Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
            "query": "exec SK_GET_FOLLOWUP_LIST '$sapUserId'"
          }));
      resCode = response.statusCode;
     // print(response.statusCode.toString());
     log("log data: "
     +  jsonEncode({
            "constr":"Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
            "query": "exec SK_GET_FOLLOWUP_LIST '$sapUserId'"
          }));
      log("followup data: "+json.decode(response.body).toString());
      if (response.statusCode == 200) {
        return FollowUPListModel.fromJson(json.decode(response.body), resCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return FollowUPListModel.error("Error", resCode);
      }
    } catch (e) {
      print("Exception: " + e.toString());
      return FollowUPListModel.error(e.toString(), resCode);
    }
  }
}
