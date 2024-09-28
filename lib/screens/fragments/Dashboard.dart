import 'package:brownsofts/activities/models/service/categeries.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:brownsofts/screens/fragments/widgets.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  int currentint = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        child: Column(
          children: [Placeholder()],
        ),
      ),
      backgroundColor: const Color.fromARGB(239, 254, 249, 245),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black38,
        fixedColor: Colors.black,
        unselectedLabelStyle: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          decorationColor: Theme.of(context).colorScheme.primary,
        ),
        selectedLabelStyle: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
          // decorationColor: Theme.of(context).colorScheme.primary,
        ),
        // selectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_max_outlined), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.speaker_notes_outlined), label: "Services"),
          BottomNavigationBarItem(
              icon: Icon(Icons.contacts_outlined), label: "Contact"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined), label: "profile"),
        ],
        showUnselectedLabels: true,
        type: BottomNavigationBarType.shifting,
        currentIndex: currentint,
        onTap: (int) {
          setState(() {
            currentint = int;
          });
        },
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 248, 244, 244),
        title: Text(
          "BrownSofts",
          style: TextStyle(fontSize: 25, letterSpacing: 3),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(75.0),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              //   onChanged: _filterItems,
              decoration: InputDecoration(
                hintText: ' S e a r c h . . .',
                suffixIcon: Icon(Icons.search_outlined),
                // suffix: IconButton(
                //     onPressed: () {}, icon: Icon(Icons.search_outlined)),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                filled: true,
                fillColor: const Color.fromARGB(255, 248, 244, 244),
              ),
            ),
          ),
        ),
      ),

      //  body: ListView.builder(
      //       itemCount: _filteredItems.length,
      //       itemBuilder: (context, index) {
      //         return ListTile(
      //           title: Text(_filteredItems[index]),
      //         );
      //       },
      //     ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200, width: MediaQuery.of(context).size.width,
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
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "What service do you need?",
                      style: TextStyle(fontSize: 25),
                    ),
                  )),
                  Center(
                    child: Text("Slide Show of Services "),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Categories",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            SizedBox(
              height: 15,
            ),
            cats(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Top Featured Services",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            SizedBox(
              height: 100,
            ),
            Center(
              child: Text("backend codes need to be written "),
            )
          ],
        ),
      ),
    );
  }
}

Widget cats() {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
        children: List.generate(appCategory.length, (index) {
      return GestureDetector(
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.only(
              left: index == 0 ? 18 : 10,
              right: index == appCategory.length - 1 ? 18 : 10,
              top: 10,
              bottom: 10),
          child: Column(
            children: [
              SizedBox(
                  height: 80,
                  width: 80,
                  child: CircleAvatar(
                    foregroundImage: NetworkImage(appCategory[index].image),
                    minRadius: 50,
                    //  child: appCategory[index].image
                  )),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
                width: 70,
                child: Text(appCategory[index].titles,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 15,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1)),
              )
            ],
          ),
        ),
      );
    })),
  );
}
