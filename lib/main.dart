import "dart:convert";

import "package:brownsofts/activities/API-old/api.dart";
import "package:brownsofts/activities/api/api_calls.dart";
import "package:brownsofts/activities/authentivation/create_user.dart";
import "package:brownsofts/activities/authentivation/google_signin.dart";
import "package:brownsofts/activities/authentivation/sign_In.dart";
import "package:brownsofts/activities/models/remember_user.dart";
import "package:brownsofts/activities/models/user.dart";
import "package:brownsofts/main%20screen.dart";
import "package:brownsofts/screens/fragments/constants.dart";
import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';
import "package:get/get.dart";
import "package:google_sign_in/google_sign_in.dart";
import 'package:http/http.dart' as http;
import "package:flutter_dotenv/flutter_dotenv.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized;
  await dotenv.load(fileName: ".env");
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
//Page were login  and signup stage begins

class _HomePageState extends State<HomePage> {
  Future googleLogintoSQL(GoogleSignInAccount? user) async {
    try {
      print(
          "glg ${user!.displayName} , ${user.email}, ${user.id} ,${user.runtimeType.toString()}");
      var send = await http.post(Uri.parse(API.googlelogin),
          body: jsonEncode({
            "user_name": user!.displayName.toString(),
            "user_email": user.email.toString(),
            "user_login_id": user.id.toString(),
            "user_login_type": user.runtimeType.toString()
          }));
      Fluttertoast.showToast(msg: "${send.statusCode}");
      if (send.statusCode == 200) {
        Fluttertoast.showToast(msg: "2");
        var resBody = jsonDecode(send.body);
        if (resBody["success"]) {
          Fluttertoast.showToast(msg: "You Logged in sucesfuly");

          Future.delayed(
              Duration(milliseconds: 100), () => Get.off(const MainScreen()));
          const LinearProgressIndicator();
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Remembrprefs.readCurrentUser(),
        builder: (ctx, datasnapshots) {
          
          if (datasnapshots.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Image(image: AssetImage("assets/brownsofts logo.png")),
            );
          }
          if (datasnapshots.connectionState == ConnectionState.done) {
            if (datasnapshots.data == null) {
              return WelcomeScreen();
            } else {
              username.value = datasnapshots.data!.name;
              useremail.value = datasnapshots.data!.user_email;
              userID.value = datasnapshots.data!.id.toString();
              

              return const MainScreen();
            }
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

          return const MainScreen();
          // return const CreateAccountPage();
        });
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

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
                height: MediaQuery.of(context).size.height / 1.8,
                child: Center(
                  child: SizedBox(
                    width: 350,
                    child: Image.asset(
                      "assets/brownsofts logo.png",
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
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
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: OutlinedButton(
                    onLongPress: () async {
                      await Google_Login.signOut();
                      Fluttertoast.showToast(msg: "Signed out successfully");
                    },
                    onPressed: () async {
                      // The button or action to trigger the sign-in
// ...

                      var user = await Google_Login.login();

                      if (user == null) {
                        Fluttertoast.showToast(
                            msg: "Google Sign-In cancelled or failed.");
                      } else {
                        //here it is
                        http.Response responseFrom =
                            await ApiCalls().googleSignIn(user);
                        print("here is the response ${responseFrom.body}");

                        Fluttertoast.showToast(
                            msg: "Signed in as: ${user.toString()}");

                        print("signe:" + user.toString());
                        var responseBody = jsonDecode(responseFrom.body);

                        userID.value = responseBody["user_id"].toString();

//save the user with Remembrprefs
                        User _current_user = User(
                            name: user.displayName.toString(),
                            user_email: user.email,
                            user_password: user.id,
                            google_login_id: user.id,
                            id: userID.value.toString(),
                            profile_image: user.photoUrl);

                        await Remembrprefs.saveMyUserInfo(_current_user);

                        Fluttertoast.showToast(
                            msg: responseFrom.body.toString());

                        Get.off(MainScreen());
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
                  height: MediaQuery.of(context).size.height * 0.07,
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
}
