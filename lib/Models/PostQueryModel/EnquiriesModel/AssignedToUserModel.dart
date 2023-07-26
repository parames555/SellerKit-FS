import 'dart:convert';

class AssignedToUserModal {
List<AssignedToUserData>? userLtData;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  AssignedToUserModal(
      {required this.userLtData,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory AssignedToUserModal.fromJson(Map<String, dynamic> jsons,int stcode) {
    if (jsons["data"] != null) {
      var list = json.decode(jsons["data"]) as List;
      List<AssignedToUserData> dataList =
          list.map((data) => AssignedToUserData.fromJson(data)).toList();
      return AssignedToUserModal(
        userLtData: dataList,
        message: jsons["msg"],
        status: jsons["status"],
        stcode: stcode,
        exception:null
      );
    } else {
      return AssignedToUserModal(
        userLtData: null,
        message: jsons["msg"],
        status: jsons["status"],
        stcode: stcode,
        exception:null
      );
    }
  }

  factory AssignedToUserModal.error(String jsons,int stcode) {
    return AssignedToUserModal(
        userLtData: null, message: 'Exception', status: null,   stcode: stcode,
        exception:jsons);
  }
}

class AssignedToUserData {
  AssignedToUserData({
    required this.actionResponce,
    required this.actionResponseMessage,
  });

  String? actionResponce;
  String? actionResponseMessage;


  factory AssignedToUserData.fromJson(Map<String, dynamic> json) =>
   AssignedToUserData(
     actionResponce: json['ActionResponse'] ?? '',
     actionResponseMessage: json['ActionResponseMessage'] ?? '',
     );
   
}
