// import 'dart:ui_web';

import 'package:brownsofts/activities/models/remember_user.dart';
// import 'package:brownsofts/activities/models/user.dart';
import 'package:brownsofts/main.dart';
import 'package:brownsofts/screens/conrollers/userdetailscontroller.dart';
import 'package:brownsofts/screens/fragments/constants.dart';
import 'package:brownsofts/screens/fragments/controllers/profilecontrollers.dart';
import 'package:brownsofts/screens/utils/constants.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  late Userdetailscontroller userdetailscontroller;
  late Profilecontrollers profilecontrollers;
  @override
  void initState() {
    // TODO: implement initState
    // retriving_data();
    userdetailscontroller = Get.put(Userdetailscontroller());
    userdetailscontroller.retriving_data();

    profilecontrollers = Get.put(Profilecontrollers());
    profilecontrollers.isLoading1.value = true;
    starttimer();
    super.initState();
  }

  starttimer() async {
    Future.delayed(Duration(seconds: 3), () {
      profilecontrollers.isLoading1.value = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _profileActions() {
      return [
        // SettingsSection(
        //   title: 'Account Settings',
        //   items: [
        //     SettingsItemData(
        //       icon: Icons.person_outline,
        //       label: 'Edit Profile',
        //       onTap: () {},
        //     ),
        //     SettingsItemData(
        //       icon: Icons.notifications_none,
        //       label: 'Notifications',
        //       onTap: () {},
        //     ),
        //     SettingsItemData(
        //       icon: Icons.lock_outline,
        //       label: 'Change Password',
        //       onTap: () {},
        //     ),
        //     SettingsItemData(
        //       icon: Icons.payment_outlined,
        //       label: 'Payment Methods',
        //       onTap: () {},
        //     ),
        //   ],
        // ),
        SettingsSection(
          title: 'Support & Legal',
          items: [
            SettingsItemData(
              icon: Icons.help_outline,
              label: 'Help Center',
              onTap: () async {
                final __uri = Uri.parse("https://brownsofts.com/contact");

                launchUrl(
                  __uri,
                  mode: LaunchMode.inAppWebView,
                );
              },
            ),
            SettingsItemData(
              icon: Icons.article_outlined,
              label: 'Terms of Service',
              onTap: () async {
                final __uri =
                    Uri.parse("https://brownsofts.com/terms--conditions");

                launchUrl(
                  __uri,
                  mode: LaunchMode.inAppWebView,
                );
              },
            ),
            SettingsItemData(
              icon: Icons.privacy_tip_outlined,
              label: 'Privacy Policy',
              onTap: () async {
                final __url =
                    Uri.parse("https://brownsofts.com/privacy-policy");
                launchUrl(
                  __url,
                  mode: LaunchMode.inAppWebView,
                );
              },
            ),
            SettingsItemData(
              icon: Icons.logout,
              label: 'Logout',
              onTap: () {
                Remembrprefs.removeUser();
                _navigatorKey.currentState
                    ?.pushReplacement(MaterialPageRoute(builder: (v) {
                  return HomePage();
                }));

                Get.offAll(() => HomePage());
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Log out Succes")));
              },
              iconColor: Colors.red,
              labelColor: Colors.red,
            ),
          ],
        ),
      ];
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 190,
            child: Stack(
              children: [
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                      color: Theme.of(context).appBarTheme.backgroundColor,
                      //       color: Colors.orange[300],
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(100),
                          bottomRight: Radius.circular(100))),
                ),
                Align(
                  alignment: Alignment(0, 1.3),
                  child: CircleAvatar(
                    maxRadius: 75,
                    backgroundColor: Colors.white,
                    child: Obx(() {
                      return CircleAvatar(
                          maxRadius: 70,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: ColorsUsed.primaryColor,
                              ),
                            ),
                          ),
                          onForegroundImageError: (exception, stackTrace) {
                            print("Error loading profile image: $exception");
                          },
                          //   foregroundColor: Colors.white,
                          //  backgroundColor: Colors.white,
                          //    foregroundColor: Colors.orange,
                          foregroundImage: userdetailscontroller
                                  .uprofile_image.value.isEmpty
                              ? NetworkImage(SampleNetworkImages.userProfilePic,
                                  scale: 0.8)
                              : NetworkImage(
                                  userdetailscontroller.uprofile_image.value,
                                ));
                    }),
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
                    '${userdetailscontroller.uname.value}',
                    style: TextStyle(
                      fontFamily: GoogleFonts.aBeeZee().fontFamily,
                      fontSize: 15, // Adjust size as needed

                      color: Colors.black, // Text color
                    ),
                  )),
            ],
          ),
          Obx(() => Text(
                '${userdetailscontroller.uuser_email.value}',
                style: TextStyle(
                  fontFamily:
                      GoogleFonts.aBeeZeeTextTheme().titleLarge!.fontFamily,
                  fontSize: 12, // Adjust size as needed

                  color: Colors.black, // Text color
                ),
              )),
          Obx(() => Text(
                '${userdetailscontroller.ugoogle_login_id.value}',
                style: TextStyle(
                  fontFamily:
                      GoogleFonts.aBeeZeeTextTheme().titleLarge!.fontFamily,
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
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     InkWell(
          //       onTap: () {
          //         ScaffoldMessenger.of(context)
          //             .showSnackBar(SnackBar(content: Text("Profile Edited ")));
          //       },
          //       child: Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Text(
          //           "Edit Profile",
          //           style: TextStyle(
          //             fontFamily:
          //                 GoogleFonts.aBeeZeeTextTheme().titleLarge!.fontFamily,
          //             fontSize: 14, // Adjust size as needed

          //             color: const Color.fromARGB(255, 0, 0, 0), // Text color
          //           ),
          //         ),
          //       ),
          //     ),
          //     InkWell(
          //       onTap: () {
          //         Remembrprefs.removeUser();
          //         _navigatorKey.currentState
          //             ?.pushReplacement(MaterialPageRoute(builder: (v) {
          //           return HomePage();
          //         }));

          //         Get.offAll(() => HomePage());
          //         ScaffoldMessenger.of(context)
          //             .showSnackBar(SnackBar(content: Text("Log out Succes")));
          //       },
          //       child: Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Text(
          //           "Log Out",
          //           style: TextStyle(
          //             fontFamily:
          //                 GoogleFonts.aBeeZeeTextTheme().titleLarge!.fontFamily,
          //             fontSize: 14, // Adjust size as needed

          //             color: const Color.fromARGB(255, 0, 0, 0), // Text color
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          Obx(
            () {
              return profilecontrollers.isLoading1.value
                  ? RecentOrdersSkeleton()
                  : RecentOrdersWidget();
            },
          ),
          Column(
            children: _profileActions(),
          )
        ],
      ),
    );
  }
}

class RecentOrdersWidget extends StatelessWidget {
  final List<Order> orders = [
    Order(
      serviceName: "Professional Video Editing",
      by: "Sarah Miller",
      date: "2024-01-15",
      status: OrderStatus.completed,
      price: 45,
    ),
    Order(
      serviceName: "Website Design Package",
      by: "Alex Johnson",
      date: "2024-01-12",
      status: OrderStatus.inProgress,
      price: 299,
    ),
    Order(
      serviceName: "SEO Optimization",
      by: "Emma Davis",
      date: "2024-01-08",
      status: OrderStatus.completed,
      price: 89,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ThemeData.light().colorScheme.background,
      margin: EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Orders',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  'View All',
                  style: TextStyle(
                    color: Colors.orange[700],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            ...orders.map((order) => OrderTile(order: order)).toList(),
          ],
        ),
      ),
    );
  }
}

class Order {
  final String serviceName;
  final String by;
  final String date;
  final OrderStatus status;
  final double price;

  Order({
    required this.serviceName,
    required this.by,
    required this.date,
    required this.status,
    required this.price,
  });
}

enum OrderStatus { completed, inProgress }

class OrderTile extends StatelessWidget {
  final Order order;

  const OrderTile({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    String statusText;
    switch (order.status) {
      case OrderStatus.completed:
        statusColor = Colors.green.shade100;
        statusText = 'Completed';
        break;
      case OrderStatus.inProgress:
        statusColor = Colors.orange.shade100;
        statusText = 'In Progress';
        break;
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Title & Details
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.serviceName,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(height: 5),
                Text(
                  'by ${order.by}',
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
                Text(
                  order.date,
                  style: TextStyle(color: Colors.grey[500], fontSize: 12),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(
                        color: order.status == OrderStatus.completed
                            ? Colors.green
                            : Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '\$${order.price.toInt()}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class RecentOrdersSkeleton extends StatelessWidget {
  final int itemCount;

  const RecentOrdersSkeleton({super.key, this.itemCount = 3});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ThemeData.light().colorScheme.background,
      margin: EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(width: 120, height: 20, color: Colors.white),
                  Container(width: 50, height: 20, color: Colors.white),
                ],
              ),
            ),
            SizedBox(height: 16),
            // List placeholders
            Column(
              children:
                  List.generate(itemCount, (index) => _orderSkeletonItem()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _orderSkeletonItem() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left column placeholders
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 180, height: 18, color: Colors.white),
                  SizedBox(height: 8),
                  Container(width: 120, height: 14, color: Colors.white),
                  SizedBox(height: 4),
                  Container(width: 70, height: 12, color: Colors.white),
                ],
              ),
              // Right column placeholders
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 80,
                    height: 22,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(width: 40, height: 18, color: Colors.white),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

//Account settings

// Reusable SettingsSection for Column usage (no ListView)
class SettingsSection extends StatelessWidget {
  final String title;
  final List<SettingsItemData> items;

  const SettingsSection({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ThemeData.light().colorScheme.background,
      elevation: 0,
      margin:
          EdgeInsets.symmetric(vertical: 8, horizontal: 20), // vertical spacing
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                )),
            SizedBox(height: 14),
            ...items.map((item) => SettingsTile(data: item)).toList(),
          ],
        ),
      ),
    );
  }
}

// Data holder for settings item
class SettingsItemData {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? labelColor;

  SettingsItemData({
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconColor,
    this.labelColor,
  });
}

// Reusable settings tile for individual items
class SettingsTile extends StatelessWidget {
  final SettingsItemData data;

  const SettingsTile({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: Text(
        data.label,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: data.labelColor ?? Colors.black,
        ),
      ),
      contentPadding: EdgeInsets.zero,
      trailing: Icon(Icons.chevron_right, color: Colors.grey[400]),
      leading: CircleAvatar(
        radius: 16,
        backgroundColor: Colors.grey[100],
        child: Icon(
          data.icon,
          color: data.iconColor ?? Colors.black54,
          size: 18,
        ),
      ),
      onTap: data.onTap,
    );
  }
}
