import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Constant/DataBaseConfig.dart';
import '../../../Models/PostQueryModel/FeedsModel/FeedsModel.dart';

class FeedsApi {
  static Future<FeedsModal> getData(
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
            "query": "exec SK_GET_FEEDS_LIST '${ConstantValues.slpcode}'"
          }));

          // log(jsonEncode({
          //   "constr":"Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
          //   "query": "exec SK_GET_FEEDS_LIST '${ConstantValues.sapUserID}'"
          // }));

      resCode = response.statusCode;
      // print(response.statusCode.toString());
      // log("Feeds: "+json.decode(response.body).toString());
      if (response.statusCode == 200) {
        return FeedsModal.fromJson(
            json.decode(response.body), resCode);
      } else {
      //  print("Error: ${json.decode(response.body)}");
        return FeedsModal.error('Error', resCode);
        //throw Exception();
      }
    } catch (e) {
     // print("Exception: " + e.toString());
      return FeedsModal.error(e.toString(), resCode);
     // throw Exception(e.toString());
    }
  }
}
