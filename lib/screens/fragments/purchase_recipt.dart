import 'package:brownsofts/screens/fragments/constants.dart';
import 'package:brownsofts/screens/fragments/customer_entry_screen.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PurchaseReciptScreen extends StatefulWidget {
  PurchaseReciptScreen(
      {super.key,
      this.image,
      this.currentServiceMap1,
      this.selectedPrice,
      this.chosed,
      this.price_1,
      this.cut_price,
      this.delivery_1,
      this.revision_1,
      this.regulations_1});
  String? image = "";
  Map? currentServiceMap1;
  Map? selectedPrice;
  String? chosed = "Basic";
  int? price_1;
  double? cut_price = 0.0;
  String? delivery_1 = "";
  String? revision_1 = "";
  List? regulations_1 = [];

  @override
  State<PurchaseReciptScreen> createState() => _PurchaseReciptScreenState();
}

class _PurchaseReciptScreenState extends State<PurchaseReciptScreen> {
  late var BScurrentService;
  late var BSname1;
  late var bscategory1;
  late var category_code1;
  late var BSimage1;
  late var BSfAQ1;
  late var BSprice1;
  late var BSdescription1;
  Map? content11;
  List? packagekey;
  double screenheight = 0;
  int selected_des_cont = 0;

  double screensize = 0;
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
        });
      },
    );

    BScurrentService = widget.currentServiceMap1;

    //store id and pass to next screen
    BSname1 = BScurrentService["name"];
    bscategory1 = BScurrentService["category"];
    category_code1 = BScurrentService["category_code"];
    BSimage1 = BScurrentService["image"];
    BSfAQ1 = BScurrentService["FAQ"];
    BSprice1 = BScurrentService["price"];
    BSdescription1 = BScurrentService["description"];
    content11 = BSprice1["basic"];
    print(content11);
  }

  @override
  Widget build(BuildContext context) {
    var screensize = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: SizedBox(
        width: 120, // Custom width
        height: 50, // Custom height
        child: FloatingActionButton.extended(
          onPressed: () {
            selectedServiceId.value = category_code1;
            selectedPricePackage.value = widget.chosed!;
            selectedserviceName.value = BSname1;
            selectedservicePrice.value =  widget.price_1!;
            Navigator.of(context).push(MaterialPageRoute(builder: (cvb) {
              return CustomerEntryScreen(
                product_name: BSname1,
                price_2: widget.price_1!,
              );
            }));
          },
          label: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Next",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Icon(
                Icons.arrow_right_rounded,
                size: 28,
              ),
            ],
          ),
          // backgroundColor: Colors.orange, // Optional: Add background color
        ),
      ),
      body: SafeArea(
        child: Card(
            margin: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25)),
                        height: screensize / 2.5,
                        child: Image(
                            image: NetworkImage(widget.image.toString()))),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: Text(
                    " $BSname1",
                    style: TextStyle(
                        fontSize: 23,
                        letterSpacing: 1.4,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Selected Package",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Divider(),
                          Text(
                            widget.chosed.toString(),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                "\$" "${widget.price_1}",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange),
                              ),
                              SizedBox(width: 8),
                              Text(
                                "\$" "${widget.cut_price}",
                                style: TextStyle(
                                    fontSize: 16,
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.access_time, size: 16),
                              SizedBox(width: 4),
                              Text("${widget.delivery_1}" " Days Delivery"),
                              SizedBox(width: 16),
                              Icon(Icons.loop, size: 16),
                              SizedBox(width: 4),
                              Text("${widget.revision_1}" " Revisions"),
                            ],
                          ),
                          SizedBox(height: 8),
                          Column(
                            children: List.generate(
                                widget.regulations_1!.length, (vbn) {
                              return _buildFeature(widget.regulations_1![vbn]);
                            }),
                          ),

                          // _buildFeature("Up to 1 minute of infographic video"),
                          // _buildFeature("Basic animation and transitions"),
                          // _buildFeature("Standard infographic"),
                          Divider(),
                          // Subtotal, Tax, and Total
                          _buildTotalRow("Subtotal:", "\$" "${widget.price_1}"),
                          _buildTotalRow("Tax:", "\$0.00"),
                          _buildTotalRow(
                            "Total:",
                            "\$" "${widget.price_1}",
                            isBold: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

Widget _buildFeature(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check, color: Colors.orange, size: 16),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 15),
          ),
        ),
      ],
    ),
  );
}

Widget _buildTotalRow(String label, String value, {bool isBold = false}) {
  return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ));
}
