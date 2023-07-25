// ignore_for_file: unnecessary_new, prefer_const_constructors, prefer_interpolation_to_compose_strings, non_constant_identifier_names

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sellerkit/Pages/Collection/widgets/CollectionSuccessPage.dart';
import 'package:sellerkit/Pages/Collection/widgets/PDFInVoiceApi.dart';
import 'package:share/share.dart';

import '../../Constant/Configuration.dart';
import '../../Constant/ConstantRoutes.dart';
import '../../Widgets/SucessDialagBox.dart';

class NewCollectionContoller extends ChangeNotifier {
  Config config = Config();
  int pageChanged = 0;
  PageController pageController = PageController(initialPage: 0);
  List<CollectionLineData> productDetails = [];
  List<CollectionLineData> get getProduct => productDetails;

  List<CollectionCustomerData> allProductDetails = [];
  List<CollectionCustomerData> filterProductDetails = [];

  List<CollectionCustomerData> get getAllProductDetails => allProductDetails;
  bool showItemList = true;
  bool isUpdateClicked = false;
  List<GlobalKey<FormState>> formkey = new List.generate(
      3, (i) => new GlobalKey<FormState>(debugLabel: "Collection"));
  List<TextEditingController> mycontroller =
      List.generate(30, (i) => TextEditingController());
  changeVisible() {
    showItemList = !showItemList;
    notifyListeners();
  }

  static String? docNO;
  static String? title;
  List<String> paths = [];

  pdfMethod() async {
    final tempDir = await getTemporaryDirectory();
    print("direc: " + tempDir.path.toString() + '/$title-$docNO.pdf');
    paths.add('${tempDir.path}/$title-$docNO.pdf');
    await Share.shareFiles(paths);
    paths.clear();
  }

  init() {
    ClearDataAll();
    getData();
    print(showItemList);
    print(allProductDetails);
  }

  colletionTotal() {
    double val = 0.0;
    for (int i = 0; i < productDetails.length; i++) {
      val = val + productDetails[i].amount;
    }
    mycontroller[5].text = val.toString();
    return val.toStringAsFixed(2);
  }

  ClearDataAll() {
    filterProductDetails.clear();
    customerlist.clear();
    filterCustomerlist.clear();
    customerbool = false;
    custCodebool = false;
    paymentmode = null;
    mycontroller[0].text = "";
    mycontroller[1].text = "";
    mycontroller[2].text = "";
    mycontroller[3].text = "";
    mycontroller[4].text = "";
    mycontroller[5].text = "";
    mycontroller[6].text = "";
    notifyListeners();
  }

  filterList(String v) {
    if (v.isNotEmpty) {
      allProductDetails = filterProductDetails
          .where((e) =>
              e.invoice!.toLowerCase().contains(v.toLowerCase()) ||
              e.date.toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      allProductDetails = filterProductDetails;
      notifyListeners();
    }
  }

  isselectMethod(int i, BuildContext context, bool val) {
    if (val == true) {
      resetItems(i);

      isUpdateClicked = false;

      showBottomSheetInsert(context, i);
    }
  }

  resetItems(int i) {
    mycontroller[0].text = allProductDetails[i].amount.toStringAsFixed(2);
    //.clear();
  }

  String? paymentmode;
  resonChoosed(String val) {
    paymentmode = val;
    notifyListeners();
  }

  String? slelectedIteminvoice;
  String? slelectedItemDate;

  addProductDetails(
      BuildContext context, CollectionCustomerData? CollectionCusData) {
    if (formkey[1].currentState!.validate()) {
      productDetails.add(CollectionLineData(
        amount: double.parse(mycontroller[0].text.toString()),
        date: slelectedItemDate!,
        invoice: slelectedIteminvoice,
        purpose: CollectionCusData!.purpose,
        type: CollectionCusData.type,
      ));
      showItemList = false;
      Navigator.pop(context);
      isUpdateClicked = false;
      allProductDetails.remove(CollectionCusData);

      notifyListeners();
    }
  }

  validateFirst(BuildContext context) {
    // int count = 0;
    // if (paymentmode == null) {
    //   count = 1;
    //   paymentmodeErro = "Please Select PaymentMode..!!";
    //   notifyListeners();
    // } else {
    //   count = 0;
    //   paymentmodeErro = "";
    //   notifyListeners();
    // }
    // count = 0;
    if (formkey[0].currentState!.validate()) {
      // if (count == 0) {
      showItemList = true;
      pageController.animateToPage(++pageChanged,
          duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
      // }
    }
    notifyListeners();
  }

  String validateCustomer(val) {
    String? cusvalue = "";
    for (int i = 0; i < customerlist.length; i++) {
      if (val == customerlist[i].customer) {
        cusvalue = customerlist[i].customer!;
      }
    }
    return cusvalue!;
  }

  String validateCustomerCode(val) {
    String? cusvalue = "";
    for (int i = 0; i < customerlist.length; i++) {
      // print(customerlist[i].cuscode);
      // print(val);

      if (val == customerlist[i].cuscode) {
        cusvalue = customerlist[i].cuscode;
      }
    }
    return cusvalue!;
  }

  String validateCustomerCantact(val) {
    String? cusvalue = "";
    for (int i = 0; i < customerlist.length; i++) {
      // print(customerlist[i].cuscode);
      // print(val);

      if (val == customerlist[i].contactname) {
        cusvalue = customerlist[i].contactname;
      }
    }
    return cusvalue!;
  }

  String validateCustomerMobile(val) {
    String? cusvalue = "";
    for (int i = 0; i < customerlist.length; i++) {
      // print(customerlist[i].cuscode);
      // print(val);

      if (val == customerlist[i].mobile) {
        cusvalue = customerlist[i].mobile;
      }
    }
    return cusvalue!;
  }

  validateFinal(BuildContext context) {
    int count = 0;
    if (paymentmode == null || mycontroller[5].text.isEmpty) {
      count = 1;
      paymentmodeErro = "Please Select PaymentMode..!!";
      notifyListeners();
    } else if (paymentmode != null && mycontroller[5].text.isEmpty) {
      count = 0;
      paymentmodeErro = "";
      notifyListeners();
    }
    if (getProduct.isNotEmpty) {
      if (count == 0) {
        Get.toNamed(ConstantRoutes.collectioSuccess);
      }
      //  CollectionSuccessPage

    } else {
      showDialog<dynamic>(
          context: context,
          builder: (_) {
            return SuccessDialogPG(
              heading: 'Response',
              msg: 'Please Select Invoice..!!',
            );
          });
    }
    notifyListeners();
  }

  RemoveandAdd(CollectionLineData? collcetionline) {
    // for (int i = 0; i < filterProductDetails.length; i++) {
    //   if (filterProductDetails[i].invoice == collcetionline!.invoice) {
    filterProductDetails.add(CollectionCustomerData(
      amount: collcetionline!.amount,
      date: collcetionline.date,
      invoice: collcetionline.invoice,
      purpose: collcetionline.purpose,
      type: collcetionline.type,
    ));
    //   }
    // }
    allProductDetails = filterProductDetails;
    getProduct.remove(collcetionline);
    print(allProductDetails.length);
    notifyListeners();
  }

  updateProductDetails(BuildContext context, int i) {
    if (formkey[1].currentState!.validate()) {
      productDetails[i].amount = double.parse(mycontroller[0].text.toString());

      showItemList = false;
      Navigator.pop(context);
      isUpdateClicked = false;
    }
  }

  showBottomSheetInsert(BuildContext context, int i) {
    final theme = Theme.of(context);
    slelectedIteminvoice = allProductDetails[i].invoice.toString();
    slelectedItemDate = allProductDetails[i].date.toString();
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: Form(
            key: formkey[1],
            child: Container(
              child: Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(height: 10),
                    // Row(
                    //   children: [
                    //     Container(
                    //       // width: Screens.width(context)*0.8,
                    //       child: Text(allProductDetails[i].invoice.toString(),
                    //           style: theme.textTheme.bodyText1
                    //               ?.copyWith(color: theme.primaryColor)),
                    //     ),   Container(
                    //   // width: Screens.width(context)*0.7,
                    //   // color: Colors.red,
                    //   child: Text(allProductDetails[i].date.toString(),
                    //       style: theme.textTheme.bodyText1
                    //           ?.copyWith() //color: theme.primaryColor
                    //       ),
                    // ),
                    //   ],
                    // ),
                    // Container(
                    //   // width: Screens.width(context)*0.8,
                    //   child: Text("Amount to Pay",
                    //       style: theme.textTheme.bodyText1
                    //           ?.copyWith(color: theme.primaryColor)),
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    SizedBox(
                      // width: 270,
                      // height: 40,
                      child: new TextFormField(
                          controller: mycontroller[0],
                          onChanged: (val) {},
                          validator: (value) {
                            print("Amount value" +
                                allProductDetails[i].amount.toString());
                            if (value!.isEmpty) {
                              return "ENTER AMOUNT";
                            } else if (allProductDetails[i].amount <
                                double.parse(value)) {
                              return "Enter Correct Amount";
                            } else if (0 == double.parse(value)) {
                              return "Enter Correct Amount";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            labelText: 'Amount to Pay',
                            border: UnderlineInputBorder(),
                            labelStyle: theme.textTheme.bodyText1!
                                .copyWith(color: Colors.grey),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              //  when the TextFormField in unfocused
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              //  when the TextFormField in focused
                            ),
                            errorBorder: UnderlineInputBorder(),
                            focusedErrorBorder: UnderlineInputBorder(),
                          )),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("cancel")),
                        isUpdateClicked == false
                            ? ElevatedButton(
                                onPressed: () {
                                  mycontroller[12].clear();
                                  addProductDetails(
                                      context, allProductDetails[i]);
                                },
                                child: Text("ok"))
                            : ElevatedButton(
                                onPressed: () {
                                  updateProductDetails(context, i);
                                },
                                child: Text("Update")),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }

  UpdateshowBottomSheetInsert(BuildContext context, int i) {
    final theme = Theme.of(context);
    // slelectedIteminvoice = getProduct[i].invoice.toString();
    // slelectedItemDate = getProduct[i].date.toString();
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: Form(
            key: formkey[1],
            child: Container(
              child: Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(height: 10),
                    // Row(
                    //   children: [
                    //     Container(
                    //       // width: Screens.width(context)*0.8,
                    //       child: Text(allProductDetails[i].invoice.toString(),
                    //           style: theme.textTheme.bodyText1
                    //               ?.copyWith(color: theme.primaryColor)),
                    //     ),   Container(
                    //   // width: Screens.width(context)*0.7,
                    //   // color: Colors.red,
                    //   child: Text(allProductDetails[i].date.toString(),
                    //       style: theme.textTheme.bodyText1
                    //           ?.copyWith() //color: theme.primaryColor
                    //       ),
                    // ),
                    //   ],
                    // ),
                    // Container(
                    //   // width: Screens.width(context)*0.8,
                    //   child: Text("Amount to Pay",
                    //       style: theme.textTheme.bodyText1
                    //           ?.copyWith(color: theme.primaryColor)),
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    SizedBox(
                      // width: 270,
                      // height: 40,
                      child: new TextFormField(
                          controller: mycontroller[0],
                          onChanged: (val) {},
                          validator: (value) {
                            print("Amount value" +
                                getProduct[i].amount.toString());
                            if (value!.isEmpty) {
                              return "ENTER AMOUNT";
                            } else if (getProduct[i].amount <
                                double.parse(value)) {
                              return "Enter Correct Amount";
                            } else if (0 == double.parse(value)) {
                              return "Enter Correct Amount";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            labelText: 'Amount to Pay',
                            border: UnderlineInputBorder(),
                            labelStyle: theme.textTheme.bodyText1!
                                .copyWith(color: Colors.grey),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              //  when the TextFormField in unfocused
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              //  when the TextFormField in focused
                            ),
                            errorBorder: UnderlineInputBorder(),
                            focusedErrorBorder: UnderlineInputBorder(),
                          )),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("cancel")),
                        ElevatedButton(
                            onPressed: () {
                              updateProductDetails(context, i);
                            },
                            child: Text("Update")),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }

  List<InvoiceData> invoice = [];
  List<customerDetails> customerlist = [];
  List<customerDetails> get getcustomerlist => customerlist;
  List<customerDetails> filterCustomerlist = [];
  bool customerbool = false;
  bool custCodebool = false;
  bool contactbool = false;
  bool mobilebool = false;

  clearbool() {
    customerbool = false;
    custCodebool = false;
    contactbool = false;
    mobilebool = false;
    notifyListeners();
  }

  String paymentmodeErro = "";
  getExiCustomerData(String Customer) {
    for (int i = 0; i < customerlist.length; i++) {
      if (Customer == customerlist[i].customer) {
        mycontroller[1].text = customerlist[i].customer.toString();
        mycontroller[2].text = customerlist[i].cuscode.toString();
        mycontroller[3].text = customerlist[i].contactname.toString();
        mycontroller[4].text = customerlist[i].mobile.toString();
        mycontroller[7].text = "25000";
        mycontroller[8].text = "1200";
        mycontroller[9].text = "22800";
        notifyListeners();
      }
    }
    notifyListeners();
  }

  getExiCustomerCodeData(String Customer) {
    for (int i = 0; i < customerlist.length; i++) {
      if (Customer == customerlist[i].cuscode) {
        mycontroller[1].text = customerlist[i].customer.toString();
        mycontroller[2].text = customerlist[i].cuscode.toString();
        mycontroller[3].text = customerlist[i].contactname.toString();
        mycontroller[4].text = customerlist[i].mobile.toString();
        mycontroller[7].text = "25000";
        mycontroller[8].text = "1200";
        mycontroller[9].text = "22800";
        notifyListeners();
      }
    }
    notifyListeners();
  }

  getExiCustomerCantactData(String Customer) {
    for (int i = 0; i < customerlist.length; i++) {
      if (Customer == customerlist[i].contactname) {
        mycontroller[1].text = customerlist[i].customer.toString();
        mycontroller[2].text = customerlist[i].cuscode.toString();
        mycontroller[3].text = customerlist[i].contactname.toString();
        mycontroller[4].text = customerlist[i].mobile.toString();
        mycontroller[7].text = "25000";
        mycontroller[8].text = "1200";
        mycontroller[9].text = "22800";
        notifyListeners();
      }
    }
    notifyListeners();
  }

  getExiCustomerMobileData(String Customer) {
    for (int i = 0; i < customerlist.length; i++) {
      if (Customer == customerlist[i].mobile) {
        mycontroller[1].text = customerlist[i].customer.toString();
        mycontroller[2].text = customerlist[i].cuscode.toString();
        mycontroller[3].text = customerlist[i].contactname.toString();
        mycontroller[4].text = customerlist[i].mobile.toString();
        mycontroller[7].text = "25000";
        mycontroller[8].text = "1200";
        mycontroller[9].text = "22800";
        notifyListeners();
      }
    }
    notifyListeners();
  }

  filterCollectionCuslist(String v) {
    if (v.isNotEmpty) {
      filterCustomerlist = customerlist.where((e) =>
          // e.cuscode.toLowerCase().contains(v.toLowerCase()) ||
          e.customer!.toLowerCase().contains(v.toLowerCase())).toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterCustomerlist = customerlist;
      notifyListeners();
    }
  }

  filterCollectionCusCardCode(String v) {
    if (v.isNotEmpty) {
      filterCustomerlist = customerlist.where((e) =>
          // e.cuscode.toLowerCase().contains(v.toLowerCase()) ||
          e.cuscode.toLowerCase().contains(v.toLowerCase())).toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterCustomerlist = customerlist;
      notifyListeners();
    }
  }

  filterCollectionCusCantact(String v) {
    if (v.isNotEmpty) {
      filterCustomerlist = customerlist.where((e) =>
          // e.cuscode.toLowerCase().contains(v.toLowerCase()) ||
          e.contactname.toLowerCase().contains(v.toLowerCase())).toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterCustomerlist = customerlist;
      notifyListeners();
    }
  }

  filterCollectionCusMobile(String v) {
    if (v.isNotEmpty) {
      filterCustomerlist = customerlist.where((e) =>
          // e.cuscode.toLowerCase().contains(v.toLowerCase()) ||
          e.mobile.toLowerCase().contains(v.toLowerCase())).toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterCustomerlist = customerlist;
      notifyListeners();
    }
  }

  getData() {
    filterProductDetails = [
      CollectionCustomerData(
        invoice: "1623233",
        date: "2023-07-03",
        purpose: "Looking For Chair/Tables",
        amount: 2370.00,
        type: "Balance",
        // isselect: false,
      ),
      CollectionCustomerData(
        invoice: "987765",
        date: "2022-06-13",
        purpose: "Looking For Chair/Tables",
        amount: 1070.00,
        type: "Balance",
        // isselect: false
      ),
      CollectionCustomerData(
        invoice: "342323",
        date: "2023-10-11",
        purpose: "Looking For Chair/Tables",
        amount: 2000.00,
        type: "Balance",
        // isselect: false,
      )
    ];
    customerlist = [
      customerDetails(
          cuscode: "A00001",
          customer: "Ram Electricals",
          contactname: "Saravanan",
          mobile: "9876543210"),
      customerDetails(
          cuscode: "A00002",
          customer: "Chennai Mobiles",
          contactname: "Senthil Kumar",
          mobile: "9812345210"),
      customerDetails(
          cuscode: "A00023",
          customer: "Ram & Co",
          contactname: "Sathyamurthi",
          mobile: "9876543987"),
      customerDetails(
          cuscode: "A00045",
          customer: "Krishna Builders",
          contactname: "Abdul Rahuman",
          mobile: "9876543210"),
    ];
    invoice = [
      InvoiceData(id: 1, invoiceNo: "12345", total: 20000, totalPayment: 18000),
      InvoiceData(id: 2, invoiceNo: "54321", total: 12022, totalPayment: 1200),
      InvoiceData(id: 3, invoiceNo: "10001", total: 25000, totalPayment: 12000),
    ];

    filterCustomerlist = customerlist;
    allProductDetails = filterProductDetails;
    notifyListeners();
  }
}

class CollectionCustomerData {
  String? invoice;
  String date;
  String purpose;
  double amount;
  String type;
  // bool isselect;

  CollectionCustomerData({
    required this.invoice,
    required this.date,
    required this.purpose,
    required this.amount,
    required this.type,
    // required this.isselect,
  });
}

class customerDetails {
  String? customer;
  String cuscode;
  String contactname;
  // double amount;
  String mobile;

  customerDetails({
    required this.cuscode,
    required this.customer,
    required this.contactname,
    required this.mobile,
    // required this.type,
  });
}

class CollectionLineData {
  String? invoice;
  String date;
  String purpose;
  double amount;
  String type;

  CollectionLineData({
    required this.invoice,
    required this.date,
    required this.purpose,
    required this.amount,
    required this.type,
  });
}

class InvoiceData {
  String? invoiceNo;
  int? total;
  int? id;

  int? totalPayment;

  InvoiceData({
    required this.id,
    required this.invoiceNo,
    required this.total,
    required this.totalPayment,
  });
}
