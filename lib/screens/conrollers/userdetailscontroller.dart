import 'package:brownsofts/activities/models/remember_user.dart';
import 'package:get/get.dart';

class Userdetailscontroller extends GetxController {
  RxString uname = "".obs;
  RxString uuser_email = "".obs;
  RxString uuser_password = "".obs;
  RxString ugoogle_login_id = "".obs;
  RxString uid = "".obs;
  RxString uprofile_image = "".obs;
  RxBool loading = false.obs;

  
  retriving_data() async {
    var _current_user = await Remembrprefs.readCurrentUser();

    uname.value = _current_user!.name;
    uuser_email.value = _current_user.user_email;
    uuser_password.value = _current_user.user_password!;
    ugoogle_login_id.value = _current_user.google_login_id!;
    uid.value = _current_user.id!;
    print(_current_user.profile_image);
    if (_current_user.profile_image != null &&
        _current_user.profile_image != "") {
      loading.value = true;
      uprofile_image.value = _current_user.profile_image.toString();
    } else {
      uprofile_image =
          "https://pbs.twimg.com/profile_images/1653626498828619776/D8WR6HGT_400x400.jpg"
              .obs;
    }
    print(uname.value);
    print(uprofile_image.value);
  }
}
