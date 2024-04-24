import 'package:flutter/material.dart';

class Shopreg extends StatefulWidget {
  const Shopreg({Key? key}) : super(key: key);

  @override
  State<Shopreg> createState() => _ShopregState();
}

class _ShopregState extends State<Shopreg> {
  final _shopNameController = TextEditingController();
  final _shopRegNoController = TextEditingController();
  final _ownerNameController = TextEditingController();
  final _phoneNoController = TextEditingController();
  String _selectedCategory = '';
  String _selectedOperatingHours = '';
  String _selectedDeliveryPreference = '';
  bool _termsAndConditionsAccepted = false;

  @override
  void dispose() {
    _shopNameController.dispose();
    _shopRegNoController.dispose();
    _ownerNameController.dispose();
    _phoneNoController.dispose();
    super.dispose();
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
                'Operating Hours',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedOperatingHours,
                onChanged: (newValue) {
                  setState(() {
                    _selectedOperatingHours = newValue!;
                  });
                },
                items: <String>['', 'Morning', 'Afternoon', 'Evening']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Select operating hours',
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Delivery Preferences',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedDeliveryPreference,
                onChanged: (newValue) {
                  setState(() {
                    _selectedDeliveryPreference = newValue!;
                  });
                },
                items: <String>['', 'Scheduled Delivery', 'On-Demand Delivery']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Select delivery preferences',
                ),
              ),
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
                    // Add your logic to register the shop
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
}
