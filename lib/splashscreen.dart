import 'dart:async';
import 'package:farefinale/signup.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 3000), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Signup()));
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/templogo.png"),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Fare Finale",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w900,
                fontSize: 24, // Adjust font size if necessary
              ),
            ),
            SizedBox(height: 11.5),
            Text(
              'Find Expiring Food Near You',
              style: TextStyle(
                fontSize: 16, // Adjust font size if necessary
              ),
            ),
          ],
        ),
      ),
    );
  }
}
