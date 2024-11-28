import 'dart:async';

import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';

class AllDishesController extends GetxController {
  var processedAllDishes = <dynamic>[].obs;
  final DatabaseReference _dishesRef =
      FirebaseDatabase.instance.ref('allDishes');

  @override
  void onInit() {
    super.onInit();
    _setupListeners();
  }

  void reset() {
    processedAllDishes.clear(); // Clear the list
    processedAllDishes.refresh(); // Ensure the UI updates
  }

  Future<void> fetchInitialData() async {
    final DataSnapshot snapshot = await _dishesRef.get();
    if (snapshot.exists && snapshot.value != null) {
      final data = snapshot.value as Map<Object?, Object?>;
      processedAllDishes.clear();
      processedAllDishes.addAll(data.values.toList());
      processedAllDishes.shuffle();
      processedAllDishes.refresh();
    }
  }

  void _setupListeners() {
    // Add listeners again (after reset)
    _dishesRef.onChildAdded.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      if (data != null) {
        processedAllDishes.add(data);
      }
      processedAllDishes.shuffle();
      processedAllDishes.refresh();
    });

    _dishesRef.onChildChanged.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      if (data != null) {
        int index = processedAllDishes.indexWhere((dish) =>
            ((dish as Map)['mealId'] == (data as Map)["mealId"]) &&
            ((dish)['vendorId'] == (data)["vendorId"]));
        processedAllDishes[index] = data;
      }
      processedAllDishes.shuffle();
      processedAllDishes.refresh();
    });

    _dishesRef.onChildRemoved.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      if (data != null) {
        int index = processedAllDishes.indexWhere((dish) =>
            ((dish as Map)['mealId'] == (data as Map)["mealId"]) &&
            ((dish)['vendorId'] == (data)["vendorId"]));
        if (index != -1) {
          processedAllDishes.removeAt(index);
        }
      }
      processedAllDishes.shuffle();
      processedAllDishes.refresh();
    });
  }
}
