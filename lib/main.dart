import 'package:farefinale/home.dart';
import 'package:farefinale/resources/auth_methods.dart';
import 'package:farefinale/signup.dart';
import 'package:farefinale/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'splashscreen.dart';
import 'utils/dimension.dart';
import 'widgets/textfield.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyA-eZb82KnCnGh9-sSqaHcyVSwcB7WDbEc",
        appId: "1:969641690633:web:b3e11cb657b5d233d1dad8",
        messagingSenderId: "969641690633",
        projectId: "farefinale-4ec3b",
        storageBucket: "farefinale-4ec3b.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: StreamBuilder(
      stream: FirebaseAuth.instance.idTokenChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return MyApp();
          } else if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          }
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }
        return const SplashScreen();
      },
    ),
  ));
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  bool _isLoading = false;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passController.text);
    if (res == "success") {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MyApp()));
    } else {
      showSnackbar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void navigateTosignup() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const Signup()));
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
                        "Sign In",
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
