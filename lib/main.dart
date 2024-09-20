import "dart:convert";
import "dart:js_interop";

import "package:brownsofts/API/api.dart";
import "package:brownsofts/authentivation/google_signin.dart";
import "package:brownsofts/authentivation/log_in.dart";
import "package:brownsofts/authentivation/sign_In.dart";
import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';
import "package:google_sign_in/google_sign_in.dart";

import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    theme: ThemeData(useMaterial3: true).copyWith(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(225, 91, 44, 31))),
    home: const HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Future googleLogintoSQL(GoogleSignInAccount? user) async {
  //   try {
  //     var send = await http.post(Uri.parse(API.googe_loin), body: {
  //       "user_name": user!.displayName,
  //       "user_email": user.email,
  //       "user_password": null,
  //       "user_login_id": user.id,
  //       "user_login_type": user.runtimeType
  //     });

  //     if (send.statusCode == 200) {
  //       var resBody = jsonDecode(send.body);
  //       if (resBody["success"]) {
  //         Fluttertoast.showToast(msg: "You Logged in sucesfuly");
  //       }
  //     }
  //   } catch (e) {
  //     Fluttertoast.showToast(msg: "$e");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                color: const Color.fromARGB(224, 238, 225, 215),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.4,
                child: Center(
                  child: SizedBox(
                    height: 350,
                    width: 350,
                    child: Image.asset(
                      "assets/logo.png",
                      alignment: Alignment.bottomCenter * 12,
                      scale: 4,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 55,
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => const SignInPage()));
                    },
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 3)),
                    child: const Text(
                      "Sign In",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 55,
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: OutlinedButton(
                    onPressed: () async {
                      var user = await Google_Login.login();
                      Fluttertoast.showToast(
                          msg:
                              "${user!.displayName} ,\n ${user.email} ,\n${user.id} ,\n ${user.photoUrl} ,\n${user.displayName}");

                      //  googleLogintoSQL(user);

                      // if (user != null) {
                      //   Fluttertoast.showToast(
                      //       msg:
                      //           "${user.displayName} ,\n ${user.email} ,\n${user.id} ,\n ${user.photoUrl} ,\n${user.serverAuthCode}");
                      // }
                    },
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 3)),
                    child: const Text(
                      "Google Sign In ",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 55,
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: OutlinedButton(
                    onPressed: () {
                      // Handle create account action here
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (ctx) {
                        return const CreateAccountPage();
                      }));
                    },
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 3)),
                    child: const Text(
                      "Create Account",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
