

// ignore_for_file: file_names
const String tableItemMaster = "ItemMaster";
class ItemMasterColumns{
 static const String itemCode = "ItemCode";
 static const String itemName = "ItemName";
 static const String category = "Category";
 static const String brand = "Brand";
 static const String division = "Division";
 static const String segment = "Segment";
 static const String favorite = "Favorite";
 static const String isselected = "IsSelected";
 static const String slpPrice = "SlpPrice";
 static const String mgrPrice = "MgrPrice";
 static const String storeStock = "StoreStock";
 static const String whsStock = "WhsStock";
 static const String refreshedRecordDate = "RefreshedRecordDate";
}
class ItemMasterDBModel{
  int?IMId;
 String? itemCode;
 String itemName;
 String category ;
 String brand ;
 String division ;
 String segment;
 String favorite;
 int isselected;
 double? slpPrice;
 double? mgrPrice;
  double? storeStock;
 double? whsStock;
 String?refreshedRecordDate;


ItemMasterDBModel({
 required this.itemCode,
  required this.brand, 
  required this.division,
  required this.category, 
  required this.itemName,
  required this.segment,
  required this.isselected,
  required this.favorite,
  required this.mgrPrice,
  required this.slpPrice,
  this.IMId,
  required this.storeStock,
  required this.whsStock,
  this.refreshedRecordDate
});

Map<String , Object?> toMap()=>{
  ItemMasterColumns.itemCode:itemCode,
  ItemMasterColumns.itemName:itemName,
  ItemMasterColumns.category:category,
  ItemMasterColumns.brand:brand,
  ItemMasterColumns.division:division,
  ItemMasterColumns.segment:segment,
  ItemMasterColumns.isselected:isselected,
  ItemMasterColumns.favorite:favorite,
  ItemMasterColumns.mgrPrice:mgrPrice,
  ItemMasterColumns.slpPrice:slpPrice,
  ItemMasterColumns.whsStock:whsStock,
  ItemMasterColumns.storeStock:storeStock,
  ItemMasterColumns.refreshedRecordDate:refreshedRecordDate
};
}
