import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20.0),
            // Text(
            //   'Ordering Process',
            //   style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            // ),
            // ListTile(
            //   leading: Icon(Icons.arrow_right),
            //   title: Text('How to place an order'),
            //   onTap: () {
            //     // Add navigation logic or display information
            //   },
            // ),
            // ListTile(
            //   leading: Icon(Icons.arrow_right),
            //   title: Text('Selecting items from the menu'),
            //   onTap: () {
            //     // Add navigation logic or display information
            //   },
            // ),
            // ListTile(
            //   leading: Icon(Icons.arrow_right),
            //   title: Text('Adding items to the cart'),
            //   onTap: () {
            //     // Add navigation logic or display information
            //   },
            // ),
            // ListTile(
            //   leading: Icon(Icons.arrow_right),
            //   title: Text('Payment options available'),
            //   onTap: () {
            //     // Add navigation logic or display information
            //   },
            // ),
            SizedBox(height: 20.0),
            Text(
              'Account Management',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            ListTile(
              leading: Icon(Icons.arrow_right),
              title: Text('Creating an account'),
              onTap: () {
                // Add navigation logic or display information
              },
            ),
            ListTile(
              leading: Icon(Icons.arrow_right),
              title: Text('Logging into an existing account'),
              onTap: () {
                // Add navigation logic or display information
              },
            ),
            ListTile(
              leading: Icon(Icons.arrow_right),
              title: Text('Updating profile information'),
              onTap: () {
                // Add navigation logic or display information
              },
            ),
            ListTile(
              leading: Icon(Icons.arrow_right),
              title: Text('Resetting password'),
              onTap: () {
                // Add navigation logic or display information
              },
            ),
            SizedBox(height: 20.0),
            Text(
              'Privacy and Security',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            ListTile(
              leading: Icon(Icons.arrow_right),
              title: Text('Privacy policy'),
              onTap: () {
                // Add navigation logic or display information
              },
            ),
            ListTile(
              leading: Icon(Icons.arrow_right),
              title: Text('Data security measures'),
              onTap: () {
                // Add navigation logic or display information
              },
            ),
            ListTile(
              leading: Icon(Icons.arrow_right),
              title: Text('User data protection practices'),
              onTap: () {
                // Add navigation logic or display information
              },
            ),
            SizedBox(height: 20.0),
            Text(
              'App Features',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            ListTile(
              leading: Icon(Icons.arrow_right),
              title: Text('Explanation of key features of the app'),
              onTap: () {
                // Add navigation logic or display information
              },
            ),
            ListTile(
              leading: Icon(Icons.arrow_right),
              title: Text('How to navigate different sections of the app'),
              onTap: () {
                // Add navigation logic or display information
              },
            ),
            SizedBox(height: 20.0),
            Text(
              'Legal Information',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            ListTile(
              leading: Icon(Icons.arrow_right),
              title: Text('Terms of Service'),
              onTap: () {
                // Add navigation logic or display information
              },
            ),
            ListTile(
              leading: Icon(Icons.arrow_right),
              title: Text('End User License Agreement (EULA)'),
              onTap: () {
                // Add navigation logic or display information
              },
            ),
            ListTile(
              leading: Icon(Icons.arrow_right),
              title: Text(
                  'Disclaimer regarding product availability, pricing, and accuracy of information'),
              onTap: () {
                // Add navigation logic or display information
              },
            ),
          ],
        ),
      ),
    );
  }
}
