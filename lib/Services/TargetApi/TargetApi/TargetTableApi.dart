import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/DataBaseConfig.dart';
import 'package:sellerkit/Models/TargetModel/TargetTableModel.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Models/PostQueryModel/LeadsCheckListModel/GetAllLeadModel.dart';

class GetTargetTableApi {
  static Future<TargetTableModal> getData(
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
                "Exec SK_GET_SALES_TARGET_TABLE1 '${ConstantValues.slpcode}'",
          }));

      resCode = response.statusCode;
      print(response.statusCode.toString());
      log("table: " + json.decode(response.body).toString());
      if (response.statusCode == 200) {
        return TargetTableModal.fromJson(json.decode(response.body), resCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return TargetTableModal.error('Error', resCode);
      }
    } catch (e) {
      print("Exception: " + e.toString());
      return TargetTableModal.error(e.toString(), resCode);
    }
  }
}
