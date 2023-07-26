// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Models/PostQueryModel/LeadsCheckListModel/LeadSavePostModel/LeadSavePostModel.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';

class LeadSavePostApi {
  static Future<LeadSavePostModal> getData(sapUserId, PostLead postLead) async {
    int resCode = 500;
    log(Url.SLUrl + 'Quotations' + " .. ${ConstantValues.sapSessions} save lead api");
    try {
      final response = await http.post(Uri.parse(Url.SLUrl + 'Quotations'),
          headers: {
            "content-type": "application/json",
            "cookie": 'B1SESSION=' + ConstantValues.sapSessions,
          },
          body: jsonEncode(postLead.tojson()));
        log(jsonEncode(postLead.tojson()));
      resCode = response.statusCode;
      print(response.statusCode.toString());
      log(json.decode(response.body).toString());
      if (response.statusCode >= 200 && response.statusCode <= 210) {
        return LeadSavePostModal.fromJson(json.decode(response.body.toString()), resCode);
        // return resCode;
      } else {
        //return resCode;
        print("Error: ${json.decode(response.body)}");
        return LeadSavePostModal.issue(json.decode(response.body), resCode);
      }
    } catch (e) {
      print("Exception: " + e.toString());
      // return resCode;
      return LeadSavePostModal.error(e.toString(), resCode);
    }
  }

  static printData(PostLead postLead) {
    log(jsonEncode(postLead.tojson()));
  }
}
