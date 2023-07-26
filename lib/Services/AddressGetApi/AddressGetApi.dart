import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import '../../Models/AddressMoasterModel.dart';


class AddressMasterApi {
  static Future<AddressrModel> getData(String lan,String long) async {
    int resCode = 500;

    try {
      final response = await http.get(
        Uri.parse('https://geocode.maps.co/reverse?lat=$lan&lon=$long'),
        headers: {
          "content-type": "application/json",
        },
      );
      resCode = response.statusCode;
      log(response.body.toString());
      // log("sk_Address_master_data${json.decode(response.body)}");
      if (response.statusCode == 200) {
        // Map data = json.decode(response.body);
        return AddressrModel.fromJson(json.decode(response.body), resCode);
      } else {
        log("Error: ${json.decode(response.body)}");
        throw Exception("Error");
        // return AddressrModel.error('Error', resCode);
      }
    } catch (e) {
      log("Exception: " + e.toString());
       throw Exception(e.toString());
      // return AddressrModel.error(e.toString(), resCode);
    }
  }
}
