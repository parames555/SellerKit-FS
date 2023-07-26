import 'dart:convert';

class GetCustomerDetailsModal {
List<GetCustomerData>? itemdata;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  GetCustomerDetailsModal(
      {required this.itemdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory GetCustomerDetailsModal.fromJson(Map<String, dynamic> jsons,int stcode) {
    if (jsons["data"] != "No data found") {
      var list = json.decode(jsons["data"]) as List;
      List<GetCustomerData> dataList =
          list.map((data) => GetCustomerData.fromJson(data)).toList();
      return GetCustomerDetailsModal(
        itemdata: dataList,
        message: jsons["msg"],
        status: jsons["status"],
        stcode: stcode,
        exception:null
      );
    } else {
      return GetCustomerDetailsModal(
        itemdata: null,
        message: jsons["msg"],
        status: jsons["status"],
        stcode: stcode,
        exception:null
      );
    }
  }

  factory GetCustomerDetailsModal.error(String jsons,int stcode) {
    return GetCustomerDetailsModal(
        itemdata: null, message: 'Exception', status: null,   stcode: stcode,
        exception:jsons);
  }
}

class GetCustomerData {
  GetCustomerData({
    required this.ZipCode,
    required this.CardCode,
    required this.CardName,
    required this.Street,
    required this.Block,
    required this.City,
    required this.State,
    required this.Country,
    required this.tags,


  });

  String? CardCode;
  String? CardName;
  String? Street;
  String? Block;
  String? ZipCode;
  String? City;
  String? State;
  String? Country;
  String? tags;


  factory GetCustomerData.fromJson(Map<String, dynamic> json) =>
   GetCustomerData(
     CardCode: json['CardCode'] ?? '',
     CardName: json['CardName'] ?? '', 
     Street: json['Street'] ?? '',
     Block: json['Block'] ?? '', 
     ZipCode: json['ZipCode'] ?? '',
     City: json['City'] ??'',
     State: json['State'] ?? '',
     Country:json['Country']?? '',
     tags:json['Tag']?? '',

     
     );
}
