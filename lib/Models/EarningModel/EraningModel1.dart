import 'dart:convert';


class EarningModel1 {
  List<EarningData1>? earning1data;
  String? message;
  bool? status;
  String? exception;
  int? stcode;
  EarningModel1(
      {required this.earning1data,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory EarningModel1.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (jsons["data"] != null) {
      var list = json.decode(jsons["data"]) as List;
      List<EarningData1> dataList =
          list.map((data) => EarningData1.fromJson(data)).toList();
      return EarningModel1(
          earning1data: dataList,
          message: jsons["msg"],
          status: jsons["status"],
          stcode: stcode,
          exception: null);
    } else {
      return EarningModel1(
          earning1data: null,
          message: jsons["msg"],
          status: jsons["status"],
          stcode: stcode,
          exception: null);
    }
  }

  factory EarningModel1.error(String jsons, int stcode) {
    return EarningModel1(
        earning1data: null,
        message: null,
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class EarningData1 {
  
  String? monthEarning;
  String? todayEarning;
  EarningData1({
   
    required this.monthEarning,
    required this.todayEarning,
  });

  factory EarningData1.fromJson(Map<String, dynamic> json) => EarningData1(
       
        monthEarning: json['MTD_Earning'] ?? "",
        todayEarning: json['Today_Earning'] ?? "",
      );

}
