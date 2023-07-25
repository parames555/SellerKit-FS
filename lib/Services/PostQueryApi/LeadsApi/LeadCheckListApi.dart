import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Constant/DataBaseConfig.dart';
import '../../../Models/PostQueryModel/LeadsCheckListModel/GetLeadCheckListModel.dart';

class GetLeadCheckListApi {
  static Future<LeadsCheckListModal> getData(
    sapUserId,
  ) async {
    int resCode = 500;
    try {
      final response = await http.post(Uri.parse(Url.queryApi + 'SellerKit'),
          headers: {
            "content-type": "application/json",
          },
          body: jsonEncode({
            "constr":"Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
            "query": "exec SK_GET_LEAD_CHECKLIST '${ConstantValues.slpcode}'"
          }));

      resCode = response.statusCode;
      print(response.statusCode.toString());
      print(json.decode(response.body));
      if (response.statusCode == 200) {
        return LeadsCheckListModal.fromJson(
            json.decode(response.body), resCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return LeadsCheckListModal.error('Error', resCode);
      }
    } catch (e) {
      print("Exception: " + e.toString());
      return LeadsCheckListModal.error(e.toString(), resCode);
    }
  }
}
