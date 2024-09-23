import 'dart:convert';

import 'package:brownsofts/activities/API/api.dart';
import 'package:brownsofts/activities/authentivation/create_user.dart';
import 'package:brownsofts/activities/models/remember_user.dart';
import 'package:brownsofts/activities/models/user.dart';
import 'package:brownsofts/screens/dummyscreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  bool visible = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  String entered_email = "";
  String entered_password = "";

  Future login_user() async {
    try {
      var send = await http.post(Uri.parse(API.loginuser), body: {
        "user_email": entered_email.toString(),
        "user_password": entered_password.toString(),
      });
      // Fluttertoast.showToast(msg: "${send.statusCode}");
      if (send.statusCode == 200) {
        Fluttertoast.showToast(msg: "2");
        var resBody = jsonDecode(send.body);
        if (resBody["success"] == true) {
          // Fluttertoast.showToast(msg: "${entered_email},${entered_password}");
          // Fluttertoast.showToast(msg: "You Logged in sucesfuly");
          // Fluttertoast.showToast(msg: "${resBody['userData']}");

          var datafromSQL = resBody['userData'];

          //save my user credentials

          Remembrprefs.saveMyUserInfo(User(
              name: datafromSQL["user_name"],
              user_email: datafromSQL["user_email"],
              user_password: datafromSQL["user_password"],
              google_login_id: "App Login",
              id: datafromSQL["id"]));
          User? current;
          current = await Remembrprefs.readCurrentUser();
         
          Future.delayed(
             const Duration(microseconds: 100),
              () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => Homescreen())));
        } else {
          Fluttertoast.showToast(msg: "User Email Id and passwod not exist");
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(left: 25, top: 25, bottom: 25, right: 15),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 150,
                ),
                const Text(
                  "Login",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                  ),
                ),
                const Text(
                  "Please sign in to continue",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                Form(
                  key: formkey,
                  child: Column(
                    children: [
                      // Email Field
                      TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !value.contains("@")) {
                            return "Please enter a valid Email Address";
                          }
                          return null;
                        },
                        autofocus: false,
                        onSaved: (newValue) {
                          entered_email = newValue!;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email_outlined),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          label: const Text("Email"),
                          hintText: "user123@gmail.com",
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      // Password Field
                      TextFormField(
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a password";
                          }
                          return null;
                        },
                        obscureText: !visible,
                        onSaved: (newValue) {
                          entered_password = newValue!;
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 10),
                          suffix: IconButton(
                            onPressed: () {
                              setState(() {
                                visible = !visible;
                              });
                            },
                            icon: visible
                                ? const Icon(Icons.visibility_outlined)
                                : const Icon(Icons.visibility_off_outlined),
                          ),
                          prefixIcon: const Icon(Icons.lock_outline),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          label: const Text("Password"),
                          hintText: "••••••••",
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          height: 50,
                          width: 175,
                          child: OutlinedButton.icon(
                            onPressed: () {
                              formkey.currentState!.validate();
                              formkey.currentState!.save();
                              if (formkey.currentState!.validate()) {
                                login_user();
                                print("Email: ${emailController.text}");
                                print("Password: ${passwordController.text}");
                              }
                            },
                            label: const Text("LOGIN"),
                            icon: const Icon(Icons.arrow_right_rounded),
                            style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                    width: 2,
                                    color:
                                        Theme.of(context).colorScheme.primary)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(fontSize: 15),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (ctx) =>
                                        const CreateAccountPage()),
                              );
                            },
                            child: const Text(
                              "Sign up",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
