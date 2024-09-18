import 'package:flutter/material.dart';

class SIgnInPage extends StatefulWidget {
  const SIgnInPage({super.key});

  @override
  State<SIgnInPage> createState() => _SIgnInPageState();
}

class _SIgnInPageState extends State<SIgnInPage> {
  final email = TextEditingController();
  final password = TextEditingController();
  final formkey = GlobalKey<FormState>();
  String entered_emiail = "";
  String entered_password = "";
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(left: 25, top: 25, bottom: 25, right: 15),
        child: ListView(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 150,
              ),
              const Text(
                "Login ",
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
                      //email Field
                      TextFormField(
                        onSaved: (val) {
                          entered_emiail = val.toString();
                        },
                        validator: (value) {
                          if (value == null ||
                              value!.isEmpty ||
                              !value.contains("@")) {
                            return "Please enter a Valid Email Address";
                          } else
                            return null;
                        },
                        autofocus: true,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email_outlined),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                borderRadius: BorderRadius.circular(20)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            label: Text("Email"),
                            hintText: "user123@gail.com"),
                        controller: email,
                      ),
                      const SizedBox(
                        height: 25,
                      ), //Password Field
                      TextFormField(
                        onSaved: (val) {
                          entered_password = val.toString();
                        },
                        validator: (value) {
                          if (value == null || value!.isEmpty) {
                            return "Please mention password";
                          } else
                            return null;
                        },
                        autofocus: true,
                        obscureText: visible,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 10),
                            suffix: IconButton(
                                onPressed: () {
                                  setState(() {
                                    visible = !visible;
                                  });
                                },
                                icon: visible
                                    ? const Icon(Icons.visibility_outlined)
                                    : const Icon(
                                        Icons.visibility_off_outlined)),
                            prefixIcon: const Icon(Icons.lock_person_outlined),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                borderRadius: BorderRadius.circular(20)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            label: const Text(" Password"),
                            hintText: "***"),
                        controller: password,
                      ),

                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 50,
                        width: 175,
                        child: Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              bool valid = formkey.currentState!.validate();
                              formkey.currentState!.save();
                              print(valid);
                              print("$entered_emiail ,$entered_password");
                            },
                            label: const Text("LOGIN "),
                            icon: const Icon(Icons.arrow_right_rounded),
                            iconAlignment: IconAlignment.end,
                          ),
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ]),
      ),
    );
  }
}
