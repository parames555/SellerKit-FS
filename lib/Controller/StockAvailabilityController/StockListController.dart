// ignore_for_file: unnecessary_new, prefer_const_constructors, unnecessary_string_interpolations

import 'dart:collection';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/DBHelper/DBHelper.dart';
import 'package:sellerkit/DBModel/ItemMasertDBModel.dart';
import 'package:sqflite/sqflite.dart';
import '../../DBHelper/DBOperation.dart';
import '../../Services/PostQueryApi/ItemMasterUpdateApi.dart/ItemMasterUpdateApiNew.dart';
import '../../Services/ServiceLayerApi/ItemMasterPriceUpdateApi/ItemMasterPriceApi.dart';
import 'package:jiffy/jiffy.dart';

class StockListController extends ChangeNotifier {
  Config config = new Config();
    List<TextEditingController> mycontroller =
      List.generate(15, (i) => TextEditingController());
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  double values = 0;
  double min = 0;
  double max = 50;

  double get getvalues => values;
  double get getmin => min;
  double get getmax => max;

  List<ItemMasterDBModel> brandList = [];
  List<ItemMasterDBModel> productList = [];
  List<ItemMasterDBModel> segmentList = [];
  List<ItemMasterDBModel> listPriceAvail = [];

  List<ItemMasterDBModel> get getbrandList => brandList;
  List<ItemMasterDBModel> get getproductList => productList;
  List<ItemMasterDBModel> get getsegmentList => segmentList;
  List<ItemMasterDBModel> get getlistPriceAvail => listPriceAvail;

  List<String> isselectedBrandString = [];
  List<String> isselectedProductString = [];
  List<String> isselectedSegmentString = [];

  List<String> get getisselectedBrandString => isselectedBrandString;
  List<String> get getisselectedProductString => isselectedProductString;
  List<String> get getisselectedSegmentString => isselectedSegmentString;

  // view all page

  List<ItemMasterDBModel> viewAll = [];
  List<ItemMasterDBModel> get getviewAll => viewAll;
  List<String> isselectedViewAllString = [];
  List<String> get getisselectedViewAllString => isselectedViewAllString;

  bool viewAllBrandSelected = false;
  bool viewAllProductSelected = false;
  bool viewAllSegementSelected = false;

  bool get getviewAllBrandSelected => viewAllBrandSelected;
  bool get getviewAllProductSelected => viewAllProductSelected;
  bool get getviewAllSegementSelected => viewAllSegementSelected;

  bool isBPSSelected = false;
  bool isBrandViewAllSelected = false;
  bool isProductViewAllSelected = false;
  bool isSegmentViewAllSelected = false;

  bool get getisBPSSelected => isBPSSelected;
  bool get getisBrandViewAllSelected => isBrandViewAllSelected;
  bool get getisProductViewAllSelected => isProductViewAllSelected;
  bool get getisSegmentViewAllSelected => isSegmentViewAllSelected;

//rangevalue

  var rageValue = RangeValues(0, 0);

  RangeValues get getrangevalue => rageValue;

//Listview Loading on clicked
  bool isLoadingListView = false;
  bool get getisLoadingListView => isLoadingListView;

  List<ItemMasterDBModel> filterdataprice = [];

  isSelectedBPS(){
  isBPSSelected = true;
  notifyListeners();
}

isSelectedBrandViewAll2(){
  isBrandViewAllSelected= true;
  notifyListeners();
}

isSelectedProductViewAll2(){
  isProductViewAllSelected = true;
  notifyListeners();
}

isSelectedSegmentViewAll2(){
  isSegmentViewAllSelected = true;
  notifyListeners();
}

  filterList(String v) {
    if (v.isNotEmpty) {
      listPriceAvail = filterdataprice
          .where((e) =>
              e.itemCode!.toLowerCase().contains(v.toLowerCase()) ||
              e.itemName.toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      listPriceAvail = filterdataprice;
      notifyListeners();
    }
  }

  validateSearch(BuildContext context)async{
    if(formkey.currentState!.validate()){
    //  log(mycontroller[0].text);
      config.disableKeyBoard(context);
      mycontroller[0].clear();
      Navigator.pop(context);
   final Database db = (await DBHelper.getInstance())!;

   await   DBOperation.getSearchData(mycontroller[0].text,db).then((resul) {
         listPriceAvail =  resul;
        Get.toNamed(ConstantRoutes.listStockAvailability);
         notifyListeners();
      });
    }
  }

  String subtractDateTime(String datetime) {
    return Jiffy("$datetime", "yyyy-MM-dd hh:mm:ss").fromNow();
  }

  getrange(RangeValues val) {
    rageValue = val;

    onSelectedFilter();
  }

  getDataFromDB() async {
   final Database db = (await DBHelper.getInstance())!;

    brandList = await DBOperation.getFavData("Brand",db);
    productList = await DBOperation.getFavData("Category",db);
    segmentList = await DBOperation.getFavData("Segment",db);
    notifyListeners();
  }

  //changed bar function
  changevalue(double value) {
    values = value;
    notifyListeners();
  }

  //selection

  isselectedBrand(int i) {
    if (brandList[i].isselected == 0) {
      brandList[i].isselected = 1;
      addBrand(brandList[i].brand);
    } else {
      brandList[i].isselected = 0;
      removeBrand(brandList[i].brand);
    }
    // notifyListeners();
  }

  addBrand(String brand) {
    isselectedBrandString.add("'$brand'");
    print("Brand: " + isselectedBrandString.toString());
    print("object" + isselectedBrandString[0].toString());
    onSelectedFilter();
  }

  removeBrand(String brand) {
    isselectedSegmentString.remove("'$brand'");
    print("Brandremoved: " + isselectedSegmentString.toString());
    onSelectedFilter();
  }

  isselectedProduct(int i) {
    if (productList[i].isselected == 0) {
      productList[i].isselected = 1;
      addProduct(productList[i].brand);
    } else {
      productList[i].isselected = 0;
      removeProduct(productList[i].brand);
    }
    //notifyListeners();
  }

  addProduct(String brand) {
    isselectedProductString.add("'$brand'");
    print("Brand: " + isselectedProductString.toString());
    onSelectedFilter();
  }

  removeProduct(String brand) {
    isselectedProductString.remove("'$brand'");
    print("Brandremoved: " + isselectedProductString.toString());
    onSelectedFilter();
  }

  isselectedSegment(int i) {
    if (segmentList[i].isselected == 0) {
      segmentList[i].isselected = 1;
      addProduct(segmentList[i].brand);
    } else {
      segmentList[i].isselected = 0;
      removeProduct(segmentList[i].brand);
    }
    // notifyListeners();
  }

  addSegment(String brand) {
    isselectedSegmentString.add("'$brand'");
    print("Brand: " + isselectedSegmentString.toString());
    onSelectedFilter();
  }

  removeSegment(String brand) {
    isselectedSegmentString.remove("'$brand'");
    print("Brandremoved: " + isselectedSegmentString.toString());
    onSelectedFilter();
  }

//// view all

  isselectedbrandViewAllPage() async {
   final Database db = (await DBHelper.getInstance())!;

    viewAllBrandSelected = true;
    viewAllProductSelected = false;
    viewAllSegementSelected = false;
    // isselectedViewAllString.clear();
    viewAll.clear();
    isselectedViewAllString.clear();
    if(isBPSSelected == false){
    viewAll = await DBOperation.getViewAllData("Brand",db);
    Get.toNamed(ConstantRoutes.stockListOfDetails)!.then(
      (value) {
        notifyListeners();
      },
    );
    }
      else if(isBPSSelected == true){
      viewAll = brandList;
          Get.toNamed(ConstantRoutes.stockListOfDetails)!.then(
      (value) {
        notifyListeners();
      },
    );
      }
    notifyListeners();
  }

  isselectedBrandViewAll(int i) {
    if (viewAll[i].isselected == 0) {
      viewAll[i].isselected = 1;
      addBrandViewAll(viewAll[i].brand);
    } else {
      viewAll[i].isselected = 0;
      removeBrandViewAll(viewAll[i].brand);
    }
  }

  addBrandViewAll(String brand) {
    isselectedViewAllString.add("'$brand'");
    print("Brand: " + isselectedViewAllString.toString());
    notifyListeners();
  }

  removeBrandViewAll(String brand) {
    isselectedViewAllString.remove("'$brand'");
    print("Brandremoved: " + isselectedViewAllString.toString());
    notifyListeners();
  }

  //product viw all

  isselectedProductViewAllPage() async {
   final Database db = (await DBHelper.getInstance())!;

    viewAllBrandSelected = false;
    viewAllProductSelected = true;
    viewAllSegementSelected = false;
    viewAll.clear();
    isselectedViewAllString.clear();
     log(viewAll.length.toString());

    if(isBPSSelected == false){
    viewAll = await DBOperation.getViewAllData("Category",db);
    Get.toNamed(ConstantRoutes.stockListOfDetails)!.then(
      (value) {
        notifyListeners();
      },
    );
    }
    else if(isBPSSelected == true){
     viewAll = productList;
     log(viewAll.length.toString());
      Get.toNamed(ConstantRoutes.stockListOfDetails)!.then(
      (value) {
        
        notifyListeners();
      },
    );
    }
    notifyListeners();
  }

  isselectedProductViewAll(int i) {
    if (viewAll[i].isselected == 0) {
      viewAll[i].isselected = 1;
      addBrandViewAll(viewAll[i].category);
    } else {
      viewAll[i].isselected = 0;
      removeBrandViewAll(viewAll[i].category);
    }
  }

  addProductViewAll(String category) {
    isselectedViewAllString.add("'$category'");
    print("Brand: " + isselectedViewAllString.toString());
    notifyListeners();
  }

  removeProductViewAll(String category) {
    isselectedViewAllString.remove("'$category'");
    print("Brandremoved: " + isselectedViewAllString.toString());
    notifyListeners();
  }

//segment view all

  isselectedSegmentViewAllPage() async {
   final Database db = (await DBHelper.getInstance())!;

    viewAllBrandSelected = false;
    viewAllProductSelected = false;
    viewAllSegementSelected = true;
    viewAll.clear();
    isselectedViewAllString.clear();
     if(isBPSSelected == false){
    viewAll = await DBOperation.getViewAllData("Segment",db);
    Get.toNamed(ConstantRoutes.stockListOfDetails)!.then(
      (value) {
        notifyListeners();
      },
    );
     }  
     else if(isBPSSelected == true){
      viewAll = segmentList ;
      Get.toNamed(ConstantRoutes.stockListOfDetails)!.then(
      (value) {
        notifyListeners();
      },
    );
    }
    notifyListeners();
  }

  isselectedSegmentViewAll(int i) {
    if (viewAll[i].isselected == 0) {
      viewAll[i].isselected = 1;
      addBrandViewAll(viewAll[i].category);
    } else {
      viewAll[i].isselected = 0;
      removeBrandViewAll(viewAll[i].category);
    }
    notifyListeners();
  }

  addSegmentViewAll(String category) {
    isselectedViewAllString.add("'$category'");
    print("Brand: " + isselectedViewAllString.toString());
  }

  removeSegmentViewAll(String category) {
    isselectedViewAllString.remove("'$category'");
    print("Brandremoved: " + isselectedViewAllString.toString());
  }

  ///clear alll

  clearAllData() {
    isselectedBrandString.clear();
    isselectedProductString.clear();
    isselectedSegmentString.clear();
    brandList.clear();
    productList.clear();
    segmentList.clear();
    viewAllBrandSelected = false;
    viewAllProductSelected = false;
    viewAllSegementSelected = false;
    isselectedViewAllString.clear();
    viewAll.clear();
    selectstringbarndsw.clear();
    selectstringsegmentsw.clear();
    selectstringproductsw.clear();
    rageValue = RangeValues(0, 0);
    isBPSSelected = false;
    isBrandViewAllSelected = false;
    isProductViewAllSelected = false;
    isSegmentViewAllSelected = false;
    getDataFromDB();
  }

  clearViewAllData() {
    viewAllBrandSelected = false;
    viewAllProductSelected = false;
    viewAllSegementSelected = false;
    Get.back();
    // isselectedViewAllString.clear();
    // viewAll.clear();
    onSelectedFilter();
    //notifyListeners();
  }

  Future<List<ItemMasterDBModel>> brandViewAllData() async {
       List<ItemMasterDBModel> newBrandList =[];
    if (isselectedViewAllString.isNotEmpty) {
      // brandList.clear();
      // isselectedBrandString.clear();
      for (int i = 0; i < viewAll.length; i++) {
        if (viewAll[i].isselected == 1) {
          isBPSSelected = true;
          log("selected: " + viewAll[i].brand);
          log("selected isselected: " + viewAll[i].isselected.toString());
          newBrandList.add(ItemMasterDBModel(
              itemCode: "null",
              brand: viewAll[i].brand,
              division: "null",
              category: "null",
              itemName: "null",
              segment: "null",
              isselected: viewAll[i].isselected,
              favorite: viewAll[i].favorite,
              mgrPrice: viewAll[i].mgrPrice,
              slpPrice: viewAll[i].slpPrice,
              storeStock: viewAll[i].storeStock,
              whsStock: viewAll[i].whsStock));
        }
      }
    brandList =  newBrandList;
      return Future.value(brandList);
    }
    brandList =  newBrandList;
    return Future.value(brandList);
  }

  Future<List<ItemMasterDBModel>> productViewAllData() async {
      List<ItemMasterDBModel> newProductList =[];

    if (isselectedViewAllString.isNotEmpty) {
      // productList.clear();
      // isselectedProductString.clear();
      for (int i = 0; i < viewAll.length; i++) {
        if (viewAll[i].isselected == 1) {
          isBPSSelected = true;
          newProductList.add(ItemMasterDBModel(
              itemCode: viewAll[i].itemCode,
              brand: viewAll[i].brand,
              division: viewAll[i].division,
              category: viewAll[i].category,
              itemName: viewAll[i].itemName,
              segment: viewAll[i].segment,
              isselected: viewAll[i].isselected,
              favorite: viewAll[i].favorite,
              mgrPrice: viewAll[i].mgrPrice,
              slpPrice: viewAll[i].slpPrice,
              storeStock: viewAll[i].storeStock,
              whsStock: viewAll[i].whsStock));
        }
      }
      productList =  newProductList;
      return Future.value(productList);
    }
      productList =  newProductList;
    return Future.value(productList);
  }

  Future<List<ItemMasterDBModel>> segmentViewAllData() {
      List<ItemMasterDBModel> newSegmentList =[];
    if (isselectedViewAllString.isNotEmpty) {
      // segmentList.clear();
      // isselectedSegmentString.clear();
      for (int i = 0; i < viewAll.length; i++) {
        if (viewAll[i].isselected == 1) {
          isBPSSelected = true;
          newSegmentList.add(ItemMasterDBModel(
              itemCode: viewAll[i].itemCode,
              brand: viewAll[i].brand,
              division: viewAll[i].division,
              category: viewAll[i].category,
              itemName: viewAll[i].itemName,
              segment: viewAll[i].segment,
              isselected: viewAll[i].isselected,
              favorite: viewAll[i].favorite,
              mgrPrice: viewAll[i].mgrPrice,
              slpPrice: viewAll[i].slpPrice,
              storeStock: viewAll[i].storeStock,
              whsStock: viewAll[i].whsStock));
        }
      } 
     segmentList = newSegmentList;
      return Future.value(segmentList);
    }
     segmentList = newSegmentList;
    return Future.value(productList);
  }

  Future<String> checkSelectedValuesBrand() {
    isselectedBrandString.clear();
    selectstringbarndsw.clear();
    for (int i = 0; i < brandList.length; i++) {
      if (brandList[i].isselected == 1) {
        isselectedBrandString.add("'${brandList[i].brand}'");
        selectstringbarndsw.add(brandList[i].brand);
      }
    }
    String text = isselectedBrandString
        .toString()
        .replaceAll("[", "")
        .replaceAll("]", "");
    return Future.value(text);
  }

  Future<String> checkSelectedValuesProduct() {
    isselectedProductString.clear();
    selectstringproductsw.clear();
    for (int i = 0; i < productList.length; i++) {
      if (productList[i].isselected == 1) {
        isselectedProductString.add("'${productList[i].category}'");
        selectstringproductsw.add(productList[i].category);
      }
    }

    String text = isselectedProductString
        .toString()
        .replaceAll("[", "")
        .replaceAll("]", "");
    return Future.value(text);
  }

  Future<String> checkSelectedValuesSegment() {
    isselectedSegmentString.clear();
    selectstringsegmentsw.clear();
    for (int i = 0; i < segmentList.length; i++) {
      if (segmentList[i].isselected == 1) {
        print(segmentList[i].segment);
        isselectedSegmentString.add("'${segmentList[i].segment}'");
        selectstringsegmentsw.add(segmentList[i].segment);
      }
    }

    String text = isselectedSegmentString
        .toString()
        .replaceAll("[", "")
        .replaceAll("]", "");
    return Future.value(text);
  }

//filter
  onSelectedFilter() async {
   final Database db = (await DBHelper.getInstance())!;

    String brand = await checkSelectedValuesBrand();
    String product = await checkSelectedValuesProduct();
    String segment = await checkSelectedValuesSegment();
    await DBOperation
        .onFieldSeleted(
            brand.isEmpty ? "''" : brand,
            product.isEmpty ? "''" : product,
            segment.isEmpty ? "''" : segment,
            isselectedBrandString.isEmpty ? '' : '1',
            isselectedProductString.isEmpty ? '' : '1',
            isselectedSegmentString.isEmpty ? '' : '1',
            rageValue.start.toString(),
            rageValue.end.toString(),db)
        .then((value) async {
      brandList.clear();
      productList.clear();
      segmentList.clear();
      //  log("dataprice: : "+value.map((e) => e.price.toString()).toList().toString());
      listPriceAvail = value;
      filterdataprice = listPriceAvail;
      brandList = await distinctBrand(value);
      productList = await distinctProduct(value);
      segmentList = await distinctSegment(value);
      notifyListeners();
    });
  }

  Future<List<ItemMasterDBModel>> distinctSegment( List<ItemMasterDBModel> dataval) {
    List<ItemMasterDBModel> newData = [];
    var segmentdata = dataval.map((e) => e.segment).toSet().toList();
    for (int i = 0; i < segmentdata.length; i++) {
      int isgot = 0;
      if (selectstringsegmentsw.isNotEmpty) {
        for (int j = 0; j < selectstringsegmentsw.length; j++) {
          if (segmentdata[i] == selectstringsegmentsw[j]) {
            isgot = i;
            break;
          }
        }
        newData.add(ItemMasterDBModel(
          itemCode: null,
          brand: "null",
          division: "null",
          category: "null",
          itemName: "null",
          segment: segmentdata[i],
          isselected: isgot == i ? 1 : 0,
          favorite: "null", // viewAll[i].favorite,
          mgrPrice: 0.00, //  viewAll[i].mgrPrice,
          slpPrice: 0.00, // viewAll[i].slpPrice,
          storeStock: 0.00, // viewAll[i].storeStock,
          whsStock: 0.00, //  viewAll[i].whsStock
        ));
      } else {
        newData.add(ItemMasterDBModel(
          itemCode: null,
          brand: "null",
          division: "null",
          category: "null",
          itemName: "null",
          segment: segmentdata[i],
          isselected: 0,
          favorite: "null", // viewAll[i].favorite,
          mgrPrice: 0.00, //  viewAll[i].mgrPrice,
          slpPrice: 0.00, // viewAll[i].slpPrice,
          storeStock: 0.00, // viewAll[i].storeStock,
          whsStock: 0.00, //  viewAll[i].whsStock
        ));
      }
    }
    return Future.value(newData);
  }

  List<String> selectstringbarndsw = [];
  List<String> selectstringproductsw = [];
  List<String> selectstringsegmentsw = [];

  Future<List<ItemMasterDBModel>> distinctBrand(List<ItemMasterDBModel> dataval) async {
    List<ItemMasterDBModel> newData = [];
    var branddata = dataval.map((e) => e.brand).toSet().toList();
    log("ssssslength: " + branddata.length.toString());
    for (int i = 0; i < branddata.length; i++) {
      int isgot = 0;
      if (selectstringbarndsw.isNotEmpty) {
        for (int j = 0; j < selectstringbarndsw.length; j++) {
          // log("sssss: "+branddata[i].toString() );
          // print("selelctedss: "+selectstringbarndsw.toString());
          //  print("selelctedss length: "+selectstringbarndsw.length.toString());
          if (branddata[i] == selectstringbarndsw[j]) {
            //  log("branddata: "+branddata[i].toString() );
            //  log("selectstringbarndsw: "+selectstringbarndsw[j].toString() );
            isgot = i;
            // log("iiii: "+[i].toString() );
            //  log("isgot: "+isgot.toString() );
            break;
          }
          //  print("isgiot?: $isgot");
        }

        newData.add(ItemMasterDBModel(
          itemCode: null,
          brand: branddata[i],
          division: "null",
          category: "null",
          itemName: "null",
          segment: "null",
          isselected: isgot == i ? 1 : 0,
          favorite: "null",
          mgrPrice: 0.0, // viewAll[i].mgrPrice,
          slpPrice: 0.0, // viewAll[i].slpPrice,
          storeStock: 0.0, //viewAll[i].storeStock,
          whsStock: 0.0, //  viewAll[i].whsStock
        ));
      } else {
        print("isnotempty??");
        newData.add(ItemMasterDBModel(
          itemCode: null,
          brand: branddata[i],
          division: "null",
          category: "null",
          itemName: "null",
          segment: "null",
          isselected: 0,
          favorite: "null",
          mgrPrice: 0.0, // viewAll[i].mgrPrice,
          slpPrice: 0.0, // viewAll[i].slpPrice,
          storeStock: 0.0, //viewAll[i].storeStock,
          whsStock: 0.0, //  viewAll[i].whsStock
        ));
      }
    }
    return Future.value(newData);
  }

  Future<List<ItemMasterDBModel>> distinctProduct(List<ItemMasterDBModel> dataval) {
    List<ItemMasterDBModel> newData = [];
    var productdata = dataval.map((e) => e.category).toSet().toList();

    for (int i = 0; i < productdata.length; i++) {
      int isgot = 0;
      if (selectstringproductsw.isNotEmpty) {
        for (int j = 0; j < selectstringproductsw.length; j++) {
          // log("productdata: "+productdata[i].toString() );
          //  log("selectstringproductsw: "+selectstringproductsw[j].toString() );
          if (productdata[i] == selectstringproductsw[j]) {
            isgot = i;
            break;
          }
        }
        newData.add(ItemMasterDBModel(
          itemCode: null,
          brand: "null",
          division: "null",
          category: productdata[i],
          itemName: "null",
          segment: "null",
          isselected: isgot == i ? 1 : 0,
          favorite: "null",
          mgrPrice: 0.0, // viewAll[i].mgrPrice,
          slpPrice: 0.0, // viewAll[i].slpPrice,
          storeStock: 0.0, //viewAll[i].storeStock,
          whsStock: 0.0, //  viewAll[i].whsStock
        ));
      } else {
        newData.add(ItemMasterDBModel(
          itemCode: null,
          brand: "null",
          division: "null",
          category: productdata[i],
          itemName: "null",
          segment: "null",
          isselected: 0,
          favorite: "null", //viewAll[i].favorite,
          mgrPrice: 0.00, //  viewAll[i].mgrPrice,
          slpPrice: 0.00, //  viewAll[i].slpPrice,
          storeStock: 0.00, // viewAll[i].storeStock,
          whsStock: 0.00, // viewAll[i].whsStock
        ));
      }
    }
    return Future.value(newData);
  }

  ///call price list update api
  String errorMsg = 'Some thing went wrong';
  bool exception = false;
  bool get getException => exception;
  String get getErrorMsg => errorMsg;

  callItemMasterPriceUpdate(
      String itemcode, int tmid, int indexfromList) async {
    isLoadingListView = true;
    listPriceAvail[indexfromList].isselected = 1;
    notifyListeners();
    await ItemMasterPriceUpdateApi.getData(itemcode).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        exception = false;
        isLoadingListView = false;

        if (value.itemPrices != null) {
          if (value.itemPrices!.isNotEmpty) {
            for (int i = 0; i < value.itemPrices!.length; i++) {
              if (value.itemPrices![i].PriceList == 1
                  // ||value.itemValueValue![0].itemPrices![i].PriceList == 2
                  ) {
                listPriceAvail[indexfromList].slpPrice =
                    value.itemPrices![i].price!;
                //   "1200.00";
                // print("list values: "+listPriceAvail[indexfromList].price!+ indexfromList.toString());
                value.itemPrices![i].price!.toStringAsFixed(2);
                listPriceAvail[indexfromList].isselected = 0;
                notifyListeners();
              }
            }
          }
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        exception = true;
        isLoadingListView = false;
        errorMsg = '${value.error!.message!.value}';
        notifyListeners();
      } else if (value.stcode == 500) {
        exception = true;
        isLoadingListView = false;
        errorMsg = '${value.exception}';
        notifyListeners();
      }
    });
    notifyListeners();
  }

  callItemMasterPriceUpdateNew(
      String itemcode, int Itmid, int indexfromList) async {
    isLoadingListView = true;
    listPriceAvail[indexfromList].isselected = 1;
    notifyListeners();
    await ItemMasterApiUpdateNew.getData('${ConstantValues.slpcode}', itemcode)
        .then((value) async{
   final Database db = (await DBHelper.getInstance())!;

      print("sapuserid: " + ConstantValues.slpcode.toString());
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        exception = false;
        isLoadingListView = false;

        if (value.itemdata != null) {
          listPriceAvail[indexfromList].slpPrice = value.itemdata![0].SlpPrice;
          listPriceAvail[indexfromList].mgrPrice = value.itemdata![0].MgrPrice;
          listPriceAvail[indexfromList].storeStock = value.itemdata![0].StoreStock;
          listPriceAvail[indexfromList].whsStock = value.itemdata![0].WhsStock;
          listPriceAvail[indexfromList].refreshedRecordDate = config.currentDate();

          ItemMasterDBModel itemMas = new ItemMasterDBModel(
            itemCode: 'itemCode', 
            brand: 'brand', 
            division: 'division', 
            category: 'category', 
            itemName: 'itemName', 
            segment: 'segment', 
            isselected: 0, 
            favorite: 'favorite', 
            mgrPrice:listPriceAvail[indexfromList].mgrPrice,
            slpPrice: listPriceAvail[indexfromList].slpPrice, 
            storeStock:listPriceAvail[indexfromList].storeStock,
            whsStock:  listPriceAvail[indexfromList].whsStock,
            refreshedRecordDate: listPriceAvail[indexfromList].refreshedRecordDate
            );
   
      
          await DBOperation.updateItemMaster(Itmid.toString(), itemMas,db).then((value){
          listPriceAvail[indexfromList].isselected = 0;
          notifyListeners();
          });
        } else if (value.itemdata == null) {
          exception = true;
          isLoadingListView = false;
          errorMsg = 'No data found..!!';
          listPriceAvail[indexfromList].isselected = 0;
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        exception = true;
        isLoadingListView = false;
        errorMsg = '${value.exception}';
        listPriceAvail[indexfromList].isselected = 0;
          notifyListeners();
      } else if (value.stcode == 500) {
        exception = true;
        isLoadingListView = false;
        errorMsg = '${value.exception}';
        listPriceAvail[indexfromList].isselected = 0;
          notifyListeners();
      }
    });
    notifyListeners();
  }

  /// view all

  ///get files
  ///
  File? source1;
  Directory? copyTo;
  Future<File> getPathOFDB() async {
    final dbFolder = await getDatabasesPath();
    File source1 = File('$dbFolder/SellerKit.db');
    return Future.value(source1);
  }

  Future<Directory> getDirectory() async {
    Directory copyTo = Directory("storage/emulated/0/Sqlite Backup");
    return Future.value(copyTo);
  }

  Future<bool> getPermissionStorage() async {
    try {
      var statusStorage = await Permission.storage.status;
      if (statusStorage.isDenied) {
        Permission.storage.request();
        return Future.value(false);
      }
      if (statusStorage.isGranted) {
        return Future.value(true);
      }
    } catch (e) {
      showSnackBars("$e", Colors.red);
    }
    return Future.value(false);
  }

  showSnackBars(String e, Color color) {
    Get.showSnackbar(GetSnackBar(
      title: "Notidy",
      message: e,
    ));
  }

  Future<String> createDirectory() async {
    try {
      await copyTo!.create();
      String newPath = "${copyTo!.path}";
      createDBFile(newPath);
      return newPath;
    } catch (e) {
      print("datata1111");
      print(e);
      showSnackBars("$e", Colors.red);
    }
    return 'null';
  }

  createDBFile(String path) async {
    try {
      String getPath = "$path/SellerKit.db";
      print(getPath);
      await source1!.copy(getPath);
      showSnackBars("Created!!...", Colors.green);
    } catch (e) {
      showSnackBars("$e", Colors.red);
    }
  }
}
