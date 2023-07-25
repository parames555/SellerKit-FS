import 'dart:convert';

class WalkinModal {
List<WalkinModalData>? userLtData;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  WalkinModal(
      {required this.userLtData,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory WalkinModal.fromJson(Map<String, dynamic> jsons,int stcode) {
    if (jsons["data"] != null) {
      var list = json.decode(jsons["data"]) as List;
      List<WalkinModalData> dataList =
          list.map((data) => WalkinModalData.fromJson(data)).toList();
      return WalkinModal(
        userLtData: dataList,
        message: jsons["msg"],
        status: jsons["status"],
        stcode: stcode,
        exception:null
      );
    } else {
      return WalkinModal(
        userLtData: null,
        message: jsons["msg"],
        status: jsons["status"],
        stcode: stcode,
        exception:null
      );
    }
  }

  factory WalkinModal.error(String jsons,int stcode) {
    return WalkinModal(
        userLtData: null, message: 'Exception', status: null,   stcode: stcode,
        exception:jsons);
  }
}

class WalkinModalData {
  WalkinModalData({
    required this.actionResponce,
    required this.actionResponseMessage,
  });

  String? actionResponce;
  String? actionResponseMessage;


  factory WalkinModalData.fromJson(Map<String, dynamic> json) =>
   WalkinModalData(
     actionResponce: json['ActionResponse'] ?? '',
     actionResponseMessage: json['ActionResponseMessage'] ?? '',
     );
   
}
