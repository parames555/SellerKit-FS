
import 'dart:convert';

class VersionModel{
  List<VersionModelData>? itemdata;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  VersionModel(
      {required this.itemdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory VersionModel.fromJson(Map<String, dynamic> jsons,int stcode) {
    if (jsons["data"] != null) {
      var list = jsonDecode(jsons["data"]) as List;
      List<VersionModelData> dataList =
          list.map((data) => VersionModelData.fromJson(data)).toList();
      return VersionModel(
        itemdata: dataList,
        message: jsons["message"],
        status: jsons["status"],
        stcode: stcode,
        exception:null
      );
    } else {
      return VersionModel(
        itemdata: null,
        message: jsons["message"],
        status: jsons["status"],
        stcode: stcode,
        exception:null
      );
    }
  }

  factory VersionModel.error(String jsons,int stcode) {
    return VersionModel(
        itemdata: null, message: 'Exception', status: null,   stcode: stcode,
        exception:jsons);
  }

}
class VersionModelData {
  VersionModelData({
    required this.url,
    required this.content,
    required this.version,
  });

  String? url;
  String? content;
  String? version;



  factory VersionModelData.fromJson(Map<String, dynamic> json) =>
   VersionModelData(
     url: json['Url'] ?? '',
     content: json['Content'] ?? '',
     version: json['Vertion'] ?? '', 
);  
}
