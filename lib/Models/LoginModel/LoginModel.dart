import 'dart:convert';

class LoginModel {
  String? loginstatus;
  String? loginMsg;
  LoginModelData? data;
  int? resCode;
  String? excep;

  LoginModel(
      {required this.loginstatus,
      required this.loginMsg,
      this.data,
      this.excep,
      required this.resCode});

  factory LoginModel.fromJson(Map<String, dynamic> jsons, int rescode) {
    if (jsons["token"] != null) {
      return LoginModel(
        loginstatus: jsons["loginstatus"] as String,
        loginMsg: jsons["loginMsg"] as String,
        data: LoginModelData.fromJson(jsons["token"]),
        resCode: rescode,
        excep: null,
      );
    } else {
      return LoginModel(
          loginstatus: jsons["loginstatus"] as String,
          loginMsg: jsons["loginMsg"] as String,
          data: null,
          excep: null,
          resCode: rescode);
    }
  }

  factory LoginModel.issue(int rescode, String exp) {
    return LoginModel(
        excep: exp,
        resCode: rescode,
        loginstatus: null,
        loginMsg: null,
        data: null);
  }
}

class LoginModelData {
  String licenseKey;
  String endPointUrl;
  String sessionID;
  String UserID;
  String userDB;
  String dbUserName;
  String dbPassword;
  String userType;
  String slpcode;
  
  LoginModelData(
      {required this.licenseKey,
      required this.endPointUrl,
      required this.sessionID,
      required this.UserID,
      required this.userDB,
      required this.dbUserName,
      required this.dbPassword,
      required this.userType,
      required this.slpcode
      });

  factory LoginModelData.fromJson(Map<String, dynamic> json) {
    return LoginModelData(
        licenseKey: json["licenseKey"],
        endPointUrl: json["endPointUrl"],
        sessionID: json["sessionID"],
        UserID: json['userID'],
        userDB: json['userDB'],
        dbUserName: json['dbUserName'],
        dbPassword: json['dbPassword'],
        userType: json['userType'],
        slpcode: json['slpcode']
        );
  }
}

class PostLoginData {
  String? deviceCode;
  String? licenseKey;
  String? username;
  String? password ;
  String? fcmToken;
}
