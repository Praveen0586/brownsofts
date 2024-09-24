import "dart:convert";

import "package:brownsofts/activities/API/api.dart";
import "package:brownsofts/activities/authentivation/create_user.dart";
import "package:brownsofts/activities/authentivation/google_signin.dart";
// import "package:brownsofts/authentivation/log_in.dart";
import "package:brownsofts/activities/authentivation/sign_In.dart";
import "package:brownsofts/activities/models/remember_user.dart";
import "package:brownsofts/screens/dummyscreen.dart";
import "package:brownsofts/screens/fragments/Dashboard.dart";
import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';
import "package:get/get.dart";
import "package:google_sign_in/google_sign_in.dart";
import 'package:http/http.dart' as http;

void main() {
  WidgetsFlutterBinding.ensureInitialized;
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    debugShowMaterialGrid: false,
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
  Future googleLogintoSQL(GoogleSignInAccount? user) async {
    try {
      var send = await http.post(Uri.parse(API.googlelogin), body: {
        "user_name": user!.displayName.toString(),
        "user_email": user.email.toString(),
        "user_login_id": user.id.toString(),
        "user_login_type": user.runtimeType.toString()
      });
      Fluttertoast.showToast(msg: "${send.statusCode}");
      if (send.statusCode == 200) {
        Fluttertoast.showToast(msg: "2");
        var resBody = jsonDecode(send.body);
        if (resBody["success"]) {
          Fluttertoast.showToast(msg: "You Logged in sucesfuly");
          // Future.delayed(
          //     const Duration(microseconds: 1000),
          //     () => Navigator.of(context).push(
          //         MaterialPageRoute(builder: (ctx) => const Homescreen())));

          Future.delayed(Duration(milliseconds: 100),
              () => Get.off(const DashBoardScreen()));
          const LinearProgressIndicator();
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "$e");
    }
  }

  Widget WelcomeScreen(BuildContext context) {
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
                      //   Fluttertoast.showToast(
                      //    msg:
                      //      "${user!.displayName} ,\n ${user.email} ,\n${user.id} ,\n ${user.photoUrl} ,\n${user.displayName}");

                      googleLogintoSQL(user);

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
                      //  Handle create account action here
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (ctx) {
                        return const CreateAccountPage();
                      }));

                      // Get.to(CreateAccountPage());
                      //   Google_Login.signOut();
                    },
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 3)),
                    child: const Text(
                      "Sign Up",
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Remembrprefs.readCurrentUser(),
        builder: (ctx, datasnapshots) {
          if (datasnapshots.data == null) {
            return WelcomeScreen(ctx);
          }

          // if (datasnapshots.data != null) {
          //   return Center(
          //     child: Column(children: [
          //       Text("Working "),
          //       IconButton(
          //           onPressed: () {
          //             setState(() {
          //               Remembrprefs.removeUser();
          //             });
          //           },
          //           icon: Icon(Icons.abc_outlined))
          //     ]),
          //   );
          // }

          // return const DashBoardScreen();
          return const CreateAccountPage();
        });
  }
}
