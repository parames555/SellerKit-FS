
import 'dart:convert';

class AccountsDetails{
  List<AccountsNewData>? itemdata;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  AccountsDetails(
      {required this.itemdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory AccountsDetails.fromJson(Map<String, dynamic> jsons,int stcode) {
    if (jsons["data"] != "No data found") {
      var list = jsonDecode(jsons["data"]) as List;
      List<AccountsNewData> dataList =
          list.map((data) => AccountsNewData.fromJson(data)).toList();
      return AccountsDetails(
        itemdata: dataList,
        message: jsons["msg"],
        status: jsons["status"],
        stcode: stcode,
        exception:null
      );
    } else {
      return AccountsDetails(
        itemdata: null,
        message: jsons["msg"],
        status: jsons["status"],
        stcode: stcode,
        exception:null
      );
    }
  }

  factory AccountsDetails.error(String jsons,int stcode) {
    return AccountsDetails(
        itemdata: null, message: 'Exception', status: null,   stcode: stcode,
        exception:jsons);
  }

}
class AccountsNewData {
  AccountsNewData({
    required this.cardcode,
    required this.cardname,
    required this.street,
    required this.block,
    required this.zipcode,
    required this.city,
    required this.state,
    required this.country,
    required this.tag,
  });

  String? cardcode;
  String? cardname;
  String? street;
  String? block;
  String? zipcode;
  String? city;
  String? state;
  String? country;
  String? tag;


  factory AccountsNewData.fromJson(Map<String, dynamic> json) =>
   AccountsNewData(
     cardcode: json['CardCode'] ?? '',
     cardname: json['CardName'] ?? '',
     street: json['Street'] ?? '', 
     block: json['Block'] ?? '', 
     zipcode: json['ZipCode'] ?? '',
     city: json['City'] ?? '', 
     state: json['State'] ?? '', 
     country: json['Country']?? "",
     tag: json['Tag'] ??"");
    
}
