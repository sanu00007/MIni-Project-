import 'package:cloud_firestore/cloud_firestore.dart';

class ShopDetail {
  final String id, contact, name, location, category;
  ShopDetail({
    required this.id,
    required this.contact,
    required this.name,
    required this.location,
    required this.category,
  });
}

List<ShopDetail> ShopDetails = [];

Future<void> fetchShopDetailsFromFirestore() async {
  try {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Shop').get();
    querySnapshot.docs.forEach((doc) {
      ShopDetails.add(
        ShopDetail(
            id: doc.id,
            contact: doc['phoneNo'],
            location: doc['location'],
            name: doc['shopName'],
            category: doc['category']),
      );
    });
  } catch (e) {
    print("Error fetching shop details: $e");
  }
}
