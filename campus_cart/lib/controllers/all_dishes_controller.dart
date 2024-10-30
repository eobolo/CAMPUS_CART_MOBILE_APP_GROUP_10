import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';

class AllDishesController extends GetxController {
  dynamic processedAllDishes = [].obs;
  final DatabaseReference _dishesRef =
      FirebaseDatabase.instance.ref('allDishes');

  @override
  void onInit() {
    super.onInit();
    _setupListeners();
  }

  /*
    real time updates for dishes created an updated by vendors
  */

  void _setupListeners() {
    _dishesRef.onChildAdded.listen((DatabaseEvent event) {
      final AllDishesController allDishesController =
          Get.find<AllDishesController>();
      final data = event.snapshot.value;
      if (data != null) {
        allDishesController.processedAllDishes.add(data);
      } else {
        // do nothing
      }
      allDishesController.processedAllDishes.refresh();
    });

    _dishesRef.onChildChanged.listen((DatabaseEvent event) {
      final AllDishesController allDishesController =
          Get.find<AllDishesController>();
      final data = event.snapshot.value;
      if (data != null) {
        int index = allDishesController.processedAllDishes.indexWhere((dish) =>
            ((dish as Map)['mealId'] == (data as Map)["mealId"]) &&
            ((dish)['vendorId'] == (data)["vendorId"]));
        allDishesController.processedAllDishes[index] = data;
      } else {
        // do nothing
      }
      allDishesController.processedAllDishes.refresh();
    });
  }
}
