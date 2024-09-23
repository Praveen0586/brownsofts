import 'dart:convert';

import 'package:brownsofts/activities/models/user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Remembrprefs {
  static Future<void> saveMyUserInfo(User userinfo) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userJsonData = jsonEncode(userinfo.toJson());
    await preferences.setString("Current User", userJsonData);
    //  Fluttertoast.showToast(msg: userJsonData);
  }

  static Future<User?> readCurrentUser() async {
    User? currentUserData;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String UserJsondata = await preferences.getString("Current User")!;

    Map<String, dynamic> curentMappeddata = jsonDecode(UserJsondata);
    currentUserData = User.fromJson(curentMappeddata);

    return currentUserData;
  }

  static void removeUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove("Current User");
  }
}
