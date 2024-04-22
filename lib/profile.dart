import 'package:farefinale/main.dart';
import 'package:flutter/material.dart';
import 'package:farefinale/resources/auth_methods.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            size: 20,
            color: Colors.black,
          ),
        ),
        title: const Text('Profile'),
        backgroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color.fromARGB(255, 241, 193, 131),
              const Color.fromARGB(255, 233, 233, 184),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Text(
                          '1234 Street Name,\nCity, Country',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'SpecialFont',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: CircleAvatar(
                          radius: 100,
                          backgroundImage:
                              AssetImage('assets/images/profilepic.png'),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'User Details',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'SpecialFont',
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Name: John Doe\nEmail: john.doe@example.com\nPhone: +1234567890',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontFamily: 'SpecialFont',
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Options',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'SpecialFont',
                  ),
                ),
                const SizedBox(height: 10),
                buildOptionItem(
                  icon: Icons.payment,
                  title: 'Payment',
                  onTap: () {},
                ),
                buildOptionItem(
                  icon: Icons.shopping_basket,
                  title: 'Delivered Items',
                  onTap: () {},
                ),
                buildOptionItem(
                  icon: Icons.settings,
                  title: 'Settings',
                  onTap: () {},
                ),
                buildOptionItem(
                  icon: Icons.local_offer,
                  title: 'Promo Code',
                  onTap: () {},
                ),
                buildOptionItem(
                  icon: Icons.logout,
                  title: 'Logout',
                  onTap: () async {
                    await AuthMethods().signOut();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                      (route) => false,
                    );
                  },
                ),
                const SizedBox(height: 20),
                Divider(color: Colors.black), // Add divider line
                const SizedBox(height: 20),
                Text(
                  'Preferences',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'SpecialFont',
                  ),
                ),
                // Add user preferences widgets
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildOptionItem({
    required IconData icon,
    required String title,
    required Function()? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(
        title,
        style: TextStyle(color: Colors.black, fontFamily: 'SpecialFont'),
      ),
      onTap: onTap as void Function()?,
    );
  }
}
