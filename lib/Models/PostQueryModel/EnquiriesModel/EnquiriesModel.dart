import 'dart:convert';

class EnquiriesModal {
List<EnquiriesData>? itemdata;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  EnquiriesModal(
      {required this.itemdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory EnquiriesModal.fromJson(Map<String, dynamic> jsons,int stcode) {
    if (jsons["data"] != null) {
      var list = json.decode(jsons["data"]) as List;
      List<EnquiriesData> dataList =
          list.map((data) => EnquiriesData.fromJson(data)).toList();
      return EnquiriesModal(
        itemdata: dataList,
        message: jsons["msg"],
        status: jsons["status"],
        stcode: stcode,
        exception:null
      );
    } else {
      return EnquiriesModal(
        itemdata: null,
        message: jsons["msg"],
        status: jsons["status"],
        stcode: stcode,
        exception:null
      );
    }
  }

  factory EnquiriesModal.error(String jsons,int stcode) {
    return EnquiriesModal(
        itemdata: null, message: 'Exception', status: null,   stcode: stcode,
        exception:jsons);
  }
}

class EnquiriesData {
  EnquiriesData({
    required this.Mgr_UserName,
    required this.EnqID,
    required this.CardCode,
    required this.Status,
    required this.CardName,
    required this.AssignedTo_User,
    required this.EnqDate,
    required this.Followup,
    required this.Mgr_UserCode,
    required this.AssignedTo_UserName,
    required this.EnqType,
     required this.Lookingfor,
    required this.PotentialValue,
    required this.Address_Line_1,
    required this.Address_Line_2,
    required this.Pincode,
    required this.City,
    required this.State,
    required this.Country,
    required this.Manager_Status_Tab,
    required this.Slp_Status_Tab,
   // required this.customertag
  });

  int? EnqID;
  String? CardCode;
  String? CardName;
  String? EnqDate;
  String? Followup;
  String? Status;
  int? Mgr_UserCode;
  String? Mgr_UserName;
  int? AssignedTo_User;
  String? AssignedTo_UserName;
  String? EnqType;
  String? Lookingfor;
  double? PotentialValue;
  String? Address_Line_1;
  String? Address_Line_2;
  String? Pincode;
  String? City;
  String? State;
  String? Country;
  String? Manager_Status_Tab;
  String? Slp_Status_Tab;
 // String? customertag;

  factory EnquiriesData.fromJson(Map<String, dynamic> json) =>
   EnquiriesData(
     EnqID: json['EnqID'] ?? 0,
     CardCode: json['CardCode'] ?? '',
     Status: json['Status'] ?? '', 
     CardName: json['CardName'] ?? '', 
     EnqDate: json['EnqDate'] ?? '',
     Followup: json['Followup'] ?? '', 
     Mgr_UserCode: json['Mgr_UserCode'] ?? '', 
     AssignedTo_UserName: json['AssignedTo_UserName']?? '',
     Mgr_UserName: json['Mgr_UserName'] ?? '',
     AssignedTo_User: json['AssignedTo_User'] ?? '',
     EnqType:json['EnqType']?? '',
     Lookingfor: json['Lookingfor'] ?? '', 
     PotentialValue: json['PotentialValue'] ?? 0.00,
     Address_Line_1: json['Address_Line_1'] ?? '', 
     Address_Line_2: json['Address_Line_2'] ?? '', 
     Pincode: json['Pincode']?? '',
     City: json['City'] ??'',
     State: json['State'] ?? '',
     Country:json['Country']?? '',
      Manager_Status_Tab: json['Manager_Status_Tab'] ?? '', 
     Slp_Status_Tab: json['Slp_Status_Tab'] ?? '',
    // customertag:json['customertag'] ?? '',
     );
   
}
