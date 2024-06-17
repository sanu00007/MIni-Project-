import 'package:farefinale/dummy.dart';
import 'package:farefinale/profile.dart';
import 'package:farefinale/shop.dart';
import 'package:farefinale/widgets/location.dart';
import 'package:farefinale/widgets/searchresults.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> _imageUrls = [];
  List<String> _docNames = [];
  List<num> _pred_prices = [];
  @override
  void initState() {
    super.initState();
    _loadImageUrls();
  }

  Future<void> _loadPrice(String docId) async {
    try {
      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
          .collection('predicted_prices')
          .doc(docId)
          .get();

      if (docSnapshot.exists) {
        num predictedPrice = docSnapshot['predicted_price'] ?? 0;
        _pred_prices.add(predictedPrice);
        setState(() {
          _pred_prices = _pred_prices; // Update state with new prices
        });
      } else {
        // Document doesn't exist for this ID
        setState(() {
          _pred_prices.add(0); // Use default value or handle differently
        });
      }
    } catch (error) {
      print('Error fetching predicted price: $error');
    }
  }

// Inside _loadImageUrls method, await _loadPrice
  Future<void> _loadImageUrls() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('Food').get();

      List<String> urls = [];
      List<String> docNames = [];
      querySnapshot.docs.forEach((doc) {
        String imageUrl = doc['image'];
        String docId = doc.id;
        _loadPrice(docId); // Load price for this document ID
        urls.add(imageUrl);
        docNames.add(docId);
      });

      setState(() {
        _imageUrls = urls;
        _docNames = docNames;
      });
    } catch (error) {
      print('Error fetching image URLs: $error');
    }
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
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => const Myloc()));
            },
            icon: Icon(
              Icons.location_on_outlined,
              size: 30,
              color: Color.fromARGB(246, 201, 21, 41),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
              child: Text(
                "Recommended Items",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 200, // Adjust the height as needed
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _imageUrls.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(
                            _imageUrls[index],
                            width: 150,
                            height: 100,
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(height: 8), // Adjust spacing as needed
                        Center(
                          child: Text(
                            '         ' +
                                _docNames[index], // Display the document name
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        // Row(
                        //   children: [
                        //     Center(
                        //         child: Text(
                        //       '          Price:',
                        //       style: TextStyle(fontWeight: FontWeight.bold),
                        //     )),
                        //     Center(
                        //       child: Text(
                        //         _pred_prices.isNotEmpty &&
                        //                 index >= 0 &&
                        //                 index < _pred_prices.length
                        //             ? _pred_prices[index].toString()
                        //             : 'N/A',
                        //         style: TextStyle(
                        //           fontSize: 16,
                        //           fontWeight: FontWeight.bold,
                        //           color: _pred_prices.isNotEmpty &&
                        //                   (index < 0 ||
                        //                       index >= _pred_prices.length)
                        //               ? Colors.red // Error state indication
                        //               : Colors.black,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: SizedBox(
                width: 325,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor:
                        const Color.fromARGB(255, 232, 178, 178), // Text color
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Offer Zone',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.wallet_giftcard_outlined,
                        size: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
              child: Text(
                "Mostly Viewed Products",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 200, // Adjust the height as needed
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _imageUrls.length,
                itemBuilder: (context, index) {
                  final reversedIndex = _imageUrls.length - 1 - index;
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(
                            _imageUrls[reversedIndex],
                            width: 150,
                            height: 100,
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(height: 8), // Adjust spacing as needed
                        Center(
                          child: Text(
                            '         ' +
                                _docNames[
                                    reversedIndex], // Display the document name
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
              child: Text(
                "Expiring Soon",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 200, // Adjust the height as needed
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _imageUrls.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(
                            _imageUrls[index],
                            width: 150,
                            height: 100,
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(height: 8), // Adjust spacing as needed
                        Center(
                          child: Text(
                            '         ' +
                                _docNames[index], // Display the document name
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            // Other widgets (e.g., product lists) can be added here
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 252, 252, 252),
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchResults()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FoodItemPage()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
