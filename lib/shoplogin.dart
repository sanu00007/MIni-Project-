import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farefinale/product.dart';
import 'package:farefinale/resources/auth_methods.dart';
import 'package:farefinale/shop_registration.dart';
import 'package:farefinale/utils/dimension.dart';
import 'package:farefinale/utils/utils.dart';
import 'package:farefinale/widgets/textfield.dart';
import 'package:flutter/material.dart';

class ShopLogin extends StatefulWidget {
  const ShopLogin({super.key});

  @override
  State<ShopLogin> createState() => _ShopLoginState();
}

class _ShopLoginState extends State<ShopLogin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  bool _isLoading = false;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
  }
  
  Future<String> getShopIdFromEmail(String email) async {
  // Query Firestore to find a shop with the given email
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Shop').where('mail', isEqualTo: email).get();
  if (querySnapshot.docs.isNotEmpty) {
    // Shop found, return the shop_id
    return querySnapshot.docs[0].id;
  } else {
    // Shop not found
    return '';
  }
}

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passController.text);
    if (res == "success") {
      String shop_id = await getShopIdFromEmail(_emailController.text);

      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Product(shopId: shop_id)));
    } else {
      showSnackbar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void navigateTosignup() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const Shopreg()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          // Wrap with SingleChildScrollView
          child: Container(
            padding: MediaQuery.of(context).size.width > webScreenSize
                ? EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 3)
                : const EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 16), // Adjusted spacing
                Image.asset(
                  "assets/images/templogo.png",
                  height: 250,
                ),
                const SizedBox(
                  height: 30,
                ),
                Textfieldinput(
                  hintText: "Enter your email",
                  textInputType: TextInputType.emailAddress,
                  textEditingController: _emailController,
                ),
                const SizedBox(
                  height: 24,
                ),
                Textfieldinput(
                  hintText: "Enter your password",
                  textInputType: TextInputType.text,
                  textEditingController: _passController,
                  isPass: true,
                ),
                const SizedBox(
                  height: 24,
                ),
                InkWell(
                  onTap: loginUser,
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      color: Color.fromARGB(246, 201, 21, 41),
                    ),
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("If you don't have an account?"),
                    GestureDetector(
                      onTap: navigateTosignup,
                      child: const Text(
                        "Register Shop",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16), // Adjusted spacing
              ],
            ),
          ),
        ),
      ),
    );
  }
}
