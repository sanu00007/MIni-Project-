import 'package:flutter/material.dart';
import 'package:farefinale/signup.dart';

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
  String _productName = '';
  DateTime? _selectedExpiryDate;
  double _price = 0.0;
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
              onChanged: (value) {
                setState(() {
                  _productName = value;
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
              onChanged: (value) {
                setState(() {
                  _price = double.parse(value);
                });
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
            Text(
              'Added Products:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _products.map((product) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name: ${product.name}'),
                    Text('Type: ${product.type}'),
                    Text('Expiry Date: ${product.expiryDate}'),
                    Text('Price: ${product.price}'),
                    Text('Featured: ${product.isFeatured}'),
                    Divider(),
                  ],
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {
                _finishAddingProducts();
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
    if (_productName.isNotEmpty &&
        _selectedProductType.isNotEmpty &&
        _selectedExpiryDate != null) {
      setState(() {
        _products.add(
          ProductModel(
            name: _productName,
            type: _selectedProductType,
            expiryDate: _selectedExpiryDate!,
            price: _price,
            isFeatured: _isFeatured,
          ),
        );
        _productName = '';
        _selectedProductType = '';
        _selectedExpiryDate = null;
        _price = 0.0;
        _isFeatured = false;
      });
    }
  }

  void _finishAddingProducts() {
    // Navigate to login page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Signup()),
    );
  }
}
