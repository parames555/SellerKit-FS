import 'dart:convert';
import '../../../DBModel/EnqTypeModel.dart';

class EnquiryTypeModal {
List<EnquiryTypeData>? itemdata;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  EnquiryTypeModal(
      {required this.itemdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory EnquiryTypeModal.fromJson(Map<String, dynamic> jsons,int stcode) {
    if (jsons["data"] != "No data found") {
      var list = json.decode(jsons["data"]) as List;
      List<EnquiryTypeData> dataList =
          list.map((data) => EnquiryTypeData.fromJson(data)).toList();
      return EnquiryTypeModal(
        itemdata: dataList,
        message: jsons["msg"],
        status: jsons["status"],
        stcode: stcode,
        exception:null
      );
    } else {
      return EnquiryTypeModal(
        itemdata: null,
        message: jsons["msg"],
        status: jsons["status"],
        stcode: stcode,
        exception:null
      );
    }
  }

  factory EnquiryTypeModal.error(String jsons,int stcode) {
    return EnquiryTypeModal(
        itemdata: null, message: 'Exception', status: null,   stcode: stcode,
        exception:jsons);
  }
}

class EnquiryTypeData {
  EnquiryTypeData({
    required this.Code,
    required this.Name,


  });

  int? Code;
  String? Name;


  factory EnquiryTypeData.fromJson(Map<String, dynamic> json) =>
   EnquiryTypeData(
     Code: json['Code'] ?? 00,
     Name: json['Name'] ?? '',
     );
   
   Map<String , Object?> toMap()=>{
  EnqTypeDBModel.code:Code,
  EnqTypeDBModel.name:Name,
};
}
