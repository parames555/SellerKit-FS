// ignore_for_file: prefer_interpolation_to_compose_strings, duplicate_ignore

import 'dart:convert';
import 'dart:developer';
import 'dart:isolate';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/DataBaseConfig.dart';
import '../../../Models/PostQueryModel/ItemMasterModelNew.dart/ItemMasterNewModel.dart';
class ItemMasterApiNew {
   Future<ItemMasterNewModal> getData() async {
    int resCode = 500;
   // print("Url.SLUrl item master: ${Url.queryApi}'SellerKit'");
    try {
      final response = await http.post(
        Uri.parse(Url.queryApi+'SellerKit'
        ),
         headers: {
        "content-type": "application/json",
        "cookie": 'B1SESSION='+ ConstantValues.sapSessions,
        },
        body: jsonEncode({
    "constr": "Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
    "query": "exec sk_inventory_master_data '${ConstantValues.slpcode}'"
        })
        );
        // ignore: prefer_interpolation_to_compose_strings
       // log("sb config: "+ jsonEncode({
    // "constr": "Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
    // "query": "exec sk_inventory_master_data '${ConstantValues.slpcode}'"
    //     }));
      resCode = response.statusCode;
      // print(response.statusCode.toString());
       // print("sk_inventory_master_data"+json.decode(response.body).toString());
      if (response.statusCode == 200) {
         ReceivePort port = ReceivePort();
        final isolate = await Isolate.spawn<List<dynamic>>(deserializePerson,
            [port.sendPort, response.body, response.statusCode]);
        final person = await port.first;
        isolate.kill(priority: Isolate.immediate);
        ItemMasterNewModal itemMasterData = person;
        return itemMasterData;
      } else {
        //print("Error: ${json.decode(response.body)}");
        return ItemMasterNewModal.error ('Error',resCode);
      }
    } catch (e) {
      //print("Exception: "+e.toString());
      return ItemMasterNewModal.error(e.toString(),resCode);
    }
  }

  void deserializePerson(List<dynamic> values) {
    SendPort sendPort = values[0];
    String responce = values[1]; //its hold the responce
    //log("data:: "+ data.toString());//check this
    //print("Data: "+data);
    int statusCode = values[2];
    // print("stttt: " + statusCode.toString());
    Map<String, dynamic> dataMap = jsonDecode(responce);
    var datas = ItemMasterNewModal.fromJson(dataMap, statusCode);
    sendPort.send(datas);
  }
}
