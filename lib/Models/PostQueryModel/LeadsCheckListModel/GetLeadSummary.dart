import 'dart:convert';

class GetSummaryLeadModal {
  List<SummaryLeadData>? leadSumarydata;
  String message;
  bool? status;
  String? exception;
  int? stcode;
  GetSummaryLeadModal(
      {required this.leadSumarydata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory GetSummaryLeadModal.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (jsons["data"] != "No data found"  && jsons["data"] != null) {
      var list = json.decode(jsons["data"]) as List;
      List<SummaryLeadData> dataList =
          list.map((data) => SummaryLeadData.fromJson(data)).toList();
      return GetSummaryLeadModal(
          leadSumarydata: dataList,
          message: jsons["msg"],
          status: jsons["status"],
          stcode: stcode,
          exception: null);
    } else {
      return GetSummaryLeadModal(
          leadSumarydata: null,
          message: jsons["msg"],
          status: jsons["status"],
          stcode: stcode,
          exception: null);
    }
  }

  factory GetSummaryLeadModal.error(String jsons, int stcode) {
    return GetSummaryLeadModal(
        leadSumarydata: null,
        message: 'Exception',
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class SummaryLeadData {

  String? Caption;
  double? Target;
  double? Value;
  double? column;
  String? Status;

  SummaryLeadData({
 
    required this.Caption,
    required this.Target,
    required this.Value,
    required this.Status,
    required this.column
  });

  factory SummaryLeadData.fromJson(Map<String, dynamic> json) => SummaryLeadData(
        Caption: json['Caption'] ?? '',
        Target: json['Target'] ?? 0.00,
        Value: json['Value'] ?? 0.00,
        Status: json['Status'] ?? '',
        column:json['Column5']??0.00
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
