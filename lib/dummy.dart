import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Dummy extends StatefulWidget {
  const Dummy({super.key});

  @override
  State<Dummy> createState() => _DummyState();
}

class _DummyState extends State<Dummy> {
  String imageUrl = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
      ),
      body: Column(
        children: [
          IconButton(
            onPressed: () async {
              ImagePicker imagePicker = ImagePicker();
              XFile? file =
                  await imagePicker.pickImage(source: ImageSource.gallery);
              String uniqueFileName =
                  DateTime.now().millisecondsSinceEpoch.toString();
              if (file == null) {
                return;
              }
              Reference referenceRoot = FirebaseStorage.instance.ref();
              Reference referenceDirImages = referenceRoot.child('images');
              Reference referenceImageToUpload =
                  referenceDirImages.child(uniqueFileName);
              try {
                await referenceImageToUpload.putFile(File(file!.path));
                imageUrl = await referenceImageToUpload.getDownloadURL();
                upimage();
              } catch (error) {}
            },
            icon: Icon(Icons.camera_alt_outlined),
          )
        ],
      ),
    );
  }

  void upimage() {
    FirebaseFirestore.instance.collection('Food').doc('Noodles').set({
      'image': imageUrl,
    }).then((value) {
      // Success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image uploaded successfully')),
      );
    }).catchError((error) {
      // Error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload image: $error')),
      );
    });
  }
}
