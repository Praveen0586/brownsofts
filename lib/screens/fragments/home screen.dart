import 'package:brownsofts/activities/api/api_calls.dart';
import 'package:brownsofts/screens/utils/constants.dart';
import 'package:brownsofts/service/categeries.dart';
import 'package:brownsofts/data/s%20data.dart';
import 'package:brownsofts/screens/fragments/category_service.dart';
import 'package:brownsofts/screens/fragments/service%20view%20screen.dart';
import 'package:brownsofts/screens/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();

//empty list declaration for Empty declaration
  List VA = [];
  List DW = [];
  //This was used for slide show indicator
  RxInt _currentPage = 0.obs;

//mapped list storation
  List<Map<dynamic, dynamic>> _video_animation = [];
  List<Map<dynamic, dynamic>> _web_designs = [];
  List<Map<dynamic, dynamic>> _graphics_designs = [];
//allservice from S data
  List all = all_service;

//sorting from the data
  sorting_from_all() {
    all.forEach((__element) {
      String charcode = __element["category_code"];

      if (charcode.contains("VA")) {
        _video_animation.add(__element);
      } else if (charcode.contains("WD")) {
        _web_designs.add(__element);
      } else if (charcode.contains("GD")) {
        _graphics_designs.add(__element);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sorting_from_all();
    fn.addListener(() {
      if (fn.hasFocus) {
        fn.unfocus();
        Navigator.push(context, MaterialPageRoute(builder: (wq) {
          return SearchPage(word: _searchController.text);
        }));
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchController.dispose();
    fn.dispose();
  }

  final FocusNode fn = FocusNode();

//search bar
  Widget _buildSearchBar() {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.only(top: 15, left: 10, right: 10),
        child: Container(
          decoration: BoxDecoration(
            color: ColorsUsed.colorisOrange
                ? ColorsUsed.primaryColor.withOpacity(0.8)
                : const Color.fromARGB(
                    255, 247, 233, 227), // Background color for the search bar
            borderRadius: BorderRadius.circular(20), // Rounded corners
            boxShadow: const [
              BoxShadow(
                color: Colors.black26, // Shadow color
                blurRadius: 5, // Shadow blur
                offset: Offset(0, 2), // Shadow position
              ),
            ],
          ),
          child: Hero(
            tag: "search",
            child: TextFormField(
              focusNode: fn,
              onTap: () {
                setState(() {
                  // Only navigate if there is text in the search bar
                  if (_searchController.text.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchPage(
                            word: _searchController.text
                            // You can pass data like search history or current search query here
                            // searchHistory: _searchHistory,
                            ),
                      ),
                    );
                  }
                  // No action needed if the search bar is empty
                });
              },
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.brown,
                ),
                border: InputBorder.none, // Removes the underline
                contentPadding: EdgeInsets.symmetric(vertical: 15.0),
              ),
              onChanged: (value) {
                // Logic to handle search text change
                print("Search text: $value");
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget search_suggesions() {
    List suggesions = [
      "Video Editing ",
      "SEO",
      "UI/UX Design",
      "Graphic Designing",
      "Short Videos",
      "Marketting",
      "Ads Management",
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(suggesions.length, (index) {
          return Padding(
            padding: EdgeInsets.only(
                right: index == suggesions.length - 1 ? 10 : 5,
                left: index == 0 ? 10 : 5,
                bottom: 4,
                top: 15),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return SearchPage(
                    word: suggesions[index],
                  );
                }));
                //   _searchController.text = suggesions[index];
              },
              child: Container(
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 4, bottom: 4),
                child: Text(
                  "${suggesions[index]}",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 119, 64, 44),
                    //      fontSize: 20, // Adjust font size as needed
                    fontWeight: FontWeight.w700, // Bold text
                    //    color: Colors.brown, // Text color in brown
                    decoration: TextDecoration.none,
                    fontSize: 12,
                    overflow: TextOverflow.fade,
                  ),
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 236, 223, 217)),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

//slideshow

  Widget slide_bottom() {
    List<Widget> _buildIndicators() {
      List<Widget> indicators = [];
      int totalImages = 12; // Number of images in the slideshow

      for (int i = 0; i < totalImages; i++) {
        indicators.add(Obx(() {
          return Container(
            width: 5,
            height: 5,
            margin: EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentPage.value == i
                  ? Colors.brown
                  : Colors.grey, // Active vs inactive
            ),
          );
        }));
      }

      return indicators;
    }

    return Padding(
      padding: EdgeInsets.only(top: 15, left: 10, right: 10),
      child: Column(
        children: [
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border:
                  Border.all(color: const Color.fromARGB(255, 236, 223, 217)),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: ImageSlideshow(
                width: double.infinity,
                height: 200, indicatorBottomPadding: -20,
                initialPage: 1,
                indicatorColor: Colors.transparent, // Hide internal indicators
                autoPlayInterval: 3000, // Duration in milliseconds
                isLoop: true,
                onPageChanged: (value) {
                  _currentPage.value = value;
                },
                children: [
                  Image.network(
                    "https://brownsofts.com/assets/img/services/slider-images/66502b53d85f3.jpg",
                    fit: BoxFit.cover,
                  ),
                  Image.network(
                    "https://www.brownsofts.com/assets/img/services/slider-images/66503e36c817f.jpg",
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10), // Space between the image and indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildIndicators(), // Call function to build indicators
          ),
        ],
      ),
    );
  }

//bar Line
  Widget bar(String text) {
    return Padding(
      padding: EdgeInsets.only(top: 15, left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$text',
            style: TextStyle(
              fontSize: 23, // Adjust size as needed
              fontWeight: FontWeight.bold, // Bold text
              color: Colors.black, // Text color
            ),
          ),
          TextButton(
            onPressed: () {
              // Button action
              // Navigator.push(context, MaterialPageRoute(builder: (cvf) {
              //   return CategoryServicePage();
              // }));
            },
            style: TextButton.styleFrom(
              //  backgroundColor: Colors.white, // Button background color
              //   primary: Colors.blue, // Text color
              padding: EdgeInsets.symmetric(
                  horizontal: 20, vertical: 10), // Padding inside the button
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Rounded corners
              ),
            ),
            child: Text(
              'View All',
              style: TextStyle(
                fontSize: 14, // Adjust font size
                fontWeight: FontWeight.bold, // Bold text
                color: Colors.brown, // Text color to match the image
              ),
            ),
          ),
        ],
      ),
    );
  }

//Grid section of categories - without image
  Widget gridsection_no_image1(BuildContext context) {
    if (appCategory == null || appCategory.isEmpty) {
      return Center(child: Text("No categories available."));
    }

    int? selectedCategory;

    return Container(
      height: MediaQuery.of(context).size.height * 0.3, // Dynamic height
      width: double.infinity, // Full screen width
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
        itemCount: appCategory.length,
        padding: EdgeInsets.all(15),
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                selectedCategory = index;
              });
              Get.to(CategoryServicePage(
                index_of_Category: index,
                topic: true,
              ));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 236, 223, 217),
                    width: 1.5,
                  ),
                  color: const Color.fromARGB(254, 254, 247, 255),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 0.1),
                    Container(
                      height: 70,
                      width: 100,
                      child: Center(
                        child: Text(
                          appCategory[index].titles,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 126, 67, 45),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 0.1),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

//Popular service - horizontal alignment
  Widget popservice(List<dynamic> prefered_service) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(prefered_service.length, (index) {
          final ct_ser = prefered_service[index];

          return Padding(
            padding: EdgeInsets.only(
                top: 10,
                bottom: 10,
                left: index == 0 ? 18 : 5,
                right: index == prefered_service.length - 1 ? 18 : 10),
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                  return Serviceviewscreen(
                    currentServiceMap: ct_ser,
                  );
                }));
              },
              child: Container(
                height: 290,
                width: 200,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 236, 223, 217)),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 5),
                      height: 150,
                      width: 190,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Hero(
                            tag: "hero-${ct_ser["category_code"]}",
                            child: Image(
                              image: NetworkImage("${ct_ser["image"]}"),
                              fit: BoxFit.cover,
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 20,
                      width: 170,
                      child: Text(
                        "${ct_ser["name"]}",
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.brown,
                          //      fontSize: 20, // Adjust font size as needed
                          fontWeight: FontWeight.bold, // Bold text
                          //    color: Colors.brown, // Text color in brown
                          decoration: TextDecoration.none,
                          fontSize: 12,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 170,
                      child: Text(
                        "${ct_ser["description"][0]}",
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.brown,
                          //      fontSize: 20, // Adjust font size as needed
                          fontWeight: FontWeight.w500, // Bold text
                          //    color: Colors.brown, // Text color in brown
                          decoration: TextDecoration.none,
                          fontSize: 12,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Container(
                        height: 40,
                        width: 170,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color.fromARGB(225, 245, 235, 232),
                        ),
                        child: TextButton(
                          onPressed: () {
                            // Button action
                            Navigator.push(context,
                                MaterialPageRoute(builder: (ctx) {
                              return Serviceviewscreen(
                                currentServiceMap: ct_ser,
                              );
                            }));
                            //pass
                            //bs service with there current num
                          },
                          style: TextButton.styleFrom(
                            //  backgroundColor: Colors.white, // Button background color
                            //   primary: Colors.blue, // Text color
                            padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10), // Padding inside the button
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10), // Rounded corners
                            ),
                          ),
                          child: Text(
                            'View More',
                            style: TextStyle(
                              fontWeight: FontWeight.bold, // Bold text
                              color:
                                  Colors.brown, // Text color to match the image
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            _buildSearchBar(),
            search_suggesions(),
            slide_bottom(),
            bar("Categories"),
            gridsection_no_image1(context),
            bar("Service From Backend"),
            FutureBuilder(
              future: ApiCalls().getAllService(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: LinearProgressIndicator(
                    color: Colors.orange,
                  ));
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No services available.'));
                } else {
                  List _services = snapshot.data!;
                  return popservice(_services);
                }
              },
            ),
            bar("Popular Service"),
            popservice(all_service),
            bar("Video & Animation"),
            popservice(_video_animation),
            bar("Web Design"),
            popservice(_web_designs),
            bar("Graphics & Designs "),
            popservice(_graphics_designs),
          ],
        )
      ],
    );
  }
}
