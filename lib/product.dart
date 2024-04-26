import 'package:farefinale/main.dart';
import 'package:farefinale/resources/auth_methods.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String name;
  String type;
  DateTime expiryDate;
  double price;
  bool isFeatured;

  ProductModel({
    required this.name,
    required this.type,
    required this.expiryDate,
    required this.price,
    required this.isFeatured,
  });
}

class Product extends StatefulWidget {
  const Product({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<Product> {
  final List<ProductModel> _products = [];
  String _selectedProductType = '';
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  DateTime? _selectedExpiryDate;
  bool _isFeatured = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
        backgroundColor: Colors.red,
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
                _addProduct();
              },
              child: Text('Add Product'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                textStyle: TextStyle(fontSize: 18),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              ),
            ),
            SizedBox(height: 32),
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
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addProduct() {
    String productName = _productNameController.text;
    double price = double.parse(_priceController.text);
    // Check if all required fields are filled
    if (productName.isNotEmpty &&
        _selectedProductType.isNotEmpty &&
        _selectedExpiryDate != null) {
      // Get the current user UID
      String uid = FirebaseAuth.instance.currentUser!.uid;

      // Add data to Firestore
      FirebaseFirestore.instance.collection('Products').add({
        'name': productName,
        'type': _selectedProductType,
        'expiryDate': _selectedExpiryDate!,
        'price': price,
        'isFeatured': _isFeatured,
        'uid': uid, // Add user UID to the product data
      }).then((value) {
        // Success message
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
