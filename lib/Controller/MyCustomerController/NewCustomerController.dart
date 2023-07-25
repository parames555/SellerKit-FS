// ignore_for_file: unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../DBHelper/DBHelper.dart';
import '../../DBHelper/DBOperation.dart';
import '../../Models/PostQueryModel/EnquiriesModel/EnqRefferesModel.dart';
import '../../Widgets/SucessDialagBox.dart';

class NewCustomerContoller extends ChangeNotifier {
  init(BuildContext context) {
    clearAll();
    determinePosition(context);
    getEnqRefferes();
  }

  //bool exception = false;f
  bool billadressbool = false;
  bool shipaddressbool = false;
  bool officeaddress = false;
  bool custInfobool = false;
  bool latilongbool = false;
  bool billingCheckbox = false;
  bool delivAddCheckbox = false;

  // bool spaddressbool = true;
  bool isselect = false;
  String? EnqRefer;
  List<TextEditingController> mycontroller =
      List.generate(20, (i) => TextEditingController());
  List<TextEditingController> mycontroller1 =
      List.generate(20, (i) => TextEditingController());
  List<TextEditingController> mycontroller2 =
      List.generate(15, (i) => TextEditingController());
  List<TextEditingController> mycontroller3 =
      List.generate(15, (i) => TextEditingController());
  ScrollController scrollController = ScrollController();

  List<GlobalKey<FormState>> formkey =
      new List.generate(5, (i) => new GlobalKey<FormState>());
  List<EnqRefferesData> enqReffList = [];
  List<EnqRefferesData> get getenqReffList => enqReffList;
  String isSelectedenquiryReffers = '';
  String get getisSelectedenquiryReffers => isSelectedenquiryReffers;
  getEnqRefferes() async {
    final Database db = (await DBHelper.getInstance())!;
    enqReffList = await DBOperation.getEnqRefferes(db);
    print("payment term lenghth::" + enqReffList.length.toString());
    notifyListeners();
  }

  customerDropDown() {
    custInfobool = !custInfobool;
    notifyListeners();
  }

  billAddCheckboxmethod(bool val) {
    billingCheckbox = val;
    if (val == true) {
      mycontroller2[0].text = mycontroller1[0].text.toString();
      mycontroller2[1].text = mycontroller1[1].text.toString();
      mycontroller2[2].text = mycontroller1[2].text.toString();
      mycontroller2[3].text = mycontroller1[3].text.toString();
      mycontroller2[4].text = mycontroller1[4].text.toString();
      mycontroller2[5].text = mycontroller1[5].text.toString();
      mycontroller2[6].text = mycontroller1[6].text.toString();
    } else {
      mycontroller2[0].text = "";
      mycontroller2[1].text = "";
      mycontroller2[2].text = "";
      mycontroller2[3].text = "";
      mycontroller2[4].text = "";
      mycontroller2[5].text = "";
      mycontroller2[6].text = "";
    }
    notifyListeners();
  }

  clearAll() {
    mycontroller1[0].text = "";
    mycontroller1[1].text = "";
    mycontroller1[2].text = "";
    mycontroller1[3].text = "";
    mycontroller1[4].text = "";
    mycontroller1[5].text = "";
    mycontroller1[6].text = "";
    mycontroller1[7].text = "";
    mycontroller1[8].text = "";
    //
    mycontroller2[0].text = "";
    mycontroller2[1].text = "";
    mycontroller2[2].text = "";
    mycontroller2[3].text = "";
    mycontroller2[4].text = "";
    mycontroller2[5].text = "";
    mycontroller2[6].text = "";
    mycontroller3[0].text = "";
    mycontroller3[1].text = "";
    mycontroller3[2].text = "";
    mycontroller3[3].text = "";
    mycontroller3[4].text = "";
    mycontroller3[5].text = "";
    mycontroller3[6].text = "";
    billadressbool = true;
    shipaddressbool = true;
    officeaddress = true;
    custInfobool = true;
    latilongbool = false;
    billingCheckbox = false;
    delivAddCheckbox = false;
  }

  deliAddCheckboxmethod(bool val) {
    delivAddCheckbox = val;
    if (val == true) {
      mycontroller3[0].text = mycontroller2[0].text.toString();
      mycontroller3[1].text = mycontroller2[1].text.toString();
      mycontroller3[2].text = mycontroller2[2].text.toString();
      mycontroller3[3].text = mycontroller2[3].text.toString();
      mycontroller3[4].text = mycontroller2[4].text.toString();
      mycontroller3[5].text = mycontroller2[5].text.toString();
      mycontroller3[6].text = mycontroller2[6].text.toString();
    } else {
      mycontroller3[0].text = "";
      mycontroller3[1].text = "";
      mycontroller3[2].text = "";
      mycontroller3[3].text = "";
      mycontroller3[4].text = "";
      mycontroller3[5].text = "";
      mycontroller3[6].text = "";
    }
    notifyListeners();
  }

  OfficeDropDown() {
    officeaddress = !officeaddress;
    notifyListeners();
  }

  billingAddDropDown() {
    billadressbool = !billadressbool;
    notifyListeners();
  }

  ShipAddDropDown() {
    shipaddressbool = !shipaddressbool;
    notifyListeners();
  }

  radio(bool val) {
    // latilongbools
    if (val == true) {
      mycontroller1[6].text = latitude.toString();
      mycontroller1[7].text = langitude.toString();
      notifyListeners();
    } else {
      mycontroller1[6].text = "";
      mycontroller1[7].text = "";
      notifyListeners();
    }
  }

  selectEnqReffers(String selected, String refercode) {
    isSelectedenquiryReffers = selected;
    EnqRefer = refercode;
    notifyListeners();
  }

  validate2(BuildContext context) {
    int count = 0;
    int custcount = 0;
    int addcount = 0;

    String? billadd = "";
    String? offadd = "";
    String? shipadd = "";

    billadressbool = false;
    shipaddressbool = false;
    officeaddress = false;
    custInfobool = false;
    if (formkey[0].currentState!.validate()) {
    } else {
      custcount = 1;
      notifyListeners();
    }

    if (formkey[3].currentState!.validate()) {
    } else if (formkey[1].currentState!.validate()) {
    } else if (formkey[2].currentState!.validate()) {
    } else {
      addcount = 1;
      notifyListeners();
    }

    if (custcount == 0 && addcount == 0) {
      //    billadressbool = false;
      // shipaddressbool = false;
      // officeaddress = false;
      // custInfobool = false;
      showDialog<dynamic>(
          context: context,
          builder: (_) {
            return SuccessDialogPG(
              heading: 'Response',
              msg: 'Customer Successfully Registered..!!',
            );
          });
    } else if (custcount != 0 || addcount != 0) {
      showDialog<dynamic>(
          context: context,
          builder: (_) {
            return SuccessDialogPG(
              heading: 'Response',
              msg: 'Please Fill Mandatory fields..!!',
            );
          });
      // formkey[0].currentState!.validate();
      // formkey[1].currentState!.validate();
      // formkey[2].currentState!.validate();
      // formkey[3].currentState!.validate();
    }

    notifyListeners();
  }

  validate(BuildContext context) {
    int count = 0;
    int custcount = 0;
    int addcount = 0;

    String? billadd = "";
    String? offadd = "";
    String? shipadd = "";

    billadressbool = false;
    shipaddressbool = false;
    officeaddress = false;
    custInfobool = false;
    if (formkey[0].currentState!.validate()) {
    } else {
      custcount = 1;
      notifyListeners();
    }

    // if (formkey[1].currentState!.validate() ||
    //     formkey[2].currentState!.validate() ||
    //     formkey[3].currentState!.validate()) {
    if (mycontroller1[0].text.isNotEmpty ||
        mycontroller1[1].text.isNotEmpty ||
        mycontroller1[2].text.isNotEmpty ||
        mycontroller1[3].text.isNotEmpty ||
        mycontroller1[4].text.isNotEmpty ||
        mycontroller1[5].text.isNotEmpty ||
        mycontroller1[6].text.isNotEmpty ||
        mycontroller1[7].text.isNotEmpty ||
        mycontroller1[8].text.isNotEmpty) {
      if (formkey[1].currentState!.validate()) {
      } else {
        count++;
        notifyListeners();
      }
    } else
    //
    if (mycontroller2[0].text.isNotEmpty ||
        mycontroller2[1].text.isNotEmpty ||
        mycontroller2[2].text.isNotEmpty ||
        mycontroller2[3].text.isNotEmpty ||
        mycontroller2[4].text.isNotEmpty ||
        mycontroller2[5].text.isNotEmpty ||
        mycontroller2[6].text.isNotEmpty) {
      if (formkey[2].currentState!.validate()) {
      } else {
        count++;
        notifyListeners();
      }
    } else
    //
    if (mycontroller3[0].text.isNotEmpty ||
        mycontroller3[1].text.isNotEmpty ||
        mycontroller3[2].text.isNotEmpty ||
        mycontroller3[3].text.isNotEmpty ||
        mycontroller3[4].text.isNotEmpty ||
        mycontroller3[5].text.isNotEmpty ||
        mycontroller3[6].text.isNotEmpty) {
      if (formkey[3].currentState!.validate()) {
      } else {
        count++;
        notifyListeners();
      }
    } else {
      addcount = 1;
      formkey[1].currentState!.validate();
      formkey[2].currentState!.validate();
      formkey[3].currentState!.validate();
      notifyListeners();
    }
    if (custcount == 0 && count == 0 && addcount == 0) {
      showDialog<dynamic>(
          context: context,
          builder: (_) {
            return SuccessDialogPG(
              heading: 'Response',
              msg: 'Customer Successfully Registered..!!',
            );
          });
    } else if (custcount != 0 || count != 0 || addcount != 0) {
      showDialog<dynamic>(
          context: context,
          builder: (_) {
            return SuccessDialogPG(
              heading: 'Response',
              msg: 'Please Fill Mandatory fields..!!',
            );
          });
    }
    // else if (custcount != 0) {
    //   showDialog<dynamic>(
    //       context: context,
    //       builder: (_) {
    //         return SuccessDialogPG(
    //           heading: 'Response',
    //           msg: 'Please Fill Customer Info Mandatory fields..!!',
    //         );
    //       });
    // } else if (count != 0) {
    //   showDialog<dynamic>(
    //       context: context,
    //       builder: (_) {
    //         return SuccessDialogPG(
    //           heading: 'Response',
    //           msg: 'Please Fill Address Details..!!',
    //         );
    //       });
    // } else if (addcount == 3 && custcount != 0) {
    //   showDialog<dynamic>(
    //       context: context,
    //       builder: (_) {
    //         return SuccessDialogPG(
    //           heading: 'Response',
    //           msg: 'Please Fill Minimum One Address Details..!!',
    //         );
    //       });
    // }
    // } else {
    //   if (custcount == 0) {
    //     showDialog<dynamic>(
    //         context: context,
    //         builder: (_) {
    //           return SuccessDialogPG(
    //             heading: 'Response',
    //             msg: 'Please Enter Minimum One Address..!!',
    //           );
    //         });
    //   }
    // }
    //else if (mycontroller1.isEmpty &&
    //     mycontroller2.isEmpty &&
    //     mycontroller3.isEmpty) {
    //   showDialog<dynamic>(
    //       context: context,
    //       builder: (_) {
    //         return SuccessDialogPG(
    //           heading: 'Response',
    //           msg: 'Please Enter Addresss..!!',
    //         );
    //       });
    // }
    // formkey[1].currentState!.validate();
    // formkey[2].currentState!.validate();
    // formkey[3].currentState!.validate();
    // formkey[4].currentState!.validate();
    notifyListeners();
  }

  String latitude = '';
  String langitude = '';
  String? url;
  String? longi;
  String? lati;
  Future<void> determinePosition(BuildContext context) async {
    bool? serviceEnabled;
    LocationPermission permission;
    try {
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

          // url = 'https://www.openstreetmap.org/#map=11/$latitude/$langitude';

          var lat = double.parse(latitude);
          var long = double.parse(langitude);
          // await AddressMasterApi.getData(lat.toString(), long.toString())
          //     .then((value) {
          //   log("value.stcode::" + value.stcode.toString());
          //   if (200 >= value.stcode! && 210 <= value.stcode!) {
          //     adrress = value.address2;
          //     log("adress::" + adrress.toString());
          //     notifyListeners();
          //   } else {
          //     print("error:api");
          //   }
          // });
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
        // await AddressMasterApi.getData(lat.toString(), long.toString())
        //     .then((value) {
        //   log("value.stcode::" + value.stcode.toString());
        //   if (value.stcode! >= 200 && value.stcode! <= 210) {
        //     adrress = value.address2;
        //     log("adress::" + adrress.toString());
        //     notifyListeners();
        //   } else {
        //     print("error:api");
        //   }
        // });
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
}
