import 'package:flutter/material.dart';

class PurchaseReciptScreen extends StatefulWidget {
  PurchaseReciptScreen({super.key, this.image});
  String? image = "";
  @override
  State<PurchaseReciptScreen> createState() => _PurchaseReciptScreenState();
}

class _PurchaseReciptScreenState extends State<PurchaseReciptScreen> {
  @override
  Widget build(BuildContext context) {
    var screensize = MediaQuery.of(context).size.width;
    return Scaffold(
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
                Container(
                    height: screensize / 2.5,
                    child: Image(image: NetworkImage(widget.image.toString()))),
              ],
            )),
      ),
    );
  }
}
