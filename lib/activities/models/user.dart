class User {
  final String name;
  final String user_email;
  String? user_password = "";
  String? google_login_id = "";
  String? id = "";

  User(
      {required this.name,
      this.google_login_id,
      required this.user_email,
      required this.user_password,
      this.id});

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "user_email": user_email,
      "user_password": user_password,
      "google_login_id": google_login_id,
      "id": id
    };
  }

  static User fromJson(Map<String, dynamic> json) {
    return User(
        name: json["name"],
        user_email: json["user_email"],
        user_password: json["user_password"],
        google_login_id: json["google_login_id"],
        id: json["id"]);
  }
}
