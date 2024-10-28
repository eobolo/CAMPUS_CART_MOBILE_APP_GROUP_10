import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StoreLogoStateController extends GetxController {
  RxString imageUrl = "".obs;
  dynamic fileObject = null.obs;

  Future<void> uploadImage(XFile? imageFile, String userId) async {
    // create storage instance
    final storageRef = FirebaseStorage.instance.ref();

    // check if Xfile is not null
    if (imageFile != null) {
      File logoFile = File(imageFile.path);
      final logoImageRef =
          storageRef.child("store_logos/$userId/store_logo.png");
      try {
        await logoImageRef.putFile(logoFile);
        await retrieveImage(userId);
        fileObject = logoFile;
      } catch (e) {
        throw Exception("Error uploading image: $e");
      }
    }
  }

  Future<void> retrieveImage(String userId) async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      final logoImageRef =
          storageRef.child("store_logos/$userId/store_logo.png");

      // Try to download the URL of the image
      dynamic downloadUrl = await logoImageRef.getDownloadURL();

      // Update the image URL to be used in the UI
      imageUrl.value = downloadUrl;
    } on FirebaseException catch (e) {
      if (e.code == 'object-not-found') {
        // The file doesn't exist
        throw Exception(
            "upload your store image, no previous store image found: $e");
      } else {
        // Handle other potential errors
        throw Exception(
            'upload your store image, no previous store image found: $e');
      }
    }
  }
}
