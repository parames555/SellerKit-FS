import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/DataBaseConfig.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Models/PostQueryModel/TargetModel/TargetModel.dart';

class GetTargetApi {
  static Future<TargetModal> getData(
      // sapUserId,
      ) async {
    int resCode = 500;
    try {
      final response = await http.post(Uri.parse(Url.queryApi + 'SellerKit'),
          // ('http://164.52.214.147:47182/api/SellerKit'),

          headers: {
            "content-type": "application/json",
          },
          body: jsonEncode({
            "constr":
                "Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
            "query":
                "Exec SK_GET_SALES_TARGET_KPI '${ConstantValues.slpcode}'",
          }));

      resCode = response.statusCode;
      print(response.statusCode.toString());
      print(json.decode(response.body));
      if (response.statusCode == 200) {
        return TargetModal.fromJson(json.decode(response.body), resCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return TargetModal.error('Error', resCode);
      }
    } catch (e) {
      print("Exception: " + e.toString());
      return TargetModal.error(e.toString(), resCode);
    }
  }
}
