import 'package:brownsofts/activities/models/remember_user.dart';
import 'package:brownsofts/activities/models/user.dart';
import 'package:get/get.dart';

class CurrentUser extends GetxController {
  Rx<User> currentUser = User(
          name: "",
          user_email: "",
          user_password: "",
          google_login_id: "",
          id: "")
      .obs;

  User get user => currentUser.value;

  getCurrentUser() async {
    var user = await Remembrprefs.readCurrentUser();
    currentUser.value = user!;
  }
}
