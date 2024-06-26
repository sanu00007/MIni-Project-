import 'package:farefinale/main.dart';
import 'package:farefinale/productlist.dart';
import 'package:farefinale/resources/auth_methods.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String name;
  String type;
  DateTime expiryDate;
  double price;
  int count;
  bool isFeatured;

  ProductModel({
    required this.name,
    required this.type,
    required this.expiryDate,
    required this.price,
    required this.isFeatured,
    required this.count,
  });
}

class Product extends StatefulWidget {
  final String shopId;
  const Product({Key? key, required this.shopId}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<Product> {
  final List<ProductModel> _products = [];
  String _selectedProductType = '';
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _countcontroller = TextEditingController();
  DateTime? _selectedExpiryDate;
  bool _isFeatured = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
        backgroundColor: Color.fromARGB(246, 201, 21, 41),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Product Name',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: _productNameController,
              onChanged: (value) {
                setState(() {
                  // No need to use _productName variable
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter product name',
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Product Type',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedProductType,
              onChanged: (newValue) {
                setState(() {
                  _selectedProductType = newValue!;
                });
              },
              items: <String>[
                '',
                'Fruits',
                'Vegetables',
                'Dairy',
                'Bakery',
                'Meat',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Select product type',
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Expiry Date',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            InkWell(
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(DateTime.now().year + 5),
                ).then((pickedDate) {
                  if (pickedDate != null) {
                    setState(() {
                      _selectedExpiryDate = pickedDate;
                    });
                  }
                });
              },
              child: InputDecorator(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: _selectedExpiryDate != null
                      ? _selectedExpiryDate!.toString().split(' ')[0]
                      : 'Select expiry date',
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Price',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: _priceController,
              onChanged: (value) {
                // No need to setState for _price
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter price',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            Text(
              'Stocks Available',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: _countcontroller,
              onChanged: (value) {},
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter number of packets available',
              ),
              keyboardType: TextInputType.number,
            ),
            Row(
              children: [
                Checkbox(
                  value: _isFeatured,
                  onChanged: (value) {
                    setState(() {
                      _isFeatured = value!;
                    });
                  },
                ),
                Text(
                  'Featured Product',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _addProduct(widget.shopId);
              },
              child: Text('Add Product'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color.fromARGB(246, 201, 21, 41),
                textStyle: TextStyle(fontSize: 18),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              ),
            ),
            SizedBox(height: 26),
            Row(
              children: [
                TextButton(
                  onPressed: () async {
                    await AuthMethods().signOut();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                      (route) => false,
                    );
                  },
                  child: Text(
                    'Finish Adding Products',
                    style: TextStyle(
                      color: Color.fromARGB(246, 201, 21, 41),
                    ),
                  ),
                ),
                
               TextButton(
                   onPressed: () {
                    Navigator.push(
                    context,
                     MaterialPageRoute(
                     builder: (context) => ProductList(shopId: widget.shopId),
                      ),
                    );
                   },
             child: Text(
             'View Product List',
             style: TextStyle(
               color: Color.fromARGB(246, 201, 21, 41),
          ),
          ),
         ),


              ],
            ),
          ],
        ),
      ),
    );
  }

  void _addProduct(String shopId) {
    String productName = _productNameController.text;
    int count = int.parse(_countcontroller.text);
    double price = double.parse(_priceController.text);
    // Check if all required fields are filled
    if (productName.isNotEmpty &&
        _selectedProductType.isNotEmpty &&
        _selectedExpiryDate != null) {
      // Add data to Firestore
      FirebaseFirestore.instance.collection('Products').add({
        'name': productName,
        'type': _selectedProductType,
        'expiryDate': _selectedExpiryDate!,
        'price': price,
        'isFeatured': _isFeatured,
        'shop_id': shopId,
        'count': count,
        // Add user UID to the product data
      }).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Product added successfully')),
        );

        // Clear input fields after successful addition
        _productNameController.clear();
        _selectedProductType = '';
        _selectedExpiryDate = null;
        _priceController.clear();
        _isFeatured = false;
      }).catchError((error) {
        // Error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add product: $error')),
        );
      });
    } else {
      // Show error if any field is empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
    }
  }
}
