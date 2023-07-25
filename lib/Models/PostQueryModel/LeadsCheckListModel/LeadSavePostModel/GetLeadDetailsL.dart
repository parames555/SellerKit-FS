import 'dart:convert';

class GetLeadDetailsL {
  List<GetLeadDeatilsLData>? leadDeatilsLeadData;
  String message;
  bool? status;
  String? exception;
  int? stcode;
  GetLeadDetailsL(
      {required this.leadDeatilsLeadData,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory GetLeadDetailsL.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (jsons["data"] != "No data found" && jsons["data"] != null) {
      var list = json.decode(jsons["data"]) as List;
      List<GetLeadDeatilsLData> dataList =
          list.map((data) => GetLeadDeatilsLData.fromJson(data)).toList();
      return GetLeadDetailsL(
          leadDeatilsLeadData: dataList,
          message: jsons["msg"],
          status: jsons["status"],
          stcode: stcode,
          exception: null);
    } else {
      return GetLeadDetailsL(
          leadDeatilsLeadData: null,
          message: jsons["msg"],
          status: jsons["status"],
          stcode: stcode,
          exception: null);
    }
  }

  factory GetLeadDetailsL.error(String jsons, int stcode) {
    return GetLeadDetailsL(
        leadDeatilsLeadData: null,
        message: 'Exception',
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class GetLeadDeatilsLData {
  String? FollowMode;
  String? Followup_Date_Time;
  String? Status;
  String? Feedback;
  int? FollowupEntry;
  int? LeadDocEntry;
  String? NextFollowup_Date;
  String? UpdatedBy;

  GetLeadDeatilsLData({
    required this.FollowMode,
    required this.Followup_Date_Time,
    required this.Status,
    required this.Feedback,
    required this.FollowupEntry,
    required this.LeadDocEntry,
    required this.NextFollowup_Date,
    required this.UpdatedBy
  });

  factory GetLeadDeatilsLData.fromJson(Map<String, dynamic> json) => GetLeadDeatilsLData(
        FollowMode: json['FollowMode']== 'Phone'?'Phone Call':
json['FollowMode']== 'Visit'?'Store Visit':json['FollowMode']== 'Text'?'Sms/WhatsApp':
json['FollowMode']== 'Other'?'Other':'',
        Followup_Date_Time: json['Followup_Date_Time'] ?? '',
        Status: json['Status'] ?? '',
        Feedback: json['Feedback'] ?? '',
        FollowupEntry: json['FollowupEntry'] ?? -1,
        LeadDocEntry: json['LeadDocEntry'] ?? -1,
        NextFollowup_Date: json['NextFollowup_Date'] ?? '',
        UpdatedBy: json['UpdatedBy'] ?? '',
      );
}
