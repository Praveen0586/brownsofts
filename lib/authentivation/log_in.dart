import 'package:brownsofts/authentivation/sign_In.dart';
import 'package:flutter/material.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPage();
}

class _CreateAccountPage extends State<CreateAccountPage> {
  final name = TextEditingController();
  final email = TextEditingController();
  final pass1 = TextEditingController();
  final pass2 = TextEditingController();

  String e_name = "";
  String e_email = "";
  String e_pass1 = "";
  String e_pass2 = "";

  final formkey1 = GlobalKey<FormState>();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    name.dispose();
    email.dispose();
    pass1.dispose();
    pass2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(25),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 130,
                ),
                const Text(
                  "Create Account ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 45,
                  ),
                ),
                const SizedBox(
                  height: 75,
                ),
                Form(
                    key: formkey1,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(15),
                              prefixIcon: Icon(
                                Icons.person_2_outlined,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    width: 2,
                                  )),
                              //   prefixIcon: Icon(Icons.person_2_outlined),
                              label: Text("Full Name")),
                          autocorrect: false,
                          controller: name,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value == null || value!.trim().isEmpty) {
                              return "Enter Your name";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (newValue) {
                            e_name = newValue!;
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ), //email
                        TextFormField(
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(15),
                              prefixIcon: Icon(
                                Icons.email_outlined,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    width: 2,
                                  )),
                              //   prefixIcon: Icon(Icons.person_2_outlined),
                              label: Text("Email")),
                          autocorrect: false,
                          controller: email,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null ||
                                value!.trim().isEmpty ||
                                !value.contains("@")) {
                              return "Please enter a valid Email Address";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (newValue) {
                            e_email = newValue!;
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ), //Password 1
                        TextFormField(
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(15),
                              prefixIcon: Icon(
                                Icons.password_outlined,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    width: 2,
                                  )),
                              //   prefixIcon: Icon(Icons.person_2_outlined),
                              label: Text("Password")),
                          autocorrect: false,
                          obscureText: true,
                          controller: pass1,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value!.trim().isEmpty) {
                              return "Enter Password";
                            } else if (pass1.text != pass2.text) {
                              return "Password missmatch";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (newValue) {
                            e_pass1 = newValue!;
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(15),
                              prefixIcon: Icon(
                                Icons.password_outlined,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    width: 2,
                                  )),
                              //   prefixIcon: Icon(Icons.person_2_outlined),
                              label: Text("Re-Enter Password")),
                          autocorrect: false,
                          obscureText: true,
                          controller: pass2,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value!.trim().isEmpty) {
                              return "Enter Password";
                            } else if (pass1.text != pass2.text) {
                              return "Password missmatch";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (newValue) {
                            e_pass2 = newValue!;
                          },
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: SizedBox(
                            height: 50,
                            width: 175,
                            child: OutlinedButton.icon(
                              onPressed: () {
                                formkey1.currentState!.validate();
                                formkey1.currentState!.save();
                                print(formkey1.currentState!.validate());
                                if (formkey1.currentState!.validate()) {
                                  print("$e_email,$e_name,$e_pass1,$e_pass2");
                                }
                              },
                              iconAlignment: IconAlignment.end,
                              label: const Text("Sign UP"),
                              icon: const Icon(Icons.arrow_right_rounded),
                              style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                      width: 2,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 55,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account?",
                              style: TextStyle(fontSize: 15),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (ctx) => const SignInPage()),
                                );
                            //    Navigator.pop(context);
                              },
                              child: const Text(
                                "Sign In",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
