import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20.0),
            _buildSectionTitle('Our Mission'),
            SizedBox(height: 10.0),
            _buildMissionText(),
            SizedBox(height: 20.0),
            _buildSectionTitle('Our Vision'),
            SizedBox(height: 10.0),
            _buildVisionText(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildMissionText() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: EdgeInsets.all(16.0),
      child: const Text(
        'Our mission at FareFinale is to combat food waste by connecting users with local shops offering discounted perishable items nearing their expiration dates. We strive to provide a sustainable solution that reduces economic loss and environmental strain while ensuring affordability and convenience for consumers.',
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }

  Widget _buildVisionText() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: EdgeInsets.all(16.0),
      child: const Text(
        'Our vision at FareFinale is to create a world where food waste is minimized, and every individual has access to affordable and fresh food options. We envision a community of eco-conscious consumers, budget-conscious shoppers, and supportive local businesses working together to make a positive impact on the environment and the economy. Through innovative technology and partnerships, we aim to revolutionize the way people think about food consumption and waste reduction.',
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }
}
