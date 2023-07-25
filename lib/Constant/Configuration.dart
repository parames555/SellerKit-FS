// ignore_for_file: unnecessary_string_interpolations, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, unused_local_variable

import 'dart:developer';

// import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import '../Controller/PriceListController/PriceListController.dart';
import '../Controller/StockAvailabilityController/StockListController.dart';
import 'Screen.dart';

class Config {
  msgDialog(BuildContext context, String title, String msg) {
    final theme = Theme.of(context);
    // Get.defaultDialog(
    //   title: "$title",
    //   titleStyle: TextStyle(color: Colors.black),
    //   middleTextStyle: TextStyle(color: Colors.black),
    //   buttonColor: Colors.red,
    //   barrierDismissible: false,
    //   content: Column(
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     mainAxisSize: MainAxisSize.min,
    //     children: [
    //       Text(
    //         "$msg",
    //         style: theme.textTheme.bodyText1?.copyWith(),
    //       ),
    //     ],
    //   ),
    // );
  }

  showSnackBars(String title, String msg, Color color) {
    Get.showSnackbar(GetSnackBar(
      title: title,
      message: msg,
      duration: Duration(seconds: 2),
    ));
  }

  showMsg(String msg, BuildContext context, Color col) {
    final having = SnackBar(
      content: Text(msg),
      backgroundColor: col,
    );
    ScaffoldMessenger.of(context).showSnackBar(having);
  }

  void showSearchDialogBox(BuildContext context) {
    showDialog<dynamic>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            final theme = Theme.of(context);
            return AlertDialog(
              content: Container(
                //  color: Colors.black12,
                // height: Screens.heigth(context) * 0.4,
                width: Screens.width(context) * 0.8,
                child: Form(
                  key: context.read<StockListController>().formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                          controller: context
                              .read<StockListController>()
                              .mycontroller[0],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Required *";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: 'Search here',
                              border: UnderlineInputBorder(),
                              enabledBorder: UnderlineInputBorder(),
                              focusedBorder: UnderlineInputBorder(),
                              errorBorder: UnderlineInputBorder(),
                              focusedErrorBorder: UnderlineInputBorder(),
                              suffixIcon: InkWell(
                                  onTap: () {
                                    context
                                        .read<StockListController>()
                                        .validateSearch(context);
                                  },
                                  child: Icon(Icons.search,
                                      color: theme.primaryColor)))),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void showSearchDialogBoxPrice(BuildContext context) {
    showDialog<dynamic>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            final theme = Theme.of(context);
            return AlertDialog(
              content: Container(
                //  color: Colors.black12,
                // height: Screens.heigth(context) * 0.4,
                width: Screens.width(context) * 0.8,
                child: Form(
                  key: context.read<PriceListController>().formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                          controller: context
                              .read<PriceListController>()
                              .mycontroller[0],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Required *";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: 'Search here',
                              border: UnderlineInputBorder(),
                              enabledBorder: UnderlineInputBorder(),
                              focusedBorder: UnderlineInputBorder(),
                              errorBorder: UnderlineInputBorder(),
                              focusedErrorBorder: UnderlineInputBorder(),
                              suffixIcon: InkWell(
                                  onTap: () {
                                    context
                                        .read<PriceListController>()
                                        .validateSearch(context);
                                  },
                                  child: Icon(Icons.search,
                                      color: theme.primaryColor)))),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  disableKeyBoard(BuildContext context) {
    FocusScopeNode focus = FocusScope.of(context);
    if (!focus.hasPrimaryFocus) {
      focus.unfocus();
    }
  }

  String currentDate() {
    DateTime now = DateTime.now();

    String currentDateTime =
        "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
    return currentDateTime;
  }

  String currentDateOnly() {
    DateTime now = DateTime.now();

    String currentDateTime =
        "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
    print("date: " + currentDateTime.toString());
    return currentDateTime;
  }

  String currentDateOnly2() {
    String date;
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd-MMMM-yyyy');
    final String formatted = formatter.format(now);
    date = formatter.toString();
    return date.toString();
  }

  String currentTimeOnly2() {
    String time;
    time = DateFormat.jm().toString();
    // somethin
    return time.toString();
  }

  //
  String alignDate(String date) {
    String dateT = date.replaceAll("T", "");
    var dates = DateTime.parse(date);
    print(
        "${dates.day.toString().padLeft(2, '0')}-${dates.month.toString().padLeft(2, '0')}-${dates.year}");
    return "${dates.day.toString().padLeft(2, '0')}-${dates.month.toString().padLeft(2, '0')}-${dates.year}";
  }

  String alignDateT(String date) {
    var dates = DateTime.parse(date);
    print(
        "${dates.day.toString().padLeft(2, '0')}-${dates.month.toString().padLeft(2, '0')}-${dates.year}");
    return "${dates.day.toString().padLeft(2, '0')}-${dates.month.toString().padLeft(2, '0')}-${dates.year}";
  }

  String alignDate2(String date) {
    var dates = DateTime.parse(date);
    print(
        "${dates.day.toString().padLeft(2, '0')}-${dates.month.toString().padLeft(2, '0')}-${dates.year}");

    return "${dates.day.toString().padLeft(2, '0')} " +
        DateFormat.MMMM().format(dates).toString().substring(0, 3);
  }

  String alignDate3(String date) {
    var dates = DateTime.parse(date);
    print(
        "${dates.day.toString().padLeft(2, '0')}-${dates.month.toString().padLeft(2, '0')}-${dates.year}");

    return "${dates.day.toString().padLeft(2, '0')}'" +
        DateFormat.MMMM().format(dates).toString().substring(0, 3);
  }

  static String k_m_b_generator(String numbers) {
    int num = int.parse(numbers);
    if (num > 999 && num < 99999) {
      return "${(num / 1000).toStringAsFixed(1)} K";
    } else if (num > 99999 && num < 999999) {
      return "${(num / 1000).toStringAsFixed(0)} K";
    } else if (num > 999999 && num < 999999999) {
      return "${(num / 1000000).toStringAsFixed(1)} M";
    } else if (num > 999999999) {
      return "${(num / 1000000000).toStringAsFixed(1)} B";
    } else {
      return num.toString();
    }
  }

  String subtractDateTime(String datetime) {
    return Jiffy("$datetime", "yyyy-MM-ddThh:mm:ss").fromNow();
  }

  String subtractDTWith(String datetime) {
    return Jiffy("$datetime", "yyyy-MM-dd hh:mm:ss").fromNow();
  }

  String subtractDateTime2(String datetime) {
    String subDate = '';
    String sub = Jiffy("$datetime", "yyyy-MM-ddThh:mm:ss").fromNow();
    //T  2022-10-05 13:33:10
    log(sub);
    log(sub.substring(0, 3));
    // if(sub.contains("ago")){
    // subDate =  sub.replaceAll("ago", "");
    // }else

    if (sub.contains("an hour ago")) {
      subDate = sub.replaceAll("an hour ago", "an hrs");
    } else if (sub.contains("minute")) {
      // print("sub date 111: "+subDate);
      subDate = sub.substring(0, 6);
    } else if (sub.contains("a few seconds ago")) {
      subDate = sub.replaceAll("a few seconds ago", "a sec");
    } else if (sub.contains("hours ago")) {
      subDate = sub.replaceAll("hours ago", "hrs");
    } else if (sub.contains("days ago")) {
      subDate = sub.replaceAll("days ago", "days");
    } else if (sub.contains("a month ago")) {
      subDate = sub.replaceAll("a month ago", "a month");
    } else if (sub.contains("months ago")) {
      subDate = sub.replaceAll("months ago", "mths");
    } else if (sub.contains("years ago")) {
      subDate = sub.replaceAll("years ago", "years");
    } else {
      subDate = sub.replaceAll("a ", "");
    }
    //log("sub date: "+subDate);
    return subDate;
  }

  String slpitCurrency(String value) {
    int values = int.parse(value);
    var format = NumberFormat.currency(
      name: "INR", locale: 'en_IN',
      decimalDigits: 0, // change it to get decimal places
      symbol: '₹ ',
    );
    String formattedCurrency = format.format(values);
    return formattedCurrency;
  }

  String slpitCurrency2(String value) {
    int values = int.parse(value);
    var format = NumberFormat.currency(
      name: "INR", locale: 'en_IN',
      decimalDigits: 0, // change it to get decimal places
      symbol: '',
    );
    String formattedCurrency = format.format(values);
    return formattedCurrency;
  }

  // get ip

  // Future<String>  getIP()async{
  //   String ipv4 = await Ipify.ipv4();
  //   return ipv4;
  // }
}

class NumberFormatter {
  static String formatter(String currentBalance) {
    try {
      // suffix = {' ', 'k', 'M', 'B', 'T', 'P', 'E'};
      double value = double.parse(currentBalance);
      if (value >= 1000 && value < 10000) {
        // less than a million
        return value.toStringAsFixed(0) + 'K';
      }
      if (value >= 10000 && value < 100000) {
        // less than a million
        return value.toStringAsFixed(1) + 'K';
      } else if (value >= 100000 && value < 1000000) {
        // less than a million
        return value.toStringAsFixed(0) + 'K';
      } else if (value >= 1000000 && value < (1000000 * 10 * 100)) {
        // less than 100 million
        double result = value / 1000000;
        return result.toStringAsFixed(0) + "M";
      } else if (value >= (1000000 * 10 * 100) &&
          value < (1000000 * 10 * 100 * 100)) {
        // less than 100 billion
        double result = value / (1000000 * 10 * 100);
        return result.toStringAsFixed(0) + "B";
      } else if (value >= (1000000 * 10 * 100 * 100) &&
          value < (1000000 * 10 * 100 * 100 * 100)) {
        // less than 100 trillion
        double result = value / (1000000 * 10 * 100 * 100);
        return result.toStringAsFixed(0) + "T";
      }
    } catch (e) {
      print(e);

      return e.toString();
    }

    return currentBalance;
  }
}

// void showDialogBox(String title, String msg, BuildContext context) {
//   showDialog<dynamic>(
//     context: context,
//     builder: (context) {
//       return StatefulBuilder(
//         builder: (context, setState) {
//           final theme = Theme.of(context);
//           return AlertDialog(
//             title: Center(
//                 child: Text(
//               "$title",
//               style: theme.textTheme.subtitle1?.copyWith(color: Colors.black),
//             )),
//             content: Container(
//               width: Screens.width(context) * 0.8,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     "$msg",
//                     style: theme.textTheme.bodyText1?.copyWith(),
//                   ),
//                   SizedBox(
//                     height: Screens.bodyheight(context) * 0.01,
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       );
//     },
//   );
// }

// void loginDialogBox(BuildContext context) {
//   showDialog<dynamic>(
//     context: context,
//     builder: (context) {
//       return StatefulBuilder(
//         builder: (context, setState) {
//           final theme = Theme.of(context);
//           return AlertDialog(
//             title: Center(
//                 child: Text(
//               "Welcome to login",
//               style: theme.textTheme.subtitle1?.copyWith(),
//             )),
//             content: Container(
//               width: Screens.width(context) * 0.8,
//               child: Form(
//                 key: context.watch<LoginController>().formkey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     TextFormField(
//                       controller:
//                           context.read<LoginController>().mycontroller[0],
//                       keyboardType: TextInputType.text,
//                       style: theme.textTheme.bodyText2,
//                       validator: (data) {
//                         if (data!.isEmpty) {
//                           return "Required*";
//                         }
//                         // else if (!data.contains("@")) {
//                         //   return "Enter Valid Email*";
//                         // }
//                         return null;
//                       },
//                       decoration: InputDecoration(
//                         contentPadding: EdgeInsets.symmetric(
//                             vertical: 10.0, horizontal: 10.0),
//                         fillColor: Colors.grey[200],
//                         filled: true,
//                         prefixIcon: const Icon(
//                           Icons.account_circle_outlined,
//                           size: 25,
//                         ),
//                         labelText: "Username",
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                           borderSide: const BorderSide(
//                             color: Colors.lightBlueAccent,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: Screens.bodyheight(context) * 0.02,
//                     ),
//                     TextFormField(
//                       controller:
//                           context.read<LoginController>().mycontroller[1],
//                       validator: (data) {
//                         if (data!.isEmpty) {
//                           return "Required*";
//                         }
//                         return null;
//                       },
//                       obscureText:
//                           context.watch<LoginController>().getHidepassword,
//                       style: theme.textTheme.bodyText2,
//                       decoration: InputDecoration(
//                         contentPadding: EdgeInsets.symmetric(
//                             vertical: 10.0, horizontal: 10.0),
//                         fillColor: Colors.grey[200],
//                         filled: true,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                           borderSide: const BorderSide(
//                             color: Colors.lightBlueAccent,
//                           ),
//                         ),
//                         prefixIcon: const Icon(
//                           Icons.lock_outlined,
//                           size: 25,
//                         ),
//                         suffixIcon: IconButton(
//                           icon:
//                               context.watch<LoginController>().getHidepassword
//                                   ? const Icon(Icons.visibility_off)
//                                   : const Icon(Icons.visibility),
//                           onPressed: () {
//                             context.read<LoginController>().obsecure();
//                           },
//                         ),
//                         labelText: "Password",
//                       ),
//                     ),
//                     SizedBox(
//                       height: Screens.bodyheight(context) * 0.02,
//                     ),
//                     ElevatedButton(
//                         onPressed: () {
//                           context.read<LoginController>().validateLogin(context);
//                         },
//                         child: Text("Login"))
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       );
//     },
//   );
// }
