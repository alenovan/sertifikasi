import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart' as intl;
import 'package:softwaresertifikasi/widget/SharedPreference.dart';

void hideKeyboard(context) {
  FocusScope.of(context).requestFocus(FocusNode());
}

void popScreen(BuildContext context, [dynamic data]) {
  Navigator.pop(context, data);
}

enum RouteTransition { slide, dualSlide, fade, material, cupertino }


Future pushScreenAndWait(BuildContext context, Widget buildScreen) async {
  await Navigator.push(
      context, CupertinoPageRoute(builder: (context) => buildScreen));
  return;
}

// launchScreen(context, String tag, {Object arguments}) {
//   if (arguments == null) {
//     Navigator.pushNamed(context, tag);
//   } else {
//     Navigator.pushNamed(context, tag, arguments: arguments);
//   }
// }

// void launchScreenWithNewTask(context, String tag) {
//   Navigator.pushNamedAndRemoveUntil(context, tag, (r) => false);
// }

Color hexStringToHexInt(String hex) {
  hex = hex.replaceFirst('#', '');
  hex = hex.length == 6 ? 'ff' + hex : hex;
  int val = int.parse(hex, radix: 16);
  return Color(val);
}
/*
String parseHtmlString(String htmlString) {
  return parse(parse(htmlString).body.text).documentElement.text;
}*/

Color computeTextColor(Color color) {
  return color.computeLuminance() > 0.5 ? Colors.black : Colors.white;
}

bool Potrait(ctx) {
  return MediaQuery
      .of(ctx)
      .orientation == Orientation.portrait;
}

Future<Map<String, String>> tokenHeader() async {
  var token = await getStringValuesSF("token");
  var headers = {
    "Content-Type": "application/json",
    'Authorization': 'Bearer $token',
  };
  return headers;
}

Future<Map<String, String>> tokenSupardiHeader() async {
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('yyyyMdd').format(now);
  var bytes1 = utf8.encode("eGn6E<AcZ8wQk&" + formattedDate);
  var token = sha256.convert(bytes1);
  print("token = " + token.toString());
  var headers = {
    "Content-Type": "application/json",
    'Authorization': 'Bearer $token',
  };
  return headers;
}

String numberFormat(number, status) {
  final formatter = intl.NumberFormat.decimalPattern();
  if (status) {
    return "Rp." + formatter.format(number);
  } else {
    return formatter.format(number);
  }
}

