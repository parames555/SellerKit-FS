// ignore_for_file: unnecessary_string_interpolations, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../Constant/ConstantSapValues.dart';
import '../../../Constant/DataBaseConfig.dart';
import '../../../Models/KpiModel/KpiModel.dart';
import '../../URL/LocalUrl.dart';

class KpiApi {
  // static String? deviceId;
  static Future<KpiModel> sampleDetails() async {
    try {
      final response = await http.post(Uri.parse(Url.queryApi + "SellerKit"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "constr": "Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
            "query": "EXEC SK_DASHBOARD_KPI '${ConstantValues.slpcode}'"
          }));
      if (response.statusCode == 200) {
        //  print(json.decode(response.body));
       return KpiModel.fromJson(
           json.decode(response.body), response.statusCode);
      } else {
         throw Exception("Error");
       // return KpiModel.issue( response.statusCode,'');
      }
    } catch (e) {
      //
       throw Exception(e.toString());
      //return KpiModel.issue( 500,'${e.toString()}');
    }
  }
}
