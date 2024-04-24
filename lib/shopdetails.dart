import 'package:cloud_firestore/cloud_firestore.dart';

class ShopDetail {
  final String id, contact, name, location;
  ShopDetail({
    required this.id,
    required this.contact,
    required this.name,
    required this.location,
  });
}

List<ShopDetail> ShopDetails = [];

Future<void> fetchShopDetailsFromFirestore() async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Shop').get();
    querySnapshot.docs.forEach((doc) {
      ShopDetails.add(
        ShopDetail(
          id: doc.id,
          contact: doc['contact'],
          location: doc['loc'],
          name: doc['name'],
        ),
      );
    });
  } catch (e) {
    print("Error fetching shop details: $e");
  }
}

