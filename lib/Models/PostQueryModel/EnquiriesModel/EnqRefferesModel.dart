import 'dart:convert';
import '../../../DBModel/EnqTypeModel.dart';

class EnqRefferesModal {
List<EnqRefferesData>? enqReffersdata;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  EnqRefferesModal(
      {required this.enqReffersdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory EnqRefferesModal.fromJson(Map<String, dynamic> jsons,int stcode) {
    if (jsons["data"] != null) {
      var list = json.decode(jsons["data"]) as List;
      List<EnqRefferesData> dataList =
          list.map((data) => EnqRefferesData.fromJson(data)).toList();
      return EnqRefferesModal(
        enqReffersdata: dataList,
        message: jsons["msg"],
        status: jsons["status"],
        stcode: stcode,
        exception:null
      );
    } else {
      return EnqRefferesModal(
        enqReffersdata: null,
        message: jsons["msg"],
        status: jsons["status"],
        stcode: stcode,
        exception:null
      );
    }
  }

  factory EnqRefferesModal.error(String jsons,int stcode) {
    return EnqRefferesModal(
        enqReffersdata: null, message: 'Exception', status: null,   stcode: stcode,
        exception:jsons);
  }
}

class EnqRefferesData {
  EnqRefferesData({
    required this.Code,
    required this.Name,


  });

  String? Code;
  String? Name;


  factory EnqRefferesData.fromJson(Map<String, dynamic> json) =>
   EnqRefferesData(
     Code: json['Code'] ?? '',
     Name: json['Name'] ?? '',
     );
   
   Map<String , Object?> toMap()=>{
  EnqTypeDBModel.code:Code,
  EnqTypeDBModel.name:Name,
};
}
