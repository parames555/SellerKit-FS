// ignore_for_file: unnecessary_new, prefer_interpolation_to_compose_strings, prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, unused_local_variable, unnecessary_import, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:geocoder/geocoder.dart';
// import 'package:geocoder/model.dart';
// import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';

import '../../Constant/Configuration.dart';
import '../../Constant/SharedPreference.dart';
import '../../Pages/DayStartEnd/Screens/DayEnd.dart';
import '../../Pages/DayStartEnd/Screens/DayStart.dart';
import '../../Pages/SiteIn/Widgets/TestMapPage.dart';
import '../../Pages/VisitPlans/visitplanScreen.dart';
import '../../Services/AddressGetApi/AddressGetApi.dart';
import '../../Widgets/SucessDialagBox.dart';

class DayStartEndController extends ChangeNotifier {
  String? longi;
  String? lati;
  String latitude = '';
  String langitude = '';
  String? url;
//  String? host = await SharedPref.getHostDSP();
  //  await SharedPref.saveHostSP(mycontroller[2].text.trim());

  String? adrress;
  String selectedCust = '';
  String selectedCustCode = '';
  int? selectedClgCode;
  Config config = Config();

  List<File> files = [];
  List<FilesData> filedata = [];

  // File? image;
  bool loadingImage = false;
  clearAll() {
    ima = null;
    files.clear();
    notifyListeners();
  }

  File? ima;
  Future imagetoBinary(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    ima = File(image.path);
    files.add(File(image.path));
    filedata.clear();
    notifyListeners();

    if (files.length <= 3) {
      for (int i = 0; i < files.length; i++) {
        List<int> intdata = files[i].readAsBytesSync();
        filedata.add(FilesData(
            fileBytes: base64Encode(intdata),
            fileName: files[i].path.split('/').last));
        notifyListeners();
      }
      log("filesz lenghthhhhh::::::" + filedata.length.toString());

      // return null;
    } else {
      log("filesz lenghthhhhh::::::" + filedata.length.toString());
      // showtoast();
    }
    log("camera fileslength" + files.length.toString());
    // showtoast();

    notifyListeners();
  }

  String timeString = "";

  void getTime() {
    final String formattedDateTime =
        DateFormat('hh:mm:ss:a').format(DateTime.now()).toString();
    timeString = formattedDateTime;
    notifyListeners();
  }

  checkDayStart() async {
    await SharedPref.saveDayStart("DayStart");
  }

  checkDayEnd() async {
    await SharedPref.saveDayStart("DayEnd");
  }

  void showtoast() {
    Fluttertoast.showToast(
        msg: "More than Four Document Not Allowed..",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14.0);
  }

  Showdialog() async {
    await Get.defaultDialog(
            title: "Success",
            // content: Icon(Icons.thumb_up,color: Colors.green,),
            middleText: "Register Successfully..",
            backgroundColor: Colors.white,
            titleStyle: TextStyle(color: Colors.green),
            middleTextStyle: TextStyle(color: Colors.black),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: Text("Close"),
                    onPressed: () {
                      Get.toNamed(ConstantRoutes.dashboard);
                    },
                  ),
                ],
              ),
            ],
            radius: 5)
        .then((value) {});
    notifyListeners();
  }

  Future<void> determinePosition(BuildContext context) async {
    bool? serviceEnabled;
    latitude = "";
    adrress = "";
    langitude = "";
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

          // if (permission == LocationPermission.deniedForever) {}
          var pos = await Geolocator.getCurrentPosition();
          latitude = pos.latitude.toString();
          langitude = pos.longitude.toString();
          longi = langitude;
          lati = latitude;

          DayStartEndPageState.lati1 = double.parse(latitude);
          DayStartEndPageState.lang2 = double.parse(langitude);
          DayEndPageState.lati1 = double.parse(latitude);
          DayEndPageState.lang2 = double.parse(langitude);

          print('https://www.openstreetmap.org/#map=11/$latitude/$langitude');
          print('longtitude: ' + pos.longitude.toString());
          url = 'https://www.openstreetmap.org/#map=11/$latitude/$langitude';
          MapSampleState.lati1 = double.parse(latitude);
          MapSampleState.lang2 = double.parse(langitude);
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

        DayStartEndPageState.lati1 = double.parse(latitude);
        DayStartEndPageState.lang2 = double.parse(langitude);
        DayEndPageState.lati1 = double.parse(latitude);
        DayEndPageState.lang2 = double.parse(langitude);
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
    // log(DayStartEndPageState.lati1.toString());
    // log(DayStartEndPageState.lang2.toString());
    notifyListeners();
  }

  validateDayStart(BuildContext context) {
    if (files.isNotEmpty) {
      checkDayStart();
      showDialog<dynamic>(
          context: context,
          builder: (_) {
            return SuccessDialogPG(
              heading: 'Response',
              msg: 'Attendance Successfully Registered..!!',
            );
          }).then((value) {
        Get.offAllNamed(ConstantRoutes.dashboard);
      });
    } else {
      showDialog<dynamic>(
          context: context,
          builder: (_) {
            return SuccessDialogPG(
              heading: 'Response',
              msg: 'Please take Photo..!!',
            );
          });
    }
  }

  validateDayEnd(BuildContext context) {
    checkDayEnd();
    showDialog<dynamic>(
        context: context,
        builder: (_) {
          return SuccessDialogPG(
            heading: 'Response',
            msg: 'Attendance Successfully Registered..!!',
          );
        }).then((value) {
      Get.offAllNamed(ConstantRoutes.dashboard);
    });
  }
}

class FilesData {
  String fileBytes;
  String fileName;

  FilesData({required this.fileBytes, required this.fileName});
}

// callApi() async {
//   int initial = 1;
//   String url =
//       "Items?\$select=ItemCode, ItemName,U_Category,U_Brand,U_Division,U_Segment,Properties1,ItemPrices,ItemWarehouseInfoCollection";

//   await HelperFunctions.getDownloadedSharedPreference().then((value) {
//     if (value == true) {
//       // await dbHelper.truncareItemMaster();
//       //  await dbHelper.truncareItemMasterPrice();
//     }
//   });
//   List<ItemMasterDBModel> valuesInserMaster = [];
//   List<ItemMasterPriceDBModel> valuesInsertMasterPrice = [];
//   for (int i = 0; i < initial; i++) {
//     log(url);
//     log("initaial: " + initial.toString());
//     await ItemMasterApi.getData(url).then((value) {
//       if (value.stcode! >= 200 && value.stcode! <= 210) {
//         exception = false;
//         if (value.nextLink != 'null') {
//           print("nexturl: ${value.nextLink}");
//           initial = initial + 1;
//           url = value.nextLink!.replaceAll("/b1s/v1/", "");
//           print("nexturl22: $url");
//           for (int ij = 0; ij < value.itemValueValue!.length; ij++) {
//             valuesInserMaster.add(ItemMasterDBModel(
//                 itemCode: value.itemValueValue![ij].itemCode,
//                 brand: value.itemValueValue![ij].brand!,
//                 division: value.itemValueValue![ij].division!,
//                 category: value.itemValueValue![ij].category!,
//                 itemName: value.itemValueValue![ij].itemName!,
//                 segment: value.itemValueValue![ij].segement!,
//                 isselected: 0,
//                 favorite: value.itemValueValue![ij].properties1!,
//                 mgrPrice: null,
//                 slpPrice: null,
//                 storeStock: null,
//                 whsStock: null

//                 ));
//             for (int ijk = 0;
//                 ijk < value.itemValueValue![ij].itemPrices!.length;
//                 ijk++) {
//               if (value.itemValueValue![ij].itemPrices![ijk].PriceList == 1 ||
//                   value.itemValueValue![ij].itemPrices![ijk].PriceList == 2) {
//                 valuesInsertMasterPrice.add(ItemMasterPriceDBModel(
//                     priceList: value
//                         .itemValueValue![ij].itemPrices![ijk].PriceList
//                         .toString(),
//                     price: value.itemValueValue![ij].itemPrices![ijk].price!,
//                     foriegnKey: (valuesInserMaster.length).toString()));
//               }
//             }//next
//           }

//           log("valuesInserMaster: " + valuesInserMaster.length.toString());
//           log("valuesInsertMasterPrice: " +
//               valuesInsertMasterPrice.length.toString());
//         } else if (value.nextLink == 'null') {
//           //print("no nexturl: ${value.nextLink}");
//           initial = -1;
//         }
//         notifyListeners();
//       } else if (value.stcode! >= 400 && value.stcode! <= 410) {
//         exception = true;
//         errorMsg = '${value.error!.message!.value}';
//         notifyListeners();
//       } else if (value.stcode == 500) {
//         exception = true;
//         errorMsg = '${value.exception}';
//         notifyListeners();
//       }
//     });
//     // print("i: ${i}");
//     // print("initial: ${initial}");
//     if (initial == -1) {
//       await dbHelper.insertItemMaster(valuesInserMaster).then((value) {
//         dbHelper.insertItemMasterPrice(valuesInsertMasterPrice).then((value) {
//           HelperFunctions.saveDonloadednSharedPreference(true).then((value) {
//             Get.offAllNamed(ConstantRoutes.dashboard);
//           });
//         });
//       });
//       break;
//     }
//   }
// }

    //    await HelperFunctions.getDownloadedSharedPreference().then((value) async{
    //   if (value == true) {
    //     log("data cleared");
    //   }
    // });
    // String dataIpadd = (await HelperFunctions.getHostDSP())!;