import 'dart:convert';

class EarningModel2 {
  List<EarningData2>? earningtabledata;
  String? message;
  bool? status;
  String? exception;
  int? stcode;
  EarningModel2(
      {required this.earningtabledata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory EarningModel2.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (jsons["data"] != null) {
      var list = json.decode(jsons["data"]) as List;
      List<EarningData2> dataList =
          list.map((data) => EarningData2.fromJson(data)).toList();
      return EarningModel2(
          earningtabledata: dataList,
          message: jsons["msg"],
          status: jsons["status"],
          stcode: stcode,
          exception: null);
    } else {
      return EarningModel2(
          earningtabledata: null,
          message: jsons["msg"],
          status: jsons["status"],
          stcode: stcode,
          exception: null);
    }
  }

  factory EarningModel2.error(String jsons, int stcode) {
    return EarningModel2(
        earningtabledata: null,
        message: null,
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class EarningData2 {
  
  String? date;
  String? transDetails;
  double? amount;  
  EarningData2({
   
    required this.date,
    required this.transDetails,
    required this.amount
  });

  factory EarningData2.fromJson(Map<String, dynamic> json) => EarningData2(
       
        date: json['Date'],
        transDetails: json['TransDetails'] ?? "",
        amount: json['Amount'] 
      );

}
