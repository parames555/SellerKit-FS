import 'dart:convert';

class KpiModel {
  bool? status;
  String? msg;
  List<KpiModelData>? data;
  int? resCode;
  String? exception;
  KpiModel(
      {
      required this.status,
      required this.msg,
      this.data,
      required this.resCode,
      this.exception
      });

  factory KpiModel.fromJson(Map<String, dynamic> jsons, int rescode) {
    if (jsons["data"] != null) {
       var list = jsonDecode(jsons["data"]) as List;

      List<KpiModelData> dataList =
          list.map((data) => KpiModelData.fromJson(data)).toList();
      return KpiModel(
          status: jsons["status"] ,
          msg: jsons["msg"] as String,
          data: dataList,
          resCode: rescode,
          exception: null
          );
    } else {
      return KpiModel(
          status: jsons["status"] ,
          msg: jsons["msg"] as String,
          data: null,
          resCode: rescode,
          exception: null
          );
    }
  }

  factory KpiModel.issue(int rescode,String excep) {
    return KpiModel(
        status: null, msg: null, data: null, resCode: rescode,
        exception: excep
        );
  }
}

class KpiModelData {
  int Enquiries;
  int OpenLeads;
  double LeadConversion;
  int TodayFUP;
  int OverdueFUP;
  double SalesConversion;
  double NPS;
  double Sales;
  double Target;
  double Ach;
  double DayTarget;
  double TillNow;
  double RunRate;

  KpiModelData({
    required this.Enquiries,
    required this.OpenLeads,
    required this.LeadConversion,
    required this.TodayFUP,
    required this.OverdueFUP,
    required this.SalesConversion,
    required this.NPS,
    required this.Sales,
    required this.Target,
    required this.Ach,
    required this.DayTarget,
    required this.RunRate,
    required this.TillNow
  });

  factory KpiModelData.fromJson(Map<String, dynamic> json) {
    return KpiModelData(
      Enquiries: json["Enquiries"],
      OpenLeads: json["OpenLeads"],
      LeadConversion: json["LeadConversion"],
      TodayFUP:json['TodayFUP'], 
      OverdueFUP:json['OverdueFUP'], 
      SalesConversion:json['SalesConversion'], 
      Ach: json['Ach'], 
      DayTarget:json['DayTarget'],  
      NPS:json['NPS'], 
      RunRate:json['RunRate'], 
      Sales:json['Sales'], 
      Target: json['Target'], 
      TillNow: json['TillNow'] );
  }
}


