import 'dart:convert';

import 'package:brownsofts/activities/models/user.dart';
import 'package:brownsofts/screens/fragments/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Remembrprefs {
  static Future<void> saveMyUserInfo(User userinfo) async {
    username.value = userinfo.name;
    useremail.value = userinfo.user_email;
    userID.value = userinfo.id.toString();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userJsonData = jsonEncode(userinfo.toJson());
    await preferences.setString("Current User", userJsonData);
    //  Fluttertoast.showToast(msg: userJsonData);
  }

  static Future<User?> readCurrentUser() async {
    User? currentUserData;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String UserJsondata = await preferences.getString("Current User") ?? "";

    Map<String, dynamic> curentMappeddata = jsonDecode(UserJsondata);
    currentUserData = User.fromJson(curentMappeddata);
    // Future.delayed(Duration(seconds: 4));
    return currentUserData;
  }

  static void removeUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove("Current User");
  }
}
