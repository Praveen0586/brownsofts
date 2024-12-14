import 'package:brownsofts/data/data%20type.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Serviceviewscreen extends StatefulWidget {
  Map currentServiceMap;
  Serviceviewscreen({super.key, required this.currentServiceMap});

  @override
  State<Serviceviewscreen> createState() => _ServiceviewscreenState();
}

class _ServiceviewscreenState extends State<Serviceviewscreen> {
  List topics = ["Description", "Reviews", "FAQ"];

  List pricelist = ["Basic", "Standard", "Premium"];

  RxInt starRatng = 0.obs;
  RxBool isExpandedFAQ = false.obs;
  late var BScurrentService;
  late var BSname;
  late var bscategory;
  late var category_code;
  late var BSimage;
  late var BSfAQ;
  late var BSprice;
  late var BSdescription;
  Map? content1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        setState(() {
          screensize = MediaQuery.of(context).size.width;
          screenheight = MediaQuery.of(context).size.height;
          selected_des_cont = 0;
          selected_content_widget = description_content();
        });
      },
    );
    BScurrentService = widget.currentServiceMap;
    BSname = BScurrentService["name"];
    bscategory = BScurrentService["category"];
    category_code = BScurrentService["category_code"];
    BSimage = BScurrentService["image"];
    BSfAQ = BScurrentService["FAQ"];
    BSprice = BScurrentService["price"];
    BSdescription = BScurrentService["description"];
    content1 = BSprice["basic"];
  }

  // final MyTabController tabController = Get.put(MyTabController());

//content for price tabs
  //var content = bscurr;
  int selected_price = 0;
  var discription_content = "";
  int selected_des_cont = 0;
  var selected_content_widget = Container(
    height: 450,
  );
  var star_rating = 0;
  var _formKey = GlobalKey<FormState>();
  var _textController = TextEditingController();
  final textColor = Color.fromARGB(255, 126, 67, 45);
  final bag = const Color.fromARGB(255, 255, 241, 235).withOpacity(0.8);
  double screenheight = 0;
  double screensize = 0;
  String word_description = "";
  List Description_topics = [];

  Widget buildContainer(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0, left: 6, right: 6),
      child: Container(
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(0, 239, 235, 233),
          borderRadius: BorderRadius.circular(18.0),
          border: Border.all(
              color: const Color.fromARGB(43, 121, 85, 72), width: 1.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 194, 105, 73),
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              content,
              style: TextStyle(fontSize: 15, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

// desscritpion conetents
  Container description_content() {
    Map something = BSdescription[2];
    List words_list = something["topics"];
    Map just_topics_andtheir_keys = {};
    for (var topicss in words_list) {
      // print(topicss);
      Description_topics.add(topicss);
    }
    for (var keyss in Description_topics) {
      if (something.containsKey(keyss)) {
        just_topics_andtheir_keys["$keyss"] = something["$keyss"];
        // just_topics_andtheir_keys.entries.map((entry) {
        //   return buildContainer(entry.key, entry.value);
        // });
      }
    }

    // print(just_topics_andtheir_keys);
    return Container(
      //  height: double.maxFinite,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: just_topics_andtheir_keys.entries.map((entry) {
          return buildContainer(entry.key, entry.value);
        }).toList(),
      ),
    );
  }

  Container Reviews() {
    return Container(
      padding: EdgeInsets.only(bottom: 100),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 15,
          ),
          Container(
            child: Text(
              "This Service has no Reviews Yet ",
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(5, (hjk) {
                    return InkWell(
                        onTap: () {
                          return setState(() {
                            starRatng.value = hjk + 1;
                            Reviews();
                          });
                        },
                        child: Obx(
                          () => Icon(hjk < starRatng.value
                              ? Icons.star
                              : Icons.star_border),
                        ));
                  }),
                ),
                // TextField(
                //   maxLines: null,
                //   decoration: InputDecoration(
                //       focusColor: textColor,
                //       disabledBorder: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(25),
                //       ),
                //       contentPadding:
                //           EdgeInsets.only(bottom: 200, left: 50, right: 40)),
                // )

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: TextFormField(
                            controller: _textController,
                            keyboardType: TextInputType.multiline,
                            maxLines:
                                null, // Allows the field to expand with content
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  left: 20, top: 15, bottom: 15),
                              labelText: 'Enter your text',
                              hintText: 'Add Review ....',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25)),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  // Handle form submission
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Form Submitted')),
                                  );
                                  _textController.clear();

                                  //here handle for star selection and commentry must add
                                }
                              },
                              child: Text('Submit'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container FAQ() {
    return Container(
      padding: EdgeInsets.only(bottom: 100),
      child: Column(
        children: List.generate(sample_FAQ.length, (vbn) {
          String content1 = sample_FAQ[vbn]["content"];

          return ExpansionTile(
            dense: true,
            title: Text(
              "${sample_FAQ[vbn]["heading"]}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            children: [
              Container(
                padding: EdgeInsets.only(left: 4),
                child: ListTile(
                  title: Text(
                    content1,
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    var size = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: EdgeInsets.only(left: size * 0.09),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Material(
                child: Container(
                  height: 45,
                  width: 180,
                  decoration: BoxDecoration(
                      border: Border.all(style: BorderStyle.none),
                      color: const Color.fromARGB(255, 224, 103, 28),
                      borderRadius: BorderRadius.circular(15)),
                  child: TextButton(
                      onPressed: () {
                        print("");
                      },
                      child: Text("Purchase",
                          style: GoogleFonts.ubuntu(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500))),
                ),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Material(
              child: Container(
                height: 45,
                width: 180,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 224, 103, 28),
                    borderRadius: BorderRadius.circular(15)),
                child: TextButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (jk) {
                            return BottomSheet(onClosing: () {
                              Fluttertoast.showToast(msg: "Thats it");
                            }, builder: (ss) {
                              return Container(
                                height: 700,
                                child: Column(
                                  children: [
                                    Text(
                                      "Contact Us ",
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 25, right: 25),
                                      child: TextField(
                                        decoration: InputDecoration(
                                            label: Text("Name"),
                                            contentPadding: EdgeInsets.only(
                                                top: 1, left: 20),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15))),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 25, right: 25),
                                      child: TextField(
                                        decoration: InputDecoration(
                                            label: Text("Email"),
                                            contentPadding: EdgeInsets.only(
                                                top: 20, left: 20),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15))),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 25, right: 25),
                                      child: TextField(
                                        decoration: InputDecoration(
                                            label: Text("Subject"),
                                            contentPadding: EdgeInsets.only(
                                                top: 20, left: 20),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15))),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 25, right: 25),
                                      child: TextField(
                                        decoration: InputDecoration(
                                            label: Text("Questions"),
                                            contentPadding: EdgeInsets.only(
                                                top: 20, left: 20),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15))),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 80,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Material(
                                              child: Container(
                                            height: 45,
                                            width: 180,
                                            decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 224, 103, 28),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: TextButton(
                                                onPressed: () {},
                                                child: Text("Get Touch",
                                                    style: GoogleFonts.ubuntu(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w500))),
                                          )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                          });
                    },
                    child: Text("Contact us",
                        style: GoogleFonts.ubuntu(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500))),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
          child: Card(
        elevation: 50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                    height: 290,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: Hero(
                      tag: "${BSimage}",
                      child: Image(
                        image: NetworkImage("${BSimage}"),
                        fit: BoxFit.cover,
                      ),
                    )),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Business icon or logo placeholder
                    CircleAvatar(
                      foregroundImage: AssetImage("assets/logo.png"),
                      radius: 24,
                      //backgroundImage:  AssetImage("assets/logo.png"),
                      backgroundColor: Colors.grey[300],
                      // child: Image(image: AssetImage("assets/logo.png")),
                      //  Icon(Icons.business, color: Colors.grey[500])
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Business Name and Verified Badge
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${BSname}",
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.verified,
                                  color: Colors.blue, size: 18),
                            ],
                          ),
                          SizedBox(height: 4),
                          // Additional business details
                          Row(
                            children: [
                              Icon(Icons.business_center,
                                  size: 16, color: Colors.grey),
                              SizedBox(width: 4),
                              Text(bscategory.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.grey)),
                              SizedBox(width: 16),
                              Icon(Icons.location_on,
                                  size: 16, color: Colors.grey),
                              SizedBox(width: 4),
                              Text("Kaliyakkavilai",
                                  style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Rating
                    Column(
                      children: const [
                        Icon(Icons.star, color: Colors.amber, size: 20),
                        SizedBox(height: 4),
                        Text(
                          "4.3",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(height: 1, color: Colors.grey[300]),
              SizedBox(
                height: 10,
              ),
              /////////////////////////////////////////////////////////////////
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  // height: 375,
                  width: w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(pricelist.length, (ind) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                selected_price = ind;
                                if (selected_price == 0) {
                                  setState(() {
                                    content1 = BSprice["basic"];
                                  });
                                } else if (selected_price == 1) {
                                  setState(() {
                                    content1 = BSprice["standard"];
                                  });
                                } else if (ind == 2) {
                                  setState(() {
                                    content1 = BSprice["premium"];
                                  });
                                }
                              });
                              print(ind);
                              print(content1);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: ind == selected_price
                                        ? const Color.fromARGB(
                                            255, 224, 103, 28)
                                        : Colors.orange[100],
                                    borderRadius: BorderRadius.circular(10)),
                                height: 40,
                                width: 100,
                                child: Center(
                                    child: Text(
                                  pricelist[ind],
                                  style: TextStyle(
                                      fontSize: ind == selected_price ? 15 : 11,
                                      color: ind == selected_price
                                          ? Colors.white
                                          : Colors.black),
                                )),
                              ),
                            ),
                          );
                        }),
                      ),

                      Container(
                        // height: 310,
                        width: w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.orange[100],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 40, top: 20),
                                  child: Text(
                                    "Price",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.only(right: 5, top: 20),
                                        child: Text(
                                          "\$ ${content1!["price"]}",
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(right: 30, top: 20),
                                        child: Text(
                                          "\$${content1!["cross cut"]}",
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              decorationColor:
                                                  const Color.fromARGB(
                                                      176, 0, 0, 0),
                                              decorationThickness: 5,
                                              color: const Color.fromARGB(
                                                  137, 0, 0, 0),
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            /// days delivery and revisions
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Icon(Icons.timer),
                                      ),
                                      Text(
                                        "${content1!["delivery"]} Days Delivery",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Icon(Icons.sync),
                                        ),
                                        Text(
                                          "${content1!["delivery"]} Revisions",
                                          style: TextStyle(fontSize: 15),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),

                            SizedBox(
                              height: 20,
                            ),
                            Column(
                              children: List.generate(
                                  content1!["restrictions"].length,
                                  (inf) => Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, bottom: 7),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.check,
                                              color: Colors.orange,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Expanded(
                                              child: Text(
                                                "${content1!["restrictions"][inf]}",
                                                style:
                                                    TextStyle(fontSize: 15.5),
                                                maxLines: 2,
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
                            ),
                            SizedBox(
                              height: 25,
                            )

                            ///
                          ],
                        ),
                      ),

                      //contents indside price box
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(3, (mnm) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selected_des_cont = mnm;
                          });

                          if (selected_des_cont == 0) {
                            setState(() {
                              selected_content_widget = description_content();
                            });
                          } else if (selected_des_cont == 1) {
                            setState(() {
                              selected_content_widget = Reviews();
                            });
                          } else if (selected_des_cont == 2) {
                            setState(() {
                              selected_content_widget = FAQ();
                            });
                          }
                        },
                        child: Container(
                          height: 50,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("${topics[mnm]}"),
                              // SizedBox(
                              //   height: 2,
                              // ),
                              if (selected_des_cont == mnm)
                                Container(
                                  height: 5,
                                  width: topics.length.toDouble() * 7,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: textColor),
                                ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                  selected_content_widget
                ],
              ),
              SizedBox(
                height: 55,
              )
            ],
          ),
        ),
      )),
    );
  }
}

List sample_FAQ = [
  {
    "heading": "Will my website rank well in search engines?",
    "content":
        "We prioritize Search Engine Optimization (SEO) best practices during development. This will improve your website's organic traffic and raise its search engine ranking."
  },
  {
    "heading": "Is this website design package mobile-friendly?",
    "content":
        "Absolutely, our web design service package includes responsive design, guaranteeing that your site will appear visually appealing and will operate"
  },
  {
    "heading": "How long does the typical website design process take?",
    "content":
        "Depending on the complexity and extent of the work involved, a custom website design project's timeline may change. However, we will work closely with you to establish a clear timeline during the initial planning stages."
  },
  {
    "heading":
        "What makes your custom website design different from templates?",
    "content":
        "Our custom website designs, as compared to generic templates, are made specifically to match your company's identity and particular requirements, making your web page stand out and efficiently promote your goods and services."
  },
  {
    "heading": "Will my website rank well in search engines?",
    "content":
        "We prioritize Search Engine Optimization (SEO) best practices during development. This will improve your website's organic traffic and raise its search engine ranking."
  }
];
