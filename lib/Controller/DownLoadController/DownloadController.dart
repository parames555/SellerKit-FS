// ignore_for_file: unnecessary_new, prefer_interpolation_to_compose_strings, prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Constant/DataBaseConfig.dart';
import 'package:sellerkit/Models/OfferZone/OfferZoneModel.dart';
import 'package:sellerkit/Services/OfferZoneApi/OfferZoneAPi.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Constant/AppConstant.dart';
import '../../Constant/Configuration.dart';
import '../../Constant/ConstantRoutes.dart';
import '../../Constant/Helper.dart';
import '../../Constant/MenuAuth.dart';
import '../../DBHelper/DBHelper.dart';
import '../../DBHelper/DBOperation.dart';
import '../../DBModel/ItemMasertDBModel.dart';
import '../../Models/MenuAuthModel/MenuAuthModel.dart';
import '../../Models/PostQueryModel/EnquiriesModel/EnqRefferesModel.dart';
import '../../Models/PostQueryModel/EnquiriesModel/EnqTypeModel.dart';
import '../../Models/PostQueryModel/EnquiriesModel/GetUserModel.dart';
import '../../Models/PostQueryModel/ItemMasterModelNew.dart/ItemMasterNewModel.dart';
import '../../Models/PostQueryModel/LeadsCheckListModel/GetLeadStatuModel.dart';
import '../../Models/PostQueryModel/ProfileModel.dart/ProfileModel.dart';
import '../../Services/MenuAuthApi/MenuAuthApi.dart';
import '../../Services/PostQueryApi/EnquiriesApi/GetEnqReffers.dart';
import '../../Services/PostQueryApi/EnquiriesApi/GetEnqType.dart';
import '../../Services/PostQueryApi/EnquiriesApi/GetUserApi.dart';
import '../../Services/PostQueryApi/ItemMasterApi/ItemMasterApiNew.dart';
import '../../Services/PostQueryApi/LeadsApi/GetLeadStatusApi.dart';
import '../../Services/PostQueryApi/ProfileApi/ProfileApi.dart';
import '../../Services/URL/LocalUrl.dart';
import '../../Services/VersionApi/VersionApi.dart';

class DownLoadController extends ChangeNotifier {
  String errorMsg = 'Some thing went wrong';
  bool exception = false;
  bool get getException => exception;
  String get getErrorMsg => errorMsg;
  Config config = new Config();

  // Future<void> createDB() async {
  //   await DBOperation.createDB().then((value) {
  //     print("Value created....!!");
  //   });
  // }

  setURL() async {
    String? getUrl = await HelperFunctions.getHostDSP();
    log("getUrl $getUrl");
    ConstantValues.userNamePM = await HelperFunctions.getUserName();
    Url.queryApi = "http://$getUrl:19979/api/";
  }

  ItemMasterApiNew itemMasterApiNew = ItemMasterApiNew();
  EnquiryTypeApi enquiryTypeApi = EnquiryTypeApi();
  EnquiryRefferesApi enquiryRefferesApi = EnquiryRefferesApi();
  GetUserApi getUserApi = GetUserApi();
  GetLeadStatusApi getLeadStatusApi = GetLeadStatusApi();
  ProfileApi profileApi = ProfileApi();
  OfferZoneApi1 offerZoneApi1 = OfferZoneApi1();
  MenuAuthApi menuAuth = MenuAuthApi();
  callApiNew(BuildContext context) async {
       final Database db = (await DBHelper.getInstance())!;
    DataBaseConfig.ip = (await HelperFunctions.gethostIP())!;
    DataBaseConfig.database = (await HelperFunctions.getuserDB())!;
    DataBaseConfig.password = (await HelperFunctions.getdbPassword())!;
    DataBaseConfig.userId = (await HelperFunctions.getdbUserName())!;

    await DBOperation.truncareItemMaster(db);
    await DBOperation.truncareEnqType(db);
    await DBOperation.truncareEnqReffers(db);
    await DBOperation.truncateUserList(db);
    await DBOperation.truncateLeadstatus(db);
    await DBOperation.truncateOfferZone(db);

    await VersionApi.getData().then((value) async {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.itemdata != null) {
          toLaunch = value.itemdata![0].url;
          content = value.itemdata![0].content;
          if (value.itemdata![0].version == AppConstant.version) {
            callDefaultApi();
          } else {
            updateDialog(context);
          }
          notifyListeners();
        } else if (value.itemdata! == null) {
          exception = true;
          errorMsg = "Something went wrong..!!";
          notifyListeners();
        }
        notifyListeners();
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        exception = true;
        errorMsg = "Something went wrong..!!";
        notifyListeners();
      } else if (value.stcode! == 500) {
        exception = true;
        errorMsg = "Something went wrong..!!";
        notifyListeners();
        notifyListeners();
      }
    });
  }

  callDefaultApi() async {
    List<ItemMasterDBModel> valuesInserMaster = [];

    List<EnquiryTypeData> enqTypeData = [];

    List<EnqRefferesData> enqReffdata = [];

    List<UserListData> userListData = [];

    List<GetLeadStatusData> leadcheckdata = [];

    List<OfferZoneData> offerzone = [];
    ItemMasterNewModal itemMasterData = await itemMasterApiNew.getData();
    if (itemMasterData.stcode! >= 200 && itemMasterData.stcode! <= 210) {
      exception = false;
      if (itemMasterData.itemdata != null) {
        String date = config.currentDate();
        log("Api itemMasterData.itemdata!.length ${itemMasterData.itemdata!.length}");
        for (int ij = 0; ij < itemMasterData.itemdata!.length; ij++) {
          valuesInserMaster.add(ItemMasterDBModel(
              itemCode: itemMasterData.itemdata![ij].itemcode,
              brand: itemMasterData.itemdata![ij].Brand!,
              division: itemMasterData.itemdata![ij].Division!,
              category: itemMasterData.itemdata![ij].Category!,
              itemName: itemMasterData.itemdata![ij].itemName!,
              segment: itemMasterData.itemdata![ij].Segment!,
              isselected: 0,
              favorite: itemMasterData.itemdata![ij].Favorite!,
              mgrPrice: itemMasterData.itemdata![ij].MgrPrice,
              slpPrice: itemMasterData.itemdata![ij].SlpPrice,
              storeStock: itemMasterData.itemdata![ij].StoreStock,
              whsStock: itemMasterData.itemdata![ij].WhsStock,
              refreshedRecordDate: date));
          // dbHelper.insertdocuments(valuesInserMaster[ij]);
        }
      } else if (itemMasterData.itemdata == null) {
        exception = true;
        errorMsg = 'No data found..!!';
        notifyListeners();
      }
      notifyListeners();
    } else if (itemMasterData.stcode! >= 400 && itemMasterData.stcode! <= 410) {
      exception = true;
      errorMsg = '${itemMasterData.exception}';
      notifyListeners();
    } else if (itemMasterData.stcode == 500) {
      exception = true;
      errorMsg = '${itemMasterData.exception}';
      notifyListeners();
    }

    EnquiryTypeModal enquiryTypeModal =
        await enquiryTypeApi.getData(ConstantValues.slpcode);
    if (enquiryTypeModal.stcode! >= 200 && enquiryTypeModal.stcode! <= 210) {
      exception = false;
      if (enquiryTypeModal.itemdata != null) {
        String date = config.currentDate();
        // for (int i = 0; i < values.itemdata!.length; i++) {
        //     enqTypeData.add(EnquiryTypeData(
        //       Code: values.itemdata![i].Code,
        //       Name:  values.itemdata![i].Name));
        // }
        enqTypeData = enquiryTypeModal.itemdata!;
      } else if (enquiryTypeModal.itemdata == null) {
        exception = true;
        errorMsg = 'No data found..!!';
        notifyListeners();
      }
      notifyListeners();
    } else if (enquiryTypeModal.stcode! >= 400 &&
        enquiryTypeModal.stcode! <= 410) {
      exception = true;
      errorMsg = '${enquiryTypeModal.exception}';
      notifyListeners();
    } else if (enquiryTypeModal.stcode == 500) {
      exception = true;
      errorMsg = '${enquiryTypeModal.exception}';
      notifyListeners();
    }

    EnqRefferesModal enqRefferesModal =
        await enquiryRefferesApi.getData(ConstantValues.slpcode);
    if (enqRefferesModal.stcode! >= 200 && enqRefferesModal.stcode! <= 210) {
      exception = false;
      if (enqRefferesModal.enqReffersdata != null) {
        String date = config.currentDate();

        enqReffdata = enqRefferesModal.enqReffersdata!;
      } else if (enqRefferesModal.enqReffersdata == null) {
        exception = true;
        errorMsg = 'No data found..!!';
        notifyListeners();
      }
      notifyListeners();
    } else if (enqRefferesModal.stcode! >= 400 &&
        enqRefferesModal.stcode! <= 410) {
      exception = true;
      errorMsg = '${enqRefferesModal.exception}';
      notifyListeners();
    } else if (enqRefferesModal.stcode == 500) {
      exception = true;
      errorMsg = '${enqRefferesModal.exception}';
      notifyListeners();
    }

    UserListModal userListModal =
        await getUserApi.getData(ConstantValues.slpcode);
    if (userListModal.stcode! >= 200 && userListModal.stcode! <= 210) {
      exception = false;
      if (userListModal.userLtData != null) {
        userListData = userListModal.userLtData!;
      } else if (userListModal.userLtData == null) {
        exception = true;
        errorMsg = 'No data found..!!';
        notifyListeners();
      }
      notifyListeners();
    } else if (userListModal.stcode! >= 400 && userListModal.stcode! <= 410) {
      exception = true;
      errorMsg = '${userListModal.exception}';
      notifyListeners();
    } else if (userListModal.stcode == 500) {
      exception = true;
      errorMsg = '${userListModal.exception}';
      notifyListeners();
    }

    GetLeadStatusModal getLeadStatusModal = await getLeadStatusApi.getData();
    if (getLeadStatusModal.stcode! >= 200 &&
        getLeadStatusModal.stcode! <= 210) {
      exception = false;
      if (getLeadStatusModal.leadcheckdata != null) {
        leadcheckdata = getLeadStatusModal.leadcheckdata!;
      } else if (getLeadStatusModal.leadcheckdata == null) {
        exception = true;
        errorMsg = 'No data found..!!';
        notifyListeners();
      }
      notifyListeners();
    } else if (getLeadStatusModal.stcode! >= 400 &&
        getLeadStatusModal.stcode! <= 410) {
      exception = true;
      errorMsg = '${getLeadStatusModal.exception}';
      notifyListeners();
    } else if (getLeadStatusModal.stcode == 500) {
      exception = true;
      errorMsg = '${getLeadStatusModal.exception}';
      notifyListeners();
    }

    ProfileModel profileModel =
        await profileApi.getData(ConstantValues.slpcode);
    if (profileModel.stcode! >= 200 && profileModel.stcode! <= 210) {
      if (profileModel.profileData != null) {
        exception = false;
        await HelperFunctions.saveFSTNameSharedPreference(
            profileModel.profileData![0].firstName!);
        await HelperFunctions.saveLSTNameSharedPreference(
            profileModel.profileData![0].lastName!);
        await HelperFunctions.saveBranchSharedPreference(
            profileModel.profileData![0].Branch!);
        await HelperFunctions.savemobileSharedPreference(
            profileModel.profileData![0].mobile!);
        await HelperFunctions.saveProfilePicSharedPreference(
            profileModel.profileData![0].ProfilePic!);
        await HelperFunctions.saveUSERIDSharedPreference(
            profileModel.profileData![0].USERID!);
        await HelperFunctions.saveemailSharedPreference(
            profileModel.profileData![0].email!);
        await HelperFunctions.saveManagerPhoneSharedPreference(
            profileModel.profileData![0].managerPhone!);
        await HelperFunctions.getFSTNameSharedPreference().then((value) {
          if (value != null) {
            ConstantValues.firstName = value;
            notifyListeners();
          }
        });
      } else if (profileModel.profileData == null) {
        exception = true;
        errorMsg = '${profileModel.exception}';
      }
    } else if (profileModel.stcode! >= 400 && profileModel.stcode! <= 410) {
      exception = true;
      errorMsg = '${profileModel.exception}';
    } else if (profileModel.stcode == 500) {
      if (profileModel.exception == 'No route to host') {
        errorMsg = 'Check your Internet Connection...!!';
      } else {
        exception = true;
        errorMsg = '${profileModel.exception}';
      }
    }
    notifyListeners();

    OfferZoneModel offerZoneModel = await offerZoneApi1.getOfferZone();
    exception = false;
    if (offerZoneModel.stcode! >= 200 && offerZoneModel.stcode! <= 210) {
      if (offerZoneModel.offerZoneData1 != null) {
        // print("OfferZoneModel");

        for (int ij = 0; ij < offerZoneModel.offerZoneData1!.length; ij++) {
          offerzone = offerZoneModel.offerZoneData1!;
        }
      } else if (offerZoneModel.offerZoneData1 == null) {
        // exception = true;
        // errorMsg = 'No data found..!!';
      }
    } else if (offerZoneModel.stcode! >= 400 && offerZoneModel.stcode! <= 410) {
      // exception = true;
      // errorMsg = '${offerZoneModel.exception}';
    } else if (offerZoneModel.stcode == 500) {
      if (offerZoneModel.exception == 'No route to host') {
        // exception = true;
        // errorMsg = '${offerZoneModel.exception}';
      } else {
        // exception = true;
        // errorMsg = '${offerZoneModel.exception}';
      }
    }
    notifyListeners();

    MenuAuthModel menuAuthModel = await menuAuth.getOfferZone();
    if (menuAuthModel.stcode! >= 200 && menuAuthModel.stcode! <= 210) {
      if (menuAuthModel.menuAuthData != null) {
        setMenuAuth(menuAuthModel);
      } else if (menuAuthModel.menuAuthData == null) {
        exception = true;
        errorMsg = 'No data found..!!';
      }
    } else if (menuAuthModel.stcode! >= 400 && menuAuthModel.stcode! <= 410) {
      exception = true;
      errorMsg = '${menuAuthModel.exception}';
    } else if (menuAuthModel.stcode! == 500) {
      if (menuAuthModel.exception == 'No route to host') {
        exception = true;
        errorMsg = '${menuAuthModel.exception}';
      } else {
        exception = true;
        errorMsg = '${menuAuthModel.exception}';
      }
    }
   final Database db = (await DBHelper.getInstance())!;
    // log("valuesInserMaster: " + valuesInserMaster.length.toString());
    await DBOperation.insertItemMaster(valuesInserMaster,db);
    // log("valuesInserEnq: " + enqTypeData.length.toString());

    await DBOperation.insertEnqType(enqTypeData,db);
    //  log("enqReffersdata: " + enqReffdata.length.toString());
    await DBOperation.insertEnqReffers(enqReffdata,db);
    await DBOperation.insertUserList(userListData,db);
    await DBOperation.insertLeadStatusList(leadcheckdata,db);
    await DBOperation.insertOfferZone(offerzone,db);

    await HelperFunctions.saveDonloadednSharedPreference(true);

    Get.offAllNamed(ConstantRoutes.dashboard);
  }

  String? content;
  Future<void> updateDialog(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return WillPopScope(
              onWillPop: dialogBackBun,
              child: AlertDialog(
                //content:
                title: Text(
                  "Upgrade Information",
                ),
                content: Container(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                           "This app is currently not supported.Please upgrade to enjoy our service."
                            )
                            ])),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        //  Navigator.of(context).pop();
                        // Navigator.of(context).pop(true);
                        exit(0);
                      },
                      child: Text(
                        "No",
                      ),
                      style: TextButton.styleFrom(primary: Colors.red)),
                  TextButton(
                      onPressed: () async {
                        setState(() {
                          _launchInBrowser(toLaunch!);
                        });
                      },
                      child: Text(
                        "Yes",
                      ))
                ],
              ),
            );
          });
        });
  }

  String? toLaunch;
  //"https://drive.google.com/file/d/15zlBCFGgrZLuklr4dlGloltjCPryxEUv/view?usp=sharing";
  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  DateTime? currentBackPressTime;
  Future<bool> dialogBackBun() {
    //if is not work check material app is on the code
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 1)) {
      currentBackPressTime = now;
      return Future.value(false);
    }
    // print("objectqqqqq");
    return Future.value(false);
  }

  Future<int> getDefaultValues() async {
    int i = 0;
    await HelperFunctions.getSapURLSharedPreference().then((value) {
      if (value != null) {
        Url.SLUrl = value;
        // print("url: ${ Url.SLUrl}");
      }
      i = i + 1;
    });
    await HelperFunctions.getSlpCode().then((value) {
      if (value != null) {
        ConstantValues.slpcode = value;
        log("ConstantValues.slpcode : ${ConstantValues.slpcode}");
      }
      i = i + 1;
    });
    await HelperFunctions.getSessionIDSharedPreference().then((value) {
      if (value != null) {
        ConstantValues.sapSessions = value;
        //   print("url: ${ConstantValues.sapSessions}");
      }
      i = i + 1;
    });

    return i;
  }
}

setMenuAuth(MenuAuthModel menuAuthModel) {
  for (int i = 0; i < menuAuthModel.menuAuthData!.length; i++) {
    if (menuAuthModel.menuAuthData![i].MenuName == "ScoreCard") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.ScoreCard = 'Y';
      } else {
        MenuAuthDetail.ScoreCard = 'N';
      }
    }
    if (menuAuthModel.menuAuthData![i].MenuName == "Earnings") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.Earnings = 'Y';
      } else {
        MenuAuthDetail.Earnings = 'N';
      }
    }
    if (menuAuthModel.menuAuthData![i].MenuName == "Performance") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.Performance = 'Y';
      } else {
        MenuAuthDetail.Performance = 'N';
      }
    }
    if (menuAuthModel.menuAuthData![i].MenuName == "Target") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.Target = 'Y';
      } else {
        MenuAuthDetail.Target = 'N';
      }
    }
    if (menuAuthModel.menuAuthData![i].MenuName == "Challenges") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.Challenges = 'Y';
      } else {
        MenuAuthDetail.Challenges = 'N';
      }
    }
    if (menuAuthModel.menuAuthData![i].MenuName == "Stocks") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.Stocks = 'Y';
      } else {
        MenuAuthDetail.Stocks = 'N';
      }
    }
    if (menuAuthModel.menuAuthData![i].MenuName == "PriceList") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.PriceList = 'Y';
      } else {
        MenuAuthDetail.PriceList = 'N';
      }
    }
    if (menuAuthModel.menuAuthData![i].MenuName == "OfferZone") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.OfferZone = 'Y';
      } else {
        MenuAuthDetail.OfferZone = 'N';
      }
    }
    if (menuAuthModel.menuAuthData![i].MenuName == "Enquiries") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.Enquiries = 'Y';
      } else {
        MenuAuthDetail.Enquiries = 'N';
      }
    }
    if (menuAuthModel.menuAuthData![i].MenuName == "Walkins") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.Walkins = 'Y';
      } else {
        MenuAuthDetail.Walkins = 'N';
      }
    }
    if (menuAuthModel.menuAuthData![i].MenuName == "Leads") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.Leads = 'Y';
      } else {
        MenuAuthDetail.Leads = 'N';
      }
    }
    if (menuAuthModel.menuAuthData![i].MenuName == "Orders") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.Orders = 'Y';
      } else {
        MenuAuthDetail.Orders = 'N';
      }
    }
    if (menuAuthModel.menuAuthData![i].MenuName == "Followup") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.Followup = 'Y';
      } else {
        MenuAuthDetail.Followup = 'N';
      }
    }
    if (menuAuthModel.menuAuthData![i].MenuName == "Accounts") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.Accounts = 'Y';
      } else {
        MenuAuthDetail.Accounts = 'N';
      }
    }
    if (menuAuthModel.menuAuthData![i].MenuName == "Profile") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.Profile = 'Y';
      } else {
        MenuAuthDetail.Profile = 'N';
      }
    }
    if (menuAuthModel.menuAuthData![i].MenuName == "Dashboard") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.Dashboard = 'Y';
      } else {
        MenuAuthDetail.Dashboard = 'N';
      }
    }
    if (menuAuthModel.menuAuthData![i].MenuName == "KPI") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.KPI = 'Y';
      } else {
        MenuAuthDetail.KPI = 'N';
      }
    }
    if (menuAuthModel.menuAuthData![i].MenuName == "Feeds") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.Feeds = 'Y';
      } else {
        MenuAuthDetail.Feeds = 'N';
      }
    }
    if (menuAuthModel.menuAuthData![i].MenuName == "NewFeeds") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.NewFeeds = 'Y';
      } else {
        MenuAuthDetail.NewFeeds = 'N';
      }
    }
    if (menuAuthModel.menuAuthData![i].MenuName == "Analytics") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.Analytics = 'Y';
      } else {
        MenuAuthDetail.Analytics = 'N';
      }
    }
  }
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