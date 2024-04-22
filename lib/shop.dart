import 'package:farefinale/widgets/location.dart';
import 'package:flutter/material.dart';
import 'package:farefinale/home.dart';
import 'package:farefinale/profile.dart';
import 'package:farefinale/shopdetails.dart';
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(),
              child: GridView.builder(
                itemCount: ShopDetails.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, childAspectRatio: 0.65),
                itemBuilder: (context, index) => ShopDesign(
                  design: ShopDetails[index],
                  onTap: () {
                    // Define the action to be performed when the image is tapped
                    print('Image tapped! Index: $index');
                    // You can navigate to another page here if needed
                  },
                ),
              ),
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

class ShopDesign extends StatelessWidget {
  final ShopDetail design;
  final VoidCallback onTap;

  const ShopDesign({
    Key? key,
    required this.design,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyMap()));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(3),
            height: 150,
            width: 160,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.white,
                  blurRadius: 5,
                  spreadRadius: 5,
                  offset: Offset(0.0, 3.0),
                ),
              ],
              border: Border.all(
                color: Colors.white,
                width: 3,
              ),
              image: DecorationImage(
                image: AssetImage(design.image),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
            ),
            child: Center(
              child: Text(
                design.title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 1,
            ),
            child: Center(
              child: Text(
                design.location,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
