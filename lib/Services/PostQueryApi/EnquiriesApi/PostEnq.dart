// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Models/AddEnqModel/AddEnqModel.dart';
import '../../../Models/PostQueryModel/EnquiriesModel/EnqPostModel.dart';

class EnqPostApi {
  static Future<EnqPostModal> getData(sapUserId, PostEnq patch) async {
    int resCode = 500;
    log(Url.SLUrl + 'Activities' +" .. ${ConstantValues.sapSessions}");
    try {
      final response = await http.post(Uri.parse(Url.SLUrl+'Activities'),
          headers: {
            "content-type": "application/json",
            "cookie": 'B1SESSION=' + ConstantValues.sapSessions,
          },
          body: jsonEncode({
            "CardCode": "${patch.CardCode}",
            "Activity": "cn_Task",
            "ActivityType": patch.ActivityType,//enqtype
            "U_Lookingfor": "${patch.U_Lookingfor}",
            "U_PotentialValue": null,
            "U_AssignedTo": patch.assignedtoslpCode,
            "U_ManagerSlp" : "${ConstantValues.slpcode}",
            "U_EnqStatus": "NEW ENQUIRY",
            "U_EnqRefer":"${patch.U_EnqRefer}",
          }));

          log(jsonEncode({
            "CardCode": "${patch.CardCode}",
            "Activity": "cn_Task",
            "ActivityType": patch.ActivityType,//enqtype
            "U_Lookingfor": "${patch.U_Lookingfor}",
            "U_PotentialValue": null,
            "U_AssignedTo": patch.assignedtoslpCode,
            "U_ManagerSlp" : "${ConstantValues.slpcode}",
            "U_EnqStatus": "NEW ENQUIRY",
             "U_EnqRefer":"${patch.U_EnqRefer}",
          }));

      resCode = response.statusCode;
      print(response.statusCode.toString());
      print(json.decode(response.body));
      if (response.statusCode >= 200 && response.statusCode<=210 ) {
        return EnqPostModal.fromJson(
            json.decode(response.body), resCode);
       // return resCode;
      } else  if (response.statusCode >= 400 && response.statusCode<=410 ){
        //return resCode;
        print("Error: ${json.decode(response.body)}");
         return EnqPostModal.issue(json.decode(response.body), resCode);
      }else{
         return EnqPostModal.error('', resCode);
      }
    } catch (e) {
      print("Exception: " + e.toString());
     // return resCode;
     return EnqPostModal.error(e.toString(), resCode);
    }
  }
}
