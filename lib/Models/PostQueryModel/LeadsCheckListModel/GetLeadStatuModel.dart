import 'dart:convert';

import 'package:sellerkit/DBModel/EnqTypeModel.dart';

class GetLeadStatusModal {
  List<GetLeadStatusData>? leadcheckdata;
  String message;
  bool? status;
  String? exception;
  int? stcode;
  GetLeadStatusModal(
      {required this.leadcheckdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory GetLeadStatusModal.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (jsons["data"] != null) {
      var list = json.decode(jsons["data"]) as List;
      List<GetLeadStatusData> dataList =
          list.map((data) => GetLeadStatusData.fromJson(data)).toList();
      return GetLeadStatusModal(
          leadcheckdata: dataList,
          message: jsons["msg"],
          status: jsons["status"],
          stcode: stcode,
          exception: null);
    } else {
      return GetLeadStatusModal(
          leadcheckdata: null,
          message: jsons["msg"],
          status: jsons["status"],
          stcode: stcode,
          exception: null);
    }
  }

  factory GetLeadStatusModal.error(String jsons, int stcode) {
    return GetLeadStatusModal(
        leadcheckdata: null,
        message: 'Exception',
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class GetLeadStatusData {
  String? code;
  String? name;
  String? statusType;

  GetLeadStatusData({
    required this.code,
    required this.name,
    required this.statusType,
  });

  factory GetLeadStatusData.fromJson(Map<String, dynamic> json) =>
      GetLeadStatusData(
        code: json['Code'] ?? '',
        name: json['Name'] ?? '',
        statusType: json['StatusType'] ?? '',
      );

  Map<String, Object?> toMap() => {
        LeadStatusReason.code: code,
        LeadStatusReason.name: name,
        LeadStatusReason.statusType: statusType,
      };
}
