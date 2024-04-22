import 'package:farefinale/widgets/textfield.dart';
import 'package:flutter/material.dart';

class Shopreg extends StatefulWidget {
  const Shopreg({Key? key}) : super(key: key);

  @override
  State<Shopreg> createState() => _ShopregState();
}

class _ShopregState extends State<Shopreg> {
  final _shopNameController = TextEditingController();
  final _shopLocationController = TextEditingController();

  @override
  void dispose() {
    _shopNameController.dispose();
    _shopLocationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          // Wrap with SingleChildScrollView
          child: Container(
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Adjusted spacing
                TextField(
                  //controller: _shopNameController,
                  decoration: InputDecoration(
                    hintText: 'Enter shop name',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 16),

                TextField(
                  //controller: _shopNameController,
                  decoration: InputDecoration(
                    hintText: 'Enter shop location',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                TextField(
                  //controller: _shopNameController,
                  decoration: InputDecoration(
                    hintText: 'Enter shop location',
                    border: OutlineInputBorder(),
                  ),
                ), // Adjusted spacing
              ],
            ),
          ),
        ),
      ),
    );
  }
}
