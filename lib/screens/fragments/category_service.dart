import 'package:brownsofts/screens/fragments/service%20view%20screen.dart';
import 'package:dynamic_tabbar/dynamic_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:brownsofts/data/s data.dart';

class CategoryServicePage extends StatefulWidget {
  const CategoryServicePage({super.key});

  @override
  State<CategoryServicePage> createState() => _CategoryServicePageState();
}

class _CategoryServicePageState extends State<CategoryServicePage> {
  List<Map<dynamic, dynamic>> video_animation = [];
  List all = all_service;

  sorting() {
    all.forEach((data) {
      String __categeryCode = data["category_code"];
      if (__categeryCode.contains("VA0")) {
        video_animation.add(data);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    sorting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    vidandani() {
      return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: ListView.builder(
                          itemCount: video_animation.length,
                          physics: const ScrollPhysics(),
                          itemBuilder: (BuildContext context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (ctr) {
                                    return Serviceviewscreen(
                                      currentServiceMap: video_animation[index],
                                    );
                                  }),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 1, left: 10, right: 10, bottom: 5),
                                child: Container(
                                  height: 150,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color:
                                          const Color.fromARGB(80, 121, 85, 72),
                                    ),
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: SizedBox(
                                          width: 150,
                                          child: Image(
                                            image:NetworkImage("${video_animation[index]["image"]}"),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 15,
                                            left: 11,
                                            right: 5,
                                            bottom: 20),
                                        child: SizedBox(
                                          width: 195,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${video_animation[index]["name"]}",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                "${video_animation[index]["description"][1]}",
                                                style: const TextStyle(
                                                  fontSize: 10,
                                                ),
                                                maxLines: 4,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const Spacer(),
                                              Row(
                                                children: const [
                                                  Icon(
                                                    Icons.star_border_outlined,
                                                    size: 15,
                                                  ),
                                                  Text("4.2"),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    List<TabData> tabdata = [
      TabData(
        index: 1,
        title: const Tab(text: "Video & Animation"),
        content: vidandani(),
      ),
      TabData(
        index: 2,
        title: const Tab(text: "Web Design"),
        content: const Center(
          child: Text("Web Design"),
        ),
      ),
      TabData(
        index: 3,
        title: const Tab(text: "Graphics and Design"),
        content: const Center(
          child: Text("Graphics and Design"),
        ),
      ),
      TabData(
        index: 4,
        title: const Tab(text: "SEO & Marketing"),
        content: const Center(
          child: Text("SEO & Marketing"),
        ),
      ),
      TabData(
        index: 5,
        title: const Tab(text: "Admin Support"),
        content: const Center(
          child: Text("Admin Support"),
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Browse Our Collection',
          style: TextStyle(
            fontFamily: GoogleFonts.aBeeZeeTextTheme().titleLarge!.fontFamily,
            fontSize: 20, // Adjust size as needed

            color: Colors.black, // Text color
          ),
        ),
      ),
      body: DynamicTabBarWidget(
        padding: const EdgeInsets.only(top: 15, bottom: 10),
        isScrollable: true,
        showNextIcon: false,
        showBackIcon: false,
        onAddTabMoveTo: MoveToTab.first,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        dynamicTabs: tabdata,
        onTabControllerUpdated: (controller) {},
      ),
    );
  }
}
