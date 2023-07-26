import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Constant/DataBaseConfig.dart';
import '../../../Models/PostQueryModel/LeadsCheckListModel/GetAllLeadModel.dart';

class GetAllLeadApi {
  static Future<GetAllLeadModal> getData(
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
            "query": "exec SK_GET_LEADS '${ConstantValues.slpcode}'"
          }));
          
          jsonEncode({
            "constr":
                "Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
            "query": "exec [dbo].[SK_GET_OPEN_LEADS_REPORT]  '${ConstantValues.slpcode}'"
          });
      resCode = response.statusCode;
      // print(response.statusCode.toString());
      // print(json.decode(response.body));
      if (response.statusCode == 200) {
        return GetAllLeadModal.fromJson(
            json.decode(response.body), resCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return GetAllLeadModal.error('Error', resCode);
      }
    } catch (e) {
      print("Exception: " + e.toString());
      return GetAllLeadModal.error(e.toString(), resCode);
    }
  }
}
