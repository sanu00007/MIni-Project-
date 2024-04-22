import 'dart:async';
import 'package:farefinale/shop.dart';
import 'package:farefinale/profile.dart';
import 'package:flutter/material.dart';
import 'package:farefinale/widgets/searchresults.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  final List<String> _imageList = [
    'assets/images/download.jpeg',
    'assets/images/grains.png',
    'assets/images/beverages.png',
    'assets/images/vegetables.png',
    'assets/images/bakery.png',
    'assets/images/freshfruits.png',
    'assets/images/oils.png',
    'assets/images/protein.png',
    'assets/images/pizzahut.jpg',
    'assets/images/akstore.jpg',
    'assets/images/tea.jpg',
    'assets/images/sri.jpg',
    'assets/images/malabar.jpg',
    'assets/images/anstore.webp',
    'assets/images/livaa.jpg',
    'assets/images/tacobell.jpg',
    'assets/images/beverage.webp',
    'assets/images/medico.jpg',
    'assets/images/thumb.jpg',
    'assets/images/download (2).jpg',
    'assets/images/download (3).jpg',
    'assets/images/download (4).jpg',
    'assets/images/download (5).jpg',
    'assets/images/download (6).jpg',
    'assets/images/download (7).jpg',
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
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.favorite,
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
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.asset(_imageList[_currentIndex],
                      width: 1200, fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(height: 6),
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
            SizedBox(
              height: 18,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
              child: Text(
                "Mostly Viewed Products",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(left: 18),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: SizedBox(
                        width: 150.0,
                        height: 150.0,
                        child: Image.asset(
                          'assets/images/download (2).jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: SizedBox(
                        width: 150.0,
                        height: 150.0,
                        child: Image.asset(
                          'assets/images/download (6).jpg',
                          fit: BoxFit.cover,
                        ),
                        
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: SizedBox(
                        width: 150.0,
                        height: 150.0,
                        child: Image.asset(
                          'assets/images/download (7).jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: SizedBox(
                        width: 150.0,
                        height: 150.0,
                        child: Image.asset(
                          'assets/images/download (5).jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: SizedBox(
                        width: 150.0,
                        height: 150.0,
                        child: Image.asset(
                          'assets/images/download (3).jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: SizedBox(
                        width: 150.0,
                        height: 150.0,
                        child: Image.asset(
                          'assets/images/download (4).jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 18,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
              child: Text(
                "Trending Products",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(left: 18),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: SizedBox(
                        width: 150.0,
                        height: 150.0,
                        child: Image.asset(
                          'assets/images/download (3).jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: SizedBox(
                        width: 150.0,
                        height: 150.0,
                        child: Image.asset(
                          'assets/images/download (4).jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: SizedBox(
                        width: 150.0,
                        height: 150.0,
                        child: Image.asset(
                          'assets/images/download (5).jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: SizedBox(
                        width: 150.0,
                        height: 150.0,
                        child: Image.asset(
                          'assets/images/download (6).jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: SizedBox(
                        width: 150.0,
                        height: 150.0,
                        child: Image.asset(
                          'assets/images/download (2).jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: SizedBox(
                        width: 150.0,
                        height: 150.0,
                        child: Image.asset(
                          'assets/images/download (7).jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(
              height: 18,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
              child: Text(
                "Expiring Soon",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(left: 18),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: SizedBox(
                        width: 150.0,
                        height: 150.0,
                        child: Image.asset(
                          'assets/images/download (3).jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: SizedBox(
                        width: 150.0,
                        height: 150.0,
                        child: Image.asset(
                          'assets/images/download (4).jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: SizedBox(
                        width: 150.0,
                        height: 150.0,
                        child: Image.asset(
                          'assets/images/download (5).jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: SizedBox(
                        width: 150.0,
                        height: 150.0,
                        child: Image.asset(
                          'assets/images/download (6).jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: SizedBox(
                        width: 150.0,
                        height: 150.0,
                        child: Image.asset(
                          'assets/images/download (2).jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: SizedBox(
                        width: 150.0,
                        height: 150.0,
                        child: Image.asset(
                          'assets/images/download (7).jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(
            255, 252, 252, 252), // Background color of the BottomAppBar
        shape: CircularNotchedRectangle(), // Notch in the bottom app bar
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchResults()));
              },
            ),
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FoodItemPage()));
              },
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
