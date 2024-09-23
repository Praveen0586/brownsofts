import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:brownsofts/screens/fragments/widgets.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        child: Column(
          children: [Placeholder()],
        ),
      ),
      backgroundColor: const Color.fromARGB(224, 238, 225, 215),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "a"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "a"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "a"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "a"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "a")
        ],
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 248, 244, 244),
        title: Text(
          "BrownSofts",
          style: TextStyle(fontSize: 25, letterSpacing: 3),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Container(
            height: 250, width: MediaQuery.of(context).size.width,
            // color: Colors.white,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 248, 244, 244),
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(25))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: Text(
                  "What service do you need?",
                  style: TextStyle(fontSize: 25),
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
