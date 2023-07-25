import 'dart:convert';
import 'dart:developer';
import 'dart:isolate';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Constant/DataBaseConfig.dart';
import '../../../Models/PostQueryModel/EnquiriesModel/GetUserModel.dart';

class GetUserApi {
   Future<UserListModal> getData(
    sapUserId,
  ) async {
    int resCode = 500;
    try {
      final response = await http.post(Uri.parse(Url.queryApi + 'SellerKit'),
          headers: {
            "content-type": "application/json",
          },
          body: jsonEncode({
            "constr":"Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
            "query": "exec sk_get_userlist_for_assign '${ConstantValues.slpcode}'"
          }));

      resCode = response.statusCode;
      // print(response.statusCode.toString());
      // print("sk_get_userlist_for_assign"+json.decode(response.body).toString());
      if (response.statusCode == 200) {
          ReceivePort port  = new ReceivePort();
       final islol =await Isolate.spawn<List<dynamic>>(deserialize, [port.sendPort,response.body,response.statusCode]);
      UserListModal enquiryReferral =await port.first;
       islol.kill(priority: Isolate.immediate);
       return enquiryReferral;

      } else {
      //  print("Error: ${json.decode(response.body)}");
        return UserListModal.error('Error', resCode);
      }
    } catch (e) {
     // print("Exception: " + e.toString());
      return UserListModal.error(e.toString(), resCode);
    }
  }

    deserialize(List<dynamic> values){
    SendPort sendPort = values[0];
    String responce = values[1];
    int rescode = values[2];
    Map<String,dynamic> dataMap = jsonDecode(responce);
    var result = UserListModal.fromJson(dataMap, rescode);
    sendPort.send(result);
  }
}
