import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: const Color.fromARGB(224, 238, 225, 215),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 1.4,
            child: Center(
              child: SizedBox(
                height: 350,
                width: 350,
                child: Image.asset(
                  "assets/logo.png",
                  alignment: Alignment.bottomCenter * 12,
                  scale: 4,
                ),
              ),
            ),
          ), const LinearProgressIndicator()
        ],
      ),
    );
  }
}
