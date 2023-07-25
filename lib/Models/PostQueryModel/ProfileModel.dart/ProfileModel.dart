// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
class ProfileModel {
List<ProfileData>? profileData;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  ProfileModel(
      {required this.profileData,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory ProfileModel.fromJson(Map<String, dynamic> jsons,int stcode) {
    if (jsons["data"] != "No data found") {
      var list = json.decode(jsons["data"]) as List;
      List<ProfileData> dataList =
          list.map((data) => ProfileData.fromJson(data)).toList();
      return ProfileModel(
        profileData: dataList,
        message: jsons["msg"],
        status: jsons["status"],
        stcode: stcode,
        exception:null
      );
    } else {
      return ProfileModel(
        profileData: null,
        message: jsons["msg"],
        status: jsons["status"],
        stcode: stcode,
        exception:null
      );
    }
  }

  factory ProfileModel.error(String jsons,int stcode) {
    return ProfileModel(
        profileData: null, 
        message: 'Exception', 
        status: null,   
        stcode: stcode,
        exception:jsons);
  }
}

class ProfileData {
  ProfileData({
    required this.USER_CODE,
    required this.USERID,
    required this.firstName,
    required this.lastName,
    required this.Branch,
    required this.email,
    required this.mobile,
    required this.ProfilePic,
    required this.managerAppUser,
    required this.managerCompanyUserID,
    required this.managerMailID,
    required this.managerPhone,


  });
//"ManagerCompanyUserID\":\"sk_chn1_4\",\"ManagerAppUser\":\"ramesh\",\"ManagerMailID\":\"ramesh@buson.in\",\"ManagerPhone\":\"7305408333\"}]"
  String? USER_CODE;
  int? USERID;
  String? firstName;
  String? lastName;
  String? Branch;
  String? email;
  String? mobile;
  String? ProfilePic;
String? managerCompanyUserID;
String? managerAppUser;
String? managerMailID;
String? managerPhone;

  factory ProfileData.fromJson(Map<String, dynamic> json) =>
   ProfileData(
     USERID: json['USERID'] ?? 0,
     USER_CODE: json['USER_CODE'] ?? '',
     firstName: json['FirstName'] ?? '',
     lastName: json['lastName'] ?? '',
     Branch: json['Branch'] ?? '',
     email: json['email'] ?? '',
     mobile: json['mobile'] ?? '',
     ProfilePic: json['ProfilePic'] ?? '',
     managerAppUser: json['ManagerAppUser']??'',
     managerCompanyUserID: json['ManagerCompanyUserID'] ?? '',
     managerMailID: json['ManagerMailID']?? '',
     managerPhone: json['ManagerPhone']??'',
   );
}
