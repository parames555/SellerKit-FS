import 'dart:convert';

class CheckEnqDetailsModel {
List<CheckEnqDetailsData>? checkEnqDetailsData;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  CheckEnqDetailsModel(
      {required this.checkEnqDetailsData,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory CheckEnqDetailsModel.fromJson(Map<String, dynamic> jsons,int stcode) {
    if (jsons["data"] != "No data found" && jsons["data"] != null) {
      var list = json.decode(jsons["data"]) as List;
      List<CheckEnqDetailsData> dataList =
          list.map((data) => CheckEnqDetailsData.fromJson(data)).toList();
      return CheckEnqDetailsModel(
        checkEnqDetailsData: dataList,
        message: jsons["msg"],
        status: jsons["status"],
        stcode: stcode,
        exception:null
      );
    }

     else {
      return CheckEnqDetailsModel(
        checkEnqDetailsData: null,
        message: jsons["msg"],
        status: jsons["status"],
        stcode: stcode,
        exception:null
      );
    }
  }

  factory CheckEnqDetailsModel.error(String jsons,int stcode) {
    return CheckEnqDetailsModel(
        checkEnqDetailsData: null, message: 'Exception', status: null,   stcode: stcode,
        exception:jsons);
  }
}

class CheckEnqDetailsData {
  CheckEnqDetailsData({
    required this.Type,
    required this.DocEntry,
    required this.Current_Branch,
    required this.User_Branch,

  });

  String? Type;
  int? DocEntry;
  String? Current_Branch;
  String? User_Branch;

  factory CheckEnqDetailsData.fromJson(Map<String, dynamic> json) =>
   CheckEnqDetailsData(
     Type: json['Type'] ?? '',
     DocEntry: json['DocEntry'] ?? 0,
     Current_Branch: json['Current_Branch'] ?? '',
     User_Branch: json['User_Branch'] ?? '',

     );
   
}
