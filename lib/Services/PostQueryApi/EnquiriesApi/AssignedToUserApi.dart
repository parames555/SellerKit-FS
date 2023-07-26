import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/DataBaseConfig.dart';
import '../../../Models/PostQueryModel/EnquiriesModel/AssignedToUserModel.dart';

class AssignedToUserApi {
  static Future<AssignedToUserModal> getData(
    enqID,
    userKey
  ) async {
    int resCode = 500;
    try {
      final response = await http.post(Uri.parse(Url.queryApi+'SellerKit'),
          headers: {
            "content-type": "application/json",
          },
          body: jsonEncode({
            "constr":
               "Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
            "query": "exec sk_set_assign_enq_to_other_user '$enqID','$userKey'"
          }));

      resCode = response.statusCode;
      print(response.statusCode.toString());
      print(json.decode(response.body));
      if (response.statusCode == 200) {
        Map data = json.decode(response.body);
        return AssignedToUserModal.fromJson(
            json.decode(response.body), resCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return AssignedToUserModal.error('Error', resCode);
      }
    } catch (e) {
      print("Exception: " + e.toString());
      return AssignedToUserModal.error(e.toString(), resCode);
    }
  }
}
