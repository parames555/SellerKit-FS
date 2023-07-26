// ignore_for_file: unnecessary_string_interpolations

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Models/PostQueryModel/LeadsCheckListModel/ForwardLeadUserModel.dart';

class WonSaveLeadApi {
  static Future<ForwardLeadUser> getData(
      followDocEntry, ForwardLeadUserDataWon forwardLeadUserDataWon) async {

    List<dynamic> res = [];
    int resCode = 500;
    try {
      final response =
          await http.patch(Uri.parse(Url.SLUrl + 'LEADFOLLOWUP($followDocEntry)'),
              headers: {
                "content-type": "application/json",
                "cookie": 'B1SESSION=' + ConstantValues.sapSessions,
              },
              body: 
               jsonEncode(
             {
    "SK_LEADFOLLOW_LINECollection": [
        {
            "U_UpdateType": "ManualWonFUP",
            "U_UpdateDateTime": "${forwardLeadUserDataWon.curentDate}",
            "U_UpdatedBy": "${forwardLeadUserDataWon.updatedBy}",
            "U_FollowupMode":  (forwardLeadUserDataWon.followupMode =='Phone Call'?"Phone":
                 forwardLeadUserDataWon.followupMode =='Sms/WhatsApp'?"Text":
                 forwardLeadUserDataWon.followupMode =='Store Visit'?"Visit":"Other"),
            "U_ReasonCode": "${forwardLeadUserDataWon.ReasonCode}",
            "U_NextFollowupDate": null,
            "U_Feedback": "${forwardLeadUserDataWon.feedback}",
            "U_Ref1": "${forwardLeadUserDataWon.billRef}",
            "U_Ref2":  null,
            "U_RefDate": "${forwardLeadUserDataWon.billDate}",
            "U_NextUser": null
        }
    ]
}
              ));
              
              // jsonEncode({
              //    "U_sk_FollowupType": (followup =='Phone Call'?"Phone":
              //   followup =='Sms/WhatsApp'?"Test":followup =='Store Visit'?"Visit":"Other"),
              //   "U_sk_UpdateType": "ManualWon",
              //   "U_sk_LostReason": "$status",
              //   "U_sk_WonDate": "$wonDate",
              //   "U_sk_WonNumber": "$reference",
              //   "Comments": "$feedback"
              // }));

              log(jsonEncode( {
    "SK_LEADFOLLOW_LINECollection": [
        {
            "U_UpdateType": "ManualWonFUP",
            "U_UpdateDateTime": "${forwardLeadUserDataWon.curentDate}",
            "U_UpdatedBy": "${forwardLeadUserDataWon.updatedBy}",
            "U_FollowupMode":  (forwardLeadUserDataWon.followupMode =='Phone Call'?"Phone":
                 forwardLeadUserDataWon.followupMode =='Sms/WhatsApp'?"Text":
                 forwardLeadUserDataWon.followupMode =='Store Visit'?"Visit":"Other"),
            "U_ReasonCode": "${forwardLeadUserDataWon.ReasonCode}",
            "U_NextFollowupDate": null,
            "U_Feedback": "${forwardLeadUserDataWon.feedback}",
            "U_Ref1": "${forwardLeadUserDataWon.billRef}",
            "U_Ref2":  null,
            "U_RefDate": "${forwardLeadUserDataWon.billDate}",
            "U_NextUser": null
        }
    ]
}));

      resCode = response.statusCode;
      print(response.statusCode.toString());
      print(json.decode(response.body));
      if (response.statusCode >= 200 && response.statusCode<=210) {
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

 static prinjson(followDocEntry, ForwardLeadUserDataWon forwardLeadUserDataWon){
               log(jsonEncode( {
    "SK_LEADFOLLOW_LINECollection": [
        {
            "U_UpdateType": "ManualWonFUP",
            "U_UpdateDateTime": "${forwardLeadUserDataWon.curentDate}",
            "U_UpdatedBy": "${forwardLeadUserDataWon.updatedBy}",
            "U_FollowupMode":  (forwardLeadUserDataWon.followupMode =='Phone Call'?"Phone":
                 forwardLeadUserDataWon.followupMode =='Sms/WhatsApp'?"Text":
                 forwardLeadUserDataWon.followupMode =='Store Visit'?"Visit":"Other"),
            "U_ReasonCode": "${forwardLeadUserDataWon.ReasonCode}",
            "U_NextFollowupDate": null,
            "U_Feedback": "${forwardLeadUserDataWon.feedback}",
            "U_Ref1": "${forwardLeadUserDataWon.billRef}",
            "U_Ref2":  null,
            "U_RefDate": "${forwardLeadUserDataWon.billDate}",
            "U_NextUser": null
        }
    ]
}));
  }
}

class ForwardLeadUserDataWon{
  String?  curentDate;
  String?  nextFD;
  String?  updatedBy;
  String?  followupMode;
  String ? ReasonCode;
  String? feedback;
  String? billRef;
  String? billDate;


  ForwardLeadUserDataWon({
    this.curentDate,
    this.nextFD,
    this.ReasonCode,
    this.followupMode,
    this.updatedBy,
    this.feedback,
    this.billDate,
    this.billRef
  });
}
