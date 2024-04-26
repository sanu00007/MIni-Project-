import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farefinale/main.dart';
import 'package:farefinale/onboard.dart';
import 'package:farefinale/resources/auth_methods.dart';
import 'package:farefinale/shoplogin.dart';
import 'package:farefinale/utils/dimension.dart';
import 'package:farefinale/utils/utils.dart';
import 'package:farefinale/widgets/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_button/sign_in_button.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
    _usernameController.dispose();
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      username : _usernameController.text,
      email: _emailController.text,
      password: _passController.text,
    );
    if (res == "success") {
      FirebaseFirestore.instance.collection('User').add({
        'username': _usernameController.text,
        'email': _emailController.text,
        'photoUrl' : "",
      }).then((value) {
        // Success message for adding shop owner data
        // You can navigate to the next screen or perform any other actions here
      }).catchError((error) {
        // Error message for adding user data
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to signup :$error')),
        );
      });

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

  void navigateToOwner() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ShopLogin()));
  }

  final _auth = FirebaseAuth.instance;
  Future<UserCredential?> loginWithgoogle(BuildContext context) async {
    try {
      final googleUser = await GoogleSignIn().signIn();

      if (googleUser != null) {
        final googleAuth = await googleUser.authentication;

        final cred = GoogleAuthProvider.credential(
            idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

        final userCredential = await _auth.signInWithCredential(cred);

         // Access user information
        final User user = userCredential.user!;

        final String? username = user.displayName;
        final String? photoUrl = user.photoURL;
        final String? email = user.email;

         FirebaseFirestore.instance.collection('User').add({
           'username': username,
           'photoUrl': photoUrl,
           'email': email,
        });

        // Check if userCredential is not null and navigate to onboard screen
        // ignore: unnecessary_null_comparison
        if (userCredential != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  Onboard(), // Replace 'Onboard' with your onboard screen
            ),
          );

          return userCredential;
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
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
                  hintText: "Enter your username",
                  textInputType: TextInputType.text,
                  textEditingController: _usernameController,
                ),
                const SizedBox(
                  height: 24,
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
                            'Sign Up',
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),
                const Text(
                  'OR',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),

                //google signin
                SignInButton(
                  Buttons.google,
                  onPressed: () => loginWithgoogle(context),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: navigateToOwner,
                      child: const Text(
                        "Are you a Shop Owner?",
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
