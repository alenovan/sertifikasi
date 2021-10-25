import 'package:shared_preferences/shared_preferences.dart';

addStringSf(param,value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(param, value);
}

getStringValuesSF(param) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? stringValue = prefs.getString(param);
  return await stringValue;
}

