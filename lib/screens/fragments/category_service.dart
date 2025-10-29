import 'package:brownsofts/screens/fragments/service%20view%20screen.dart';
import 'package:brownsofts/screens/search.dart';
import 'package:brownsofts/screens/utils/constants.dart';
import 'package:dynamic_tabbar/dynamic_tabbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:brownsofts/data/s data.dart';

class CategoryServicePage extends StatefulWidget {
  CategoryServicePage({super.key, this.topic, this.index_of_Category});
  int? index_of_Category = 0;
  bool? topic = true;

  @override
  State<CategoryServicePage> createState() => _CategoryServicePageState();
}

class _CategoryServicePageState extends State<CategoryServicePage> {
  TabController? ctl;

  //Marketing & Advertising
  List VA01 = [];
  //    "Social Media & Online Content",
  List VA02 = [];
  //        "Education & Training",
  List VA03 = [];
  //        "Entertainment & Storytelling",
  List VA04 = [];
  //        "Events & Celebrations",
  List VA05 = [];
  //        "Marketing & Advertising"
  List VA06 = [];

  List WD01 = []; // Business Websites
  List WD02 = []; // Landing Pages
  List WD03 = []; // Website Design Services

  List GD01 = []; // Logo & Banner Design
  List GD02 = []; // Documents & Presentations
  List GD03 = []; // Marketing & Branding
  List GD04 = []; // Photo Editing
  List GD05 = []; // UI & UX Designing

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

  sorting_For_WebSubCategories() {
    all_service.forEach((__element) {
      String cCode = __element["category_code"];
      if (cCode.contains("WD01")) {
        WD01.add(__element);
      }
      if (cCode.contains("WD02")) {
        WD02.add(__element);
      }
      if (cCode.contains("WD03")) {
        WD03.add(__element);
      }
    });
  }

  sorting_For_VideoAnimation() {
    List<String> __subcategory = [
      "Color Grading & Animation",
      "Social Media & Online Content",
      "Education & Training",
      "Entertainment & Storytelling",
      "Events & Celebrations",
      "Marketing & Advertising"
    ];

    all_service.forEach((__element) {
      String cCode = __element["category_code"];
      if (cCode.contains("VA01")) {
        VA01.add(__element);
      }
      if (cCode.contains("VA02")) {
        VA02.add(__element);
      }
      if (cCode.contains("VA03")) {
        VA03.add(__element);
      }
      if (cCode.contains("VA04")) {
        VA04.add(__element);
      }
      if (cCode.contains("VA05")) {
        VA05.add(__element);
      }
      if (cCode.contains("VA06")) {
        VA06.add(__element);
      }
    });
  }

  sorting_For_GraphicsDesign() {
    all_service.forEach((__element) {
      String cCode = __element["category_code"];
      if (cCode.contains("GD01")) {
        GD01.add(__element);
      }
      if (cCode.contains("GD02")) {
        GD02.add(__element);
      }
      if (cCode.contains("GD03")) {
        GD03.add(__element);
      }
      if (cCode.contains("GD04")) {
        GD04.add(__element);
      }
      if (cCode.contains("GD05")) {
        GD05.add(__element);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    sorting();
    sorting_For_VideoAnimation();
    sorting_For_WebSubCategories();
    sorting_For_GraphicsDesign();

    super.initState();
  }

// @override
// void dispose() {
//   _tabController.dispose();
//   super.dispose();
// }
  @override
  Widget build(BuildContext context) {
    Widget vidandani(List _current_list) {
      return Scaffold(
        body: SafeArea(
          child: ListView.builder(
            itemCount: _current_list.length,
            padding: const EdgeInsets.symmetric(vertical: 10),
            itemBuilder: (BuildContext context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctr) {
                      return Serviceviewscreen(
                        currentServiceMap: _current_list[index],
                      );
                    }),
                  );
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.orange[100]!,
                      ),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: SizedBox(
                            width: 160,
                            child: Hero(
                              tag:
                                  "hero-${_current_list[index]["category_code"] ?? index}",
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(13),
                                child: Image.network(
                                  "${_current_list[index]["image"]}",
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(
                                      Icons.broken_image,
                                      size: 50,
                                      color: Colors.grey,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: SizedBox(
                            width: 195,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${_current_list[index]["name"]}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 194, 105, 73),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "${_current_list[index]["description"]?[1] ?? ''}",
                                  style: const TextStyle(
                                    color: Colors.brown,
                                    fontSize: 11,
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
      );
    }

    web_Design_SubCategories() {
      List<TabData> tabdata_web_Design = [
        TabData(
          index: 1,
          title: const Tab(text: "Business Websites"),
          content: vidandani(WD01),
        ),
        TabData(
          index: 2,
          title: const Tab(text: "Landing Pages"),
          content: vidandani(WD02),
        ),
        TabData(
          index: 3,
          title: const Tab(text: "Website Design Services"),
          content: vidandani(WD03),
        ),
      ];
      return Scaffold(
        body: DynamicTabBarWidget(
          isScrollable: true,
          labelStyle:
              const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          indicator: BoxDecoration(),
          unselectedLabelStyle:
              TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
          showNextIcon: false,
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          showBackIcon: false,
          dragStartBehavior: DragStartBehavior.start,
          onAddTabMoveTo: MoveToTab.last,
          dynamicTabs: tabdata_web_Design,
          onTabControllerUpdated: (ctl) {
            ctl.animateTo(widget.index_of_Category ?? 0);
          },
        ),
      );
    }

    video_Animation_SubCategories() {
      List<TabData> tabdata_video_Animation = [
        TabData(
          index: 1,
          title: Tab(text: "Color Grading & Animation"),
          content: vidandani(VA01),
        ),
        TabData(
            index: 2,
            title: Tab(text: "Social Media & Online Content"),
            content: vidandani(VA02)),
        TabData(
            index: 3,
            title: Tab(text: "Education & Training"),
            content: vidandani(VA03)),
        TabData(
            index: 4,
            title: Tab(text: "Entertainment & Storytelling"),
            content: vidandani(VA04)),
        TabData(
            index: 5,
            title: Tab(text: "Events & Celebrations"),
            content: vidandani(VA05)),
        TabData(
            index: 6,
            title: Tab(text: "Marketing & Advertising"),
            content: vidandani(VA06)),
      ];
//
      return Scaffold(
        body: DynamicTabBarWidget(
            isScrollable: true,
            indicator: BoxDecoration(),
            showNextIcon: false,
            labelStyle:
                const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            unselectedLabelStyle:
                TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            showBackIcon: false,
            dragStartBehavior: DragStartBehavior.start,
            onAddTabMoveTo: MoveToTab.last,
            dynamicTabs: tabdata_video_Animation,
            onTabControllerUpdated: (ctl) {
              ctl.animateTo(widget.index_of_Category ?? 0);
            }),
      );
    }

    graphics_Design_SubCategories() {
      List<TabData> tabdata_graphics_design = [
        TabData(
          index: 1,
          title: const Tab(text: "Logo & Banner Design"),
          content: vidandani(GD01),
        ),
        TabData(
          index: 2,
          title: const Tab(text: "Documents & Presentations"),
          content: vidandani(GD02),
        ),
        TabData(
          index: 3,
          title: const Tab(text: "Marketing & Branding"),
          content: vidandani(GD03),
        ),
        TabData(
          index: 4,
          title: const Tab(text: "Photo Editing"),
          content: vidandani(GD04),
        ),
        TabData(
          index: 5,
          title: const Tab(text: "UI & UX Designing"),
          content: vidandani(GD05),
        ),
      ];
      return Scaffold(
        body: DynamicTabBarWidget(
          isScrollable: true,
          labelStyle:
              const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          indicator: BoxDecoration(),
          unselectedLabelStyle:
              TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
          showNextIcon: false,
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          showBackIcon: false,
          dragStartBehavior: DragStartBehavior.start,
          onAddTabMoveTo: MoveToTab.last,
          dynamicTabs: tabdata_graphics_design,
          onTabControllerUpdated: (ctl) {
            ctl.animateTo(widget.index_of_Category ?? 0);
          },
        ),
      );
    }

    List<TabData> tabdata = [
      TabData(
        index: 1,
        title: const Tab(text: "Video & Animation"),
        content: video_Animation_SubCategories(),
      ),
      TabData(
        index: 2,
        title: const Tab(text: "Web Design"),
        content: web_Design_SubCategories(),
      ),
      TabData(
        index: 3,
        title: const Tab(text: "Graphics and Design"),
        content: graphics_Design_SubCategories(),
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
      appBar: widget.topic ?? false
          ? AppBar(
              backgroundColor: ColorsUsed.primaryColor,
              title: Text(
                'Browse Our Collection',
                style: TextStyle(
                  fontFamily:
                      GoogleFonts.aBeeZeeTextTheme().titleLarge!.fontFamily,
                  fontSize: 20, // Adjust size as needed

                  color: Colors.black, // Text color
                ),
              ),
              actions: [IconButton(onPressed: () {
                Get.to(()=> SearchPage(word: "",));
              }, icon: Icon(Icons.search))],
            )
          : null,
      body: DynamicTabBarWidget(
        padding: const EdgeInsets.only(top: 15, bottom: 10),
        isScrollable: true,
        showNextIcon: false,
        labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        unselectedLabelStyle:
            TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
        showBackIcon: false,
        onAddTabMoveTo: MoveToTab.first,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        dynamicTabs: tabdata,
        onTabControllerUpdated: (ctl) {
          ctl.animateTo(widget.index_of_Category ?? 0);
        },
      ),
    );
  }
}
