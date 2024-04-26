import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:farefinale/home.dart';
import 'package:farefinale/profile.dart';
import 'package:farefinale/widgets/searchresults.dart';

class FoodItemPage extends StatefulWidget {
  const FoodItemPage({Key? key}) : super(key: key);

  @override
  State<FoodItemPage> createState() => _FoodItemPageState();
}

class _FoodItemPageState extends State<FoodItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 7,
          ),
          Container(
            child: Image.asset("assets/images/bakery.png"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "     Bread",
              style: TextStyle(fontSize: 17),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              Text(
                "Filter Options",
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
              )
            ],
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        return Color.fromARGB(255, 242, 205, 209);
                      },
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "View all",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          return Color.fromARGB(255, 242, 205, 209);
                        },
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Shop",
                      style: TextStyle(color: Colors.black),
                    )),
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          return Color.fromARGB(255, 242, 205, 209);
                        },
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Food",
                      style: TextStyle(color: Colors.black),
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          return Color.fromARGB(255, 242, 205, 209);
                        },
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Menu",
                      style: TextStyle(color: Colors.black),
                    )),
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          return Color.fromARGB(255, 242, 205, 209);
                        },
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Alcohol",
                      style: TextStyle(color: Colors.black),
                    )),
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          return Color.fromARGB(255, 242, 205, 209);
                        },
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Craft",
                      style: TextStyle(color: Colors.black),
                    )),
              ],
            ),
          ),

          SizedBox(height: 10), // Adjust the spacing as needed
          Expanded(
            child: FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection('Shop').get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    strokeWidth: 2,
                  );
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                // If data fetching is successful, display the list of shops
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // Set the number of columns in the grid
                    crossAxisSpacing: 10, // Set the spacing between columns
                    mainAxisSpacing: 10, // Set the spacing between rows
                  ),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    // Extract data from the document snapshot
                    var doc = snapshot.data!.docs[index];
                    var id = doc.id;
                    var name = doc['shopName'];
                    var location = doc['location'];
                    var contact = doc['phoneNo'];
                    var category = doc['category'];
                    // Return a ListTile widget for each shop
                    return Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(name,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 4),
                            Text('$location'),
                            Text('$contact'),
                            Text('$category'),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          // Expanded(
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(),
          //     child: GridView.builder(
          //       itemCount: ShopDetails.length,
          //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //           crossAxisCount: 3, childAspectRatio: 0.65),
          //       itemBuilder: (context, index) => ShopDesign(
          //         design: ShopDetails[index],
          //         onTap: () {
          //           // Define the action to be performed when the image is tapped
          //           print('Image tapped! Index: $index');
          //           // You can navigate to another page here if needed
          //         },
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 252, 252, 252),
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MyApp()));
              },
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchResults()));
              },
            ),
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
