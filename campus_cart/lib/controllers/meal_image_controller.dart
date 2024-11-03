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

  void reset() {
    imageUrl.value = "";
    mealName.value = "";
    mealDescription.value = "";
    cuisine.value = "";
    type.value = "";
    dietary.value = "";
    preparationTime.value = 0;
    price.value = 0;
    latestMealId.value = 0;
    editMealId.value = 0;
    fileObject = null;
    mapOfDishes = [];
    mapOfDishes.refresh();
  }

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
      // save menu to dishes table.
      await _dbRef
          .child("dishes")
          .child(userStateController.loggedInuser.uid)
          .update(newMenu);
      // store latest mealid and store new menu to mapofdishes
      mealImageController.latestMealId.value = newId;
      mealImageController.mapOfDishes.add({
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

      // store this dish into Alldishes table.
      await _dbRef
          .child("allDishes")
          .child("${userStateController.loggedInuser.uid}-$newId")
          .update({
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
    final MealImageController mealImageController =
        Get.find<MealImageController>();
    if (mealImageController.mapOfDishes.isNotEmpty) {
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
        mealImageController.mapOfDishes.value = vendorDishes;
      } else {
        mealImageController.mapOfDishes.value = [];
      }
    } catch (e) {
      throw Exception("$e");
    }
  }

  Future<void> editMenuToDb() async {
    final UserStateController userStateController =
        Get.find<UserStateController>();
    final MealImageController mealImageController =
        Get.find<MealImageController>();
    Map<String, dynamic> newMenu = {};
    int mealId = mealImageController.editMealId.value;
    newMenu = {
      "$mealId": {
        "mealName": mealImageController.mealName.value,
        "mealDescription": mealImageController.mealDescription.value,
        "cuisine": mealImageController.cuisine.value,
        "type": mealImageController.type.value,
        "dietary": mealImageController.dietary.value,
        "preparationTime": mealImageController.preparationTime.value,
        "price": mealImageController.price.value,
        "mealId": mealId,
        "kitchen": userStateController.campusCartUser["vendorName"],
        "vendorId": userStateController.loggedInuser.uid,
      }
    };
    try {
      // save edited value to dishes table
      await _dbRef
          .child("dishes")
          .child(userStateController.loggedInuser.uid)
          .update(newMenu);
      // save edited value to alldishes table
      await _dbRef
          .child("allDishes")
          .child("${userStateController.loggedInuser.uid}-$mealId")
          .update({
        "mealName": mealImageController.mealName.value,
        "mealDescription": mealImageController.mealDescription.value,
        "cuisine": mealImageController.cuisine.value,
        "type": mealImageController.type.value,
        "dietary": mealImageController.dietary.value,
        "preparationTime": mealImageController.preparationTime.value,
        "price": mealImageController.price.value,
        "mealId": mealId,
        "kitchen": userStateController.campusCartUser["vendorName"],
        "vendorId": userStateController.loggedInuser.uid,
      });

      // save to getx controller
      int index = mealImageController.mapOfDishes
          .indexWhere((dish) => (dish as Map)['mealId'] == mealId);

      if (index != -1) {
        mealImageController.mapOfDishes[index] = {
          "mealName": mealImageController.mealName.value,
          "mealDescription": mealImageController.mealDescription.value,
          "cuisine": mealImageController.cuisine.value,
          "type": mealImageController.type.value,
          "dietary": mealImageController.dietary.value,
          "preparationTime": mealImageController.preparationTime.value,
          "price": mealImageController.price.value,
          "mealId": mealId,
          "kitchen": userStateController.campusCartUser["vendorName"],
          "vendorId": userStateController.loggedInuser.uid,
        };
        mealImageController.mapOfDishes.refresh();
      }
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
        // add image to the database of user dishes
        await _dbRef
            .child("dishes")
            .child(userStateController.loggedInuser.uid)
            .child("${mealImageController.latestMealId.value}")
            .update({"mealImageUrl": downloadUrl});
        // add image to the database all dishes
        await _dbRef
            .child("allDishes")
            .child(
                "${userStateController.loggedInuser.uid}-${mealImageController.latestMealId.value}")
            .update({"mealImageUrl": downloadUrl});
        // add to the controller state.
        int index = mealImageController.mapOfDishes.indexWhere((dish) =>
            (dish as Map)['mealId'] ==
            mealImageController
                .latestMealId.value); // Assuming each dish is a Map

        // If the dish is found, update the mealImageUrl property
        if (index != -1) {
          (mealImageController.mapOfDishes[index] as Map)['mealImageUrl'] =
              downloadUrl;
        }
        fileObject = mealImageFile;
        mealImageController.mapOfDishes.refresh();
      } catch (e) {
        throw Exception("Error uploading image: $e");
      }
    }
  }

  Future<void> editUploadImage(
      XFile? imageFile, String userId, int mealId) async {
    final MealImageController mealImageController =
        Get.find<MealImageController>();
    final UserStateController userStateController =
        Get.find<UserStateController>();
    // create storage instance
    final storageRef = FirebaseStorage.instance.ref();

    // check if Xfile is not null
    if (imageFile != null) {
      File mealImageFile = File(imageFile.path);
      final mealImageRef =
          storageRef.child("meal_images/$userId/$mealId/meal_image.png");
      try {
        await mealImageRef.putFile(mealImageFile);
        dynamic downloadUrl = await mealImageRef.getDownloadURL();
        // add to the dishes database
        await _dbRef
            .child("dishes")
            .child(userId)
            .child("$mealId")
            .update({"mealImageUrl": downloadUrl});
        // add to the alldishes database
        await _dbRef
            .child("allDishes")
            .child("${userStateController.loggedInuser.uid}-$mealId")
            .update({"mealImageUrl": downloadUrl});
        int index = mealImageController.mapOfDishes.indexWhere((dish) =>
            (dish as Map)['mealId'] == mealId); // Assuming each dish is a Map

        // If the dish is found, update the mealImageUrl property
        if (index != -1) {
          (mealImageController.mapOfDishes[index] as Map)['mealImageUrl'] =
              downloadUrl;
        }
        fileObject = mealImageFile;
        mealImageController.mapOfDishes.refresh();
      } catch (e) {
        throw Exception("Error uploading image: $e");
      }
    } else {
      int index = mealImageController.mapOfDishes.indexWhere((dish) =>
          (dish as Map)['mealId'] == mealId); // Assuming each dish is a Map

      // If the dish is found, update the mealImageUrl property
      if (index != -1) {
        (mealImageController.mapOfDishes[index] as Map)['mealImageUrl'] =
            mealImageController.imageUrl.value;
      }
      try {
        // add to the dishes database
        await _dbRef
            .child("dishes")
            .child(userStateController.loggedInuser.uid)
            .child("$mealId")
            .update({"mealImageUrl": mealImageController.imageUrl.value});
        // add to the alldishes database
        await _dbRef
            .child("allDishes")
            .child("${userStateController.loggedInuser.uid}-$mealId")
            .update({"mealImageUrl": mealImageController.imageUrl.value});
      } catch (e) {
        // do nothing
      }
      mealImageController.mapOfDishes.refresh();
    }
  }
}
