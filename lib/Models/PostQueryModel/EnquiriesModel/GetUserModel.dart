import 'dart:convert';

import '../../../DBModel/EnqTypeModel.dart';

class UserListModal {
List<UserListData>? userLtData;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  UserListModal(
      {required this.userLtData,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory UserListModal.fromJson(Map<String, dynamic> jsons,int stcode) {
    if (jsons["data"]  != "No data found") {
      var list = json.decode(jsons["data"]) as List;
      List<UserListData> dataList =
          list.map((data) => UserListData.fromJson(data)).toList();
      return UserListModal(
        userLtData: dataList,
        message: jsons["msg"],
        status: jsons["status"],
        stcode: stcode,
        exception:null
      );
    } else {
      return UserListModal(
        userLtData: null,
        message: jsons["msg"],
        status: jsons["status"],
        stcode: stcode,
        exception:null
      );
    }
  }

  factory UserListModal.error(String jsons,int stcode) {
    return UserListModal(
        userLtData: null, message: 'Exception', status: null,   stcode: stcode,
        exception:jsons);
  }
}

class UserListData {
  UserListData({
    // required this.UserKey,
    // required this.UserCode,
    required this.UserName,
    required this.color,
    // required this.EmployeeID,
    required this.SalesEmpID
  });

  // int? UserKey;
  // String? UserCode;
  String? UserName;
  int? color;
  int?SalesEmpID;
  // int?EmployeeID;

  factory UserListData.fromJson(Map<String, dynamic> json) =>
   UserListData(
    //  UserKey: json['UserKey'] ??0,
     SalesEmpID: json['SalesEmpID'] ??0,
    //  EmployeeID: json['EmployeeID'] ??0,
    //  UserCode: json['UserCode'] ?? '',
     UserName: json['UserName'] ?? '',
     color: 0
     );


  Map<String , Object?> toMap()=>{
  // UserListDBModel.userKey:UserKey,
  // UserListDBModel.userCode:UserCode,
  UserListDBModel.userName:UserName,
  // UserListDBModel.employeeID:EmployeeID,
  UserListDBModel.salesEmpID:SalesEmpID,
  UserListDBModel.color:color
};
}
