import 'dart:async';

import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';

class AllDishesController extends GetxController {
  var processedAllDishes = <dynamic>[].obs;
  final DatabaseReference _dishesRef =
      FirebaseDatabase.instance.ref('allDishes');

  // Create a variable to store the subscriptions
  late StreamSubscription<DatabaseEvent> _childAddedSubscription;
  late StreamSubscription<DatabaseEvent> _childChangedSubscription;
  late StreamSubscription<DatabaseEvent> _childRemovedSubscription;

  @override
  void onInit() {
    super.onInit();
    _setupListeners();
  }

  @override
  void onClose() {
    // Cancel subscriptions when the controller is closed or account is switched
    _childAddedSubscription.cancel();
    _childChangedSubscription.cancel();
    _childRemovedSubscription.cancel();
    super.onClose();
  }

  void reset() {
    processedAllDishes.clear(); // Clear the list
    processedAllDishes.refresh(); // Ensure the UI updates

    // After resetting, you can reinitialize the listeners if necessary.
    _setupListeners();
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
    _childAddedSubscription =
        _dishesRef.onChildAdded.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      if (data != null) {
        processedAllDishes.add(data);
      }
      processedAllDishes.shuffle();
      processedAllDishes.refresh();
    });

    _childChangedSubscription =
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

    _childRemovedSubscription =
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
