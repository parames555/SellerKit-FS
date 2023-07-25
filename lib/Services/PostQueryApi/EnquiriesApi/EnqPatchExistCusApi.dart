// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Constant/DataBaseConfig.dart';
import '../../../Models/AddEnqModel/AddEnqModel.dart';
import '../../../Models/PostQueryModel/EnquiriesModel/UpdateEnqModel.dart';

class EnqPatchExistCustApi {
  static Future<UpdateEnqModal> getData(sapUserId, PatchExCus patch) async {
    int resCode = 500;
    // ignore: unnecessary_null_comparison
    try {
      final response = await http.post(
          Uri.parse(Url.queryApi + 'SellerKit'),
          headers: {
            "content-type": "application/json",
            //"cookie": 'B1SESSION='+ ConstantValues.sapSessions,
          },
          body: jsonEncode({
            "constr":"Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
            "query": "exec SK_UPDATE_CUSTOMER '${ConstantValues.slpcode}','${patch.CardCode}','${patch.CardName}','${patch.U_Address1}','${patch.U_Address2}','${patch.U_City}','${patch.U_Pincode}',"+ (patch.U_State ==null?null: '${patch.U_State}').toString() +  ","+
             (patch.U_Country ==null?null : '${patch.U_Country}' ).toString()+ ","+(patch.U_Facebook ==null?null: '${patch.U_Facebook},' ).toString()+","+ (patch.U_EMail==null?null: "'${patch.U_EMail}'").toString() +","+  (patch.U_Type==''?null: "'${patch.U_Type}'").toString(),
          }));

          log("Update cus: "+
           jsonEncode({
            "constr":"Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
            "query": "exec SK_UPDATE_CUSTOMER '${ConstantValues.slpcode}','${patch.CardCode}','${patch.CardName}','${patch.U_Address1}','${patch.U_Address2}','${patch.U_City}','${patch.U_Pincode}',"+ (patch.U_State ==null?null: '${patch.U_State}').toString() +  ","+
             (patch.U_Country ==null?null : '${patch.U_Country}' ).toString()+ ","+(patch.U_Facebook ==null?null: '${patch.U_Facebook},' ).toString()+","+ (patch.U_EMail==null?null: "'${patch.U_EMail}'").toString() +","+  (patch.U_Type==''?null: "'${patch.U_Type}'").toString(),
          })
          );
      resCode = response.statusCode;
      // ignore: unnecessary_null_comparison
      print(response.statusCode.toString());
      print(json.decode(response.body));
      if (response.statusCode == 200) {
        return UpdateEnqModal.fromJson(json.decode(response.body), resCode);
        //return resCode;
      } else {
        //return resCode;
        print("Error: ${json.decode(response.body)}");
        return UpdateEnqModal.error("Error", resCode);
      }
    } catch (e) {
      print("Exception: " + e.toString());
      //  return  resCode;
      return UpdateEnqModal.error(e.toString(), resCode);
    }
  }

  static printJson(sapUserId, PatchExCus patch){
     log(jsonEncode({
            "constr":"Server=164.52.214.147;Database=JRF1;User Id=Sa; Password=BusOn@123;",
            "query": "exec SK_UPDATE_CUSTOMER '${ConstantValues.slpcode}','${patch.CardCode}','${patch.CardName}','${patch.U_Address1}','${patch.U_Address2}','${patch.U_City}','${patch.U_Pincode}',"+ (patch.U_State ==null?null: '${patch.U_State}').toString() +  ","+
    (patch.U_Country ==null?null : '${patch.U_Country}' ).toString()+ ","+(patch.U_Facebook ==null?null: '${patch.U_Facebook},' ).toString()+","+ (patch.U_EMail ==null?null: "'${patch.U_EMail}'").toString(),
          }));
  }
}


//   try {
//       final response = await http.patch(Uri.parse(Url.SLUrl + "BusinessPartners('${patch.CardCode}')"),
//           headers: {
//             "content-type": "application/json",
//             "cookie": 'B1SESSION='+ ConstantValues.sapSessions,
//           },
//           body: jsonEncode(
//           {
//     "CardCode":"${patch.CardCode}",// "8610659136",
//     "CardName": "${patch.CardName}",
//     "CardType": "cCustomer" ,
//      "U_Address1":"${patch.U_Address1}",
//     "U_Address2": "${patch.U_Address2}",
//     "U_City": "${patch.U_City}",
//     "U_Pincode":"${patch.U_Pincode}",
//     "U_State":patch.U_State==null?null:"${patch.U_State}",
//     "U_Country":patch.U_Country==null?null:"${patch.U_Country}",
//     "U_Facebook":patch.U_Facebook==null?null:"${patch.U_Facebook}",
//     "U_EMail" : "${patch.U_EMail}",
// }
//           ));
// log(
//   jsonEncode(
//           {
//     "CardCode":"${patch.CardCode}",// "8610659136",
//     "CardName": "${patch.CardName}",
//     "CardType": "cCustomer" ,
//      "U_Address1":"${patch.U_Address1}",
//     "U_Address2": "${patch.U_Address2}",
//     "U_City": "${patch.U_City}",
//     "U_Pincode":"${patch.U_Pincode}",
//     "U_State":patch.U_State==null?null:"${patch.U_State}",
//     "U_Country":patch.U_Country==null?null:"${patch.U_Country}",
//     "U_Facebook":patch.U_Facebook==null?null:"${patch.U_Facebook}",
//     "U_EMail" : "${patch.U_EMail}",
// }
//           ));
//       resCode = response.statusCode;
//       print(response.statusCode.toString());
//       print(json.decode(response.body));
//       if (response.statusCode == 200) {
//         return EnqPatchModal.fromJson(
//             json.decode(response.body), resCode);
//         //return resCode;
//       } else {
//          //return resCode;
//        print("Error: ${json.decode(response.body)}");
//        return EnqPatchModal.issue(json.decode(response.body), resCode);
//       }
//     }