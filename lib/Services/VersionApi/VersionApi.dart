// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../Models/VersionModel/VersionModel.dart';

class VersionApi {
  static Future<VersionModel> getData() async {
    int resCode = 500;
// print(Url.queryApi + 'SellerKit/GetVertion');
    try {
      final response = await http.get(Uri.parse(Url.queryApi + 'SellerKit/GetVertion'),
          headers: {
            "content-type": "application/json",
          },);
      resCode = response.statusCode;
      //  print(response.statusCode.toString());
      //  print("Version" + json.decode(response.body).toString());
      if (response.statusCode == 200) {
        // Map data = json.decode(response.body);
        return VersionModel.fromJson(json.decode(response.body), resCode);
      } else {
       // print("Error: ${json.decode(response.body)}");
        // throw Exception("Error");
        return VersionModel.error('Error', resCode);
      }
    } catch (e) {
      print("Exception: " + e.toString());
      //  throw Exception(e.toString());
      return VersionModel.error(e.toString(), resCode);
    }
  }
}
