import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'dart:convert';
import 'package:sellerkit/Constant/DataBaseConfig.dart';
import 'package:sellerkit/Models/ScoreCardModel/ScoreCard1mode.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';

class ScoreCardApi1 {
  static Future<ScoreCard1Model> getScore1Data() async {
    int resCode = 500;
    try {
      final response = await http.post(Uri.parse(Url.queryApi + "SellerKit"),
          headers: {
            "content-type": "application/json",
          },
          body: jsonEncode({
            "constr":
                "Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
            "query": "exec SK_GET_SCORECARD_1  '${ConstantValues.slpcode}'"
          }));

      resCode = response.statusCode;
      print(response.statusCode.toString());
      print(json.decode(response.body));
      if (response.statusCode == 200) {
        return ScoreCard1Model.fromJson(json.decode(response.body), resCode);
      } else {
        // print("Error: ${json.decode(response.body)}");
        return ScoreCard1Model.error('Error', resCode);
      }
    } catch (e) {
      print("Exception: " + e.toString());
      return ScoreCard1Model.error(e.toString(), resCode);
    }
  }
}
