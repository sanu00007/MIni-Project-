import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

showSnackbar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}
