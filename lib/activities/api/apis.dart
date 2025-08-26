class BrownAPI {
  static const String liveUrl = "https://brownsofts-new-js-server.onrender.com";
  static const String devUrl = "http://localhost:8000";

  static const String activeBase = liveUrl;

  static const headers = {
    "Content-Type": "application/json",
  };

  // Authentication APIs
  // static const String googlelogin = "$activeBase/google/google_login";
  static const String google_login = "$activeBase/google/login_or_google";

  static const String createUser = "$activeBase/google/add_user";

  static const String logIn = "$activeBase/google/login_user";

  //Database APIs
//  static const String rememberuser = "$activeBase/api/database/getuser";

//Service APIs
  static const String getService = "$activeBase/brown_services/get_service";
}
