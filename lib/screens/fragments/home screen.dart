import 'package:brownsofts/activities/models/service/categeries.dart';
import 'package:brownsofts/data/data%20type.dart';
import 'package:brownsofts/data/s%20data.dart';
import 'package:brownsofts/screens/fragments/service%20view%20screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchController.dispose();
  }

//search bar
  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.only(top: 15, left: 10, right: 10),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(
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
        child: TextField(
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
                Fluttertoast.cancel();
                Fluttertoast.showToast(msg: "${suggesions[index]}");
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
  int _currentPage = 0;

  Widget slide_bottom() {
    List<Widget> _buildIndicators() {
      List<Widget> indicators = [];
      int totalImages = 12; // Number of images in the slideshow

      for (int i = 0; i < totalImages; i++) {
        indicators.add(Container(
          width: 5,
          height: 5,
          margin: EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == i
                ? Colors.brown
                : Colors.grey, // Active vs inactive
          ),
        ));
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
                initialPage: 0,
                indicatorColor: Colors.transparent, // Hide internal indicators
                autoPlayInterval: 3000, // Duration in milliseconds
                isLoop: true,
                onPageChanged: (value) {
                  setState(() {
                    _currentPage = value;
                  });
                },
                children: [
                  Image.network(
                    "https://brownsofts.com/assets/img/services/slider-images/66502b53d85f3.jpg",
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
    return Container(
      height: 270, // Fixed height for the grid container
      width: double.infinity, // Full width of the screen
      child: GridView.count(
        crossAxisCount: 3, // 3 items per row
        crossAxisSpacing: 15, // Spacing between columns
        mainAxisSpacing: 15, // Spacing between rows
        padding: EdgeInsets.all(15), // Padding around the grid
        physics:
            NeverScrollableScrollPhysics(), // Prevent internal scrolling if needed
        children: List.generate(appCategory.length, (index) {
          late int? selected_category;
          return InkWell(
            onTap: () {
              setState(() {
                selected_category = index;
              });
              //  Get.to(CategoryServicePage());

              //
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 236, 223, 217),
                      width: 1.5),
                  color: const Color.fromARGB(
                      254, 254, 247, 255), // Background color
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 0.1,
                    ),
                    Container(
                        decoration: BoxDecoration(
                            // border: Border.all(
                            //     color: const Color.fromARGB(255, 236, 223, 217)),
                            ),
                        height: 70,
                        width: 100,
                        child: Center(
                          child: Text(
                            "${appCategory[index].titles}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 126, 67, 45)),
                          ),
                        )),
                    SizedBox(
                      height: 0.1,
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

//Popular service - horizontal alignment
  Widget popservice() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(all_service.length, (index) {
          final ct_ser = all_service[index];

          return Padding(
            padding: EdgeInsets.only(
                top: 10,
                bottom: 10,
                left: index == 0 ? 18 : 5,
                right: index == all_service.length - 1 ? 18 : 10),
            child: Container(
              height: 290,
              width: 200,
              decoration: BoxDecoration(
                border:
                    Border.all(color: const Color.fromARGB(255, 236, 223, 217)),
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
                        child: Image(
                          image: NetworkImage("${ct_ser["image"]}"),
                          fit: BoxFit.cover,
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
            bar("Popular Service"),
            popservice(),
            bar("Video & Animation"),
            popservice(),
          ],
        )
      ],
    );
  }
}
