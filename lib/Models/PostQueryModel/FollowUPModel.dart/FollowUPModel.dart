// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class FollowUPListModel {
List<FollowUPListData>? followUPListData;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  FollowUPListModel(
      {required this.followUPListData,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory FollowUPListModel.fromJson(Map<String, dynamic> jsons,int stcode) {
    if (jsons["data"] != "No data foun") {
      var list = json.decode(jsons["data"]) as List;
      List<FollowUPListData> dataList =
          list.map((data) => FollowUPListData.fromJson(data)).toList();
      return FollowUPListModel(
        followUPListData: dataList,
        message: jsons["msg"],
        status: jsons["status"],
        stcode: stcode,
        exception:null
      );
    } else {
      return FollowUPListModel(
        followUPListData: null,
        message: jsons["msg"],
        status: jsons["status"],
        stcode: stcode,
        exception:null
      );
    }
  }

  factory FollowUPListModel.error(String jsons,int stcode) {
    return FollowUPListModel(
        followUPListData: null, 
        message: 'Exception', 
        status: null,   
        stcode: stcode,
        exception:jsons);
  }
}

class FollowUPListData {
  FollowUPListData({
    required this.FollowupDate,
    required this.LeadDocEntry,
    required this.LeadDocNum,
    required this.FollowupEntry,
    required this.Phone,
    required this.Customer,
    required this.CretedDate,
    required this.LastFollowupDate,
    required this.DocTotal,
    required this.Quantity,
    required this.Product,
    required this.LastFollowupStatus,
    required this.LastFollowup_Feedback,
    required this.CustomerInitialIcon,
   required this.Followup_Due_Type
  });

  String? FollowupDate;
  int? LeadDocEntry;
  int? LeadDocNum;
  int? FollowupEntry;
  String? Phone;
  String? Customer;
  String? CretedDate;
  String? LastFollowupDate;
  double? DocTotal;
  String? Quantity;
  String? Product;
  String? LastFollowupStatus;
  String? LastFollowup_Feedback;
  String? CustomerInitialIcon;
  String? Followup_Due_Type;



  factory FollowUPListData.fromJson(Map<String, dynamic> json) =>
   FollowUPListData(
     FollowupDate: json['FollowupDate'] ?? '',
     LeadDocEntry: json['LeadDocEntry'] ?? 0,
     LeadDocNum: json['LeadDocNum'] ?? 0,
     FollowupEntry: json['FollowupEntry'] ?? 0,
     Phone: json['Phone'] ?? '',
     Customer: json['Customer'] ?? '',
     CretedDate: json['CreateDate'] ?? '',
     LastFollowupDate: json['LastFollowupDate'] ?? '',
     DocTotal: json['DocTotal'] ?? 0,
     Quantity: json['Quantity'] ?? '',
     Product: json['Product']!=null?
     ( json['Product'].toString().length>26?
     json['Product'].toString().substring(0,26)
     :json['Product'].toString()): '',
     LastFollowupStatus: json['LastFollowupStatus'] ?? '',
     LastFollowup_Feedback: json['LastFollowup_Feedback'] ?? '',
     CustomerInitialIcon: json['CustomerInitialIcon'] ?? '',
     Followup_Due_Type: json['Followup_Due_Type'] ?? '',

     );


    Map<String, dynamic> tojson() {
    Map<String, dynamic> map = {
      "FollwUPDate": FollowupDate,
      "LeadDocEntry": LeadDocEntry,
      "LeadDocNum":LeadDocNum,
      "FollowupEntry": FollowupEntry,
      "Phone": Phone,
      "Customer":Customer,
      "CretedDate": CretedDate,
      "LastFollowupDate": LastFollowupDate,
      "DocTotal":DocTotal,
      "Quantity": Quantity,
      "Product": Product,
      "LastFollowupStatus":LastFollowupStatus,
      "LastFollowup_Feedback":LastFollowup_Feedback,
      "CustomerInitialIcon": CustomerInitialIcon,
    };
    return map;
  }
}
