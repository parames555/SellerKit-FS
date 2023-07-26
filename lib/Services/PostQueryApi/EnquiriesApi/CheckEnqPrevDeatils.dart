// ignore_for_file: file_names, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Constant/DataBaseConfig.dart';
import '../../../Models/PostQueryModel/EnquiriesModel/CheckEnqPrevModel.dart';

class EnqPrevDetailsApi {
  static Future<CheckEnqPrevDetailsModel> getData(
    int enqDocEntry
  ) async {
    int resCode = 500;
    try {
      final response = await http.post(Uri.parse(Url.queryApi + 'SellerKit'),
          headers: {
            "content-type": "application/json",
          },
          body: jsonEncode({
            "constr":
               "Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
            "query": "exec sk_get_Enquiries_Details '$enqDocEntry','${ConstantValues.slpcode}'"
          }));

log("sp: "+ jsonEncode({
            "constr":
               "Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
            "query": "exec sk_get_Enquiries_Details '$enqDocEntry','${ConstantValues.slpcode}'"
          }));
      resCode = response.statusCode;
      print(response.statusCode.toString());
      print(json.decode(response.body));
      if (response.statusCode == 200) {
        return CheckEnqPrevDetailsModel.fromJson(
            json.decode(response.body), resCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return CheckEnqPrevDetailsModel.error('Error', resCode);
      }
    } catch (e) {
      print("Exception: " + e.toString());
      return CheckEnqPrevDetailsModel.error(e.toString(), resCode);
    }
  }
}
