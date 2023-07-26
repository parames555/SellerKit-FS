import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Models/PostQueryModel/LeadsCheckListModel/ForwardLeadUserModel.dart';

class LostSaveLeadApi {
  static Future<ForwardLeadUser> getData(
      followDocEntry, ForwardLeadUserDataLost forwardLeadUserDataLost) async {
    List<dynamic> res = [];
    int resCode = 500;
    try {
      final response = await http.patch(
          Uri.parse(Url.SLUrl + 'LEADFOLLOWUP($followDocEntry)'),
          headers: {
            "content-type": "application/json",
            "cookie": 'B1SESSION=' + ConstantValues.sapSessions,
          },
          body: jsonEncode({
            "SK_LEADFOLLOW_LINECollection": [
              {
                "U_UpdateType": "ManualLostFUP",
                "U_UpdateDateTime": "${forwardLeadUserDataLost.curentDate}",
                "U_UpdatedBy": "${forwardLeadUserDataLost.updatedBy}",
                "U_FollowupMode": (forwardLeadUserDataLost.followupMode ==
                        'Phone Call'
                    ? "Phone"
                    : forwardLeadUserDataLost.followupMode == 'Sms/WhatsApp'
                        ? "Text"
                        : forwardLeadUserDataLost.followupMode == 'Store Visit'
                            ? "Visit"
                            : "Other"),
                "U_ReasonCode": "${forwardLeadUserDataLost.ReasonCode}",
                "U_NextFollowupDate": null,
                "U_Feedback": "${forwardLeadUserDataLost.feedback}",
                "U_Ref1": null,
                "U_Ref2": null,
                "U_RefDate": null,
                "U_NextUser": null
              }
            ]
          }));

      log(jsonEncode({
        "SK_LEADFOLLOW_LINECollection": [
          {
            "U_UpdateType": "ManualLostFUP",
            "U_UpdateDateTime": "${forwardLeadUserDataLost.curentDate}",
            "U_UpdatedBy": "${forwardLeadUserDataLost.updatedBy}",
            "U_FollowupMode":
                (forwardLeadUserDataLost.followupMode == 'Phone Call'
                    ? "Phone"
                    : forwardLeadUserDataLost.followupMode == 'Sms/WhatsApp'
                        ? "Text"
                        : forwardLeadUserDataLost.followupMode == 'Store Visit'
                            ? "Visit"
                            : "Other"),
            "U_ReasonCode": "${forwardLeadUserDataLost.ReasonCode}",
            "U_NextFollowupDate": null,
            "U_Feedback": "${forwardLeadUserDataLost.feedback}",
            "U_Ref1": null,
            "U_Ref2": null,
            "U_RefDate": null,
            "U_NextUser": null
          }
        ]
      }));
      // jsonEncode({
      //   "U_sk_FollowupType": (followup =='Phone Call'?"Phone":
      //   followup =='Sms/WhatsApp'?"Test":followup =='Store Visit'?"Visit":"Other"),
      //   "U_sk_UpdateType": "ManualLost",
      //   "U_sk_LostReason": "$reason",
      //   "Comments": "$feedback"
      // }));

      resCode = response.statusCode;
      print(response.statusCode.toString());
      print(json.decode(response.body));
      if (response.statusCode >= 200 && response.statusCode <= 210) {
        res.add(resCode);
        res.add(response.body);
        return ForwardLeadUser.fromjson(resCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        res.add(resCode);
        res.add(response.body);
        return ForwardLeadUser.issue(json.decode(response.body), resCode);
      }
    } catch (e) {
      print("Exception: " + e.toString());
      res.add(resCode);
      res.add(e.toString());
      return ForwardLeadUser.fromjson(resCode);
    }
  }

static  prinjson(followDocEntry, ForwardLeadUserDataLost forwardLeadUserDataLost) {
    log(jsonEncode({
      "SK_LEADFOLLOW_LINECollection": [
        {
          "U_UpdateType": "ManualLostFUP",
          "U_UpdateDateTime": "${forwardLeadUserDataLost.curentDate}",
          "U_UpdatedBy": "${forwardLeadUserDataLost.updatedBy}",
          "U_FollowupMode":
              (forwardLeadUserDataLost.followupMode == 'Phone Call'
                  ? "Phone"
                  : forwardLeadUserDataLost.followupMode == 'Sms/WhatsApp'
                      ? "Text"
                      : forwardLeadUserDataLost.followupMode == 'Store Visit'
                          ? "Visit"
                          : "Other"),
          "U_ReasonCode": "${forwardLeadUserDataLost.ReasonCode}",
          "U_NextFollowupDate": null,
          "U_Feedback": "${forwardLeadUserDataLost.feedback}",
          "U_Ref1": null,
          "U_Ref2": null,
          "U_RefDate": null,
          "U_NextUser": null
        }
      ]
    }));
  }
}

class ForwardLeadUserDataLost {
  String? curentDate;
  String? nextFD;
  String? updatedBy;
  String? followupMode;
  String? ReasonCode;
  String? feedback;

  ForwardLeadUserDataLost({
    this.curentDate,
    this.nextFD,
    this.ReasonCode,
    this.followupMode,
    this.updatedBy,
    this.feedback,
  });
}
