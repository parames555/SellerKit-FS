// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sellerkit/Pages/Settlement/Widgets/DDSavePop.dart';
import 'package:sellerkit/Pages/Settlement/Widgets/UPISavePop.dart';

import '../../Constant/ConstantRoutes.dart';
import '../../Pages/Settlement/Widgets/CardSavePop.dart';
import '../../Pages/Settlement/Widgets/CashSavePop.dart';
import '../../Pages/Settlement/Widgets/ChequeSavePop.dart';
import '../../Widgets/SucessDialagBox.dart';

class SettlementController extends ChangeNotifier {
  void init() {
    getData();
    SplitMethod();
  }

  List<SettlementList> settlementList = [];
  List<SettlementList> cashList = [];
  List<SettlementList> cardList = [];
  List<SettlementList> chequeList = [];
  List<SettlementList> ddtList = [];
  List<SettlementList> upiList = [];

  String? settleTocash;
  String? settleTocard;
  String? settleTochque;
  String? settleToUpi;
  String? settleToDD;

  // bool? isselect = false;

  chooseSettleToCash(String? val) {
    settleTocash = val;
    notifyListeners();
  }

  chooseSettleToCard(String? val) {
    settleTocard = val;
    notifyListeners();
  }

  chooseSettleToCheuqe(String? val) {
    settleTochque = val;
    notifyListeners();
  }

  chooseSettleToUPI(String? val) {
    settleToUpi = val;
    notifyListeners();
  }

  chooseSettleToDD(String? val) {
    settleToDD = val;
    notifyListeners();
  }

  //  showDialog<dynamic>(
  //         context: context,
  //         builder: (_) {
  //           return SuccessDialogPG(
  //             heading: 'Response',
  //             msg: 'Customer Successfully Registered..!!',
  //           );
  //         });
  validateMethod(BuildContext context) {
    double val = 0.00;
    for (int i = 0; i < cashList.length; i++) {
      if (cashList[i].isselect == true) {
        val = val + cashList[i].typeAmount!;
      }
    }

    if (val == 0) {
      showDialog<dynamic>(
          context: context,
          builder: (_) {
            return SuccessDialogPG(
              heading: 'Response',
              msg: 'Please Choose Customer..!!',
            );
          });
    } else {
      showDialog<dynamic>(
          context: context,
          builder: (_) {
            // context.read<EnquiryUserContoller>(). showSpecificDialog();
            //   context.read<EnquiryUserContoller>().showSuccessDia();
            return CashAlertBox(
            );
          });
    }
  }
  validateMethodcard(BuildContext context) {
    double val = 0.00;
    for (int i = 0; i < cardList.length; i++) {
      if (cardList[i].isselect == true) {
        val = val + cardList[i].typeAmount!;
      }
    }

    if (val == 0) {
      showDialog<dynamic>(
          context: context,
          builder: (_) {
            return SuccessDialogPG(
              heading: 'Response',
              msg: 'Please Choose Customer..!!',
            );
          });
    } else {
      showDialog<dynamic>(
          context: context,
          builder: (_) {
            // context.read<EnquiryUserContoller>(). showSpecificDialog();
            //   context.read<EnquiryUserContoller>().showSuccessDia();
            return CardAlertBox(
              indx: 1,
            );
          });
    }
  }
   validateMethodcheque(BuildContext context) {
    double val = 0.00;
    for (int i = 0; i < chequeList.length; i++) {
      if (chequeList[i].isselect == true) {
        val = val + cardList[i].typeAmount!;
      }
    }

    if (val == 0) {
      showDialog<dynamic>(
          context: context,
          builder: (_) {
            return SuccessDialogPG(
              heading: 'Response',
              msg: 'Please Choose Customer..!!',
            );
          });
    } else {
      showDialog<dynamic>(
          context: context,
          builder: (_) {
            // context.read<EnquiryUserContoller>(). showSpecificDialog();
            //   context.read<EnquiryUserContoller>().showSuccessDia();
            return ChequeAlertBox(
              indx: 1,
            );
          });
    }
  }
 validateMethodUpi(BuildContext context) {
    double val = 0.00;
    for (int i = 0; i < upiList.length; i++) {
      if (upiList[i].isselect == true) {
        val = val + upiList[i].typeAmount!;
      }
    }

    if (val == 0) {
      showDialog<dynamic>(
          context: context,
          builder: (_) {
            return SuccessDialogPG(
              heading: 'Response',
              msg: 'Please Choose Customer..!!',
            );
          });
    } else {
      showDialog<dynamic>(
          context: context,
          builder: (_) {
            // context.read<EnquiryUserContoller>(). showSpecificDialog();
            //   context.read<EnquiryUserContoller>().showSuccessDia();
            return UPIAlertBox(
              indx: 1,
            );
          });
    }
  }
   validateMethodDD(BuildContext context) {
    double val = 0.00;
    for (int i = 0; i < ddtList.length; i++) {
      if (ddtList[i].isselect == true) {
        val = val + ddtList[i].typeAmount!;
      }
    }

    if (val == 0) {
      showDialog<dynamic>(
          context: context,
          builder: (_) {
            return SuccessDialogPG(
              heading: 'Response',
              msg: 'Please Choose Customer..!!',
            );
          });
    } else {
      showDialog<dynamic>(
          context: context,
          builder: (_) {
            // context.read<EnquiryUserContoller>(). showSpecificDialog();
            //   context.read<EnquiryUserContoller>().showSuccessDia();
            return DDAlertBox(
              indx: 1,
            );
          });
    }
  }
  getData() {
    settlementList = [
      SettlementList(
          cusstomer: "James & Co",
          collectionDate: "23-Jun-2023",
          type: "Cash",
          totalAmount: 45000.00,
          typeAmount: 10000.00,
          isselect: false),
      SettlementList(
          cusstomer: "Murugan Stores",
          collectionDate: "22-May-2023",
          type: "Cash",
          totalAmount: 25000.00,
          typeAmount: 4000.00,
          isselect: false),
      SettlementList(
          cusstomer: "Murali Coffie",
          collectionDate: "09-Jan-2023",
          type: "Cash",
          totalAmount: 15000.00,
          typeAmount: 2000.00,
          isselect: false),
      SettlementList(
          cusstomer: "LG Ultra Electrnics",
          collectionDate: "09-Oct-2023",
          type: "Cash",
          totalAmount: 42000.00,
          typeAmount: 200000.00,
          isselect: false),
      //
      //
      SettlementList(
          cusstomer: "James & Co",
          collectionDate: "23-Jun-2023",
          type: "Card",
          totalAmount: 45000.00,
          typeAmount: 10000.00,
          isselect: false),
      SettlementList(
          cusstomer: "Murugan Stores",
          collectionDate: "22-May-2023",
          type: "Card",
          totalAmount: 25000.00,
          typeAmount: 4000.00,
          isselect: false),
      SettlementList(
          cusstomer: "Murali Coffie",
          collectionDate: "09-Jan-2023",
          type: "Card",
          totalAmount: 15000.00,
          typeAmount: 2000.00,
          isselect: false),
      SettlementList(
          cusstomer: "LG Ultra Electrnics",
          collectionDate: "09-Oct-2023",
          type: "Card",
          totalAmount: 42000.00,
          typeAmount: 200000.00,
          isselect: false),
      //
      //
      SettlementList(
          cusstomer: "James & Co",
          collectionDate: "23-Jun-2023",
          type: "Cheque",
          totalAmount: 45000.00,
          typeAmount: 10000.00,
          isselect: false),
      SettlementList(
          cusstomer: "Murugan Stores",
          collectionDate: "22-May-2023",
          type: "Cheque",
          totalAmount: 25000.00,
          typeAmount: 4000.00,
          isselect: false),
      SettlementList(
          cusstomer: "Murali Coffie",
          collectionDate: "09-Jan-2023",
          type: "Cheque",
          totalAmount: 15000.00,
          typeAmount: 2000.00,
          isselect: false),
      SettlementList(
          cusstomer: "LG Ultra Electrnics",
          collectionDate: "09-Oct-2023",
          type: "Cheque",
          totalAmount: 42000.00,
          typeAmount: 200000.00,
          isselect: false),
      //
      //
      SettlementList(
          cusstomer: "James & Co",
          collectionDate: "23-Jun-2023",
          type: "UPI",
          totalAmount: 45000.00,
          typeAmount: 10000.00,
          isselect: false),
      SettlementList(
          cusstomer: "Murugan Stores",
          collectionDate: "22-May-2023",
          type: "UPI",
          totalAmount: 25000.00,
          typeAmount: 4000.00,
          isselect: false),
      SettlementList(
          cusstomer: "Murali Coffie",
          collectionDate: "09-Jan-2023",
          type: "UPI",
          totalAmount: 15000.00,
          typeAmount: 2000.00,
          isselect: false),
      SettlementList(
          cusstomer: "LG Ultra Electrnics",
          collectionDate: "09-Oct-2023",
          type: "UPI",
          totalAmount: 42000.00,
          typeAmount: 200000.00,
          isselect: false),
      //
      //
      SettlementList(
          cusstomer: "James & Co",
          collectionDate: "23-Jun-2023",
          type: "DD",
          totalAmount: 45000.00,
          typeAmount: 10000.00,
          isselect: false),
      SettlementList(
          cusstomer: "Murugan Stores",
          collectionDate: "22-May-2023",
          type: "DD",
          totalAmount: 25000.00,
          typeAmount: 4000.00,
          isselect: false),
      SettlementList(
          cusstomer: "Murali Coffie",
          collectionDate: "09-Jan-2023",
          type: "DD",
          totalAmount: 15000.00,
          typeAmount: 2000.00,
          isselect: false),
      SettlementList(
          cusstomer: "LG Ultra Electrnics",
          collectionDate: "09-Oct-2023",
          type: "DD",
          totalAmount: 42000.00,
          typeAmount: 200000.00,
          isselect: false),
    ];
    notifyListeners();
  }

  SplitMethod() {
    cashList.clear();
    cardList.clear();
    chequeList.clear();
    ddtList.clear();
    upiList.clear();
    for (int i = 0; i < settlementList.length; i++) {
      if (settlementList[i].type == "Cash") {
        cashList.add(SettlementList(
            cusstomer: settlementList[i].cusstomer,
            collectionDate: settlementList[i].collectionDate,
            type: settlementList[i].type,
            totalAmount: settlementList[i].totalAmount,
            typeAmount: settlementList[i].typeAmount,
            isselect: false));
      }
      if (settlementList[i].type == "Card") {
        cardList.add(SettlementList(
            cusstomer: settlementList[i].cusstomer,
            collectionDate: settlementList[i].collectionDate,
            type: settlementList[i].type,
            totalAmount: settlementList[i].totalAmount,
            typeAmount: settlementList[i].typeAmount,
            isselect: false));
      }
      if (settlementList[i].type == "Cheque") {
        chequeList.add(SettlementList(
            cusstomer: settlementList[i].cusstomer,
            collectionDate: settlementList[i].collectionDate,
            type: settlementList[i].type,
            totalAmount: settlementList[i].totalAmount,
            typeAmount: settlementList[i].typeAmount,
            isselect: false));
      }
      if (settlementList[i].type == "DD") {
        ddtList.add(SettlementList(
            cusstomer: settlementList[i].cusstomer,
            collectionDate: settlementList[i].collectionDate,
            type: settlementList[i].type,
            totalAmount: settlementList[i].totalAmount,
            typeAmount: settlementList[i].typeAmount,
            isselect: false));
      }
      if (settlementList[i].type == "UPI") {
        upiList.add(SettlementList(
            cusstomer: settlementList[i].cusstomer,
            collectionDate: settlementList[i].collectionDate,
            type: settlementList[i].type,
            totalAmount: settlementList[i].totalAmount,
            typeAmount: settlementList[i].typeAmount,
            isselect: false));
      }
    }
    notifyListeners();
  }

  iselectMethodCash(int i) {
// if(cashList[i].isselect==true){

// }

    cashList[i].isselect =! cashList[i].isselect!;
    print(cashList[i].isselect);
    notifyListeners();
  }

  iselectMethodCard(int i) {
    cardList[i].isselect =!  cardList[i].isselect!;
    notifyListeners();
  }
 
  iselectMethodCheque(int i) {
   
    chequeList[i].isselect =! chequeList[i].isselect!;
    notifyListeners();
  }

  iselectMethodUpi(int i) {
    upiList[i].isselect =! upiList[i].isselect!;
    notifyListeners();
  }

  iselectMethodDD(int i,) {
    ddtList[i].isselect =!  ddtList[i].isselect!;
    notifyListeners();
  }

  totalcash() {
    double val = 0.00;
    for (int i = 0; i < cashList.length; i++) {
      if (cashList[i].isselect == true) {
        val = val + cashList[i].typeAmount!;
      }
    }
    return val.toStringAsFixed(2);
  }

  totalCard() {
    double val = 0.00;
    for (int i = 0; i < cardList.length; i++) {
      if (cardList[i].isselect == true) {
        val = val + cardList[i].typeAmount!;
      }
    }
    return val.toStringAsFixed(2);
  }

  totalCheque() {
    double val = 0.00;
    for (int i = 0; i < chequeList.length; i++) {
      if (chequeList[i].isselect == true) {
        val = val + chequeList[i].typeAmount!;
      }
    }
    return val.toStringAsFixed(2);
  }

  totalUpi() {
    double val = 0.00;
    for (int i = 0; i < upiList.length; i++) {
      if (upiList[i].isselect == true) {
        val = val + upiList[i].typeAmount!;
      }
    }
    return val.toStringAsFixed(2);
  }

  totalDD() {
    double val = 0.00;
    for (int i = 0; i < ddtList.length; i++) {
      if (ddtList[i].isselect == true) {
        val = val + ddtList[i].typeAmount!;
      }
    }
    return val.toStringAsFixed(2);
  }
}

class SettlementList {
  SettlementList({
    required this.cusstomer,
    required this.collectionDate,
    required this.type,
    required this.totalAmount,
    required this.typeAmount,
    required this.isselect,
  });

  String? cusstomer;
  String? collectionDate;
  String? type;
  double? totalAmount;
  double? typeAmount;
  bool? isselect;
}
