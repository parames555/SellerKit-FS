import 'dart:convert';

class AddressrModel {
  // List<AddressMasterData>? addressdata;
  String? address2;
  bool? status;
  String? exception;
  int? stcode;
  AddressrModel(
      {
        // required this.addressdata,
      required this.address2,
      required this.status,
      this.exception,
      required this.stcode});
  factory AddressrModel.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (jsons["display_name"] != null) {
      // var list = jsonDecode(jsons["data"]) as List;
      // List<AddressMasterData> dataList =
      //     list.map((data) => AddressMasterData.fromJson(data)).toList();
      return AddressrModel(
          // addressdata: dataList,
          address2: jsons["display_name"].toString(),
          status: true,
          stcode: stcode,
          exception: null);
    } else {
      return AddressrModel(
          // addressdata: null,
          address2: jsons["display_name"].toString(),
          status: false,
          stcode: stcode,
          exception: null);
    }
  }

  factory AddressrModel.error(String jsons, int stcode) {
    return AddressrModel(
        // addressdata: null,
        address2: null,
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class AddressMasterData {
  int? autoId;
  String custCode;
  String? address1;
  String? address2;
  String? address3;
  String billCity;
  String billstate;
  String billPincode;
  String billCountry;
  String? location1;
  String? location2;
  String? createdateTime;
  String? updatedDatetime;
  String? createdUserID;
  String? updateduserid;
  String? lastupdateIp;
  String? premiumid;
  // String shipAddress;
  // String shipCity;
  // String shipstate;
  // String shipPincode;
  // String shipCountry;
  AddressMasterData({
    this.autoId,
    required this.custCode,
    required this.address1,
    required this.address2,
    this.address3,
    required this.billCity,
    required this.billCountry,
    required this.billPincode,
    required this.billstate,
    required this.location1,
    required this.location2,
    this.createdateTime,
    this.updatedDatetime,
    this.createdUserID,
    this.lastupdateIp,
    this.updateduserid,
    // required this.shipCity,
    //required this.shipAddress,

    // required this.shipCountry,
    // required this.shipPincode,
    // required this.shipstate
  });
  // {\"custcode\":\"B1111\",\"address1\":null,\"address2\":\"P.O. BOX\",\"address3\":null,\"city\":\"MOSHI\",
// \"statecode\":null,\"pincode\":null,\"countrycode\":\"TZ\",\"geolocation1\":\"\",\"geolocation2\":\"\",
// \"createdateTime\":\"2023-04-05T10:42:42.253\",\"updatedDatetime\":\"2023-04-05T10:42:42.253\",
// \"createdUserID\":\"1\",\"updateduserid\":\"1\",\"lastupdateIp\":\"\"}
  factory AddressMasterData.fromJson(Map<String, dynamic> json) =>
      AddressMasterData(
          address1: json['address1'] ?? '',
          address2: json['address2'] ?? '',
          // address3: json['createdateTime'] ?? '',
          billCity: json['city'] ?? '',
          billCountry: json['countrycode'] ?? '',
          billPincode: json['pincode'] ?? '',
          billstate: json['statecode'] ?? '',
          location1: json['geolocation1'] ?? '',
          custCode: json['custcode'] ?? '',
          createdUserID: json['createdUserID'] ?? '',
          createdateTime: json['createdateTime'] ?? '',
          lastupdateIp: json['lastupdateIp'] ?? '',
          updatedDatetime: json['updatedDatetime'] ?? '',
          updateduserid: json['updateduserid'] ?? '',
          location2: json['geolocation2'] ?? '');
}

// json['createdateTime'] ?? '',