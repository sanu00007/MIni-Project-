import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductList extends StatefulWidget {
  final String shopId;

  const ProductList({Key? key, required this.shopId}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late List<ProductModel> _products; // Initialize as an empty list

  @override
  void initState() {
    super.initState();
    _products = []; // Initialize _products in initState
    _fetchProducts(); // Fetch products for the current shop on initialization
  }

  Future<void> _fetchProducts() async {
    try {
      // Fetch products for the current shop
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Products')
          .where('shop_id', isEqualTo: widget.shopId)
          .get();

      // Process fetched documents into ProductModel objects
      List<ProductModel> products = [];
      querySnapshot.docs.forEach((doc) {
        var product = ProductModel(
          name: doc['name'],
          count: doc['count'],
        );
        products.add(product);
      });

      // Update state to trigger UI rebuild with fetched products
      setState(() {
        _products = products;
      });
    } catch (error) {
      print('Error fetching products: $error');
      // Handle error if necessary
    }
  }

  Future<void> _updateProductCount(int index, int newCount) async {
    try {
      // Update the count of the product at the specified index
      var product = _products[index];
      product.count = newCount;

      // Update Firestore document with new count
      await FirebaseFirestore.instance
          .collection('Products')
          .doc(product.name) // Assuming 'name' is a unique identifier for products
          .update({'count': newCount});

      // Update state to trigger UI rebuild with updated product count
      setState(() {
        _products[index] = product;
      });

      // If count is zero, delete the product document
      if (newCount == 0) {
        await FirebaseFirestore.instance
            .collection('Products')
            .doc(product.name)
            .delete();

        // Remove the product from the local list
        setState(() {
          _products.removeAt(index);
        });
      }
    } catch (error) {
      print('Error updating product count: $error');
      // Handle error if necessary
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
        backgroundColor: Color.fromARGB(246, 201, 21, 41),
        foregroundColor: Colors.white,
      ),
      body: _products.isEmpty
          ? Center(
              child: Text('No products found'),
            )
          : ListView.builder(
              itemCount: _products.length,
              itemBuilder: (context, index) {
                var product = _products[index];

                return ListTile(
                  title: Text(product.name),
                  subtitle: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (product.count > 0) {
                            _updateProductCount(index, product.count - 1);
                          }
                        },
                        icon: Icon(Icons.remove),
                      ),
                      Text(product.count.toString()),
                      IconButton(
                        onPressed: () {
                          _updateProductCount(index, product.count + 1);
                        },
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

class ProductModel {
  String name;
  int count;

  ProductModel({
    required this.name,
    required this.count,
  });
}
