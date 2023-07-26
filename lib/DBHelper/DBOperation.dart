// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print, prefer_interpolation_to_compose_strings

import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:sellerkit/Models/PostQueryModel/EnquiriesModel/GetUserModel.dart';
import '../DBModel/EnqTypeModel.dart';
import '../DBModel/ItemMasertDBModel.dart';
import '../DBModel/NotificationModel.dart';
import '../DBModel/SiteCheckInTableModel.dart';
import '../Models/OfferZone/OfferZoneModel.dart';
import '../Models/OpenLeadModel.dart/OpenLeadModel.dart';
import '../Models/PostQueryModel/EnquiriesModel/EnqRefferesModel.dart';
import '../Models/PostQueryModel/EnquiriesModel/EnqTypeModel.dart';
import '../Models/PostQueryModel/LeadsCheckListModel/GetLeadStatuModel.dart';

class DBOperation {
  static Future insertItemMaster(
      List<ItemMasterDBModel> values, Database db) async {
    //openDatabase('SellerKit.db');
    // ReceivePort port = new ReceivePort();
    // final iss = await Isolate.spawn<List<dynamic>>(
    //     insertDataItem, [port.sendPort, values]);
    // iss.kill(priority: Isolate.immediate);

    var data = values.map((e) => e.toMap()).toList();
    log("ItemMasterDBModel len: " + data.length.toString());
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert(tableItemMaster, es);
      log("ItemMasterDBModel Batchhhh Item...");
    });
    await batch.commit();
    // await db.close();
  }

  insertDataItem(List<dynamic> datas, Database db) async {
    // final Database db = await createDB();
    List<ItemMasterDBModel> valuesm = datas[1];
    var data = valuesm.map((e) => e.toMap()).toList();
    log("ItemMasterDBModel len: " + data.length.toString());
    // Database db = datas[2];
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert(tableItemMaster, es);
      log("ItemMasterDBModel Batchhhh Item11111...");
    });
    log("commiteddd...");
    await batch.commit();
    log("commiteddd222222...");
  }

  static Future insertSiteCheckIn(
      Database db, List<SiteCheckInDBModel> values) async {
    var data = values.map((e) => e.toMap()).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert("SiteCheckIn", es);
    });
    final List<Map<String, Object?>> result =
        await db.rawQuery('''SELECT * FROM  SiteCheckIn ''');
    log("SitecheckIn:::" + result.toString());
    await batch.commit();
  }
   static Future insertDayStart(
      Database db, List<SiteCheckInDBModel> values) async {
    var data = values.map((e) => e.toMap()).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert("DayStart", es);
    });
    final List<Map<String, Object?>> result =
        await db.rawQuery('''SELECT * FROM  DayStart ''');
    log("DayStart:::" + result.toString());
    await batch.commit();
  }

  static Future<List<Map<String, Object?>>> getValidateCheckIn(
    Database db,
  ) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        ''' SELECT * FROM  SiteCheckIn where substr(DateTime,1,10) = DATE("now") and SiteType = "CheckIn" ''');
    //log("getSalesHeadHoldvalueDB:" + result.toString());
    return result;
  }
   static Future changeCheckIntoCheckOut(
      Database db, int checkId) async {
    List<Map<String, Object?>> result = await db.rawQuery(
        ''' UPDATE SiteCheckIn  SET SiteType = "CheckOut" Where CheckInId= $checkId ''');
    //log("Updated Coupon list::" + result.toString());
    return result;
  }

  Future insertdocuments(ItemMasterDBModel values, Database db) async {
    final id = await db.insert(tableItemMaster, values.toMap());
    print("result: $id");
  }

  static Future<List<ItemMasterDBModel>> getFavData(
      String fav, Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''
SELECT DISTINCT $fav,IsSelected,Favorite
 FROM ItemMaster
WHERE $fav IS NOT '' AND Favorite IS NOT 'N';
''');

    // log("Saved AllocATE: " + result.toList().toString());
    log("Saved AllocATE length: " + result.length.toString());

    return List.generate(result.length, (i) {
      return ItemMasterDBModel(
        itemCode: '', // result[i]['ItemCode'].toString(),
        itemName: '', //  result[i]['ItemName'].toString(),
        brand: result[i]['Brand'].toString(),
        category: result[i]['Category'].toString(),
        division: result[i]['Division'].toString(),
        segment: result[i]['Segment'].toString(),
        isselected: int.parse(result[i]['IsSelected'].toString()),
        favorite: result[i]['Favorite'].toString(),
        mgrPrice: 0.0, // double.parse(result[i]['MgrPrice'].toString()),
        slpPrice: 0.0, //double.parse( result[i]['SlpPrice'].toString()),
        storeStock: 0.0, //double.parse( result[i]['StoreStock'].toString()),
        whsStock: 0.0, // double.parse( result[i]['WhsStock'].toString()),
      );
    });
  }

  static Future<List<ItemMasterDBModel>> onFieldSeleted(
      String brand,
      String category,
      String segment,
      String isselectedBrand,
      String isSelectedCate,
      String isSelectedsegment,
      String fromAmt,
      String toAmount,
      Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        """
 SELECT * From ItemMaster A
      Where 
      A.Brand <> 'null' and coalesce(A.Brand,'') <> '' AND
      A.Segment <> 'null' and coalesce(A.Segment,'') <> '' AND 
      A.Category <> 'null' and coalesce(A.Category,'') <> '' AND 
      ('$isselectedBrand' = '' OR A.Brand in ($brand)) 
      AND ('$isSelectedCate' = '' OR A.Category in ($category)) 
      AND ('$isSelectedsegment' = '' OR A.Segment in ($segment)) 
""");

    // log("Saved AllocATE: " + result.toList().toString());
    // log("Saved AllocATE length: " + result.length.toString());

    ///
    String data =
        """
 SELECT * From ItemMaster A
      Where 
      A.Brand <> 'null' and coalesce(A.Brand,'') <> '' AND
      A.Segment <> 'null' and coalesce(A.Segment,'') <> '' AND
      A.Category <> 'null' and coalesce(A.Category,'') <> '' AND
      ('$isselectedBrand' = '' OR A.Brand in ($brand))
      AND ('$isSelectedCate' = '' OR A.Category in ($category))
      AND ('$isSelectedsegment' = '' OR A.Segment in ($segment))
""";

    log(data.toString());

    return List.generate(result.length, (i) {
      return ItemMasterDBModel(
          IMId: int.parse(result[i]['IMId'].toString()),
          itemCode: result[i]['ItemCode'].toString(),
          itemName: result[i]['ItemName'].toString(),
          brand: result[i]['Brand'].toString(),
          category: result[i]['Category'].toString(),
          division: result[i]['Division'].toString(),
          segment: result[i]['Segment'].toString(),
          isselected: int.parse(result[i]['IsSelected'].toString()),
          favorite: result[i]['Favorite'].toString(),
          mgrPrice: double.parse(result[i]['MgrPrice'].toString()),
          slpPrice: double.parse(result[i]['SlpPrice'].toString()),
          storeStock: double.parse(result[i]['StoreStock'].toString()),
          whsStock: double.parse(result[i]['WhsStock'].toString()),
          refreshedRecordDate: result[i]['RefreshedRecordDate'].toString());
    });
  }

  /// view all

  static Future<List<ItemMasterDBModel>> getViewAllData(
      String data, Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''
SELECT DISTINCT $data,IsSelected
 FROM ItemMaster
WHERE $data IS NOT '';
''');

    // log("Saved AllocATE: " + result.toList().toString());
    log("Saved AllocATE length: " + result.length.toString());

    return List.generate(result.length, (i) {
      return ItemMasterDBModel(
        itemCode: result[i]['ItemCode'].toString(),
        itemName: result[i]['ItemName'].toString(),
        brand: result[i]['Brand'].toString(),
        category: result[i]['Category'].toString(),
        division: result[i]['Division'].toString(),
        segment: result[i]['Segment'].toString(),
        isselected: int.parse(result[i]['IsSelected'].toString()),
        favorite: result[i]['Favorite'].toString(),
        mgrPrice: 0.00, // double.parse( result[i]['MgrPrice'].toString()),
        slpPrice: 0.00, // double.parse( result[i]['SlpPrice'].toString()),
        storeStock: 0.00, //double.parse( result[i]['StoreStock'].toString()),
        whsStock: 0.00, //double.parse( result[i]['WhsStock'].toString()),
      );
    });
  }

  static Future<List<ItemMasterDBModel>> getSearchData(
      String data, Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''
Select * from ItemMaster where (ItemCode || ' - ' || ItemName) Like '%$data%';
''');

    log("Search data: " + result.toList().toString());
    // log("Saved AllocATE length: " + result.length.toString());

    return List.generate(result.length, (i) {
      return ItemMasterDBModel(
          IMId: int.parse(result[i]['IMId'].toString()),
          itemCode: result[i]['ItemCode'].toString(),
          itemName: result[i]['ItemName'].toString(),
          brand: result[i]['Brand'].toString(),
          category: result[i]['Category'].toString(),
          division: result[i]['Division'].toString(),
          segment: result[i]['Segment'].toString(),
          isselected: int.parse(result[i]['IsSelected'].toString()),
          favorite: result[i]['Favorite'].toString(),
          mgrPrice: double.parse(result[i]['MgrPrice'].toString()),
          slpPrice: double.parse(result[i]['SlpPrice'].toString()),
          storeStock: double.parse(result[i]['StoreStock'].toString()),
          whsStock: double.parse(result[i]['WhsStock'].toString()),
          refreshedRecordDate: result[i]['RefreshedRecordDate'].toString());
    });
  }

  //update
  static Future<void> updateItemMaster(
      String ID, ItemMasterDBModel itemMaserPriceAvail, Database db) async {
// print("mgrPrice: "+itemMaserPriceAvail.mgrPrice.toString());
// print("refreshedRecordDate: "+itemMaserPriceAvail.refreshedRecordDate.toString());
// print("slpPrice "+itemMaserPriceAvail.slpPrice.toString());
// print("whsStock "+itemMaserPriceAvail.whsStock.toString());
// print("storeStock: "+itemMaserPriceAvail.storeStock.toString());
// print("storeID ID: "+ID.toString());

    final List<Map<String, Object?>> result = await db.rawQuery(
        '''
      UPDATE $tableItemMaster
SET MgrPrice = ${itemMaserPriceAvail.mgrPrice},
 SlpPrice = ${itemMaserPriceAvail.slpPrice} ,
 StoreStock = ${itemMaserPriceAvail.storeStock} ,
 WhsStock = ${itemMaserPriceAvail.whsStock},
 RefreshedRecordDate = "${itemMaserPriceAvail.refreshedRecordDate}" WHERE IMId = "$ID";
    ''');
  }

  static Future<List<ItemMasterDBModel>> getAllProducts(Database db) async {
    final List<Map<String, Object?>> result =
        await db.rawQuery("""
 SELECT * From ItemMaster 
""");

    return List.generate(result.length, (i) {
      return ItemMasterDBModel(
          IMId: int.parse(result[i]['IMId'].toString()),
          itemCode: result[i]['ItemCode'].toString(),
          itemName: result[i]['ItemName'].toString(),
          brand: result[i]['Brand'].toString(),
          category: result[i]['Category'].toString(),
          division: result[i]['Division'].toString(),
          segment: result[i]['Segment'].toString(),
          isselected: int.parse(result[i]['IsSelected'].toString()),
          favorite: result[i]['Favorite'].toString(),
          mgrPrice: double.parse(result[i]['MgrPrice'].toString()),
          slpPrice: double.parse(result[i]['SlpPrice'].toString()),
          storeStock: double.parse(result[i]['StoreStock'].toString()),
          whsStock: double.parse(result[i]['WhsStock'].toString()),
          refreshedRecordDate: result[i]['RefreshedRecordDate'].toString());
    });
  }

  //enqtype methods

  static Future insertEnqType(List<EnquiryTypeData> values, Database db) async {
    var data = values.map((e) => e.toMap()).toList();
    log("ItemMasterDBModel len: " + data.length.toString());
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert(tableEnqType, es);
      log("Enq Batchhhh Item...");
    });
    await batch.commit();

    // ReceivePort port = new ReceivePort();
    // final isolate = await Isolate.spawn<List<dynamic>>(
    //     insertIsoEnqtpe, [port.sendPort, values, db]);
    // isolate.kill(priority: Isolate.immediate);
  }

  insertIsoEnqtpe(List<dynamic> value) async {
    List<EnquiryTypeData> valu = value[1];
    var data = valu.map((e) => e.toMap()).toList();
    // log("ItemMasterDBModel len2222: " + data.length.toString());
    var batch = value[2].batch();
    data.forEach((es) async {
      batch.insert(tableEnqType, es);
      // log("Enq Batchhhh Item22222...");
    });
    await batch.commit();
  }

 

  static Future<List<EnquiryTypeData>> getEnqData(Database db) async {
    final List<Map<String, Object?>> result =
        await db.rawQuery('''
SELECT * FROM EnqType;
''');

    // log("Saved AllocATE: " + result.toList().toString());
    // log("Saved AllocATE length: " + result.length.toString());

    return List.generate(result.length, (i) {
      return EnquiryTypeData(
        Code: int.parse(result[i]['Code'].toString()),
        Name: result[i]['Name'].toString(),
      );
    });
  }

  static Future<void> truncareItemMaster(Database db) async {
    await db.rawQuery('delete from $tableItemMaster');
  }

  static Future<void> truncareEnqType(Database db) async {
    await db.rawQuery('delete from $tableEnqType');
  }

  static Future<void> truncareEnqReffers(Database db) async {
    await db.rawQuery('delete from $tableEnqReffers');
  }

  static Future insertEnqReffers(
      List<EnqRefferesData> values, Database db) async {
    var data = values.map((e) => e.toMap()).toList();
    //   log("ItemMasterDBModel len: " + data.length.toString());
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert(tableEnqReffers, es);
      log("Enq Batchhhh Item...");
    });
    await batch.commit();

    // ReceivePort port = new ReceivePort();
    // final isolate = await Isolate.spawn<List<dynamic>>(
    //     indertIsoReferral, [port.sendPort, values, db]);
    // isolate.kill(priority: Isolate.immediate);
  }

  static indertIsoReferral(List<dynamic> value) async {
    List<EnqRefferesData> values = value[1];
    var data = values.map((e) => e.toMap()).toList();
    //   log("ItemMasterDBModel len: " + data.length.toString());
    var batch = value[2].batch();
    data.forEach((es) async {
      batch.insert(tableEnqReffers, es);
      // log("referrall Batchhhh Item3333...");
    });
    await batch.commit();
  }

  static Future<List<EnqRefferesData>> getEnqRefferes(Database db) async {
    final List<Map<String, Object?>> result =
        await db.rawQuery('''
    SELECT * FROM $tableEnqReffers;
    ''');

    // log("Saved AllocATE: " + result.toList().toString());
    // log("Saved AllocATE length: " + result.length.toString());

    return List.generate(result.length, (i) {
      return EnqRefferesData(
        Code: result[i]['Code'].toString(),
        Name: result[i]['Name'].toString(),
      );
    });
  }

  // user list

  static Future insertUserList(List<UserListData> values, Database db) async {
    var data = values.map((e) => e.toMap()).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert(tableUserList, es);
      print("Data...");
    });
    await batch.commit();

    // ReceivePort port = new ReceivePort();
    // final isolate = await Isolate.spawn<List<dynamic>>(
    //     indertIsoUserList, [port.sendPort, values, db]);
    // isolate.kill(priority: Isolate.immediate);
  }

  static indertIsoUserList(List<dynamic> value) async {
    List<UserListData> values = value[1];
    var data = values.map((e) => e.toMap()).toList();
    //   log("ItemMasterDBModel len: " + data.length.toString());
    var batch = value[2].batch();
    data.forEach((es) async {
      batch.insert(tableUserList, es);
      // log("Enq userlist Batchhhh Item4444...");
    });
    await batch.commit();
  }

  static Future<List<UserListData>> getUserList(Database db) async {
    final List<Map<String, Object?>> result =
        await db.rawQuery('''
SELECT * FROM $tableUserList;
''');

    return List.generate(result.length, (i) {
      return UserListData(
        //  UserKey: int.parse(result[i]['UserKey'].toString()),
        //  UserCode: result[i]['UserCode'].toString(),
        UserName: result[i]['UserName'].toString(),
        color: int.parse(result[i]['Color'].toString()),
        // EmployeeID: int.parse(result[i]['EmployeeID'].toString()),
        SalesEmpID: int.parse(result[i]['SalesEmpID'].toString()),
      );
    });
  }

  static Future insertLeadStatusList(
      List<GetLeadStatusData> values, Database db) async {
    var data = values.map((e) => e.toMap()).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert(tableLeadStatusReason, es);
      print("LeadStatusList...");
    });
    await batch.commit();

    // ReceivePort port = new ReceivePort();
    // final isolate = await Isolate.spawn<List<dynamic>>(
    //     indertIsoLeadStatusList, [port.sendPort, values, db]);
    // isolate.kill(priority: Isolate.immediate);
  }

  static indertIsoLeadStatusList(List<dynamic> value) async {
    List<GetLeadStatusData> values = value[1];
    var data = values.map((e) => e.toMap()).toList();
    //   log("ItemMasterDBModel len: " + data.length.toString());
    var batch = value[2].batch();
    data.forEach((es) async {
      batch.insert(tableLeadStatusReason, es);
      // log("Enq LeadStatus Batchhhh Item555..");
    });
    await batch.commit();
  }

  static Future<List<GetLeadStatusData>> getLeadStatusOpen(Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''
      SELECT * FROM $tableLeadStatusReason where StatusType = 'Open';
      ''');

    // log("LeadStatusReason: " + result.toList().toString());
    // log("LeadStatusReason: " + result.length.toString());
    return List.generate(result.length, (i) {
      return GetLeadStatusData(
        code: result[i]['Code'].toString(),
        name: result[i]['Name'].toString(),
        statusType: result[i]['StatusType'].toString(),
      );
    });
  }

  static Future<List<GetLeadStatusData>> getLeadStatusWon(Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''
      SELECT * FROM $tableLeadStatusReason where StatusType = 'Won';
      ''');

    // log("LeadStatusReason: " + result.toList().toString());
    // log("LeadStatusReason: " + result.length.toString());

    return List.generate(result.length, (i) {
      return GetLeadStatusData(
        code: result[i]['Code'].toString(),
        name: result[i]['Name'].toString(),
        statusType: result[i]['StatusType'].toString(),
      );
    });
  }

  static Future<List<GetLeadStatusData>> getLeadStatusLost(Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''
      SELECT * FROM $tableLeadStatusReason where StatusType = 'Lost';
      ''');

    // log("LeadStatusReason: " + result.toList().toString());
    // log("LeadStatusReason: " + result.length.toString());

    return List.generate(result.length, (i) {
      return GetLeadStatusData(
        code: result[i]['Code'].toString(),
        name: result[i]['Name'].toString(),
        statusType: result[i]['StatusType'].toString(),
      );
    });
  }

  static Future insertOfferZone(List<OfferZoneData> values, Database db) async {
    var data = values.map((e) => e.toMap()).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert(tableOfferZone, es);
      // log("offerzone...$data");
    });
    await batch.commit();

    // ReceivePort port = new ReceivePort();
    // final isolate = await Isolate.spawn<List<dynamic>>(
    //     indertIsoOfferZone, [port.sendPort, values, db]);
    // isolate.kill(priority: Isolate.immediate);
  }

  static indertIsoOfferZone(
    List<dynamic> value,
  ) async {
    List<OfferZoneData> values = value[1];
    var data = values.map((e) => e.toMap()).toList();
    //   log("ItemMasterDBModel len: " + data.length.toString());
    var batch = value[2].batch();
    data.forEach((es) async {
      batch.insert(tableOfferZone, es);
      // log("OfferZone Batchhhh Item66666..");
    });
    await batch.commit();
  }

  static Future<List<OfferZoneData>> getofferFavData(Database db) async {
    final List<Map<String, Object?>> result =
        await db.rawQuery('''
SELECT *
 FROM $tableOfferZone
''');

    return List.generate(result.length, (i) {
      return OfferZoneData(
          offerId: int.parse(result[i]['OfferID'].toString()),
          itemCode: result[i]['ItemCode'].toString(),
          offerName: result[i]['OfferName'].toString(),
          offerDetails: result[i]['OfferDetails'].toString(),
          item: result[i]['Item'].toString(),
          discoutDetails: result[i]['DiscountDetails'].toString(),
          incentive: result[i]['Incentive'].toString(),
          validTill: result[i]['ValidTill'].toString());
    });
  }

  //Notification

  static Future insertNotification(
      List<NotificationModel> values, Database db) async {
    var data = values.map((e) => e.toMap()).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert(tableNotification, es);
    });
    await batch.commit();
  }

  //   Future insertNotify(NotificationModel values)async{
  //     final Database db = await createDB();
  //     final id = await db.insert(tableNotification, values.toMap());
  //       await db.close();
  // }

  static Future<List<NotificationModel>> getNotification(Database db) async {
    final List<Map<String, Object?>> result =
        await db.rawQuery('''
SELECT * FROM $tableNotification;
''');
    log(result.toList().toString());
    return List.generate(result.length, (i) {
      return NotificationModel(
        id: int.parse(result[i]['NId'].toString()),
        docEntry: int.parse(result[i]['DocEntry'].toString()),
        titile: result[i]['Title'].toString(),
        description: result[i]['Description'].toString(),
        receiveTime: result[i]['ReceiveTime'].toString(),
        seenTime: result[i]['SeenTime'].toString(),
        imgUrl: result[i]['ImgUrl'].toString(),
        naviScn: result[i]['NavigateScreen'].toString(),
      );
    });
  }

  static Future<int?> getUnSeenNotificationCount(Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''
    SELECT count(NId) from $tableNotification where SeenTime = '0';
    ''');
//log(result.toList().toString());
    int? count = Sqflite.firstIntValue(result);
    //  await db.close();
    return count;
  }

  static updateNotify(int id, String time, Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''
      UPDATE $tableNotification
    SET SeenTime = "$time" WHERE NId = $id;
    ''');
  }

  static deleteNotify(int id, Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''
      delete from $tableNotification WHERE DocEntry = $id;
    ''');
    // await db.close();
  }

  static deleteNotifyAll(Database db) async {
    final List<Map<String, Object?>> result =
        await db.rawQuery('''
      delete from $tableNotification;
    ''');
    // await db.close();
  }

  static Future<void> truncateOfferZone(Database db) async {
    await db.rawQuery('delete from $tableOfferZone');
    // await db.close();
  }

  static Future<void> truncateUserList(Database db) async {
    await db.rawQuery('delete from $tableUserList');
    // await db.close();
  }

  static Future<void> truncateLeadstatus(Database db) async {
    await db.rawQuery('delete from $tableLeadStatusReason');
    // await db.close();
  }

  Future<void> truncateNotification(Database db) async {
    await db.rawQuery('delete from $tableNotification');
    //  await db.close();
  }

  //Open Lead

  static Future insertOpenLead(List<OpenLeadData> values, Database db) async {
    var data = values.map((e) => e.toMap()).toList();
    log("openLead len: " + data.length.toString());
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert(tableOpenLead, es);
      log("openLead Batchhhh Item...");
    });
    await batch.commit();
    // await db.close();
  }

  Future<List<Map<String, Object?>>> runQuery(Database db) async {
    final List<Map<String, Object?>> result =
        await db.rawQuery('''
    SELECT * from OpenLeadT;
    ''');
    log(result.toList().toString());
    int? count = Sqflite.firstIntValue(result);
    //  await db.close();
    return result;
  }

  static Future<void> truncateOpenLead(Database db) async {
    await db.rawQuery('delete from $tableOpenLead');
    //  await db.close();
  }

  //

  static Future<List<Map<String, Object?>>> getOpenLFtr(
      String column, Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''
SELECT DISTINCT $column
 FROM $tableOpenLead
WHERE $column IS NOT '';
''');

    log("Saved AllocATE: " + result.toList().toString());
    // log("Saved AllocATE length: " + result.length.toString());
    return result;
    // return List.generate(result.length, (i) {
    //   return OpenLeadData(
    //     FollowupDate: FollowupDate,
    //     LeadDocEntry: LeadDocEntry,
    //     LeadDocNum: LeadDocNum,
    //     FollowupEntry: FollowupEntry,
    //     Phone: Phone,
    //     Customer: Customer,
    //     CreateDate: CreateDate,
    //     LastFollowupDate: LastFollowupDate,
    //     DocTotal: DocTotal,
    //     Quantity: Quantity,
    //     Product: Product,
    //     LastFollowupStatus: LastFollowupStatus,
    //     CustomerInitialIcon: CustomerInitialIcon,
    //     Followup_Due_Type: Followup_Due_Type,
    //     ItemCode: ItemCode, Brand: Brand, GroupProperty: GroupProperty,
    //     GroupSegment: GroupSegment, Division: Division, Branch: Branch,
    //     SalesExecutive: SalesExecutive, BranchManager: BranchManager,
    //     RegionalManager: RegionalManager,
    //     LastFollowup_Feedback: LastFollowup_Feedback
    //     );
    // });
  }

  static Future<List<OpenLeadData>> onFilteredOpenLead(
      String brand,
      String groupProperty,
      String groupSegment,
      String division,
      String branch,
      String salesExecutive,
      String branchManager,
      String regionalManager,
      String isBrand,
      String isgroupProperty,
      String isgroupSegment,
      String isdivision,
      String isBranch,
      String issalesExecutive,
      String isBranchManager,
      String isRegionalManager,
      Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        """
 SELECT * From OpenLeadT A
            Where 

            ('$isBrand' = '' OR A.Brand in ($brand))  AND 
            ('$isgroupProperty' = '' OR A.GroupProperty in ($groupProperty)) AND 
            ('$isgroupSegment' = '' OR A.GroupSegment in ($groupSegment))AND
            ('$isdivision' = '' OR A.Division in ($division))AND
            ('$isBranch' = '' OR A.Branch in ($branch))AND
            ('$issalesExecutive' = '' OR A.SalesExecutive in ($salesExecutive))AND
            ('$isBranchManager' = '' OR A.BranchManager in ($branchManager))AND
            ('$isRegionalManager' = '' OR A.RegionalManager in ($regionalManager))
""");

    String data =
        """
  SELECT * From OpenLeadT A
            Where 
            ('$isBrand' = '' OR A.Brand in ($brand))  AND 
            ('$isgroupProperty' = '' OR A.GroupProperty in ($groupProperty)) AND 
            ('$isgroupSegment' = '' OR A.GroupSegment in ($groupSegment))AND
            ('$isdivision' = '' OR A.Division in ($division))AND
            ('$isBranch' = '' OR A.Branch in ($branch))AND
            ('$issalesExecutive' = '' OR A.SalesExecutive in ($salesExecutive))AND
            ('$isBranchManager' = '' OR A.BranchManager in ($branchManager))AND
            ('$isRegionalManager' = '' OR A.RegionalManager in ($regionalManager))
""";
    log(data.toString());
    log(result.toString());

    return List.generate(result.length, (i) {
      return OpenLeadData(
          FollowupDate: result[i]["FollowupDate"].toString(),
          LeadDocEntry: int.parse(result[i]["LeadDocEntry"].toString()),
          LeadDocNum: int.parse(result[i]["LeadDocNum"].toString()),
          FollowupEntry: int.parse(result[i]["FollowupEntry"].toString()),
          Phone: result[i]["Phone"].toString(),
          Customer: result[i]["Customer"].toString(),
          CreateDate: result[i]["CreateDate"].toString(),
          LastFollowupDate: result[i]["LastFollowupDate"].toString(),
          DocTotal: double.parse(result[i]["DocTotal"].toString()),
          Quantity: result[i]["Quantity"].toString(),
          Product: result[i]["Product"].toString(),
          LastFollowupStatus: result[i]["LastFollowupStatus"].toString(),
          CustomerInitialIcon: result[i]["CustomerInitialIcon"].toString(),
          Followup_Due_Type: result[i]["Followup_Due_Type"].toString(),
          ItemCode: result[i]["ItemCode"].toString(),
          Brand: result[i]["Brand"].toString(),
          GroupProperty: result[i]["GroupProperty"].toString(),
          GroupSegment: result[i]["GroupSegment"].toString(),
          Division: result[i]["Division"].toString(),
          Branch: result[i]["Branch"].toString(),
          SalesExecutive: result[i]["SalesExecutive"].toString(),
          BranchManager: result[i]["BranchManager"].toString(),
          RegionalManager: result[i]["RegionalManager"].toString(),
          LastFollowup_Feedback: result[i]["LastFollowup_Feedback"].toString());
    });
    //return  result;
  }

  static Future<List<OpenLeadData>> onSearchOpenLead(
      String data, Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        """
        SELECT * From OpenLeadT Where ItemCode LIKE '%$data%';
    """);
    log(result.toString());
    return List.generate(result.length, (i) {
      return OpenLeadData(
          FollowupDate: result[i]["FollowupDate"].toString(),
          LeadDocEntry: int.parse(result[i]["LeadDocEntry"].toString()),
          LeadDocNum: int.parse(result[i]["LeadDocNum"].toString()),
          FollowupEntry: int.parse(result[i]["FollowupEntry"].toString()),
          Phone: result[i]["Phone"].toString(),
          Customer: result[i]["Customer"].toString(),
          CreateDate: result[i]["CreateDate"].toString(),
          LastFollowupDate: result[i]["LastFollowupDate"].toString(),
          DocTotal: double.parse(result[i]["DocTotal"].toString()),
          Quantity: result[i]["Quantity"].toString(),
          Product: result[i]["Product"].toString(),
          LastFollowupStatus: result[i]["LastFollowupStatus"].toString(),
          CustomerInitialIcon: result[i]["CustomerInitialIcon"].toString(),
          Followup_Due_Type: result[i]["Followup_Due_Type"].toString(),
          ItemCode: result[i]["ItemCode"].toString(),
          Brand: result[i]["Brand"].toString(),
          GroupProperty: result[i]["GroupProperty"].toString(),
          GroupSegment: result[i]["GroupSegment"].toString(),
          Division: result[i]["Division"].toString(),
          Branch: result[i]["Branch"].toString(),
          SalesExecutive: result[i]["SalesExecutive"].toString(),
          BranchManager: result[i]["BranchManager"].toString(),
          RegionalManager: result[i]["RegionalManager"].toString(),
          LastFollowup_Feedback: result[i]["LastFollowup_Feedback"].toString());
    });
    //return  result;
  }
}
