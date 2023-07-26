import 'dart:convert';

class GetLeadDetailsQTH {
  List<GetLeadDeatilsQTHData>? leadDeatilsQTHData;
  String message;
  bool? status;
  String? exception;
  int? stcode;
  GetLeadDetailsQTH(
      {required this.leadDeatilsQTHData,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory GetLeadDetailsQTH.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (jsons["data"] != "No data found" && jsons["data"] != null) {
      var list = json.decode(jsons["data"]) as List;
      List<GetLeadDeatilsQTHData> dataList =
          list.map((data) => GetLeadDeatilsQTHData.fromJson(data)).toList();
      return GetLeadDetailsQTH(
          leadDeatilsQTHData: dataList,
          message: jsons["msg"],
          status: jsons["status"],
          stcode: stcode,
          exception: null);
    } else {
      return GetLeadDetailsQTH(
          leadDeatilsQTHData: null,
          message: jsons["msg"],
          status: jsons["status"],
          stcode: stcode,
          exception: null);
    }
  }

  factory GetLeadDetailsQTH.error(String jsons, int stcode) {
    return GetLeadDetailsQTH(
        leadDeatilsQTHData: null,
        message: 'Exception',
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class GetLeadDeatilsQTHData {
  int? LeadDocEntry;
  // int? FollowupEntry;
  int? LeadNum;
  String? LeadCreatedDate;
  String? LastFUPUpdate;
  String? CardCode;
  String? CardName;
  String? Address1;
  String? Address2;
  String? City;
  String? Pincode;
  double?DocTotal;
  // String? LastUpdateMessage;
  // String? LastUpdateTime;

  GetLeadDeatilsQTHData({
    required this.LeadDocEntry,
    required this.LeadNum,
    required this.LeadCreatedDate,
    required this.LastFUPUpdate,
    required this.CardCode,
    required this.CardName,
    required this.Address1,
    required this.Address2,
    required this.City,
    required this.Pincode,
    required this.DocTotal
    // required this.LastUpdateMessage,
    // required this.LastUpdateTime,
    //required this.FollowupEntry
  });

  factory GetLeadDeatilsQTHData.fromJson(Map<String, dynamic> json) => GetLeadDeatilsQTHData(
        LeadDocEntry: json['LeadDocEntry'] ?? -1,
        LeadNum: json['LeadNumber'] ?? -1,
        LeadCreatedDate: json['LeadCreatedDate'] ?? '',
        LastFUPUpdate: json['LastFUPUpdate'] ?? '',
        CardCode: json['CardCode'] ?? '',
        CardName: json['CardName'] ?? '',
        Address1: json['Address1'] ?? '',
        Address2: json['Address2'] ?? '',
        City: json['City'] ?? '',
        Pincode: json['Pincode'] ?? '',
        DocTotal: json['DocTotal']??0.00,
        // LastUpdateMessage: json['LastUpdateMessage'] ?? '',
        // LastUpdateTime: json['LastUpdateTime'] ?? '',
        //FollowupEntry: json['FollowupEntry']
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
