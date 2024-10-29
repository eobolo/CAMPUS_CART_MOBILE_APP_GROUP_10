import 'dart:io';
import 'package:campus_cart/controllers/user_controller.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StoreLogoStateController extends GetxController {
  RxString imageUrl = "".obs;
  dynamic fileObject = null.obs;
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

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
    final StoreLogoStateController storeLogoStateController =
        Get.find<StoreLogoStateController>();
    final UserStateController userStateController =
        Get.find<UserStateController>();
    try {
      final storageRef = FirebaseStorage.instance.ref();
      final logoImageRef =
          storageRef.child("store_logos/$userId/store_logo.png");

      // Try to download the URL of the image
      dynamic downloadUrl = await logoImageRef.getDownloadURL();

      // Update the image URL to be used in the UI
      storeLogoStateController.imageUrl.value = downloadUrl;
      // update campus cart user db with store logo
      await _dbRef
          .child("campusCartUsers")
          .child(userStateController.loggedInuser.uid)
          .update({"storeLogo": downloadUrl});
      // now add this to the campuscartuser reactive variable
      userStateController.campusCartUser.value = {
        ...userStateController.campusCartUser,
        "storeLogo": downloadUrl
      };
      userStateController.campusCartUser.refresh();
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
