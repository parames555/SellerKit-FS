// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Models/NewProfileModel/ProfileUpdate1Model.dart';
import 'package:sellerkit/Services/PostQueryApi/ProfileApi/ProfileApi.dart';
import 'package:sellerkit/Services/ProfileImageApi/ProfileUpdate1Api.dart';
import 'package:sellerkit/Services/ProfileImageApi/SaveProfileApi.dart';
import 'package:sellerkit/Services/ProfileImageApi/ProfileUpdate2Api.dart';

import '../../Models/PostQueryModel/ProfileModel.dart/ProfileModel.dart';

class NewProfileController extends ChangeNotifier {
   ProfileApi profileApi = ProfileApi();
  File? imageeFile;
  File? get getimageeFile => imageeFile;

  bool isprogress = false;
  bool get getisprogress => isprogress;

  String? data1;
  String? get getdata => data1;

  String successmsg = '';
  String get getsuccessmsg => successmsg;

  List<ProfileUpdateModel1Data> newProData = [];
  List<ProfileUpdateModel1Data> get getprofileData => newProData;

  String? newprofileexmsg = '';
  String? filePathh;

  Future imagetoBinary(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    imageeFile = File(image.path);
    List<int> imageBytes = imageeFile!.readAsBytesSync();
    String Data = base64Encode(imageBytes);
    data1 = Data;
    notifyListeners();
    callProfileUpdateApi1();
  }

  callProfileUpdateApi1() async {
    isprogress = true;
    notifyListeners();
    await ProfileUpdateApi1.getData().then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.profiledata != null) {
          newProData = value.profiledata!;
          filePathh = newProData[0].attachpath.toString();
        } else if (value.profiledata == null) {
          isprogress = false;
          newprofileexmsg = 'No Data in UP1Image1 Api..!!';
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        newprofileexmsg = 'Something went wrong in UP1Image1 Api..!!';
        isprogress = false;

        print(newprofileexmsg);
      } else if (value.stcode == 500) {
        if (value.exception == 'No route to host') {
          newprofileexmsg = 'Check your Internet Connection...!!';
          isprogress = false;
        } else {
          newprofileexmsg = 'Something went wrong try again...!!';
          isprogress = false;
        }
      }
    });
    await SaveProfileApi.getSaveProfileData(filePathh, data1).then((value) {
      if (value.statuscode >= 200 && value.statuscode <= 210) {
        print("object");
      } else if (value.statuscode >= 400 && value.statuscode <= 410) {
        newprofileexmsg = 'Some thing went wrong in saveimage Api..!!';
        isprogress = false;

        print(newprofileexmsg);
      } else if (value.statuscode == 500) {
        if (value.errormsg == 'No route to host') {
          newprofileexmsg = 'Check your Internet Connection...!!';
          isprogress = false;
        } else {
          newprofileexmsg = 'Something went wrong try again...!!';
          isprogress = false;
        }
      }
    });

    await ProfileUpdateApi2.getProfileUpdate2Data(filePathh!).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.setprofiledata != null) {
          successmsg =
              value.setprofiledata![0].actionResponseMessage.toString();

          print("Set profile msg:$successmsg");
        } else if (value.setprofiledata == null) {
          isprogress = false;
          newprofileexmsg = 'No Data UP2Image Api..!!';
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        newprofileexmsg = 'Some thing went wrong in UP2Image Api..!!';
        isprogress = false;
      } else if (value.stcode == 500) {
        if (value.exception == 'No route to host') {
          newprofileexmsg = 'Check your Internet Connection...!!';
          isprogress = false;
        } else {
          newprofileexmsg = 'Something went wrong try again...!!';
          isprogress = false;
        }
      }
    });

   ProfileModel profileModel = await profileApi.getData(ConstantValues.slpcode);
      if (profileModel.stcode! >= 200 && profileModel.stcode! <= 210) {
        if (profileModel.profileData != null) {
          evictImage(ConstantValues.profilepic!);
          ConstantValues.profilepic = profileModel.profileData![0].ProfilePic!;
          isprogress = false;
          print("ConstantValues.profilepic:${ConstantValues.profilepic}");
          notifyListeners();
        } else if (profileModel.profileData == null) {
          isprogress = false;
          newprofileexmsg = '${profileModel.exception}';
        }
      } else if (profileModel.stcode! >= 400 && profileModel.stcode! <= 410) {
        isprogress = false;
        newprofileexmsg = '${profileModel.exception}';
      } else if (profileModel.stcode == 500) {
        if (profileModel.exception == 'No route to host') {
          newprofileexmsg = 'Check your Internet Connection...!!';
        } else {
          isprogress = false;
          newprofileexmsg = '${profileModel.exception}';
        }
      }
    notifyListeners();
  }

  void evictImage(String url) {
    final NetworkImage provider = NetworkImage(url);
    provider.evict().then<void>((bool success) {
      if (success) debugPrint('removed image!');
    });
  }

  sheetbottom(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Wrap(
            children: [
              Container(
                  height: Screens.padingHeight(context) * 0.13,
                  width: Screens.width(context) * 0.35,
                  child: IconButton(
                    color: theme.primaryColor,
                    onPressed: () {
                      imagetoBinary(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.image,
                      size: 60,
                    ),
                  )),
              Container(
                  height: Screens.padingHeight(context) * 0.13,
                  width: Screens.width(context) * 0.4,
                  child: IconButton(
                    color: theme.primaryColor,
                    onPressed: () {
                      imagetoBinary(ImageSource.camera);
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.add_a_photo,
                      size: 60,
                    ),
                  ))
            ],
          );
        },
      );
    }
  }
}
