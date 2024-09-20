import "dart:js_interop";

import "package:brownsofts/authentivation/google_signin.dart";
import "package:brownsofts/authentivation/log_in.dart";
import "package:brownsofts/authentivation/sign_In.dart";
import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';
import "package:google_sign_in/google_sign_in.dart";

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
                              Future<GoogleSignInAuthentication> gh=user.authentication;
                       
                      if (user != null) {
                        Fluttertoast.showToast(
                            msg:
                                "${user.displayName} ,\n ${user.email} ,\n${user.id} ,\n ${user.photoUrl} ,\n${user.serverAuthCode}");
                      }
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
