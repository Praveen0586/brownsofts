// import 'dart:developer';

import 'package:brownsofts/activities/models/remember_user.dart';
import 'package:brownsofts/screens/conrollers/userdetailscontroller.dart';
import 'package:brownsofts/screens/fragments/category_service.dart';
import 'package:brownsofts/screens/fragments/constants.dart';
import 'package:brownsofts/screens/fragments/contact.dart';
import 'package:brownsofts/screens/fragments/home%20screen.dart';
import 'package:brownsofts/screens/fragments/profile.dart';
import 'package:brownsofts/screens/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:brownsofts/service/mail_services.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Moved currentindex to the class level

  RxInt currentindex = 2.obs;

  late Userdetailscontroller userdetailscontroller;
  @override
  void initState() {
    super.initState();

    userdetailscontroller = Get.put(Userdetailscontroller());
    // TODO: implement initState

    userdetailscontroller.retriving_data();
  }

  bool floatingmailButton = false;
  @override
  Widget build(BuildContext context) {
    var colorisOrange = true;
    return Scaffold(
        // floatingActionButton: FloatingActionButton(
        //     onPressed: floatingmailButton
        //         ? () {
        //             MailService().send_mail(
        //                 "PRAVEEN",
        //                 "1@GMAIL.COM",
        //                 "WHATSAPP GTDHWJD",
        //                 "SOMETHING I WAT TO TELL",
        //                 "COLOR GRADING",
        //                 "PACKAGE",
        //                 23.toString(),
        //                 DateTime.now().toString(),
        //                 "gopal");
        //           }
        //         : () {
        //             // log("My First Log",
        //             //     name: "Praveen",
        //             //     level: 1,
        //             //     error: "Some Error",
        //             //     stackTrace: StackTrace.empty);
        //             Fluttertoast.showToast(msg: "some buton Preesed ");
        //           }),
        resizeToAvoidBottomInset: true,
        backgroundColor: Theme.of(context).cardTheme.surfaceTintColor,
        key: _scaffoldKey,
        appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          // bottom: PreferredSize(
          //     preferredSize: Size(MediaQuery.of(context).size.width, 100),
          //     child: Container(
          //       decoration: BoxDecoration(
          //           color: const Color.fromARGB(201, 254, 249, 245),
          //           borderRadius: BorderRadius.circular(100)),
          //     )),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: colorisOrange
              ? ColorsUsed.primaryColor
              : const Color.fromARGB(201, 254, 249, 245),
          elevation: 20,
          title: const Text(
            "BrownSofts",
            style: TextStyle(
                fontSize: 25, letterSpacing: 3, fontWeight: FontWeight.bold),
          ),
          leading: Builder(builder: (context) {
            return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(Icons.dehaze_outlined));
          }),
          actions: [
            IconButton(
                onPressed: () {
                  //Page for Notification
                },
                icon: const Icon(
                  Icons.notifications_none,
                )),
          ],
        ),

        ///Drawer
        drawer: Padding(
          padding: const EdgeInsets.all(12),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Drawer(
                width: 320,
                elevation: 100,
                backgroundColor: const Color.fromARGB(255, 254, 249, 245),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.orange[300],
                      width: 320,
                      padding: const EdgeInsets.only(left: 25, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Obx(() {
                            return CircleAvatar(
                              maxRadius: 70,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: ColorsUsed.primaryColor,
                                    ),
                                  )),
                              foregroundImage: userdetailscontroller
                                      .uprofile_image.value.isEmpty
                                  ? NetworkImage(
                                      SampleNetworkImages.userProfilePic)
                                  : NetworkImage(userdetailscontroller
                                      .uprofile_image.value),
                            );
                          }),
                          SizedBox(
                            height: 7,
                          ),
                          Obx(() => Text(
                                '${userdetailscontroller.uname.value}',
                                style: TextStyle(
                                  fontFamily: GoogleFonts.aBeeZee().fontFamily,
                                  fontSize: 15, // Adjust size as needed

                                  color: Colors.black, // Text color
                                ),
                              )),
                          Obx(() => Text(
                                userdetailscontroller.uuser_email.value,
                                style: TextStyle(
                                  fontFamily: GoogleFonts.aBeeZeeTextTheme()
                                      .titleLarge!
                                      .fontFamily,
                                  fontSize: 12, // Adjust size as needed

                                  color: Colors.black, // Text color
                                ),
                              )),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (cc) {
                          return MainScreen();
                        }));
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text("Home")));
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 20, left: 30, bottom: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            Icon(Icons.home_max_outlined),
                            SizedBox(
                              width: 30,
                            ),
                            Text(
                              'Home',
                              style: TextStyle(
                                fontFamily: GoogleFonts.aBeeZeeTextTheme()
                                    .titleLarge!
                                    .fontFamily,
                                fontSize: 15, // Adjust size as needed

                                color: Colors.black, // Text color
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (vbn) {
                          return CategoryServicePage(
                            index_of_Category: 0,
                            topic: true,
                          );
                        }));
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text("Service")));
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 20, left: 30, bottom: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            Icon(Icons.message_outlined),
                            SizedBox(
                              width: 30,
                            ),
                            Text(
                              'Services',
                              style: TextStyle(
                                fontFamily: GoogleFonts.aBeeZeeTextTheme()
                                    .titleLarge!
                                    .fontFamily,
                                fontSize: 15, // Adjust size as needed

                                color: Colors.black, // Text color
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    divider,
                    Column(
                      children: List.generate(drawer_categery.length, (nd) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (vbn) {
                              return CategoryServicePage(
                                index_of_Category: nd,
                                topic: true,
                              );
                            }));
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text("${drawer_categery[nd]["name"]}")));
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                top: nd == 0 ? 4 : 20, left: 30, bottom: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              children: [
                                Icon(drawer_categery[nd]["icon"]),
                                SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  '${drawer_categery[nd]["name"]}',
                                  style: TextStyle(
                                    fontFamily: GoogleFonts.aBeeZeeTextTheme()
                                        .titleLarge!
                                        .fontFamily,
                                    fontSize: 15, // Adjust size as needed

                                    color: Colors.black, // Text color
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                    divider,
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Go To Site")));
                        // Link();
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 5, left: 30, bottom: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            Icon(Icons.public_sharp),
                            SizedBox(
                              width: 30,
                            ),
                            Text(
                              'Go To Site',
                              style: TextStyle(
                                fontFamily: GoogleFonts.aBeeZeeTextTheme()
                                    .titleLarge!
                                    .fontFamily,
                                fontSize: 15, // Adjust size as needed

                                color: Colors.black, // Text color
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    //footer Section
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10, left: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                CircleAvatar(
                                    child: Image(
                                        image: AssetImage(
                                            "assets/brownsofts logo.png"))),
                                Padding(
                                  padding: const EdgeInsets.only(left: 14),
                                  child: Text(
                                    "Brownsofts",
                                    style: TextStyle(
                                      fontFamily: GoogleFonts.aBeeZeeTextTheme()
                                          .titleLarge!
                                          .fontFamily,
                                      fontSize: 15, // Adjust size as needed

                                      color: Colors.black, // Text color
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 14, right: 15),
                            child: Text(
                              "Help ?",
                              style: TextStyle(
                                fontFamily: GoogleFonts.aBeeZeeTextTheme()
                                    .titleLarge!
                                    .fontFamily,
                                fontSize: 15, // Adjust size as needed

                                color: Colors.black, // Text color
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
          ),
        ),

        //Bottom sheeet
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            backgroundColor: const Color.fromARGB(200, 100, 45, 0),
            currentIndex: currentindex.value,
            onTap: (value) {
              setState(() {
                currentindex.value = value;
              });
            },
            //   mouseCursor: MouseCursor.defer, selectedFontSize: 14,
            unselectedFontSize: 10,
            showUnselectedLabels: true,
            selectedFontSize: 12,
            unselectedLabelStyle: TextStyle(color: Colors.black),
            // selectedLabelStyle:
            //     TextStyle(color: const Color.fromARGB(255, 185, 85, 49)),
            showSelectedLabels: true, useLegacyColorScheme: false,
            selectedIconTheme: IconThemeData(
                opacity: 1,
                color: ColorsUsed.colorisOrange
                    ? ColorsUsed.primaryColor
                    : Colors.brown,
                size: 20,
                shadows: [
                  BoxShadow(
                      color: Colors.brown,
                      blurRadius: 1,
                      spreadRadius: 50,
                      blurStyle: BlurStyle.inner),
                ]),
            unselectedIconTheme: IconThemeData(
              opacity: 0.9,
              size: 15,
              color: const Color.fromARGB(255, 145, 109, 96),
            ),
            items: List.generate(4, (index) {
              final bottom = bottom_bar_icons[index];
              final active = Icon(bottom["active"]);
              final non = Icon(bottom["non_active"]);
              final label = bottom["label"];
              return BottomNavigationBarItem(
                  activeIcon: active, icon: non, label: label, tooltip: "tool");
            }),
            // items: const [
            //   BottomNavigationBarItem(
            //       icon: Icon(Icons.home_max_outlined), label: "Home"),
            //   BottomNavigationBarItem(
            //       icon: Icon(Icons.speaker_notes_outlined), label: "Services"),
            //   BottomNavigationBarItem(
            //       icon: Icon(Icons.contacts_outlined), label: "Contact"),
            //   BottomNavigationBarItem(
            //       icon: Icon(Icons.person_2_outlined), label: "Profile"),
            // ],
          ),
        ),
        body: Obx(() {
          return screenList[currentindex.value];
        }));
  }
}

//corresponding datas
List<Widget> screenList = [
  // const MainScreen(),
  // const ServicePage(),
  // const DesignedContact(),
  // const Profile()
  HomeScreen(),
  CategoryServicePage(
    index_of_Category: 0,
    topic: false,
  ),

  // DesignedContact(),
  ContactUsScreen(),
  Profile()
];

List<Map> bottom_bar_icons = [
  {
    "active": Icons.home_max,
    "non_active": Icons.home_max_rounded,
    "label": "Home"
  },
  {
    "active": Icons.speaker_notes_rounded,
    "non_active": Icons.speaker_notes_outlined,
    "label": "Services"
  },
  {
    "active": Icons.contacts_rounded,
    "non_active": Icons.contacts_outlined,
    "label": "Contact"
  },
  {
    "active": Icons.person_2_rounded,
    "non_active": Icons.person_outline_rounded,
    "label": "Profile"
  },
];

var divider = Divider(
  height: 20,
  endIndent: 25,
  indent: 25,
  color: Colors.orange[300],
);

List drawer_categery = [
  {"name": "Video & Animation ", "icon": Icons.movie_creation_outlined},
  {"name": "Web Design", "icon": Icons.code},
  {"name": "Graphics & Design", "icon": FontAwesomeIcons.paintbrush},
  {"name": "SEO & Marketting", "icon": Icons.campaign_outlined},
  {"name": "Admin Support", "icon": FontAwesomeIcons.headset},
];
// FontAwesomeIcons.paintbrush


