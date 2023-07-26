import 'dart:convert';

class GetAllLeadModal {
  List<GetAllLeadData>? leadcheckdata;
  String message;
  bool? status;
  String? exception;
  int? stcode;
  GetAllLeadModal(
      {required this.leadcheckdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory GetAllLeadModal.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (jsons["data"] != null) {
      var list = json.decode(jsons["data"]) as List;
      List<GetAllLeadData> dataList =
          list.map((data) => GetAllLeadData.fromJson(data)).toList();
      return GetAllLeadModal(
          leadcheckdata: dataList,
          message: jsons["msg"],
          status: jsons["status"],
          stcode: stcode,
          exception: null);
    } else {
      return GetAllLeadModal(
          leadcheckdata: null,
          message: jsons["msg"],
          status: jsons["status"],
          stcode: stcode,
          exception: null);
    }
  }

  factory GetAllLeadModal.error(String jsons, int stcode) {
    return GetAllLeadModal(
        leadcheckdata: null,
        message: 'Exception',
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class GetAllLeadData {
  int? LeadDocEntry;
  int? FollowupEntry;
  int? LeadNum;
  String? Mobile;
  String? CustomerName;
  String? DocDate;
  String? City;
  String? NextFollowup;
  String? Product;
  double? Value;
  String? Status;
  String? LastUpdateMessage;
  String? LastUpdateTime;

  GetAllLeadData({
    required this.LeadDocEntry,
    required this.LeadNum,
    required this.Mobile,
    required this.CustomerName,
    required this.DocDate,
    required this.City,
    required this.NextFollowup,
    required this.Product,
    required this.Value,
    required this.Status,
    required this.LastUpdateMessage,
    required this.LastUpdateTime,
    required this.FollowupEntry
  });

  factory GetAllLeadData.fromJson(Map<String, dynamic> json) => GetAllLeadData(
        LeadDocEntry: json['LeadDocEntry'] ?? -1,
        LeadNum: json['LeadNum'] ?? -1,
        Mobile: json['Mobile'] ?? '',
        CustomerName: json['CustomerName'] ?? '',
        DocDate: json['DocDate'] ?? '',
        City: json['City'] ?? '',
        NextFollowup: json['NextFollowup'] ?? '',
        Product: json['Product'] ?? '',
        Value: json['Value'] ?? -1,
        Status: json['Status'] ?? '',
        LastUpdateMessage: json['LastUpdateMessage'] ?? '',
        LastUpdateTime: json['LastUpdateTime'] ?? '',
        FollowupEntry: json['FollowupEntry']
      );

  // Map<String, dynamic> tojson() {
  //   Map<String, dynamic> map = {
  //     "LeadDocEntry": LeadDocEntry,
  //     "LeadNum": LeadNum,
  //     "U_ChkValue": ischecked == false?'No':'Yes'
  //   };
  //   return map;
  // }
}
