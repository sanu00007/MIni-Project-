import 'dart:async';
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
  int _currentIndex = 0;
  final List<String> _imageList = [
    'assets/shops/shop1.jpeg',
    'assets/shops/shop2.webp',
    'assets/shops/shop3.jpg',
  ];
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 3), (_timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % _imageList.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

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
      body: 
      Column(
        children: [
          Text('Savor the Best: Your Favorites, Your Shops!',style: TextStyle(
          fontSize: 18, 
          color: Colors.black,
          fontWeight: FontWeight.bold),),
          SizedBox(
            height: 7,
          ),
         Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.asset(_imageList[_currentIndex],
                      width: 1200, fit: BoxFit.fill),
                ),
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
