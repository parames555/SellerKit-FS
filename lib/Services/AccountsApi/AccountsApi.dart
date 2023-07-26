import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/DataBaseConfig.dart';
import '../../../Models/PostQueryModel/ItemMasterModelNew.dart/ItemMasterNewModel.dart';
import '../../Models/AccountsModel/AccountsModel.dart';

class AccountsApiNew {
  static Future<AccountsDetails> getData(int i) async {
    int resCode = 500;
    print("Url accounts: ${Url.queryApi}SellerKit");
    print(ConstantValues.sapSessions);
    print(DataBaseConfig.ip);
    print(DataBaseConfig.database);

    try {
      final response = await http.post(Uri.parse(Url.queryApi + 'SellerKit'),
          headers: {
            "content-type": "application/json",
            "cookie": 'B1SESSION=' + ConstantValues.sapSessions,
          },
          body: jsonEncode({
            "constr":
                "Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
            "query":
                "exec [SK_GET_CUSTOMER_LIST] '${ConstantValues.slpcode}','$i'"
          }));
      log(jsonEncode({
        "constr":
            "Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
        "query": "exec [SK_GET_CUSTOMER_LIST] '${ConstantValues.slpcode}','$i'"
      }));
      resCode = response.statusCode;
      print(response.statusCode.toString());
      print("sk_inventory_master_data" + json.decode(response.body).toString());
      if (response.statusCode == 200) {
        // Map data = json.decode(response.body);
        return AccountsDetails.fromJson(json.decode(response.body), resCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        // throw Exception("Error");
        return AccountsDetails.error('Error', resCode);
      }
    } catch (e) {
      print("Exception: " + e.toString());
      //  throw Exception(e.toString());
      return AccountsDetails.error(e.toString(), resCode);
    }
  }
}
