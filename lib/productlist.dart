import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductList extends StatefulWidget {
  final String shopId;

  const ProductList({Key? key, required this.shopId}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late List<ProductModel> _products;

  @override
  void initState() {
    super.initState();
    _products = [];
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Products')
          .where('shop_id', isEqualTo: widget.shopId)
          .get();

      List<ProductModel> products = querySnapshot.docs.map((doc) {
        return ProductModel(
          id: doc.id, // Use the document ID as a unique identifier
          name: doc['name'],
          count: doc['count'],
        );
      }).toList();

      setState(() {
        _products = products;
      });
    } catch (error) {
      print('Error fetching products: $error');
    }
  }

  Future<void> _updateProductCount(int index, int newCount) async {
    try {
      var product = _products[index];
      var productId = product.id;

      // Update Firestore document with new count
      await FirebaseFirestore.instance
          .collection('Products')
          .doc(productId)
          .update({'count': newCount});

      if (newCount == 0) {
        // Delete the product if the count is zero
        await FirebaseFirestore.instance
            .collection('Products')
            .doc(productId)
            .delete();

        // Remove the product from the local list
        setState(() {
          _products.removeAt(index);
        });
      } else {
        // Update the product count in the local list
        setState(() {
          _products[index].count = newCount;
        });
      }
    } catch (error) {
      print('Error updating product count: $error');
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
  String id; // Add a unique identifier field
  String name;
  int count;

  ProductModel({
    required this.id,
    required this.name,
    required this.count,
  });
}
