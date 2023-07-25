import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Constant/DataBaseConfig.dart';
import '../../../Models/PostQueryModel/EnquiriesModel/GetCustomerDetailsModel.dart';

class GetCutomerDetailsApi {
  static Future<GetCustomerDetailsModal> getData(
    mobileNo,
    sapUserId,
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
            "query":  "exec sk_get_customer '$mobileNo','${ConstantValues.slpcode}'"
          }));

      resCode = response.statusCode;
      if (response.statusCode == 200) {
        return GetCustomerDetailsModal.fromJson(
            json.decode(response.body), resCode);
      } else {
        return GetCustomerDetailsModal.error('Error', resCode);
      }
    } catch (e) {
      return GetCustomerDetailsModal.error(e.toString(), resCode);
    }
  }
}
