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
  }

  void increaseMapOfItemsCount(Map<String, dynamic> addToCart) {
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
  }

  void decreaseMapOfItemsCount(Map<String, dynamic> addToCart) {
    // controller variable
    final CartController cartController = Get.find<CartController>();
    String key = "${addToCart["vendorId"]}-${addToCart["mealId"]}";
    if (cartController.mapOfItemsCount.containsKey(key)) {
      dynamic existingCart = cartController.mapOfItemsCount[key];
      int oldCount = existingCart["quantity"] ?? 0;
      if (oldCount == 0) {
        addToCart["quantity"] = oldCount;
      } else {
        addToCart["quantity"] = oldCount - 1;
        // increment the item in carts reactive variable
        cartController.itemsInCart.value -= 1;
      }
      cartController.mapOfItemsCount[key] = addToCart;
    } else {
      addToCart["quantity"] = 0;
      cartController.mapOfItemsCount[key] = addToCart;
    }
    // refresh both reactive variables
    cartController.itemsInCart.refresh();
  }
}
