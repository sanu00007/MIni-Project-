import 'package:farefinale/product.dart';
import 'package:farefinale/resources/auth_methods.dart';
import 'package:farefinale/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

class Shopreg extends StatefulWidget {
  const Shopreg({Key? key}) : super(key: key);

  @override
  State<Shopreg> createState() => _ShopregState();
}

class _ShopregState extends State<Shopreg> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final _shopNameController = TextEditingController();
  final _shopRegNoController = TextEditingController();
  final _ownerNameController = TextEditingController();
  final _phoneNoController = TextEditingController();
  final _locationController = TextEditingController();
  String _selectedCategory = '';
  bool _termsAndConditionsAccepted = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _shopNameController.dispose();
    _shopRegNoController.dispose();
    _ownerNameController.dispose();
    _phoneNoController.dispose();
    _locationController.dispose();
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passController.text,
      username: _ownerNameController.text,
    );
    if (res == "success") {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Product()));
    } else {
      showSnackbar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void navigatetoproduct() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Product()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Shop Registration'),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Shop Name',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _shopNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter shop name',
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Email',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your mail',
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Password',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _passController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter password',
                ),
              ),
              SizedBox(height: 16),
              Text(
                'FSSAI License No.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _shopRegNoController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter FSSAI License Number',
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Owner Name',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _ownerNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter owner name',
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Phone Number',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _phoneNoController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter phone number',
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 16),
              Text(
                'Location',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter location',
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Shop Category',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                onChanged: (newValue) {
                  setState(() {
                    _selectedCategory = newValue!;
                  });
                },
                items: <String>['', 'Groceries', 'Fresh Produce', 'Baked Goods']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Select shop category',
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Delivery Preferences',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: _termsAndConditionsAccepted,
                    onChanged: (value) {
                      setState(() {
                        _termsAndConditionsAccepted = value!;
                      });
                    },
                  ),
                  Text(
                    'I agree to the terms and conditions',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _registerShop();
                    signUpUser();
                  },
                  child: Text('Register Shop'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    textStyle: TextStyle(fontSize: 18),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _registerShop() {
    // Add your logic to register the shop
    String shopName = _shopNameController.text;
    String shopRegNo = _shopRegNoController.text;
    String ownerName = _ownerNameController.text;
    String phoneNo = _phoneNoController.text;
    String location = _locationController.text;
    String category = _selectedCategory;
    String mail = _emailController.text;

    String shop_id = "";
    // Check if all required fields are filled
    if (shopName.isNotEmpty &&
        shopRegNo.isNotEmpty &&
        ownerName.isNotEmpty &&
        phoneNo.isNotEmpty &&
        category.isNotEmpty &&
        location.isNotEmpty &&
        mail.isNotEmpty &&
        _termsAndConditionsAccepted) {
      // Add data to Firestore
      FirebaseFirestore.instance.collection('Shop').add({
        'shopName': shopName,
        'shopRegNo': shopRegNo,
        'ownerName': ownerName,
        'phoneNo': phoneNo,
        'location': location,
        'category': category,
        'mail': mail,
      }).then((value) {
        // Success message
        shop_id = value.id;
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Shop registered successfully')));

        FirebaseFirestore.instance.collection('Shop Owners').add({
          'name': ownerName,
          'email': mail,
          'shop_id': shop_id,
        }).then((value) {
          // Success message for adding shop owner data
          // You can navigate to the next screen or perform any other actions here
          navigatetoproduct();
        }).catchError((error) {
          // Error message for adding shop owner data
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to register shop owner: $error')),
          );
        });
      }).catchError((error) {
        // Error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to register shop: $error')),
        );
      });
    } else {
      // Show error if any field is empty or terms not accepted
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields and accept terms')),
      );
    }
  }
}
