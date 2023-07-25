import 'dart:convert';
import 'dart:developer';
import 'dart:isolate';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Constant/DataBaseConfig.dart';
import '../../../Models/PostQueryModel/EnquiriesModel/EnqTypeModel.dart';

class EnquiryTypeApi {
   Future<EnquiryTypeModal> getData(
    sapUserId,
  ) async {
    int resCode = 500;
    try {
      final response = await http.post(Uri.parse(Url.queryApi + 'SellerKit'),
          headers: {
            "content-type": "application/json",
            //"cookie": 'B1SESSION='+ ConstantValues.sapSessions,
          },
          body: jsonEncode({
            "constr":
                "Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
            "query": "exec SK_GET_ENQUIRY_TYPE '${ConstantValues.slpcode}'"
          }));

      resCode = response.statusCode;
      // print(response.statusCode.toString());
      // print("SK_GET_ENQUIRY_TYPE"+json.decode(response.body).toString());
      if (response.statusCode == 200) {
       ReceivePort port  = new ReceivePort();
       final islol =await Isolate.spawn<List<dynamic>>(deserialize, [port.sendPort,response.body,response.statusCode]);
      EnquiryTypeModal enquiryTypeModal =await port.first;
       islol.kill(priority: Isolate.immediate);
       return enquiryTypeModal;
        // return EnquiryTypeModal.fromJson(
        //     json.decode(response.body), resCode);
      } else {
        //print("Error: ${json.decode(response.body)}");
        return EnquiryTypeModal.error('Error', resCode);
      }
    } catch (e) {
     // print("Exception: " + e.toString());
      return EnquiryTypeModal.error(e.toString(), resCode);
    }
  }

    deserialize(List<dynamic> values){
    SendPort sendPort = values[0];
    String responce = values[1];
    int rescode = values[2];
    Map<String,dynamic> dataMap = jsonDecode(responce);
    var result = EnquiryTypeModal.fromJson(dataMap, rescode);
    sendPort.send(result);
  }
}
