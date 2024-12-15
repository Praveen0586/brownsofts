import 'package:brownsofts/activities/models/remember_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
   RxString uname = "".obs;
    RxString uuser_email = "".obs;
    RxString uuser_password = "".obs;
    RxString ugoogle_login_id = "".obs;
    RxString uid = "".obs;
  retriving_data() async {
   
    var _current_user = await Remembrprefs.readCurrentUser();

    uname.value = _current_user!.name;
    uuser_email.value = _current_user.user_email;
    uuser_password.value = _current_user.user_password!;
    ugoogle_login_id.value = _current_user.google_login_id!;
    uid.value = _current_user.id!;
    print(uname.value);
  }

  @override
  void initState() {
    // TODO: implement initState
    retriving_data();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 250,
          child: Stack(
            children: [
              Container(
                height: 180,
                decoration: BoxDecoration(
                    color: Colors.orange[300],
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(100),
                        bottomRight: Radius.circular(100))),
              ),
              Align(
                alignment: Alignment(0, 1.3),
                child: CircleAvatar(
                  maxRadius: 75,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
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
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 25,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Obx(() => Text(
                  '${uname.value}',
                  style: TextStyle(
                    fontFamily: GoogleFonts.aBeeZee().fontFamily,
                    fontSize: 15, // Adjust size as needed

                    color: Colors.black, // Text color
                  ),
                )),
          ],
        ),
     Obx ( ()=> Text(
          '${uuser_email.value}',
          style: TextStyle(
            fontFamily: GoogleFonts.aBeeZeeTextTheme().titleLarge!.fontFamily,
            fontSize: 12, // Adjust size as needed

            color: Colors.black, // Text color
          ),
        )),
        SizedBox(
          height: 30,
        ),
        Container(
          height: 80,
          width: 270,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13), color: Colors.purple),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Service Ordered',
                        style: TextStyle(
                          decorationColor: Colors.white,
                          fontFamily: GoogleFonts.aBeeZeeTextTheme()
                              .titleLarge!
                              .fontFamily,
                          fontSize: 17, // Adjust size as needed

                          color: const Color.fromARGB(
                              255, 255, 255, 255), // Text color
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, bottom: 5),
                    child: Text(
                      "5",
                      style: TextStyle(
                        fontFamily: GoogleFonts.aBeeZeeTextTheme()
                            .titleLarge!
                            .fontFamily,
                        fontSize: 17, // Adjust size as needed

                        color: const Color.fromARGB(
                            255, 255, 255, 255), // Text color
                      ),
                    ),
                  )
                ],
              ),
              Icon(
                Icons.category_outlined,
                opticalSize: 1,
                color: Colors.white,
                size: 40,
              )
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Profile Edited ")));
              },
              child: Text(
                "Edit Profile",
                style: TextStyle(
                  fontFamily:
                      GoogleFonts.aBeeZeeTextTheme().titleLarge!.fontFamily,
                  fontSize: 14, // Adjust size as needed

                  color: const Color.fromARGB(255, 0, 0, 0), // Text color
                ),
              ),
            ),
            InkWell(
              onTap: () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Log out Succes")));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Log Out",
                  style: TextStyle(
                    fontFamily:
                        GoogleFonts.aBeeZeeTextTheme().titleLarge!.fontFamily,
                    fontSize: 14, // Adjust size as needed

                    color: const Color.fromARGB(255, 0, 0, 0), // Text color
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
