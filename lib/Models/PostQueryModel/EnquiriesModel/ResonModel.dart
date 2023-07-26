import 'dart:convert';

class ResonModal {
List<ResonData>? userLtData;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  ResonModal(
      {required this.userLtData,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory ResonModal.fromJson(Map<String, dynamic> jsons,int stcode) {
    if (jsons["data"] != null) {
      var list = json.decode(jsons["data"]) as List;
      List<ResonData> dataList =
          list.map((data) => ResonData.fromJson(data)).toList();
      return ResonModal(
        userLtData: dataList,
        message: jsons["msg"],
        status: jsons["status"],
        stcode: stcode,
        exception:null
      );
    } else {
      return ResonModal(
        userLtData: null,
        message: jsons["msg"],
        status: jsons["status"],
        stcode: stcode,
        exception:null
      );
    }
  }

  factory ResonModal.error(String jsons,int stcode) {
    return ResonModal(
        userLtData: null, message: 'Exception', status: null,   stcode: stcode,
        exception:jsons);
  }
}

class ResonData {
  ResonData({
    required this.CODE,
    required this.color
  });

  String? CODE;
  int? color;


  factory ResonData.fromJson(Map<String, dynamic> json) =>
   ResonData(
     CODE: json['Code'] ?? '',
      color:0
     );
   
}
