// ignore_for_file: file_names, prefer_interpolation_to_compose_strings, prefer_conditional_assignment
import 'dart:developer';
import 'dart:isolate';
import 'package:sellerkit/DBModel/DayStartTableModel.dart';
import 'package:sellerkit/Models/PostQueryModel/EnquiriesModel/GetUserModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../DBModel/EnqTypeModel.dart';
import '../DBModel/ItemMasertDBModel.dart';
import '../DBModel/NotificationModel.dart';
import '../DBModel/ScreenShotModel.dart';
import '../DBModel/SiteCheckInTableModel.dart';
import '../Models/OfferZone/OfferZoneModel.dart';
import '../Models/OpenLeadModel.dart/OpenLeadModel.dart';
import '../Models/PostQueryModel/EnquiriesModel/EnqRefferesModel.dart';
import '../Models/PostQueryModel/EnquiriesModel/EnqTypeModel.dart';
import '../Models/PostQueryModel/LeadsCheckListModel/GetLeadStatuModel.dart';

class DBHelper {
  static Database? _db;

  DBHelper._() {}

  static Future<Database?> getInstance() async {
    String path = await getDatabasesPath();
    if (_db == null) {
      _db = await openDatabase(join(path, 'SellerKit2.db'),
          version: 1, onCreate: createTable);
    }
    return _db;
  }

  static void createTable(Database database, int version) async {
    await database.execute(
        '''
           create table $tableItemMaster(
             IMId integer primary key autoincrement,
             ${ItemMasterColumns.itemCode} varchar not null,
             ${ItemMasterColumns.itemName} varchar not null,
             ${ItemMasterColumns.brand} varchar not null,
             ${ItemMasterColumns.segment} varchar not null,
             ${ItemMasterColumns.category} varchar not null,
             ${ItemMasterColumns.division} varchar not null,
             ${ItemMasterColumns.favorite} varchar not null,
             ${ItemMasterColumns.isselected} integer not null,
             ${ItemMasterColumns.mgrPrice} decimal not null,
             ${ItemMasterColumns.slpPrice} decimal not null,
             ${ItemMasterColumns.whsStock} decimal not null,
             ${ItemMasterColumns.storeStock} decimal not null,
             ${ItemMasterColumns.refreshedRecordDate} varchar not null
             )
        ''');
    await database.execute(
        '''
           create table $tableEnqType(
             ETId integer primary key autoincrement,
             ${EnqTypeDBModel.code} integer not null,
             ${EnqTypeDBModel.name} varchar not null
             )
        ''');
    await database.execute(
        '''
           create table $tableEnqReffers(
             ERId integer primary key autoincrement,
             ${EnqReffersDBModel.code} varchar not null,
             ${EnqReffersDBModel.name} varchar not null
             )
        ''');
    await database.execute(
        '''
           create table $tableUserList(
             UId integer primary key autoincrement,
             ${UserListDBModel.userName} varchar not null,
             ${UserListDBModel.salesEmpID} integer not null,
             ${UserListDBModel.color} integer not null
             )
        ''');
    await database.execute(
        '''
           create table $tableLeadStatusReason(
             LRId integer primary key autoincrement,
             ${LeadStatusReason.code} varchar not null,
             ${LeadStatusReason.name} varchar not null,
             ${LeadStatusReason.statusType} varchar not null
             )
        ''');
    await database.execute(
        '''
           create table $tableOfferZone(
             OSZId integer primary key autoincrement,
             ${OfferZoneColumns.offerName} varchar not null,
             ${OfferZoneColumns.offerZoneId} integer not null,
             ${OfferZoneColumns.itemCode} varchar not null,
             ${OfferZoneColumns.offerDetails} varchar not null,
             ${OfferZoneColumns.item} varchar not null,
             ${OfferZoneColumns.discoutDetails} varchar not null,
             ${OfferZoneColumns.incentive} varchar not null,
             ${OfferZoneColumns.validTill} varchar not null
            )
        ''');
    await database.execute(
        '''
           create table $tableNotification(
             NId integer primary key autoincrement,
             ${Notification.docEntry} int not null,
             ${Notification.title} varchar not null,
             ${Notification.imgurl} varchar not null,
             ${Notification.description} varchar not null,
             ${Notification.receiveTime} varchar not null,
             ${Notification.seenTime} varchar not null,
             ${Notification.naviScn} varchar not null
             )
        ''');
    await database.execute(
        '''
           create table $tableOpenLead(
             OPLId integer primary key autoincrement,
             ${OpenLeadColumn.LeadDocEntry} int not null,
             ${OpenLeadColumn.LeadDocNum} int not null,
             ${OpenLeadColumn.FollowupEntry} int not null,
             ${OpenLeadColumn.Branch} varchar not null,
             ${OpenLeadColumn.BranchManager} varchar not null,
             ${OpenLeadColumn.Brand} varchar not null,
             ${OpenLeadColumn.CreateDate} varchar not null,
             ${OpenLeadColumn.Customer} varchar not null,
             ${OpenLeadColumn.CustomerInitialIcon} varchar not null,
             ${OpenLeadColumn.Division} varchar not null,
             ${OpenLeadColumn.DocTotal} numeric not null,
             ${OpenLeadColumn.FollowupDate} varchar not null,
             ${OpenLeadColumn.Followup_Due_Type} varchar not null,
             ${OpenLeadColumn.GroupProperty} varchar not null,
             ${OpenLeadColumn.GroupSegment} varchar not null,
             ${OpenLeadColumn.ItemCode} varchar not null,
             ${OpenLeadColumn.LastFollowupDate} varchar not null,
             ${OpenLeadColumn.LastFollowupStatus} varchar not null,
             ${OpenLeadColumn.LastFollowup_Feedback} varchar not null,
             ${OpenLeadColumn.Phone} varchar not null,
             ${OpenLeadColumn.Product} varchar not null,
             ${OpenLeadColumn.Quantity} varchar not null,
             ${OpenLeadColumn.RegionalManager} varchar not null,
             ${OpenLeadColumn.SalesExecutive} varchar not null
             )
        ''');

    await database.execute(
        '''
           create table $tableScreenShot(
             SId integer primary key autoincrement,
             ${ScreenShotTab.Filepath} varchar not null,
             ${ScreenShotTab.DateTime} varchar not null
             )
        ''');
    await database.execute(
        '''
           create table $tableSiteCheckIn(
        CheckInId integer primary key autoincrement,
        ${SiteCheckInColumns.customer} varchar,
        ${SiteCheckInColumns.mobile} integer,
        ${SiteCheckInColumns.cantactName} varchar,
        ${SiteCheckInColumns.address1} varchar,
        ${SiteCheckInColumns.address2} varchar,
        ${SiteCheckInColumns.area} varchar,
        ${SiteCheckInColumns.city} varchar,
        ${SiteCheckInColumns.pincode} integer,
        ${SiteCheckInColumns.state} varchar,
        ${SiteCheckInColumns.siteType} varchar,
        ${SiteCheckInColumns.date} varchar,
        ${SiteCheckInColumns.time} varchar,
        ${SiteCheckInColumns.datetime} varchar,
         ${SiteCheckInColumns.purpose} varchar
             )
        ''');
    //
    await database.execute(
        '''
           create table $tableDayStart(
        DayStartId integer primary key autoincrement,
        ${DayStartColumns.address} varchar,
        ${DayStartColumns.date} varchar,
        ${DayStartColumns.dayType} varchar,
        ${DayStartColumns.time} varchar
             )
        ''');
  }

  // Future<Database> createDB() async {
  //   String path = await getDatabasesPath();
  //     // print("path: "+path);
  //   return
  // // db =
  //  await
  //    openDatabase(join(path, 'SellerKit2.db'),
  //       onCreate: (database, version) async {
  //     await database.execute('''
  //          create table $tableItemMaster(
  //            IMId integer primary key autoincrement,
  //            ${ItemMasterColumns.itemCode} varchar not null,
  //            ${ItemMasterColumns.itemName} varchar not null,
  //            ${ItemMasterColumns.brand} varchar not null,
  //            ${ItemMasterColumns.segment} varchar not null,
  //            ${ItemMasterColumns.category} varchar not null,
  //            ${ItemMasterColumns.division} varchar not null,
  //            ${ItemMasterColumns.favorite} varchar not null,
  //            ${ItemMasterColumns.isselected} integer not null,
  //            ${ItemMasterColumns.mgrPrice} decimal not null,
  //            ${ItemMasterColumns.slpPrice} decimal not null,
  //            ${ItemMasterColumns.whsStock} decimal not null,
  //            ${ItemMasterColumns.storeStock} decimal not null,
  //            ${ItemMasterColumns.refreshedRecordDate} varchar not null
  //            )
  //       ''');
  //     await database.execute('''
  //          create table $tableEnqType(
  //            ETId integer primary key autoincrement,
  //            ${EnqTypeDBModel.code} integer not null,
  //            ${EnqTypeDBModel.name} varchar not null
  //            )
  //       ''');
  //     await database.execute('''
  //          create table $tableEnqReffers(
  //            ERId integer primary key autoincrement,
  //            ${EnqReffersDBModel.code} varchar not null,
  //            ${EnqReffersDBModel.name} varchar not null
  //            )
  //       ''');
  //     await database.execute('''
  //          create table $tableUserList(
  //            UId integer primary key autoincrement,
  //            ${UserListDBModel.userName} varchar not null,
  //            ${UserListDBModel.salesEmpID} integer not null,
  //            ${UserListDBModel.color} integer not null
  //            )
  //       ''');
  //     await database.execute('''
  //          create table $tableLeadStatusReason(
  //            LRId integer primary key autoincrement,
  //            ${LeadStatusReason.code} varchar not null,
  //            ${LeadStatusReason.name} varchar not null,
  //            ${LeadStatusReason.statusType} varchar not null
  //            )
  //       ''');
  //     await database.execute('''
  //          create table $tableOfferZone(
  //            OSZId integer primary key autoincrement,
  //            ${OfferZoneColumns.offerName} varchar not null,
  //            ${OfferZoneColumns.offerZoneId} integer not null,
  //            ${OfferZoneColumns.itemCode} varchar not null,
  //            ${OfferZoneColumns.offerDetails} varchar not null,
  //            ${OfferZoneColumns.item} varchar not null,
  //            ${OfferZoneColumns.discoutDetails} varchar not null,
  //            ${OfferZoneColumns.incentive} varchar not null,
  //            ${OfferZoneColumns.validTill} varchar not null
  //           )
  //       ''');
  //     await database.execute('''
  //          create table $tableNotification(
  //            NId integer primary key autoincrement,
  //            ${Notification.docEntry} int not null,
  //            ${Notification.title} varchar not null,
  //            ${Notification.imgurl} varchar not null,
  //            ${Notification.description} varchar not null,
  //            ${Notification.receiveTime} varchar not null,
  //            ${Notification.seenTime} varchar not null,
  //            ${Notification.naviScn} varchar not null
  //            )
  //       ''');
  //     await database.execute('''
  //          create table $tableOpenLead(
  //            OPLId integer primary key autoincrement,
  //            ${OpenLeadColumn.LeadDocEntry} int not null,
  //            ${OpenLeadColumn.LeadDocNum} int not null,
  //            ${OpenLeadColumn.FollowupEntry} int not null,
  //            ${OpenLeadColumn.Branch} varchar not null,
  //            ${OpenLeadColumn.BranchManager} varchar not null,
  //            ${OpenLeadColumn.Brand} varchar not null,
  //            ${OpenLeadColumn.CreateDate} varchar not null,
  //            ${OpenLeadColumn.Customer} varchar not null,
  //            ${OpenLeadColumn.CustomerInitialIcon} varchar not null,
  //            ${OpenLeadColumn.Division} varchar not null,
  //            ${OpenLeadColumn.DocTotal} numeric not null,
  //            ${OpenLeadColumn.FollowupDate} varchar not null,
  //            ${OpenLeadColumn.Followup_Due_Type} varchar not null,
  //            ${OpenLeadColumn.GroupProperty} varchar not null,
  //            ${OpenLeadColumn.GroupSegment} varchar not null,
  //            ${OpenLeadColumn.ItemCode} varchar not null,
  //            ${OpenLeadColumn.LastFollowupDate} varchar not null,
  //            ${OpenLeadColumn.LastFollowupStatus} varchar not null,
  //            ${OpenLeadColumn.LastFollowup_Feedback} varchar not null,
  //            ${OpenLeadColumn.Phone} varchar not null,
  //            ${OpenLeadColumn.Product} varchar not null,
  //            ${OpenLeadColumn.Quantity} varchar not null,
  //            ${OpenLeadColumn.RegionalManager} varchar not null,
  //            ${OpenLeadColumn.SalesExecutive} varchar not null
  //            )
  //       ''');
  //   }, version: 1);
  // }

  Future insertItemMaster(List<ItemMasterDBModel> values, Database db) async {
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

  Future insertdocuments(ItemMasterDBModel values, Database db) async {
    final id = await db.insert(tableItemMaster, values.toMap());
    print("result: $id");
  }

  Future<List<ItemMasterDBModel>> getFavData(String fav, Database db) async {
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

  Future<List<ItemMasterDBModel>> onFieldSeleted(
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

  Future<List<ItemMasterDBModel>> getViewAllData(
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

  Future<List<ItemMasterDBModel>> getSearchData(
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
  Future<void> updateItemMaster(
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

  Future<List<ItemMasterDBModel>> getAllProducts(Database db) async {
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

  Future insertEnqType(List<EnquiryTypeData> values, Database db) async {
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

  Future<List<EnquiryTypeData>> getEnqData(Database db) async {
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

  Future<void> truncareItemMaster(Database db) async {
    await db.rawQuery('delete from $tableItemMaster');
  }

  Future<void> truncareEnqType(Database db) async {
    await db.rawQuery('delete from $tableEnqType');
  }

  Future<void> truncareEnqReffers(Database db) async {
    await db.rawQuery('delete from $tableEnqReffers');
  }

  Future insertEnqReffers(List<EnqRefferesData> values, Database db) async {
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

  indertIsoReferral(List<dynamic> value) async {
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

  Future<List<EnqRefferesData>> getEnqRefferes(Database db) async {
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

  Future insertUserList(List<UserListData> values, Database db) async {
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

  indertIsoUserList(List<dynamic> value) async {
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

  Future<List<UserListData>> getUserList(Database db) async {
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

  Future insertLeadStatusList(
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

  indertIsoLeadStatusList(List<dynamic> value) async {
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

  Future<List<GetLeadStatusData>> getLeadStatusOpen(Database db) async {
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

  Future<List<GetLeadStatusData>> getLeadStatusWon(Database db) async {
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

  Future<List<GetLeadStatusData>> getLeadStatusLost(Database db) async {
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

  Future insertOfferZone(List<OfferZoneData> values, Database db) async {
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

  indertIsoOfferZone(
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

  Future<List<OfferZoneData>> getofferFavData(Database db) async {
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

  Future insertNotification(List<NotificationModel> values, Database db) async {
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

  Future<List<NotificationModel>> getNotification(Database db) async {
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

  Future<int?> getUnSeenNotificationCount(Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''
    SELECT count(NId) from $tableNotification where SeenTime = '0';
    ''');
//log(result.toList().toString());
    int? count = Sqflite.firstIntValue(result);
    //  await db.close();
    return count;
  }

  updateNotify(int id, String time, Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''
      UPDATE $tableNotification
    SET SeenTime = "$time" WHERE NId = $id;
    ''');
  }

  deleteNotify(int id, Database db) async {
    final List<Map<String, Object?>> result = await db.rawQuery(
        '''
      delete from $tableNotification WHERE DocEntry = $id;
    ''');
    // await db.close();
  }

  deleteNotifyAll(Database db) async {
    final List<Map<String, Object?>> result =
        await db.rawQuery('''
      delete from $tableNotification;
    ''');
    // await db.close();
  }

  Future<void> truncateOfferZone(Database db) async {
    await db.rawQuery('delete from $tableOfferZone');
    // await db.close();
  }

  Future<void> truncateUserList(Database db) async {
    await db.rawQuery('delete from $tableUserList');
    // await db.close();
  }

  Future<void> truncateLeadstatus(Database db) async {
    await db.rawQuery('delete from $tableLeadStatusReason');
    // await db.close();
  }

  Future<void> truncateNotification(Database db) async {
    await db.rawQuery('delete from $tableNotification');
    //  await db.close();
  }

  //Open Lead

  Future insertOpenLead(List<OpenLeadData> values, Database db) async {
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

  Future<void> truncateOpenLead(Database db) async {
    await db.rawQuery('delete from $tableOpenLead');
    //  await db.close();
  }

  //

  Future<List<Map<String, Object?>>> getOpenLFtr(
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

  Future<List<OpenLeadData>> onFilteredOpenLead(
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

  Future<List<OpenLeadData>> onSearchOpenLead(String data, Database db) async {
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

// A.Brand <> 'null' and coalesce(A.Brand,'') <> '' AND
// A.GroupProperty <> 'null' and coalesce(A.GroupProperty,'') <> '' AND
// A.GroupSegment <> 'null' and coalesce(A.GroupSegment,'') <> '' AND
// A.Division <> 'null' and coalesce(A.Division,'') <> '' AND
// A.Branch <> 'null' and coalesce(A.Branch,'') <> '' AND
// A.SalesExecutive <> 'null' and coalesce(A.SalesExecutive,'') <> '' AND
// A.BranchManager <> 'null' and coalesce(A.BranchManager,'') <> '' AND
// A.RegionalManager <> 'null' and coalesce(A.RegionalManager,'') <> '' AND

//   Future<List<ItemMasterDBModel>> getViewAllCategory() async {
//     final Database db = await createDB();
//     final List<Map<String, Object?>> result = await db.rawQuery('''
// SELECT DISTINCT Category,IsSelected
//  FROM ItemMaster
// WHERE Category IS NOT 'null' AND Category IS NOT '';
// ''');

//     // log("Saved AllocATE: " + result.toList().toString());
//     // log("Saved AllocATE length: " + result.length.toString());

//     return List.generate(result.length, (i) {
//       return ItemMasterDBModel(
//         itemCode: result[i]['ItemCode'].toString(),
//         itemName: result[i]['ItemName'].toString(),
//         brand: result[i]['Brand'].toString(),
//         category: result[i]['Category'].toString(),
//         division: result[i]['Division'].toString(),
//         segment: result[i]['Segment'].toString(),
//         isselected: int.parse(result[i]['IsSelected'].toString()),
//         favorite: result[i]['Properties1'].toString(),
//         mgrPrice: double.parse( result[i]['MgrPrice'].toString()),
//         slpPrice: double.parse( result[i]['SlpPrice'].toString()),
//         storeStock: double.parse( result[i]['StoreStock'].toString()),
//         whsStock: double.parse( result[i]['WhsStock'].toString()),
//       );
//     });
//   }

//   Future<List<ItemMasterDBModel>> getViewAllSegment() async {
//     final Database db = await createDB();
//     final List<Map<String, Object?>> result = await db.rawQuery('''
// SELECT DISTINCT Segment,IsSelected
//  FROM ItemMaster
// WHERE Segment IS NOT 'null' AND Segment IS NOT '';
// ''');

//     // log("Saved AllocATE: " + result.toList().toString());
//     // log("Saved AllocATE length: " + result.length.toString());

//     return List.generate(result.length, (i) {
//       return ItemMasterDBModel(
//         itemCode: result[i]['ItemCode'].toString(),
//         itemName: result[i]['ItemName'].toString(),
//         brand: result[i]['Brand'].toString(),
//         category: result[i]['Category'].toString(),
//         division: result[i]['Division'].toString(),
//         segment: result[i]['Segment'].toString(),
//         isselected: int.parse(result[i]['IsSelected'].toString()),
//          favorite: result[i]['Properties1'].toString(),
//         mgrPrice: double.parse( result[i]['MgrPrice'].toString()),
//         slpPrice: double.parse( result[i]['SlpPrice'].toString()),
//         storeStock: double.parse( result[i]['StoreStock'].toString()),
//         whsStock: double.parse( result[i]['WhsStock'].toString()),
//       );
//     });
//   }

///

//   Future<List<ItemMasterDBModel>> getProduct() async {
//     final Database db = await createDB();
//     final List<Map<String, Object?>> result = await db.rawQuery('''
// SELECT DISTINCT Category,IsSelected,Favorite
//  FROM ItemMaster
// WHERE Category IS NOT '' AND Favorite IS NOT 'N';
// ''');

//     log("Saved AllocATE: "+result.toList().toString());
// log("Saved AllocATE length: "+result.length .toString());

//     return List.generate(result.length, (i) {
//       return ItemMasterDBModel(
//         itemCode: result[i]['ItemCode'].toString(),
//         itemName: result[i]['ItemName'].toString(),
//         brand: result[i]['Brand'].toString(),
//         category: result[i]['Category'].toString(),
//         division: result[i]['Division'].toString(),
//         segment: result[i]['Segment'].toString(),
//         isselected: int.parse(result[i]['IsSelected'].toString()),
//          favorite: result[i]['Properties1'].toString(),
//         mgrPrice: double.parse( result[i]['MgrPrice'].toString()),
//         slpPrice: double.parse( result[i]['SlpPrice'].toString()),
//         storeStock: double.parse( result[i]['StoreStock'].toString()),
//         whsStock: double.parse( result[i]['WhsStock'].toString()),
//       );
//     });
//   }

//   Future<List<ItemMasterDBModel>> getSegment() async {
//     final Database db = await createDB();
//     final List<Map<String, Object?>> result = await db.rawQuery('''
// SELECT DISTINCT Segment,IsSelected,Favorite
//  FROM ItemMaster
// WHERE Segment IS NOT '' AND Favorite IS NOT 'N';
// ''');

// //     log("Saved AllocATE: "+result.toList().toString());
// // log("Saved AllocATE length: "+result.length .toString());

//     return List.generate(result.length, (i) {
//       return ItemMasterDBModel(
//         itemCode: result[i]['ItemCode'].toString(),
//         itemName: result[i]['ItemName'].toString(),
//         brand: result[i]['Brand'].toString(),
//         category: result[i]['Category'].toString(),
//         division: result[i]['Division'].toString(),
//         segment: result[i]['Segment'].toString(),
//         isselected: int.parse(result[i]['IsSelected'].toString()),
//         favorite: result[i]['Properties1'].toString(),
//         mgrPrice: double.parse( result[i]['MgrPrice'].toString()),
//         slpPrice: double.parse( result[i]['SlpPrice'].toString()),
//         storeStock: double.parse( result[i]['StoreStock'].toString()),
//         whsStock: double.parse( result[i]['WhsStock'].toString()),
//       );
//     });
//   }
