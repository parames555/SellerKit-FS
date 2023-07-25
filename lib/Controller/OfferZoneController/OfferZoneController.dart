import 'package:flutter/material.dart';
import 'package:sellerkit/DBHelper/DBHelper.dart';
import 'package:sellerkit/Models/OfferZone/OfferZoneModel.dart';
import 'package:sqflite/sqflite.dart';

import '../../DBHelper/DBOperation.dart';

class OfferZoneController extends ChangeNotifier {
  OfferZoneController() {
    offerdbmethod();
  }
  List<OfferZoneData> searchofferzone = [];
  List<OfferZoneData> get getofferzone => searchofferzone;
  String offerZoneexpmsg = '';
  String get getofferZoneexpmsg => offerZoneexpmsg;
  bool offerLoading = true;
  bool get getofferLoading => offerLoading;

  List<OfferZoneData> offerviewAll = [];
  List<OfferZoneData> get getofferviewAll => offerviewAll;

  offerdbmethod() async {
       final Database db = (await DBHelper.getInstance())!;
    searchofferzone = await     DBOperation.getofferFavData(db);
    offerviewAll = searchofferzone;
    print("offerviewAll:${offerviewAll.length}");
    notifyListeners();
  }

  Future<void> refreshData() async {
    offerviewAll.clear();
    searchofferzone.clear();
    offerdbmethod();
  }

  offerfilterList(String v) {
    if (v.isNotEmpty) {
      offerviewAll = searchofferzone
          .where((e) =>
              e.offerDetails!.toLowerCase().contains(v.toLowerCase()) ||
              e.discoutDetails!.toLowerCase().contains(v.toLowerCase()) ||
              e.validTill!.toLowerCase().contains(v.toLowerCase()) ||
              e.incentive!.toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      offerviewAll = searchofferzone;
      notifyListeners();
    }
  }
}
