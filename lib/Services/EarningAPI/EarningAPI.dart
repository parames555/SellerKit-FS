import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/DataBaseConfig.dart';
import 'package:sellerkit/Models/EarningModel/EraningModel1.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';

class Earning1Api {
  static Future<EarningModel1> getEarningData(
      ) async {
    int resCode = 500;
    try {
      final response = await http.post(Uri.parse('${Url.queryApi}SellerKit'),
          // ('http://164.52.214.147:47182/api/SellerKit'),

          headers: {
            "content-type": "application/json",
          },
          body: jsonEncode({
            "constr":
                "Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
            "query":
                "Exec SK_GET_EARNINGS_1 '${ConstantValues.slpcode}'",
          }));

      resCode = response.statusCode;
      print(response.statusCode.toString());
      print(json.decode(response.body));
      if (response.statusCode == 200) {
        return EarningModel1.fromJson(json.decode(response.body), resCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return EarningModel1.error('Error', resCode);
      }
    } catch (e) {
      print("Exception: $e");
      return EarningModel1.error(e.toString(), resCode);
    }
  }
}
