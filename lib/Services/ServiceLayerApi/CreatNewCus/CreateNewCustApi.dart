// ignore_for_file: prefer_interpolation_to_compose_strings, unnecessary_string_interpolations

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Models/PostQueryModel/LeadsCheckListModel/LeadSavePostModel/LeadSavePostModel.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Models/AddEnqModel/AddEnqModel.dart';
import '../../../Models/PostQueryModel/EnquiriesModel/CustomerCreationModel.dart';

class NewCustCretApi {
  static Future<NewCustomerEnqValue> getData(sapUserId, PatchExCus patch,
      [PostLead? postLead]) async {
    int resCode = 500;
    log(Url.SLUrl + "BusinessPartners");
      log(jsonEncode({
                "CardCode": "${patch.CardCode}", // "8610659136",
                "CardName": "${patch.CardName}",
                "CardType": "cCustomer",
                "SalesPersonCode" : "${ConstantValues.slpcode}",
                "LanguageCode": 8,
                "U_Address1": "${patch.U_Address1}",
                "U_Address2": "${patch.U_Address2}",
                "U_City": "${patch.U_City}",
                "U_Pincode": "${patch.U_Pincode}",
                "U_State": patch.U_State == null ? null : "${patch.U_State}",
                "U_Country":
                    patch.U_Country == null ? null : "${patch.U_Country}",
                "U_Facebook":
                    patch.U_Facebook == null ? null : "${patch.U_Facebook}",
                "U_EMail": "${patch.U_EMail}",
                "U_Type":"${patch.U_Type}"
              }));
    try {
      final response =
          await http.post(Uri.parse(Url.SLUrl + "BusinessPartners"),
              headers: {
                "content-type": "application/json",
                "cookie": 'B1SESSION=' + ConstantValues.sapSessions,
              },
              body: jsonEncode({
                "CardCode": "${patch.CardCode}", // "8610659136",
                "CardName": "${patch.CardName}",
                "CardType": "cCustomer",
                "SalesPersonCode" : "${ConstantValues.slpcode}",
                "LanguageCode": 8,
                "U_Address1": "${patch.U_Address1}",
                "U_Address2": "${patch.U_Address2}",
                "U_City": "${patch.U_City}",
                "U_Pincode": "${patch.U_Pincode}",
                "U_State": patch.U_State == null ? null : "${patch.U_State}",
                "U_Country":
                    patch.U_Country == null ? null : "${patch.U_Country}",
                "U_Facebook":
                    patch.U_Facebook == null ? null : "${patch.U_Facebook}",
                "U_EMail": "${patch.U_EMail}",
                "U_Type":"${patch.U_Type}"
              }));
    
      resCode = response.statusCode;
      print(response.statusCode.toString());
      print(json.decode(response.body));
      if (response.statusCode >= 200 && response.statusCode <= 210) {
        return NewCustomerEnqValue.fromJson(
            json.decode(response.body.toString()), resCode);
      } else if (response.statusCode >= 400 && response.statusCode <= 410) {
        print("Error: ${json.decode(response.body)}");
        // throw Exception("Error");

        return NewCustomerEnqValue.issue(json.decode(response.body), resCode);
      } else {
        // throw Exception("Error");
        return NewCustomerEnqValue.exception('', resCode);
      }
    } catch (e) {
      print("Exception: " + e.toString());
      //throw Exception(e.toString());
      return NewCustomerEnqValue.exception(e.toString(), resCode);
    }
  }
}
