import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Models/PostQueryModel/LeadsCheckListModel/GetLeadCheckListModel.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';

class LeadCheckPostApi {
  static Future<int> getData(sapUserId,List<LeadCheckData> leadCheckData,int docEntry)async {
    int resCode = 500;
    log(Url.SLUrl + 'LEADCHK' + " .. ${ConstantValues.sapSessions}");
    try {
      final response = await http.post(Uri.parse(Url.SLUrl + 'LEADCHK'),
          headers: {
            "content-type": "application/json",
            "cookie": 'B1SESSION=' + ConstantValues.sapSessions,
          },
          body: jsonEncode({
        "U_LeadDocEntry":docEntry,
        "SK_LEAD_CHK_LINECollection":leadCheckData.map((e) => e.tojson()).toList()
        }));

            log( jsonEncode({
        "U_LeadDocEntry":docEntry,
        "SK_LEAD_CHK_LINECollection":leadCheckData.map((e) => e.tojson()).toList()
        }));

      resCode = response.statusCode;
      print(response.statusCode.toString());
      print(json.decode(response.body));
      if (response.statusCode >= 200 && response.statusCode <= 210) {
        return response.statusCode;
        //LeadSavePostModal.fromJson(json.decode(response.body), resCode);
        // return resCode;
      } else {
        //return resCode;
        print("Error: ${json.decode(response.body)}");
        return   response.statusCode;
        //LeadSavePostModal.issue(json.decode(response.body), resCode);
      }
    } catch (e) {
      print("Exception: " + e.toString());
      // return resCode;
      return 500;
       //LeadSavePostModal.error(e.toString(), resCode);
    }
  }

  static printData(List<LeadCheckData> leadCheckData,int docEntry) {
    print(leadCheckData.length);
       log(jsonEncode({
        "U_LeadDocEntry":docEntry,
        "LEAD_CHK_LINECollection":leadCheckData.map((e) => e.tojson()).toList()
        }));
  }
}
