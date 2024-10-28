import 'dart:io';
import 'package:campus_cart/controllers/user_controller.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MealImageController extends GetxController {
  RxString imageUrl = "".obs;
  RxString mealName = "".obs;
  RxString mealDescription = "".obs;
  RxString cuisine = "".obs;
  RxString type = "".obs;
  RxString dietary = "".obs;
  RxInt preparationTime = 0.obs;
  RxInt price = 0.obs;
  RxInt latestMealId = 0.obs;
  RxInt editMealId = 0.obs;
  dynamic fileObject = null.obs;
  dynamic mapOfDishes = [].obs;

  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  void processFirstElement(List<Object?> dishes) {
    var firstItem = dishes[0];
    if (firstItem == null) {
      dishes.removeAt(0);
    }
  }

  Future<void> createMenuToDb() async {
    final UserStateController userStateController =
        Get.find<UserStateController>();
    final MealImageController mealImageController =
        Get.find<MealImageController>();

    /*
      - find the latest dish id created by user
      - convert to int
      - create a new menu by adding 1 to lastest dish id
    */
    Map<String, dynamic> newMenu = {};
    int newId = 1;
    if (mealImageController.mapOfDishes.isEmpty) {
      newId = 1;
      newMenu = {
        "$newId": {
          "mealName": mealImageController.mealName.value,
          "mealDescription": mealImageController.mealDescription.value,
          "cuisine": mealImageController.cuisine.value,
          "type": mealImageController.type.value,
          "dietary": mealImageController.dietary.value,
          "preparationTime": mealImageController.preparationTime.value,
          "price": mealImageController.price.value,
          "mealId": newId,
          "kitchen": userStateController.campusCartUser["vendorName"],
          "vendorId": userStateController.loggedInuser.uid,
        }
      };
    } else {
      var lastDish = mapOfDishes.last;
      newId = lastDish["mealId"] + 1;
      newMenu = {
        "$newId": {
          "mealName": mealImageController.mealName.value,
          "mealDescription": mealImageController.mealDescription.value,
          "cuisine": mealImageController.cuisine.value,
          "type": mealImageController.type.value,
          "dietary": mealImageController.dietary.value,
          "preparationTime": mealImageController.preparationTime.value,
          "price": mealImageController.price.value,
          "mealId": newId,
          "kitchen": userStateController.campusCartUser["vendorName"],
          "vendorId": userStateController.loggedInuser.uid,
        }
      };
    }
    try {
      await _dbRef
          .child("dishes")
          .child(userStateController.loggedInuser.uid)
          .update(newMenu);
      // store latest mealid and store new menu to mapofdishes
      mealImageController.latestMealId.value = newId;
      mapOfDishes.add({
        "mealName": mealImageController.mealName.value,
        "mealDescription": mealImageController.mealDescription.value,
        "cuisine": mealImageController.cuisine.value,
        "type": mealImageController.type.value,
        "dietary": mealImageController.dietary.value,
        "preparationTime": mealImageController.preparationTime.value,
        "price": mealImageController.price.value,
        "mealId": newId,
        "kitchen": userStateController.campusCartUser["vendorName"],
        "vendorId": userStateController.loggedInuser.uid,
      });
    } on FirebaseException catch (e) {
      // Handle Firebase Database errors
      switch (e.code) {
        case 'permission-denied':
          throw Exception('Permission denied: ${e.message}');
        case 'disconnected':
          throw Exception('Disconnected from the database: ${e.message}');
        case 'invalid-argument':
          throw Exception('Invalid argument: ${e.message}');
        default:
          throw Exception('Database error: ${e.message}');
      }
    } catch (e) {
      // Handle general errors
      throw Exception('An error occurred: $e');
    }
  }

  Future<void> getAllUserDishes() async {
    final UserStateController userStateController =
        Get.find<UserStateController>();

    if (mapOfDishes.isNotEmpty) {
      return;
    }

    try {
      final event = await _dbRef
          .child("dishes/${userStateController.loggedInuser.uid}")
          .once(DatabaseEventType.value);
      if (event.snapshot.value != null) {
        // type cast real time database fixed length to dynamic length
        List<Object?> vendorDishes =
            List<Object?>.from(event.snapshot.value as List<Object?>);
        processFirstElement(vendorDishes);
        mapOfDishes = vendorDishes;
      } else {
        mapOfDishes = [];
      }
    } catch (e) {
      throw Exception("$e");
    }
  }

  Future<void> editMenuToDb() async {}

  Future<void> uploadImage(XFile? imageFile, String userId) async {
    // create storage instance
    final storageRef = FirebaseStorage.instance.ref();
    final MealImageController mealImageController =
        Get.find<MealImageController>();
    final UserStateController userStateController =
        Get.find<UserStateController>();

    // check if Xfile is not null
    if (imageFile != null) {
      File mealImageFile = File(imageFile.path);
      final mealImageRef = storageRef.child(
          "meal_images/$userId/${mealImageController.latestMealId.value}/meal_image.png");
      try {
        await mealImageRef.putFile(mealImageFile);
        dynamic downloadUrl = await mealImageRef.getDownloadURL();
        await _dbRef
            .child("dishes")
            .child(userStateController.loggedInuser.uid)
            .child("${mealImageController.latestMealId.value}")
            .update({"mealImageUrl": downloadUrl});
        int index = mapOfDishes.indexWhere((dish) =>
            (dish as Map)['mealId'] ==
            mealImageController
                .latestMealId.value); // Assuming each dish is a Map

        // If the dish is found, update the mealImageUrl property
        if (index != -1) {
          (mapOfDishes[index] as Map)['mealImageUrl'] = downloadUrl;
        }
        fileObject = mealImageFile;
      } catch (e) {
        throw Exception("Error uploading image: $e");
      }
    }
  }

  // Future<void> retrieveImage(String userId) async {
  //   try {
  //     final storageRef = FirebaseStorage.instance.ref();
  //     final mealImageRef =
  //         storageRef.child("meal_images/$userId/meal_image.png");
  //     // Try to download the URL of the image
  //     dynamic downloadUrl = await mealImageRef.getDownloadURL();

  //     // Update the image URL to be used in the UI
  //     imageUrl.value = downloadUrl;
  //   } on FirebaseException catch (e) {
  //     if (e.code == 'object-not-found') {
  //       // The file doesn't exist
  //       throw Exception(
  //           "upload your meal image, no previous meal image found: $e");
  //     } else {
  //       // Handle other potential errors
  //       throw Exception(
  //           'upload your meal image, no previous meal image found: $e');
  //     }
  //   }
  // }
}
