import 'package:google_sign_in/google_sign_in.dart';

class Google_Login {
  static final google_sign_in = GoogleSignIn();
  static Future<GoogleSignInAccount?> login() => google_sign_in.signIn();
  static Future signOut() => google_sign_in.signOut();
}
