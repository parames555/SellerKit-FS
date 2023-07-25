// ignore_for_file: unnecessary_string_interpolations

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Services/URL/LocalUrl.dart';

import '../../../Constant/ConstantSapValues.dart';
import '../../../Models/PostQueryModel/LeadsCheckListModel/ForwardLeadUserModel.dart';

class ForwardLeadUserApi {
  static Future<ForwardLeadUser> getData(
    followupEntry,
     ForwardLeadUserData forwardLeadUserData
  ) async {
    print("followupentry: "+ followupEntry);
    print("salesPersonEmpId: "+ forwardLeadUserData.nextUser .toString());
    print("nextfollow: "+ forwardLeadUserData.nextFD .toString());

    List<dynamic> res =[];
    int resCode = 500;
    try {
      final response = await http.patch(
          Uri.parse(Url.SLUrl + 'LEADFOLLOWUP($followupEntry)'),
          headers: {
            "content-type": "application/json",
            "cookie": 'B1SESSION='+ ConstantValues.sapSessions,
          },
          body: jsonEncode(
             {
    "SK_LEADFOLLOW_LINECollection": [
        {
            "U_UpdateType": "ManualLeadForward",
            "U_UpdateDateTime": "${forwardLeadUserData.curentDate}",
            "U_UpdatedBy": "${ConstantValues.slpcode}",
            "U_FollowupMode": "Other",
            "U_ReasonCode": "01",
            "U_NextFollowupDate": "${forwardLeadUserData.nextFD}",
            "U_Feedback": null,
            "U_Ref1": null,
            "U_Ref2": null,
            "U_RefDate": null, 
            "U_NextUser": "${forwardLeadUserData.nextUser}"
        }
    ]
}
              ));

         

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

  static printn(  followupEntry,
     ForwardLeadUserData forwardLeadUserData){
         log(jsonEncode(
             // {"SalesPersonCode": salesPersonEmpId}
             {
     "SK_LEADFOLLOW_LINECollection": [
        {
            "U_UpdateType": "ManualLeadForward",
            "U_UpdateDateTime": "${forwardLeadUserData.curentDate}",
            "U_UpdatedBy": "${ConstantValues.slpcode}",
            "U_FollowupMode": "Other",
            "U_ReasonCode": "01",
            "U_NextFollowupDate": "${forwardLeadUserData.nextFD}",
            "U_Feedback": null,
            "U_Ref1": null,
            "U_Ref2": null,
            "U_RefDate": null,
            "U_NextUser": "${forwardLeadUserData.nextUser}"
        }
    ]
}
              ));
  }
}

class ForwardLeadUserData{
  String?  curentDate;
  String?  nextFD;
  int? nextUser;
  ForwardLeadUserData({
    this.curentDate,
    this.nextFD,
    this.nextUser
  });
}
