// ignore_for_file: file_names, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Constant/DataBaseConfig.dart';
import '../../../Models/PostQueryModel/EnquiriesModel/EnquiriesModel.dart';

class EnquiryApi {
  static Future<EnquiriesModal> getData(sapUserId,) async {
    int resCode = 500;
  //  print("Url.SLUrl: ${Url.queryApi}'SellerKit'");
  // log("exec sk_sp_inventory_master '$sapUserId'");
    try {
      final response = await http.post(Uri.parse(Url.queryApi + 'SellerKit'),
          headers: {
            "content-type": "application/json",
            //"cookie": 'B1SESSION='+ ConstantValues.sapSessions,
          },
          body: jsonEncode({
            "constr":
              "Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
            "query": "exec sk_get_enquiries '${ConstantValues.slpcode}'"
          }));

      resCode = response.statusCode;
      print(response.statusCode.toString());
      print(json.decode(response.body));
      if (response.statusCode == 200) {
        // print(response.statusCode.toString());
        // print(json.decode(response.body));
        Map data = json.decode(response.body);
        // if(data["responce"]!= null){
        // print(data["responce"]);
        // print( json.decode(data["responce"]));
        // }
        return EnquiriesModal.fromJson(
            json.decode(response.body), resCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return EnquiriesModal.error('Error', resCode);
      }
    } catch (e) {
      print("Exception: " + e.toString());
      return EnquiriesModal.error(e.toString(), resCode);
    }
  }
}
