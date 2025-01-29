import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DesignedContact extends StatefulWidget {
  const DesignedContact({super.key});

  @override
  State<DesignedContact> createState() => _DesignedContactState();
}

class _DesignedContactState extends State<DesignedContact> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    final textColor = Color.fromARGB(255, 126, 67, 45);
    final bag = const Color.fromARGB(255, 255, 241, 235).withOpacity(0.8);
    return Stack(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Container(
            height: h - 10,
            width: w / 1.5,
            decoration: BoxDecoration(
              //Colos.Orange[300]
                color: const Color.fromARGB(255, 238, 224, 220),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(400),
                    bottomLeft: Radius.circular(400))),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: w / 1.24,
            height: h / 1.5,
            decoration: BoxDecoration(
                color: ThemeData().colorScheme.surface,
                borderRadius: BorderRadius.circular(20)),
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 48),
                    child: Text(
                      "Let's Get In Touch",
                      style: TextStyle(
                        color: Colors.brown,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  //under lets get in touch line
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Or just reach out manually to ",
                        style: TextStyle(fontSize: 10),
                      ),
                      InkWell(
                        onTap: () {},
                        child: const Text(
                          "bs@brownsofts.com",
                          style:
                              TextStyle(color: Color.fromARGB(255, 87, 35, 16)),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 40),
                    child: TextFormField(
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 15),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.brown,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.brown,
                            ),
                          ),
                          prefixIcon: Icon(Icons.person_2_outlined,size: 19,
                              color: Colors.brown),
                          //   hintText: "Enter Your Full Name",
                          labelText: "Full Name",
                          labelStyle: const TextStyle(fontSize: 13)),
                    ),
                  ),

                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: TextFormField(
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.brown,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.brown,
                            ),
                          ),
                          prefixIcon: Icon(size: 19,
                            Icons.email_outlined,
                            color: Colors.brown,
                          ),
                          labelStyle: const TextStyle(fontSize: 13),
                          //    hintText: "Enter your Email Address",
                          label: Text("Email Address")),
                    ),
                  ),

                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: TextFormField(
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.brown,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.brown,
                            ),
                          ),
                          prefixIcon: Icon(size: 19,
                            Icons.mail_outline_rounded,
                            color: Colors.brown,
                          ),
                          labelStyle: const TextStyle(fontSize: 13),
                          //    hintText: " subject here  ...",
                          label: Text("Subject")),
                    ),
                  ),

                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: TextFormField(
                      maxLines: null,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.brown,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.brown,
                            ),
                          ),
                          labelStyle: const TextStyle(fontSize: 13),
                          //    hintText: "Tell us what can we help ?",
                          label: Text("Questions ?")),
                    ),
                  ),

                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 40),
                    child: Center(
                        child: Material(
                      child: Container(
                        child: TextButton(
                            onPressed: () {
                              
                            },
                            child: Text("Submit",
                                style: GoogleFonts.ubuntu(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500))),
                        height: 45,
                        width: 180,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 224, 103, 28),
                            borderRadius: BorderRadius.circular(15)),
                      ),
                    )),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
