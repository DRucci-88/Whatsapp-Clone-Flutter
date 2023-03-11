import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void customShowSnackbar({
  required BuildContext context,
  required String content,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}

Future<File?> pickImageFromGallery(BuildContext context) async {
  File? image;
  try {
    // pickedImage that taken from gallery only save in cache / temporary
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    // convert XFile to File
    if (pickedImage != null) image = File(pickedImage.path);
  } catch (e) {
    customShowSnackbar(context: context, content: e.toString());
  }
  return image;
}
