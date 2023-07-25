// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/DataBaseConfig.dart';
import '../../../Models/PostQueryModel/LeadsCheckListModel/LeadSavePostModel/GetLeadDetailsQTHModel.dart';

class GetLeadQTHApi {
  static Future<GetLeadDetailsQTH> getData(
    docentry,
  ) async {
    int resCode = 500;
    log("docentry: "+docentry);
    try {
      final response = await http.post(Uri.parse(Url.queryApi + 'SellerKit'),
          headers: {
            "content-type": "application/json",
          },
          body: jsonEncode({
            "constr":"Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
            "query": "exec SK_GET_LEAD_DETAILS_QTH '${docentry}'"
          }));
      resCode = response.statusCode;
      print(response.statusCode.toString());
      print("GetLeadQTHApi: "+json.decode(response.body).toString());
      if (response.statusCode == 200) {
        return GetLeadDetailsQTH.fromJson(
            json.decode(response.body), resCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return GetLeadDetailsQTH.error('Error', resCode);
      }
    } catch (e) {
      print("Exception: " + e.toString());
      return GetLeadDetailsQTH.error(e.toString(), resCode);
    }
  }
}
