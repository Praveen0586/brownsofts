import 'dart:async';
import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'apis.dart';

class ApiCalls {
  static const headers = {
    "Content-Type": "application/json",
  };
  final brownAPI = BrownAPI();

  FutureOr<http.Response> googleSignIn(GoogleSignInAccount? user) async {
    if (user != null) {
      try {
        Fluttertoast.showToast(msg: "stage2");
        final _userName = user.displayName;
        final _userEmail = user.email;
        final _userId = user.id;
        final _userimage = user.photoUrl;
        final _userType = user.runtimeType.toString();
        print("glg $_userName , $_userEmail, $_userId ,$_userType");
        Fluttertoast.showToast(msg: "stage3");

        final response = await http.post(Uri.parse(BrownAPI.google_login),
            headers: headers,
            body: jsonEncode({
              "login_method": "google",
              "user_name": _userName,
              "user_email": _userEmail,
              "user_login_id": _userId,
              "photo_url": _userimage
            }));
        Fluttertoast.showToast(msg: "stage4");
        Fluttertoast.showToast(msg: "Response status: ${response.statusCode}");

        // if (response.statusCode == 200 || response.statusCode == 201) {
        //   print("Google Sign In successful: ${response.body}");
        //   return response;
        // } else {
        //   print(
        //       "Google Sign In failed with status code  : ${response.statusCode}");
        //   return Future.error(
        //       "Google Sign In failed with status code: ${response.statusCode}");
        // }

        if (response.statusCode == 200) {
          // Login successful or Google linked & login success
          print("Login successful: ${response.body}");
          // Parse user data if needed and proceed
          return response;
        } else if (response.statusCode == 201) {
          // New user registered (email/password or Google)
          print("Registration successful: ${response.body}");
          // Parse user data if needed and proceed
          return response;
        } else if (response.statusCode == 401) {
          // Unauthorized - e.g., Google-only user tried email/password login
          Fluttertoast.showToast(
              msg:
                  "This account uses Google Sign-In only. Please log in using Google, not with a username and password");
          print(
              "Unauthorized login attempt. Please use the correct login method.");
          throw Exception("Unauthorized login attempt.");
        } else if (response.statusCode == 400) {
          // Bad request - missing parameters or unsupported login method
          print("Bad request: ${response.body}");
          throw Exception("Bad request.");
        } else if (response.statusCode == 500) {
          // Server error - database or internal server errors
          print("Server error: ${response.body}");
          throw Exception("Server error. Please try again later.");
        } else {
          // Handle unexpected status codes
          print(
              "Unexpected status code ${response.statusCode}: ${response.body}");
          throw Exception("Unexpected error occurred.");
        }
      } catch (e) {
        print("Error in Google Sign In: $e");
        return Future.error("Google Sign In failed");
      }
    }
    http.Response errorResponse = http.Response("User is null", 400);
    return errorResponse;
  }

  Future<void> userLogin() async {}

  Future<List<Map<String, dynamic>>> getAllService() async {
    Uri _getallService = Uri.parse(BrownAPI.getService);

    final _resul = await http.get(_getallService, headers: headers);

    if (_resul.statusCode == 200 || _resul.statusCode == 201) {
      final _responseBody = json.decode(_resul.body);
      print(_responseBody);
      List<Map<String, dynamic>> services =
          List<Map<String, dynamic>>.from(_responseBody);
      print("Services fetched successfully: ${_responseBody}");

      return services;
    } else {
      print("Failed to fetch services with status code: ${_resul.statusCode}");

      return [];
    }
  }
}
