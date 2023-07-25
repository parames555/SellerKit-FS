import 'dart:convert';
import '../../../DBModel/EnqTypeModel.dart';

class LeadsCheckListModal {
  List<LeadCheckData>? leadcheckdata;
  String message;
  bool? status;
  String? exception;
  int? stcode;
  LeadsCheckListModal(
      {required this.leadcheckdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory LeadsCheckListModal.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (jsons["data"] != null) {
      var list = json.decode(jsons["data"]) as List;
      List<LeadCheckData> dataList =
          list.map((data) => LeadCheckData.fromJson(data)).toList();
      return LeadsCheckListModal(
          leadcheckdata: dataList,
          message: jsons["msg"],
          status: jsons["status"],
          stcode: stcode,
          exception: null);
    } else {
      return LeadsCheckListModal(
          leadcheckdata: null,
          message: jsons["msg"],
          status: jsons["status"],
          stcode: stcode,
          exception: null);
    }
  }

  factory LeadsCheckListModal.error(String jsons, int stcode) {
    return LeadsCheckListModal(
        leadcheckdata: null,
        message: 'Exception',
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class LeadCheckData {
  LeadCheckData(
      {required this.Code, required this.Name, required this.ischecked});

  String? Code;
  String? Name;
  bool? ischecked;

  factory LeadCheckData.fromJson(Map<String, dynamic> json) => LeadCheckData(
      Code: json['Code'] ?? '', Name: json['Name'] ?? '', ischecked: false);

  Map<String, dynamic> tojson() {
    Map<String, dynamic> map = {
      "U_ChkCode": Code,
      "U_ChkName": Name,
      "U_ChkValue": ischecked == false?'No':'Yes'
    };
    return map;
  }
}
