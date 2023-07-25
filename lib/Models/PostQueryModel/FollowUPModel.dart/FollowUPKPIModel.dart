// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class FollowUPKPIModel {
List<FollowUPKPIData>? followUPKPIData;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  FollowUPKPIModel(
      {required this.followUPKPIData,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory FollowUPKPIModel.fromJson(Map<String, dynamic> jsons,int stcode) {
    if (jsons["data"] != null) {
      var list = json.decode(jsons["data"]) as List;
      List<FollowUPKPIData> dataList =
          list.map((data) => FollowUPKPIData.fromJson(data)).toList();
      return FollowUPKPIModel(
        followUPKPIData: dataList,
        message: jsons["msg"],
        status: jsons["status"],
        stcode: stcode,
        exception:null
      );
    } else {
      return FollowUPKPIModel(
        followUPKPIData: null,
        message: jsons["msg"],
        status: jsons["status"],
        stcode: stcode,
        exception:null
      );
    }
  }

  factory FollowUPKPIModel.error(String jsons,int stcode) {
    return FollowUPKPIModel(
        followUPKPIData: null, 
        message: 'Exception', 
        status: null,   
        stcode: stcode,
        exception:jsons);
  }
}

class FollowUPKPIData {
  FollowUPKPIData({
    required this.OverdueKPI_Head_1,
    required this.OverdueKPI_Line_1,
    required this.OverdueKPI_Line_2,
    required this.OverdueKPI_SmallLine_1,
    required this.UpcomingKPI_Head_1,
    required this.UpcomingKPI_Line_1,
    required this.UpcomingKPI_SmallLine_1,


  });

  String? OverdueKPI_Head_1;
  String? OverdueKPI_Line_1;
  String? OverdueKPI_Line_2;
  String? OverdueKPI_SmallLine_1;
  String? UpcomingKPI_Head_1;
  String? UpcomingKPI_Line_1;
  String? UpcomingKPI_SmallLine_1;


  factory FollowUPKPIData.fromJson(Map<String, dynamic> json) =>
   FollowUPKPIData(
     OverdueKPI_Head_1: json['OverdueKPI_Head_1'] ?? '',
     OverdueKPI_Line_1: json['OverdueKPI_Line_1']??'',
     OverdueKPI_Line_2: json['OverdueKPI_Line_2']??'',
     OverdueKPI_SmallLine_1: json['OverdueKPI_SmallLine_1']??'',
     UpcomingKPI_Head_1: json['UpcomingKPI_Head_1']??'',
     UpcomingKPI_Line_1: json['UpcomingKPI_Line_1']??'',
     UpcomingKPI_SmallLine_1: json['UpcomingKPI_SmallLine_1']??'',

     );
}
