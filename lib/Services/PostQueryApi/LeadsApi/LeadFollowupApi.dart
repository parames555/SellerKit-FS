import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';

class LeadFollowupApi {
  static Future<int> getData(
      sapUserId, LeadFollowupApiData leadFollowupApiData, int docEntry) async {
    int resCode = 500;
    log(Url.SLUrl + 'LEADFOLLOWUP');
    try {
      final response = await http.post(Uri.parse(Url.SLUrl + 'LEADFOLLOWUP'),
          headers: {
            "content-type": "application/json",
            "cookie": 'B1SESSION=' + ConstantValues.sapSessions,
          },
          body: jsonEncode({
            "Remark": "",
            "U_LeadDocEntry": docEntry,
            "U_LeadDocDate": "${leadFollowupApiData.date}",
            "SK_LEADFOLLOW_LINECollection": [
              {
                "U_UpdateType": "NewLead", //h
                "U_UpdateDateTime": "${leadFollowupApiData.date}",
                "U_UpdatedBy": "$sapUserId",
                "U_FollowupMode": "Other", //hh
                "U_ReasonCode": "01", //hh
                "U_NextFollowupDate": "${leadFollowupApiData.nextFollowUp}",
                "U_Feedback": null,
                "U_Ref1": null,
                "U_Ref2": null,
                "U_RefDate": null,
                "U_NextUser": "$sapUserId"
              }
            ]
          }));

          log(jsonEncode({
            "Remark": "",
            "U_LeadDocEntry": docEntry,
            "U_LeadDocDate": "${leadFollowupApiData.date}",
            "SK_LEADFOLLOW_LINECollection": [
              {
                "U_UpdateType": "NewLead", 
                "U_UpdateDateTime": "${leadFollowupApiData.date}",
                "U_UpdatedBy": "$sapUserId",
                "U_FollowupMode": "Other", 
                "U_ReasonCode": "22",
                "U_NextFollowupDate": "${leadFollowupApiData.nextFollowUp}",
                "U_Feedback": null,
                "U_Ref1": null,
                "U_Ref2": null,
                "U_RefDate": null,
                "U_NextUser": "$sapUserId"
              }
            ]
          }));

      resCode = response.statusCode;
      print(response.statusCode.toString());
      print("LEADFOLLOWUP resp: " +
          json.decode(response.body.toString()).toString());
      if (response.statusCode >= 200 && response.statusCode <= 210) {
        return response.statusCode;
        //LeadSavePostModal.fromJson(json.decode(response.body), resCode);
        // return resCode;
      } else {
        //return resCode;
        print("Error: ${json.decode(response.body)}");
        return response.statusCode;
        //LeadSavePostModal.issue(json.decode(response.body), resCode);
      }
    } catch (e) {
      print("Exception: " + e.toString());
      // return resCode;
      return 500;
      //LeadSavePostModal.error(e.toString(), resCode);
    }
  }
}

class LeadFollowupApiData {
  String? date;
  String? nextFollowUp;
  LeadFollowupApiData({this.date, this.nextFollowUp});
}
