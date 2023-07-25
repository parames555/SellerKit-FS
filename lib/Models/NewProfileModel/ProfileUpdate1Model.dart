import 'dart:convert';

class ProfileUpdateModel1 {
  List<ProfileUpdateModel1Data>? profiledata;
  String? message;
  bool? status;
  String? exception;
  int? stcode;
  ProfileUpdateModel1(
      {required this.profiledata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory ProfileUpdateModel1.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (jsons["data"] != null) {
      var list = json.decode(jsons["data"]) as List;
      List<ProfileUpdateModel1Data> dataList =
          list.map((data) => ProfileUpdateModel1Data.fromJson(data)).toList();
      return ProfileUpdateModel1(
          profiledata: dataList,
          message: jsons["msg"],
          status: jsons["status"],
          stcode: stcode,
          exception: null);
    } else {
      return ProfileUpdateModel1(
          profiledata: null,
          message: jsons["msg"],
          status: jsons["status"],
          stcode: stcode,
          exception: null);
    }
  }

  factory ProfileUpdateModel1.error(String jsons, int stcode) {
    return ProfileUpdateModel1(
        profiledata: null,
        message: null,
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class ProfileUpdateModel1Data {
  String? attachpath;

  ProfileUpdateModel1Data({
    required this.attachpath,
  });

  factory ProfileUpdateModel1Data.fromJson(Map<String, dynamic> json) =>
      ProfileUpdateModel1Data(
        attachpath: json['AttachPath'],
      );
}
