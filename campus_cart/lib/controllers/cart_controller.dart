import 'package:get/get.dart';

class CartController extends GetxController {
  RxInt itemsInCart = 0.obs;
  dynamic mapOfItemsCount = {}.obs;

  void reset() {
    itemsInCart.value = 0;
    mapOfItemsCount = {};
  }

  void updateMapOfItemsCount(Map<String, dynamic> addToCart) {
    // controller variable
    final CartController cartController = Get.find<CartController>();
    String key = "${addToCart["vendorId"]}-${addToCart["mealId"]}";
    if (cartController.mapOfItemsCount.containsKey(key)) {
      dynamic existingCart = cartController.mapOfItemsCount[key];
      int oldCount = existingCart["quantity"] ?? 0;
      addToCart["quantity"] = oldCount + 1;
      cartController.mapOfItemsCount[key] = addToCart;
    } else {
      addToCart["quantity"] = 1;
      cartController.mapOfItemsCount[key] = addToCart;
    }
    // increment the item in carts reactive variable
    cartController.itemsInCart.value += 1;
    // refresh both reactive variables
    cartController.itemsInCart.refresh();
    cartController.mapOfItemsCount.refresh();
  }

  void updateMapEntry(Map<String, Map<String, dynamic>> mainMap, String key,
      Map<String, dynamic> newMap) {
    if (mainMap.containsKey(key)) {
      // If the key exists, get the old map and retrieve its count
      Map<String, dynamic> existingMap = mainMap[key]!;
      int oldCount =
          existingMap['count'] ?? 0; // Use 0 if 'count' is missing or null

      // Update the newMap with the incremented count
      newMap['count'] = oldCount + 1;

      // Replace the old entry with the updated map
      mainMap[key] = newMap;
    } else {
      // If the key does not exist, set 'count' to 0 in the new map and add it to the main map
      newMap['count'] = 0;
      mainMap[key] = newMap;
    }
  }
}
