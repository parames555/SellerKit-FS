// ignore_for_file: unnecessary_new

import 'dart:convert';

// import 'package:fijkplayer/fijkplayer.dart';

class FeedsModal {
  List<FeedsModalData>? leadcheckdata;
  String message;
  bool? status;
  String? exception;
  int? stcode;
  FeedsModal(
      {required this.leadcheckdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory FeedsModal.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (jsons["data"] != null && jsons["data"] != 'No data found') {
      var list = json.decode(jsons["data"]) as List;
      List<FeedsModalData> dataList =
          list.map((data) => FeedsModalData.fromJson(data)).toList();
      return FeedsModal(
          leadcheckdata: dataList,
          message: jsons["msg"],
          status: jsons["status"],
          stcode: stcode,
          exception: null);
    } else {
      return FeedsModal(
          leadcheckdata: null,
          message: jsons["msg"],
          status: jsons["status"],
          stcode: stcode,
          exception: null);
    }
  }

  factory FeedsModal.error(String jsons, int stcode) {
    return FeedsModal(
        leadcheckdata: null,
        message: 'Exception',
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class FeedsModalData {
  int? FeedsID;
  String? CreatedDate;
  String? Title;
  String? Description;
  String? MediaType;
  String? MediaURL1;
  String? MediaURL2;
  String? MediaURL3;
  String? ValidTill;
  String? UserCode;
  String? Reaction;
  String? ProfilePic;
  String? CreatedBy;
  // FijkPlayer? player;

  FeedsModalData(
      {required this.FeedsID,
      required this.CreatedDate,
      required this.Title,
      required this.Description,
      required this.MediaType,
      required this.MediaURL1,
      required this.MediaURL2,
      required this.MediaURL3,
      required this.ValidTill,
      required this.UserCode,
      required this.Reaction,
      required this.ProfilePic,
      required this.CreatedBy,
      });

  factory FeedsModalData.fromJson(Map<String, dynamic> json) => FeedsModalData(
        FeedsID: json['FeedsID'] ?? -1,
        CreatedDate: json['CreatedDate'] ?? '',
        Title: json['Title'] ?? '',
        Description: json['Description'] ?? '',
        MediaType: json['MediaType'] ?? '',
        MediaURL1: json['MediaURL1'] ?? '',
        MediaURL2: json['MediaURL2'] ?? '',
        MediaURL3: json['MediaURL3'] ?? '',
        ValidTill: json['ValidTill'] ?? '',
        UserCode: json['UserCode'] ?? '',
        Reaction: json['Reaction'] ?? '',
        ProfilePic: json['ProfilePic'] ?? '',
        CreatedBy: json['CreatedBy'] ?? '',
      );

  Map<String, Object?> toMap() => {
        "FeedsID": FeedsID,
        "CreatedDate": CreatedDate,
        "Title": Title,
        "Description": Description,
        "MediaType": MediaType,
        "MediaURL1": MediaURL1,
        "MediaURL2": MediaURL2,
        "MediaURL3": MediaURL3,
        "ValidTill": ValidTill,
        "UserCode": UserCode,
      };
}
