import 'package:farefinale/home.dart';
import 'package:farefinale/main.dart';
import 'package:farefinale/onboard.dart';
import 'package:farefinale/resources/auth_methods.dart';
import 'package:farefinale/utils/dimension.dart';
import 'package:farefinale/utils/utils.dart';
import 'package:farefinale/widgets/textfield.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passController.text,
    );
    if (res == "success") {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Onboard()));
    } else {
      showSnackbar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void navigateToLogin() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
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
                  onTap: signUpUser,
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
                            'Sign In',
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
                    const Text("Already have an account?"),
                    GestureDetector(
                      onTap: navigateToLogin,
                      child: const Text(
                        "Login",
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
