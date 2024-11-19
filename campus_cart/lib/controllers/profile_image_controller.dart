import 'dart:io';
import 'package:campus_cart/controllers/user_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileImageController extends GetxController {
  Future<void> uploadImage(XFile? imageFile, String userId) async {
    // create storage instance
    final storageRef = FirebaseStorage.instance.ref();
    // get user instance in controller.
    final UserStateController userStateController =
        Get.find<UserStateController>();

    // check if Xfile is not null
    if (imageFile != null) {
      File profileImageFile = File(imageFile.path);
      final profileImageRef =
          storageRef.child("profile_images/$userId/profile_image.png");
      try {
        await profileImageRef.putFile(profileImageFile);
        dynamic imageURL = await retrieveImage(userId);
        // update user photoURL
        await userStateController.loggedInuser?.updatePhotoURL(imageURL);
      } catch (e) {
        throw Exception("Error uploading image: $e");
      }
    }
  }

  Future<dynamic> retrieveImage(String userId) async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      final profileImageRef =
          storageRef.child("profile_images/$userId/profile_image.png");

      // Try to download the URL of the image
      dynamic downloadUrl = await profileImageRef.getDownloadURL();
      return downloadUrl;
    } on FirebaseException catch (e) {
      if (e.code == 'object-not-found') {
        // The file doesn't exist
        throw Exception(
            "upload your profile image, no previous profile image found: $e");
      } else {
        // Handle other potential errors
        throw Exception(
            'upload your profile image, no previous profile image found: $e');
      }
    }
  }
}
