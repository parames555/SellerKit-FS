import 'dart:convert';


class ConfirmPwdModel{
String? status;
  String? updateMsg;
 String? exception;
  int? statuscode;
ConfirmPwdModel({
  required this.status,
  required this.updateMsg,
    required this.statuscode,
      required this.exception
});

 factory ConfirmPwdModel.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (jsons["status"] == "Success") {
      return ConfirmPwdModel(
          status: jsons["status"],
          updateMsg: jsons["responceMsg"],
          statuscode: stcode,
          exception: null);
    } else {
      return ConfirmPwdModel(
          status: null,
          updateMsg: null,
          statuscode: stcode,
          exception: "No route to host");
    }
  }
  factory ConfirmPwdModel.error(String jsons, int stcode) {
    return ConfirmPwdModel(
        status: null,
        statuscode: stcode,
        updateMsg: null,
        exception: jsons,
        );
  }
}

