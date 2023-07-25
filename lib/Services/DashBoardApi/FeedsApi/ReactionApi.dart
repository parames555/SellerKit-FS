import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Constant/DataBaseConfig.dart';
import '../../../Models/PostQueryModel/EnquiriesModel/AssignedToUserModel.dart';

class ReactionApi {
  static Future<AssignedToUserModal> getData(
   int feedIDs,
   String reaction
  ) async {
    int resCode = 500;
    try {
      final response = await http.post(Uri.parse(Url.queryApi + 'SellerKit'),
          headers: {
            "content-type": "application/json",
          },
          body: jsonEncode({
            "constr":"Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
            "query": "exec SK_SET_FEEDS_REACT '${ConstantValues.slpcode}','$feedIDs','$reaction'"
          }));

          log(jsonEncode({
            "constr":"Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
            "query": "exec SK_SET_FEEDS_REACT '${ConstantValues.slpcode}','$feedIDs','$reaction'"
          }));

       resCode = response.statusCode;
      // print(response.statusCode.toString());
       log("Profile: "+json.decode(response.body).toString());
      if (response.statusCode == 200) {
        return AssignedToUserModal.fromJson(
            json.decode(response.body), resCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return AssignedToUserModal.error('Some thing went wrong', resCode);
      }
    } catch (e) {
      print("Exception: " + e.toString());
      return AssignedToUserModal.error(e.toString(), resCode);
    }
  }
}
