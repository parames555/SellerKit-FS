import 'dart:convert';

import 'package:sellerkit/DBModel/EnqTypeModel.dart';

class OfferZoneModel {
  List<OfferZoneData>? offerZoneData1;
  String? message;
  bool? status;
  String? exception;
  int? stcode;
  OfferZoneModel(
      {required this.offerZoneData1,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory OfferZoneModel.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (jsons["data"] != "No data found") {
      var list = json.decode(jsons["data"]) as List;
      List<OfferZoneData> dataList =
          list.map((data) => OfferZoneData.fromJson(data)).toList();
      return OfferZoneModel(
          offerZoneData1: dataList,
          message: jsons["msg"],
          status: jsons["status"],
          stcode: stcode,
          exception: null);
    } else {
      return OfferZoneModel(
          offerZoneData1: null,
          message: jsons["msg"],
          status: jsons["status"],
          stcode: stcode,
          exception: null);
    }
  }

  factory OfferZoneModel.error(String jsons, int stcode) {
    return OfferZoneModel(
        offerZoneData1: null,
        message: null,
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class OfferZoneData {
  int? IMId;
  int? offerId;
  String? itemCode;
  String? offerName;
  String? offerDetails;
  String? item;
  String? discoutDetails;
  String? incentive;
  String? validTill;
  OfferZoneData({
    this.IMId,
    required this.offerId,
    required this.itemCode,
    required this.offerName,
    required this.offerDetails,
    required this.item,
    required this.discoutDetails,
    required this.incentive,
    required this.validTill,
  });

  factory OfferZoneData.fromJson(Map<String, dynamic> json) => OfferZoneData(
        offerId: json['OfferID'] ?? -1,
        itemCode: json['ItemCode'] ?? "",
        offerName: json['OfferName'] ?? "",
        offerDetails: json['OfferDetails'] ?? "",
        item: json['Item'] ?? "",
        discoutDetails: json['DiscountDetails'] ?? "",
        incentive: json['Incentive'] ?? "",
        validTill: json['ValidTill'] ?? "",
      );

  Map<String, Object?> toMap() => {
        OfferZoneColumns.offerZoneId: offerId,
        OfferZoneColumns.itemCode: itemCode,
        OfferZoneColumns.offerName: offerName,
        OfferZoneColumns.offerDetails: offerDetails,
        OfferZoneColumns.item: item,
        OfferZoneColumns.discoutDetails: discoutDetails,
        OfferZoneColumns.incentive: incentive,
        OfferZoneColumns.validTill: validTill,
      };
}
