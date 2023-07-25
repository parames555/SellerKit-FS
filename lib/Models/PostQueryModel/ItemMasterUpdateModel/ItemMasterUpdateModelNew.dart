import 'dart:convert';

class ItemMasterNewUpdateModal {
List<ItemMasterNewUpdateData>? itemdata;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  ItemMasterNewUpdateModal(
      {required this.itemdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory ItemMasterNewUpdateModal.fromJson(Map<String, dynamic> jsons,int stcode) {
    if (jsons["data"] != null && jsons["data"] != "No data found") {
      var list = json.decode(jsons["data"]) as List;
      List<ItemMasterNewUpdateData> dataList =
          list.map((data) => ItemMasterNewUpdateData.fromJson(data)).toList();
      return ItemMasterNewUpdateModal(
        itemdata: dataList,
        message: jsons["msg"],
        status: jsons["status"],
        stcode: stcode,
        exception:null
      );
    } else {
      return ItemMasterNewUpdateModal(
        itemdata: null,
        message: jsons["msg"],
        status: jsons["status"],
        stcode: stcode,
        exception:null
      );
    }
  }

  factory ItemMasterNewUpdateModal.error(String jsons,int stcode) {
    return ItemMasterNewUpdateModal(
        itemdata: null, message: 'Exception', status: null,   stcode: stcode,
        exception:jsons);
  }
}

class ItemMasterNewUpdateData {
  ItemMasterNewUpdateData({
    required this.MgrPrice,
    required this.itemcode,
    required this.itemName,
    required this.Segment,
    required this.Favorite,
    required this.SlpPrice,
    required this.Category,
    required this.Brand,
    required this.Division,
    required this.StoreStock,
    required this.WhsStock
  });

  String? itemcode;
  String? itemName;
  String? Favorite;
  String? Category;
  String? Brand;
  String? Segment;
  String? Division;
  double? MgrPrice;
  double? SlpPrice;
  double? StoreStock;
  double? WhsStock;


  factory ItemMasterNewUpdateData.fromJson(Map<String, dynamic> json) =>
   ItemMasterNewUpdateData(
     itemcode: json['ItemCode'] ?? '',
     itemName: json['ItemName'] ?? '',
     Segment: json['Segment'] ?? '', 
     Favorite: json['Favorite'] ?? '', 
     Category: json['Category'] ?? '',
     Brand: json['Brand'] ?? '', 
     Division: json['Division'] ?? '', 
     StoreStock: json['StoreStock']?? 0.00,
     MgrPrice: json['MgrPrice'] ?? 0.00, 
     SlpPrice: json['SlpPrice'] ?? 0.00,
     WhsStock:json['WhsStock']?? 0.00);
}
