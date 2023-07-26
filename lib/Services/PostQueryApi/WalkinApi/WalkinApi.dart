import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Constant/DataBaseConfig.dart';
import '../../../Models/PostQueryModel/WalkinModel.dart/WalkinModel.dart';

class WalkinApi {
  static Future<WalkinModal> getData(
    sapUserId,
    purposeOFVisit,
    division,
    headcount
  ) async {
    int resCode = 500;
    log("exec SK_POST_NEWWALKIN '$sapUserId','$division','$headcount'");
    try {
      final response = await http.post(Uri.parse(Url.queryApi + 'SellerKit'),
          headers: {
            "content-type": "application/json",
          },
          body: jsonEncode({
            "constr":
               "Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
            "query": "exec SK_POST_NEWWALKIN '${ConstantValues.slpcode}','$purposeOFVisit','$division','$headcount'"
          }));

      resCode = response.statusCode;
      print(response.statusCode.toString());
      print(json.decode(response.body));
      if (response.statusCode == 200) {
        Map data = json.decode(response.body);
        return WalkinModal.fromJson(
            json.decode(response.body), resCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return WalkinModal.error('Error', resCode);
      }
    } catch (e) {
      print("Exception: " + e.toString());
      return WalkinModal.error(e.toString(), resCode);
    }
  }
}
