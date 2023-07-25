// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print, avoid_init_to_null, use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../Constant/Configuration.dart';
import '../../Constant/ConstantRoutes.dart';
import '../../Constant/ConstantSapValues.dart';
import '../../DBHelper/DBHelper.dart';
import '../../DBHelper/DBOperation.dart';
import '../../DBModel/ItemMasertDBModel.dart';
import '../../Models/PostQueryModel/EnquiriesModel/GetUserModel.dart';
import '../../Models/PostQueryModel/LeadsCheckListModel/GetLeadCheckListModel.dart';
import '../../Pages/SiteOut/Widgets/SiteOutCardSuccessBox .dart';
import '../../Services/AddressGetApi/AddressGetApi.dart';
import '../../Services/PostQueryApi/LeadsApi/LeadCheckListApi.dart';
import '../../Widgets/SucessDialagBox.dart';
import '../DayStartEndController/DayStartEndController.dart';
import '../VisitplanController/NewVisitController.dart';

class SiteOutController extends ChangeNotifier {
  Config config = new Config();
  List<TextEditingController> mycontroller =
      List.generate(15, (i) => TextEditingController());
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  List<File> files = [];
  bool? fileValidation = false;
  List<FilesData> filedata = [];
  List<ItemMasterDBModel> category = [];
  List<ItemMasterDBModel> get getcategory => category;
  bool value = false;
  bool assignTo = false;

  void init(BuildContext context) {
    clearAll();
    callLeadCheckApi();
    getUserAssingData();
    getData();
    getDivisionValue();
    // determinePosition(context);
    setValmethod();
  }

  String? customerName;
  int? checkInId;
  validateCheckIn(BuildContext context) async {
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> serailbatchCheck =
        await DBOperation.getValidateCheckIn(db);
    if (serailbatchCheck.isEmpty) {
      showDialog<dynamic>(
          context: context,
          builder: (_) {
            return SuccessDialogPG(
              heading: 'Response',
              msg: 'Please Check-In Customer..!!',
            );
          }).then((value) {
        clearAll();
        Get.offAllNamed(ConstantRoutes.dashboard);
      });
    } else {
      Get.toNamed(ConstantRoutes.siteOut);
    }
    notifyListeners();
  }

  clearAll() {
    mycontroller[2].text = ""; //cantactname
    mycontroller[1].text = ""; //mobile
    mycontroller[9].text = ""; //purposeOfVisit
    mycontroller[7].text = ""; //looking for
    mycontroller[13].text = ""; //Next Visit On
    mycontroller[14].text = ""; //Next Followup Date
    mycontroller[8].text = ""; //Assign To
    mycontroller[3].text = ""; //Location
    files.clear();
    value = false;
  }

  checkboxselect(bool val) {
    value = val;
    notifyListeners();
  }

  checkboxselect2() {
    value = !value;
    notifyListeners();
  }

  checkboxAssignTo(bool val) {
    assignTo = val;
    notifyListeners();
  }

  List<UserListData> userLtData = [];
  List<UserListData> get getuserLtData => userLtData;
  int? selectedIdxFUser = null;
  int? getslpID;

  selectedAssignedUser() {
    mycontroller[8].text = userLtData[selectedIdxFUser!].UserName!;
    notifyListeners();
  }

  getUserAssingData() async {
    final Database db = (await DBHelper.getInstance())!;

    userLtData = await DBOperation.getUserList(db);
    notifyListeners();
  }

  //
  //

  selectUser(int ij) {
    for (int i = 0; i < userLtData.length; i++) {
      if (userLtData[i].SalesEmpID == userLtData[ij].SalesEmpID) {
        userLtData[i].color = 1;
        getslpID = userLtData[ij].SalesEmpID;
        selectedIdxFUser = ij;
      } else {
        userLtData[i].color = 0;
      }
    }
    notifyListeners();
  }

  getDivisionValue() async {
    final Database db = (await DBHelper.getInstance())!;
    category = await DBOperation.getFavData("category", db);
    filterLookingforList = category;
    notifyListeners();
  }

  iscateSeletedPurpose(BuildContext context, String select) {
    mycontroller[9].text = select;
    Navigator.pop(context);
    notifyListeners();
  }

  iscateSeletedLooking(BuildContext context, String select) {
    mycontroller[7].text = select;
    Navigator.pop(context);
    notifyListeners();
  }

  List<purposeofVisitData> purposeofVisitList = [];

  List<purposeofVisitData> filterpurposeofVisitList = [];
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

  List<ItemMasterDBModel> filterLookingforList = [];
  filterListLookingFor(String v) {
    if (v.isNotEmpty) {
      filterLookingforList = category
          .where((e) => e.category.toLowerCase().contains(v.toLowerCase())
              // ||
              // e.name!.toLowerCase().contains(v.toLowerCase())
              )
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterLookingforList = category;
      notifyListeners();
    }
  }

  setValmethod() {
    // mycontroller[2].text = "Anbu Raj"; //cantactname
    // mycontroller[1].text = "9876543210"; //mobile
    // mycontroller[9].text = "Routine Visit"; //purposeOfVisit
    // mycontroller[2].text = "";
  }

  validateCheckOut(BuildContext context) async {
    final Database db = (await DBHelper.getInstance())!;

    if (formkey.currentState!.validate()) {
      await DBOperation.changeCheckIntoCheckOut(db, checkInId!);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SiteOutSuccessCard(),
          ));
    }
  }

  String? latitude;
  String? langitude;
  String? adrress;
  Future<void> determinePosition(BuildContext context) async {
    adrress = "";
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

          // if (permission == LocationPermission.deniedForever) {}
          var pos = await Geolocator.getCurrentPosition();
          latitude = pos.latitude.toString();
          langitude = pos.longitude.toString();
          print("Heading:::" + pos.heading.toString());
          // longi = langitude;
          // lati = latitude;

          // print('https://www.openstreetmap.org/#map=11/$latitude/$langitude');
          // print('longtitude: ' + pos.longitude.toString());
          // url = 'https://www.openstreetmap.org/#map=11/$latitude/$langitude';
          // MapSampleState.lati1 = double.parse(latitude);
          // MapSampleState.lang2 = double.parse(langitude);
          var lat = double.parse(latitude!);
          var long = double.parse(langitude!);
          await AddressMasterApi.getData(lat.toString(), long.toString())
              .then((value) {
            log("value.stcode::" + value.stcode.toString());
            if (200 >= value.stcode! && 210 <= value.stcode!) {
              adrress = value.address2;
              mycontroller[3].text = adrress.toString();
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
        // print("Heading:::"+pos.toString());

        // longi = langitude;
        // lati = latitude;

        // url = 'https://www.openstreetmap.org/#map=11/$latitude/$langitude';

        var lat = double.parse(latitude!);
        var long = double.parse(langitude!);
        await AddressMasterApi.getData(lat.toString(), long.toString())
            .then((value) {
          log("value.stcode::" + value.stcode.toString());
          if (value.stcode! >= 200 && value.stcode! <= 210) {
            adrress = value.address2;
            mycontroller[3].text = adrress.toString();
            log("adress::" + adrress.toString());
            notifyListeners();
          } else {
            print("error:api");
          }
        });

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

  getData() async {
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> serailbatchCheck =
        await DBOperation.getValidateCheckIn(db);
    if (serailbatchCheck.isNotEmpty) {
      checkInId = int.parse(serailbatchCheck[0]["CheckInId"].toString());
      customerName = serailbatchCheck[0]["Customer"].toString();
      mycontroller[2].text =
          serailbatchCheck[0]["CantactName"].toString(); //cantactname
      mycontroller[1].text = serailbatchCheck[0]["Mobile"].toString(); //mobile
      mycontroller[9].text =
          serailbatchCheck[0]["Purpose"].toString(); //purpose
      mycontroller[3].text =
          "${serailbatchCheck[0]["Area"].toString()},${serailbatchCheck[0]["City"].toString()}";
    }
    purposeofVisitList = [
      purposeofVisitData(purpose: "Courtesy Visit"),
      purposeofVisitData(purpose: "Enquiry Visit"),
      purposeofVisitData(purpose: "Routine Visit"),
      purposeofVisitData(purpose: "Collection"),
      purposeofVisitData(purpose: "Customer Appointment"),
      purposeofVisitData(purpose: "New Demo"),
      purposeofVisitData(purpose: "Complaint Call Visit")
    ];
    filterpurposeofVisitList = purposeofVisitList;
  }

  Future imagetoBinary(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
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

  FilePickerResult? result;

  selectattachment() async {
    log(files.length.toString());

    result = await FilePicker.platform.pickFiles(allowMultiple: true);
    notifyListeners();

    if (result != null) {
      filedata.clear();

      List<File> filesz = result!.paths.map((path) => File(path!)).toList();

      if (filesz.length != 0) {
        for (int i = 0; i < filesz.length; i++) {
          // createAString();

          if (files.length <= 4) {
            // showtoast();
            files.add(filesz[i]);
            // log("Files Lenght :::::" + files.length.toString());
            List<int> intdata = filesz[i].readAsBytesSync();
            filedata.add(FilesData(
                fileBytes: base64Encode(intdata),
                fileName: filesz[i].path.split('/').last));
            notifyListeners();

            // return null;
          } else {
            // showtoast();
          }
        }
      }
      notifyListeners();
    }
    notifyListeners();
  }

  void showtoast() {
    Fluttertoast.showToast(
        msg: "More than Five Document Not Allowed..",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14.0);
  }

  String apiFDate = '';
  void showNextVisitOn(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    ).then((value) {
      if (value == null) {
        return;
      }
      String chooseddate = value.toString();
      var date = DateTime.parse(chooseddate);
      chooseddate = "";
      chooseddate =
          "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
      apiFDate =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      print(apiFDate);

      mycontroller[13].text = chooseddate;
      notifyListeners();
    });
  }

//  String apiFDate = '';
  void showNextFollowupDate(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    ).then((value) {
      if (value == null) {
        return;
      }
      String chooseddate = value.toString();
      var date = DateTime.parse(chooseddate);
      chooseddate = "";
      chooseddate =
          "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
      apiFDate =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      print(apiFDate);

      mycontroller[14].text = chooseddate;
      notifyListeners();
    });
  }

  //lead check list Api
  List<LeadCheckData> leadcheckdatas = [];
  List<LeadCheckData> get getleadcheckdatas => leadcheckdatas;
  String LeadCheckDataExcep = '';
  String get getLeadCheckDataExcep => LeadCheckDataExcep;

  callLeadCheckApi() {
    GetLeadCheckListApi.getData('${ConstantValues.slpcode}').then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.leadcheckdata != null) {
          leadcheckdatas = value.leadcheckdata!;
        } else if (value.leadcheckdata == null) {
          LeadCheckDataExcep = 'Lead check data not found..!!';
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        LeadCheckDataExcep = 'Some thing went wrong..!!';
      } else if (value.stcode == 500) {
        LeadCheckDataExcep = 'Some thing went wrong..!!';
      }
    });
    notifyListeners();
  }

  LeadcheckListClicked(bool? v, int i) {
    leadcheckdatas[i].ischecked = v;
    notifyListeners();
  }

  resetListSelection() {
    for (int i = 0; i < leadcheckdatas.length; i++) {
      leadcheckdatas[i].ischecked = false;
    }
  }
}
