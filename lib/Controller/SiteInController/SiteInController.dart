// ignore_for_file: unused_local_variable, use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/DBHelper/DBOperation.dart';
import 'package:sellerkit/Pages/Settings/Screen/Settings.dart';
import 'package:sqflite/sqflite.dart';

import '../../Constant/Configuration.dart';
import '../../DBHelper/DBHelper.dart';
import '../../DBModel/SiteCheckInTableModel.dart';
import '../../Models/VisitPlanModel/VisitPlanModel.dart';
import '../../Pages/SiteIn/Widgets/SiteInCardSuccessBox .dart';
import '../../Services/AddressGetApi/AddressGetApi.dart';
import '../../Widgets/SucessDialagBox.dart';
import '../VisitplanController/NewVisitController.dart';

class SiteInController extends ChangeNotifier {
  List<purposeofVisitData> purposeofVisitList = [];
  List<purposeofVisitData> filterpurposeofVisitList = [];
  List<VisitPlanData> openVisitData = [];
  List<VisitPlanData> get getopenVisitData => openVisitData;
  List<VisitPlanData> visitLists = [];

  Config config = new Config();
  List<TextEditingController> mycontroller =
      List.generate(15, (i) => TextEditingController());
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  void init() {
    // clearAll();
    getData();
    spilitData();
  }

  validateCheckIn(BuildContext context) async {
    final Database db = (await DBHelper.getInstance())!;
    String customerName;
    List<Map<String, Object?>> serailbatchCheck =
        await DBOperation.getValidateCheckIn(db);
    if (serailbatchCheck.isNotEmpty) {
      customerName = serailbatchCheck[0]["Customer"].toString();
      showDialog<dynamic>(
          context: context,
          builder: (_) {
            return SuccessDialogPG(
              heading: 'Response',
              msg: 'Please Check-Out ${customerName}..!!',
            );
          }).then((value) {
        Get.offAllNamed(ConstantRoutes.dashboard);
      });
    }
  }

  clearAll() {
    purposeofVisitList.clear();
    filterpurposeofVisitList.clear();
    openVisitData.clear();
    visitLists.clear();
    mycontroller[0].text = "";
    mycontroller[1].text = "";
    mycontroller[2].text = "";
    mycontroller[3].text = "";
    mycontroller[4].text = "";
    mycontroller[5].text = "";
    mycontroller[6].text = "";
    mycontroller[7].text = "";
    mycontroller[8].text = "";
    mycontroller[9].text = "";
    notifyListeners();
  }

  clearText() {
    mycontroller[0].text = ""; //customer
    mycontroller[1].text = ""; //MobileNo
    mycontroller[2].text = ""; //contactname
    mycontroller[3].text = ""; //address1
    mycontroller[4].text = ""; //adrsss2
    mycontroller[5].text = ""; //area
    mycontroller[6].text = ""; //city
    mycontroller[7].text = ""; //pincode
    mycontroller[8].text = ""; //state
    mycontroller[9].text = ""; //pupose
    notifyListeners();
  }

  // List<SiteCheckInDBModel> siteCheckInData = [];
  validateSchedule(BuildContext context) async {
    final Database db = (await DBHelper.getInstance())!;

    if (formkey.currentState!.validate()) {
      List<SiteCheckInDBModel> siteCheckIn = [];
      siteCheckIn.add(SiteCheckInDBModel(
          customer: mycontroller[0].text.toString(),
          mobile: int.parse(mycontroller[1].text.toString()),
          cantactName: mycontroller[2].text.toString(),
          address1: mycontroller[3].text.toString(),
          address2: mycontroller[4].text.toString(),
          area: mycontroller[5].text.toString(),
          city: mycontroller[6].text.toString(),
          pincode: int.parse(mycontroller[7].text.toString()),
          siteType: "CheckIn",
          date: config.currentDateOnly2(),
          time: config.currentTimeOnly2(),
          datetime: config.currentDate(),
          purpose: mycontroller[9].text.toString(), //pupose,
          state: mycontroller[8].text.toString()));
      await DBOperation.insertSiteCheckIn(db, siteCheckIn);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SiteInSuccessCard(),
          ));
      //
      // showDialog<dynamic>(
      //     context: context,
      //     builder: (_) {
      //       return SuccessDialogPG(
      //         heading: 'Response',
      //         msg: 'Site Check-In Created Successfully..!!',
      //       );
      //     }).then((value) {
      //   Get.offAllNamed(ConstantRoutes.sitein);
      // });
    }
  }

  spilitData() {
    openVisitData.clear();
    for (int i = 0; i < visitLists.length; i++) {
      if (visitLists[i].type == "Open") {
        openVisitData.add(VisitPlanData(
          customer: visitLists[i].customer,
          datetime: visitLists[i].datetime,
          purpose: visitLists[i].purpose,
          area: visitLists[i].area,
          product: visitLists[i].product,
          type: visitLists[i].type,
          Mobile: visitLists[i].Mobile,
          CantactName: visitLists[i].CantactName,
          U_Address1: visitLists[i].U_Address1,
          U_Address2: visitLists[i].U_Address2,
          U_City: visitLists[i].U_City,
          U_Pincode: visitLists[i].U_Pincode,
          U_State: visitLists[i].U_State,
        ));
      }
    }
  }

  selectedOpenVisits(VisitPlanData? openVisitData) {
    mycontroller[0].text = openVisitData!.customer.toString();
    mycontroller[1].text = openVisitData.Mobile.toString();
    mycontroller[2].text = openVisitData.CantactName.toString();
    mycontroller[3].text = openVisitData.U_Address1.toString();
    mycontroller[4].text = openVisitData.U_Address2.toString();
    mycontroller[5].text = openVisitData.area.toString();
    mycontroller[6].text = openVisitData.U_City.toString();
    mycontroller[7].text = openVisitData.U_Pincode.toString();
    mycontroller[8].text = openVisitData.U_State.toString();
    mycontroller[9].text = openVisitData.purpose.toString();
    notifyListeners();
  }

  getData() {
    visitLists.clear();
    purposeofVisitList = [
      purposeofVisitData(purpose: "Courtesy Visit"),
      purposeofVisitData(purpose: "Enquiry Visit"),
      purposeofVisitData(purpose: "Routine Visit"),
      purposeofVisitData(purpose: "Collection"),
      purposeofVisitData(purpose: "Customer Appointment"),
      purposeofVisitData(purpose: "New Demo"),
      purposeofVisitData(purpose: "Complaint Call Visit")
    ];
    visitLists = [
      VisitPlanData(
        customer: "Raja",
        datetime: "21-Jul-2023 2:11PM",
        purpose: "Courtesy Visit",
        area: "Saibaba Colony Coimbatore",
        product: "Looking For Table/Chair",
        type: "Open",
        Mobile: "1234567890",
        CantactName: "Arun",
        U_Address1: "104 West Street ,",
        U_Address2: "Srirangam,Trichy",
        U_City: "Trichy",
        U_Pincode: "6200005",
        U_State: "Tamil Nadu",
      ),
      VisitPlanData(
        customer: "Raja",
        datetime: "24-Jun-2023 4:23PM",
        purpose: "Enquiry Visit",
        area: "Saibaba Colony ",
        product: "Looking For Table/Chair",
        type: "Closed",
        Mobile: "9876543210",
        CantactName: "Raja",
        U_Address1: "124 KK Nagar Street ,",
        U_Address2: "Karur main Road,Karur",
        U_City: "Somur",
        U_Pincode: "6200024",
        U_State: "Tamil Nadu",
      ),
      VisitPlanData(
        customer: "Raja",
        datetime: "21-May-2023-4:23PM",
        purpose: "Customer Appointment",
        area: "Saibaba Colony Coimbatore",
        product: "Looking For Table/Chair",
        type: "Missed",
        Mobile: "9876543210",
        CantactName: "Raja",
        U_Address1: "124 KK Nagar Street ,",
        U_Address2: "Karur main Road,Karur",
        U_City: "Somur",
        U_Pincode: "6200024",
        U_State: "Tamil Nadu",
      )
    ];
    filterpurposeofVisitList = purposeofVisitList;

    notifyListeners();
  }

  filterListPurposeOfVisit(String v) {
    if (v.isNotEmpty) {
      filterpurposeofVisitList = purposeofVisitList
          .where((e) => e.purpose.toLowerCase().contains(v.toLowerCase())
              // ||
              // e.name!.toLowerCase().contains(v.toLowerCase())
              )
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterpurposeofVisitList = purposeofVisitList;
      notifyListeners();
    }
  }

  iscateSeleted(BuildContext context, String select) {
    mycontroller[9].text = select;
    Navigator.pop(context);
    notifyListeners();
  }

  String? longi;
  String? lati;
  String latitude = '';
  String langitude = '';
  String? url;
  String? adrress;

  Future<void> determinePosition(BuildContext context) async {
    bool? serviceEnabled;
    LocationPermission permission;
    try {
      LocationPermission permission;
      permission = await Geolocator.requestPermission();
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (serviceEnabled == false) {
        try {
          await Geolocator.getCurrentPosition();
          permission = await Geolocator.checkPermission();
          if (permission == LocationPermission.denied) {
            permission = await Geolocator.requestPermission();
            if (permission == LocationPermission.denied) {
              //return Future.error('Location permissions are denied');
            }
          }

          if (permission == LocationPermission.deniedForever) {}
          var pos = await Geolocator.getCurrentPosition();
          print('lattitude: ' + pos.latitude.toString());
          latitude = pos.latitude.toString();
          langitude = pos.longitude.toString();
          longi = langitude;
          lati = latitude;

          url = 'https://www.openstreetmap.org/#map=11/$latitude/$langitude';

          var lat = double.parse(latitude);
          var long = double.parse(langitude);
          await AddressMasterApi.getData(lat.toString(), long.toString())
              .then((value) {
            log("value.stcode::" + value.stcode.toString());
            if (200 >= value.stcode! && 210 <= value.stcode!) {
              adrress = value.address2;
              log("adress::" + adrress.toString());
              notifyListeners();
            } else {
              print("error:api");
            }
          });
          // var placemarks =
          //     await placemarkFromCoordinates(lat, long);

          // adrress = placemarks[0].street.toString() +
          //       ' ' +
          //       placemarks[0].thoroughfare.toString() +
          //       ' ' +
          //       placemarks[0].locality.toString();
          //    final coordinates = new Coordinates(lat, long);
          // var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
          // var first = addresses.first;
          // print("AAAAAAAAAAAAA:::${first.featureName} : ${first.addressLine}");
          // adrress=first.addressLine;
          notifyListeners();
        } catch (e) {
          const snackBar = SnackBar(
              duration: Duration(seconds: 1),
              backgroundColor: Colors.red,
              content: Text('Please turn on the Location!!..'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Future.delayed(
            const Duration(seconds: 2),
            () => Get.back<dynamic>(),
          );
        }
        notifyListeners();
      } else if (serviceEnabled == true) {
        var pos = await Geolocator.getCurrentPosition();
        print('lattitude: ' + pos.latitude.toString());
        latitude = pos.latitude.toString();
        langitude = pos.longitude.toString();
        longi = langitude;
        lati = latitude;

        url = 'https://www.openstreetmap.org/#map=11/$latitude/$langitude';

        var lat = double.parse(latitude);
        var long = double.parse(langitude);
        await AddressMasterApi.getData(lat.toString(), long.toString())
            .then((value) {
          log("value.stcode::" + value.stcode.toString());
          if (value.stcode! >= 200 && value.stcode! <= 210) {
            adrress = value.address2;
            log("adress::" + adrress.toString());
            notifyListeners();
          } else {
            print("error:api");
          }
        });
        // var placemarks = await placemarkFromCoordinates(lat, long);
        //   adrress = placemarks[0].street.toString() +
        //       ' ' +
        //       placemarks[0].thoroughfare.toString() +
        //       ' ' +
        //       placemarks[0].locality.toString();
        //  final coordinates = new Coordinates(lat, long);
        // var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
        // var first = addresses.first;
        //         adrress=first.addressLine;

        // print("${first.featureName} : ${first.addressLine}");
        notifyListeners();
      }
      notifyListeners();
    } catch (e) {
      final snackBar =
          SnackBar(backgroundColor: Colors.red, content: Text('$e'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // Future.delayed(
      //     const Duration(seconds: 2),
      //     () => Get.back<dynamic>(),
      //   );
    }
    notifyListeners();
  }

  File? source1;
  Directory? copyTo;
  Future<File> getPathOFDB() async {
    final dbFolder = await getDatabasesPath();
    File source1 = File('$dbFolder/PosDBV2.db');
    return Future.value(source1);
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

  Future<Directory> getDirectory() async {
    Directory copyTo = Directory("storage/emulated/0/Sellerkit-FS Backup");
    return Future.value(copyTo);
  }

  Future<String> createDirectory() async {
    try {
      await copyTo!.create();
      String newPath = copyTo!.path;
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
      String getPath = "$path/SellerkitDBV2.db";
      print(getPath);
      await source1!.copy(getPath);
      showSnackBars("Created!!...", Colors.green);
    } catch (e) {
      showSnackBars("$e", Colors.red);
    }
  }

  showSnackBars(String e, Color color) {
    print(e);
    Get.showSnackbar(GetSnackBar(
      duration: Duration(seconds: 3),
      title: "Warning..",
      message: e,
      backgroundColor: Colors.green,
    ));
  }
}

class NewSitin {
  String? customer;
  String? mobileNo;

  String? contactName;

  String? address1;

  String? address2;

  String? area;

  String? city;
}
