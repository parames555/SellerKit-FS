import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/DataBaseConfig.dart';
import '../../../Models/PostQueryModel/ItemMasterUpdateModel/ItemMasterUpdateModelNew.dart';
class ItemMasterApiUpdateNew {
  static Future<ItemMasterNewUpdateModal> getData(sapUserId,String itemCode,) async {
    int resCode = 500;
    try {
      final response = await http.post(
        Uri.parse(Url.queryApi+'SellerKit'
        ),
         headers: {
        "content-type": "application/json",
        //"cookie": 'B1SESSION='+ ConstantValues.sapSessions,
        },
        body: jsonEncode({
    "constr": "Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
    "query": "exec sk_sp_inventory_master_item '$sapUserId','$itemCode'"
        })
        );
        
      resCode = response.statusCode;
       print(response.statusCode.toString());
        print(json.decode(response.body));
      if (response.statusCode == 200) {
        Map data = json.decode(response.body);
        return ItemMasterNewUpdateModal.fromJson(json.decode(response.body), resCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return ItemMasterNewUpdateModal.error ('Error',resCode);
      }
    } catch (e) {
      print("Exception: "+e.toString());
      return ItemMasterNewUpdateModal.error(e.toString(),resCode);
    }
  }


}
