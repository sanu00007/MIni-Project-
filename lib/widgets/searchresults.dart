import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farefinale/home.dart';
import 'package:farefinale/profile.dart';
import 'package:farefinale/shop.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SearchResults extends StatefulWidget {
  const SearchResults({Key? key}) : super(key: key);

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  late List<Product> _filteredProducts = [];
  late List<Product> _products = [];
  TextEditingController _textEditingController = TextEditingController();
  bool isSearched = false;

  @override
  void initState() {
    super.initState();
    fetchFromProduct();
  }

  Future<void> fetchFromProduct() async {
    List<Product> productList = [];

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Products').get();
    await Future.forEach(querySnapshot.docs, (doc) async {
      String name = doc['name'];
      Timestamp expiryDate = doc['expiryDate'];
      double price = doc['price'];
      String shopId = doc['shop_id'];
      // Fetch shop details based on shopId
      String shopName = await fetchShopDetails(shopId);
      // Fetch image link from Food collection
      String? imageLink = await fetchImageLink(name);
      // Create a Product object with fetched data
      Product product = Product(
        name: name,
        expiryDate: expiryDate,
        price: price,
        shop: shopName,
        image: imageLink != null ? imageLink : "",
        // Add other fields as needed
      );
      productList.add(product);
    });
    _products = productList;
  }

  Future<String> fetchShopDetails(String shopId) async {
    DocumentSnapshot shopSnapshot =
        await FirebaseFirestore.instance.collection('Shop').doc(shopId).get();
    return shopSnapshot[
        'shopName']; // Assuming 'name' is the field containing the shop name
  }

  Future<String?> fetchImageLink(String productName) async {
    try {
      DocumentSnapshot foodSnapshot = await FirebaseFirestore.instance
          .collection('Food')
          .doc(productName)
          .get();

      if (foodSnapshot.exists) {
        return foodSnapshot['image'];
      } else {
        // Handle the case where the document does not exist
        print('Document for product $productName does not exist');
        return null;
      }
    } catch (error) {
      // Handle any potential errors that may occur during fetching
      print('Error fetching image link for product $productName: $error');
      return null;
    }
  }

  void _search(String query) {
    setState(() {
      if (query.isNotEmpty) {
        isSearched = true;
        _filteredProducts = _products
            .where((product) =>
                product.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else {
        isSearched = false;
      }
    });
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
          icon: const Icon(
            Icons.arrow_back,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'What are you looking for',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCategoryButton('All'),
                  _buildCategoryButton('Produce'),
                  _buildCategoryButton('Dairy'),
                  _buildCategoryButton('Bakery'),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                // controller: _textEditingController,
                onChanged: _search,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: IconButton(
                    onPressed: () {
                      //   _search(_textEditingController.text);
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              isSearched && _filteredProducts.isEmpty
                  ? Center(
                      child: Text('No results found'),
                    )
                  : GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      children: List.generate(
                        isSearched
                            ? _filteredProducts.length
                            : _products.length,
                        (index) => _buildProductItem(
                            context,
                            isSearched
                                ? _filteredProducts[index]
                                : _products[index]),
                      ),
                    ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 252, 252, 252),
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FoodItemPage()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryButton(String text) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: const Color.fromARGB(255, 242, 205, 209),
      ),
      child: Text(text),
    );
  }

  Widget _buildProductItem(BuildContext context, Product product) {
    String formattedDate =
        DateFormat('dd-MM-yyyy').format(product.expiryDate.toDate());
    return Container(
      height: 800,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image(
              image: NetworkImage(product.image),
              width: 100,
              height: 60,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${product.name}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Price: ${product.price}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Expiry: ${formattedDate}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Shop Name: ${product.shop}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Product {
  final String image;
  final String name;
  final String shop;
  final Timestamp expiryDate;
  final double price;

  Product(
      {required this.image,
      required this.name,
      required this.expiryDate,
      required this.price,
      required this.shop});
}

// final List<Product> _products = [
//   Product(
//     image: 'assets/images/bakery.png',
//     category: 'Bakery',
//     isExpired: 'In One day',
//     startingPrice: '\$5.99',
//   ),
//   Product(
//     image: 'assets/images/beverages.png',
//     category: 'Beverages',
//     isExpired: 'In Two days',
//     startingPrice: '\$2.49',
//   ),
//   Product(
//     image: 'assets/images/freshfruits.png',
//     category: 'Fresh Fruits',
//     isExpired: 'In Two days',
//     startingPrice: '\$3.99',
//   ),
//   Product(
//     image: 'assets/images/crisps.png',
//     category: 'Chips',
//     isExpired: 'In Three days',
//     startingPrice: '\$1.99',
//   ),
//   Product(
//     image: 'assets/images/grains.png',
//     category: 'Grains',
//     isExpired: 'In Four days',
//     startingPrice: '\$4.49',
//   ),
//   Product(
//     image: 'assets/images/grocery.png',
//     category: 'Grocery',
//     isExpired: 'In 6 days',
//     startingPrice: '\$2.99',
//   ),
//   Product(
//     image: 'assets/images/oils.png',
//     category: 'Oils',
//     isExpired: 'In 6 days',
//     startingPrice: '\$6.99',
//   ),
//   Product(
//     image: 'assets/images/protein.png',
//     category: 'Protein',
//     isExpired: 'In 7 days',
//     startingPrice: '\$7.99',
//   ),
// ];
