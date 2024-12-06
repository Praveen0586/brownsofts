import 'package:brownsofts/screens/fragments/home%20screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Moved currentindex to the class level

  RxInt currentindex = 0.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
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
          backgroundColor: const Color.fromARGB(201, 254, 249, 245),
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
                  // Navigator.of(context).push(MaterialPageRoute(builder: (cx) {
                  //   return Notification_screen();
                  // }));
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
                          CircleAvatar(
                            maxRadius: 70,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network(
                                "https://pbs.twimg.com/profile_images/1653626498828619776/D8WR6HGT_400x400.jpg",
                              ),
                            ),
                            foregroundImage: NetworkImage(
                                "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcQEavWvDyRtrk8pOhLeURhoB7zeMsAEXT0kdFDx_r8JREu9KmB2"),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            'User Name',
                            style: TextStyle(
                              fontFamily: GoogleFonts.aBeeZee().fontFamily,
                              fontSize: 15, // Adjust size as needed

                              color: Colors.black, // Text color
                            ),
                          ),
                          Text(
                            'sample6754@gmail.com',
                            style: TextStyle(
                              fontFamily: GoogleFonts.aBeeZeeTextTheme()
                                  .titleLarge!
                                  .fontFamily,
                              fontSize: 12, // Adjust size as needed

                              color: Colors.black, // Text color
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
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
                                        image: AssetImage("assets/logo.png"))),
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
                color: Colors.brown,
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
  Center(
    child: Text("home"),
  ),
  Center(
    child: Text("home"),
  ),
  Center(
    child: Text("home"),
  )
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
