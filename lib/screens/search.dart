import 'package:brownsofts/data/s%20data.dart';
import 'package:brownsofts/screens/fragments/service%20view%20screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPage extends StatefulWidget {
  SearchPage({super.key, required this.word});
  final String word;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List serachList = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Initialize search list with all items
    _searchController.text = widget.word;
    serachList = all_service; // Initialize with all items

    _searchController.addListener(_filterSearchResults);
  }

  // Filter the search results based on the query
  void _filterSearchResults() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      serachList = all_service
          .where((item) =>
              item["name"].toLowerCase().contains(query)) // Compare the name
          .toList();
    });
    print(serachList);
  }

  // Build the list of filtered items
  Widget _buildItemList() {
    return ListView.builder(
      itemCount: serachList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 20,top: 10,bottom: 5,),
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (s) {
                return Serviceviewscreen(
                  currentServiceMap: serachList[index],
                );
              }));
            },
            child: Row(
              children: [
                Hero(
                  tag: serachList[index]["image"],
                  child: CircleAvatar(
                    maxRadius: 26,
                    foregroundImage: NetworkImage(serachList[index]["image"]),
                  ),
                ),SizedBox(width: 10,),
                Column(
                  children: [
                    Text(
                      "  " + serachList[index]["name"],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
        // return ListTile(
        //   leading: CircleAvatar(
        //     child: Image(image: NetworkImage(serachList[index]["image"]))
        //   ),
        //   title: Text(serachList[index]["name"]), // Access the name key
        // );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Column(
          children: [
            InkWell(
              child: Padding(
                padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 247, 233, 227),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Hero(
                    tag: "search",
                    child: TextFormField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        suffixIcon: Icon(
                          Icons.search,
                          color: Colors.brown,
                        ),
                        prefixIcon: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.keyboard_backspace_outlined,
                            color: Colors.brown,
                          ),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(child: _buildItemList()) // Display filtered results
          ],
        ),
      ),
    );
  }
}
