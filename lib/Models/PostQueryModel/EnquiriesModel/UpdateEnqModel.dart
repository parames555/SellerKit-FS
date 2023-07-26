import 'dart:convert';

class UpdateEnqModal {
List<UpdateEnqData>? userLtData;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  UpdateEnqModal(
      {required this.userLtData,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory UpdateEnqModal.fromJson(Map<String, dynamic> jsons,int stcode) {
    if (jsons["data"] != null) {
      var list = json.decode(jsons["data"]) as List;
      List<UpdateEnqData> dataList =
          list.map((data) => UpdateEnqData.fromJson(data)).toList();
      return UpdateEnqModal(
        userLtData: dataList,
        message: jsons["msg"],
        status: jsons["status"],
        stcode: stcode,
        exception:null
      );
    } else {
      return UpdateEnqModal(
        userLtData: null,
        message: jsons["msg"],
        status: jsons["status"],
        stcode: stcode,
        exception:null
      );
    }
  }

  factory UpdateEnqModal.error(String jsons,int stcode) {
    return UpdateEnqModal(
        userLtData: null, message: 'Exception', status: null,   stcode: stcode,
        exception:jsons);
  }
}

class UpdateEnqData {
  UpdateEnqData({
    required this.actionResponce,
    required this.actionResponseMessage,
  });

  String? actionResponce;
  String? actionResponseMessage;


  factory UpdateEnqData.fromJson(Map<String, dynamic> json) =>
   UpdateEnqData(
     actionResponce: json['ActionResponse'] ?? '',
     actionResponseMessage: json['ActionResponseMessage'] ?? '',
     );
   
}
