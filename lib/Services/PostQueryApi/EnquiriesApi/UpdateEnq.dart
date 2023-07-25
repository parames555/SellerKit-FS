import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/DataBaseConfig.dart';
import '../../../Models/PostQueryModel/EnquiriesModel/UpdateEnqModel.dart';

class UpdateEnqApi {
  static Future<UpdateEnqModal> getData(
    enqID,
    reson,
    fromDate
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
            "query": 
            fromDate==null?
            "exec SK_SET_UPDATE_ENQUIRY_STATUS '$enqID','$reson',null"
            :
            "exec SK_SET_UPDATE_ENQUIRY_STATUS '$enqID','$reson','$fromDate'"
          }));

          log(jsonEncode({
            "constr":
                "Server=164.52.214.147;Database=JRF1;User Id=Sa; Password=BusOn@123;",
            "query": 
            fromDate==null?
            "exec SK_SET_UPDATE_ENQUIRY_STATUS '$enqID','$reson',null"
            :
            "exec SK_SET_UPDATE_ENQUIRY_STATUS '$enqID','$reson','$fromDate'"
          }));

      resCode = response.statusCode;
      print(response.statusCode.toString());
      print(json.decode(response.body));
      if (response.statusCode == 200) {
        Map data = json.decode(response.body);
        return UpdateEnqModal.fromJson(
            json.decode(response.body), resCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return UpdateEnqModal.error('Error', resCode);
      }
    } catch (e) {
      print("Exception: " + e.toString());
      return UpdateEnqModal.error(e.toString(), resCode);
    }
  }
}
