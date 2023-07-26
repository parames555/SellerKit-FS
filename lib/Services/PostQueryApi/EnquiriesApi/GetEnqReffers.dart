// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'dart:isolate';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Constant/DataBaseConfig.dart';
import '../../../Models/PostQueryModel/EnquiriesModel/EnqRefferesModel.dart';

class EnquiryRefferesApi {
   Future<EnqRefferesModal> getData(
    sapUserId,
  ) async {
    int resCode = 500;
    // print("Url.SLUrl: ${Url.queryApi}'SellerKit'");
    // log("exec SK_GET_ENQUIRY_REFERS '$sapUserId'");
    try {
      final response = await http.post(Uri.parse(Url.queryApi + 'SellerKit'),
          headers: {
            "content-type": "application/json",
            //"cookie": 'B1SESSION='+ ConstantValues.sapSessions,
          },
          body: jsonEncode({
            "constr":
               "Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
            "query": "exec SK_GET_ENQUIRY_REFERS '${ConstantValues.slpcode}'"
          }));

      resCode = response.statusCode;
      // print(response.statusCode.toString());
      // print("SK_GET_ENQUIRY_REFERS"+json.decode(response.body).toString());
      if (response.statusCode == 200) {
          ReceivePort port  = new ReceivePort();
       final islol =await Isolate.spawn<List<dynamic>>(deserialize, [port.sendPort,response.body,response.statusCode]);
      EnqRefferesModal enquiryReferral =await port.first;
       islol.kill(priority: Isolate.immediate);
       return enquiryReferral;
        // return EnqRefferesModal.fromJson(
        //     json.decode(response.body), resCode);
      } else {
      //  print("Error: ${json.decode(response.body)}");
        return EnqRefferesModal.error('Error', resCode);
      }
    } catch (e) {
     // print("Exception: " + e.toString());
      return EnqRefferesModal.error(e.toString(), resCode);
    }
  }

      deserialize(List<dynamic> values){
    SendPort sendPort = values[0];
    String responce = values[1];
    int rescode = values[2];
    Map<String,dynamic> dataMap = jsonDecode(responce);
    var result = EnqRefferesModal.fromJson(dataMap, rescode);
    sendPort.send(result);
  }
}
