import "package:brownsofts/authentivation/sign_In.dart";
import "package:flutter/material.dart";

void main() {
  runApp(MaterialApp(
    theme: ThemeData(useMaterial3: true).copyWith(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(225, 91, 44, 31))),
    home: const HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                color: const Color.fromARGB(224, 238, 225, 215),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height /2
                ,
                child: Positioned(
                    child: SizedBox(
                  height: 250,
                  width: 250,
                  child: Image.asset(
                    "assets/logo.png",
                    alignment: Alignment.bottomCenter / 2,
                    scale: 6,
                  ),
                )),
              ),
            ],
          ),
          Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 75,
                  ),
                  //create new acoount
                  SizedBox(
                    height: 55,
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (ctx) => SIgnInPage()));
                      },
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 3)),
                      child: const Text(
                        "Sign In",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  SizedBox(
                    height: 55,
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 3)),
                      child: const Text(
                        "Create Account",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}


//  Positioned(bottom: 10,width: 500,
//             child: Container(
//               child: Center(
//                 child: Column(
//                   children: [
//                   
//                   ],
//                 ),
//               ),
//             ),
//           ),

//  ElevatedButton(
//                     onPressed: () {},
//                     child: Text(
//                       "Sign In",
//                       style: TextStyle(fontSize: 25),
//                     ),
//                   ),