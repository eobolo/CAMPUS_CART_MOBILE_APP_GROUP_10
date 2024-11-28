import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';

class AllDishesController extends GetxController {
  // RxList for real-time UI updates
  var processedAllDishes = <dynamic>[].obs;
  final DatabaseReference _dishesRef = FirebaseDatabase.instance.ref('allDishes');

  @override
  void onInit() {
    super.onInit();
    _fetchInitialData();
    _setupListeners();
  }

  // Fetch initial data from Firebase
  void _fetchInitialData() async {
    try {
      final DataSnapshot snapshot = await _dishesRef.get();
      if (snapshot.exists && snapshot.value != null) {
        final data = snapshot.value as Map<dynamic, dynamic>;
        processedAllDishes.clear();  // Clear existing data
        processedAllDishes.addAll(data.values.toList());
        processedAllDishes.shuffle();  // Optional: shuffle for randomness
      }
    } catch (e) {
      print('Error fetching initial data: $e');  // Log error (consider using a logger)
    }
  }

  // Set up real-time listeners for database changes
  void _setupListeners() {
    _dishesRef.onChildAdded.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      if (data != null) {
        processedAllDishes.add(data);
        processedAllDishes.shuffle();
      }
    });

    _dishesRef.onChildChanged.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      if (data != null) {
        final updatedDish = data as Map<dynamic, dynamic>;
        int index = processedAllDishes.indexWhere((dish) =>
            dish['mealId'] == updatedDish['mealId'] &&
            dish['vendorId'] == updatedDish['vendorId']);

        if (index != -1) {
          processedAllDishes[index] = updatedDish;  // Update the specific dish
          processedAllDishes.shuffle();  // Optional
        }
      }
    });

    _dishesRef.onChildRemoved.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      if (data != null) {
        final removedDish = data as Map<dynamic, dynamic>;
        int index = processedAllDishes.indexWhere((dish) =>
            dish['mealId'] == removedDish['mealId'] &&
            dish['vendorId'] == removedDish['vendorId']);

        if (index != -1) {
          processedAllDishes.removeAt(index);  // Remove the dish
          processedAllDishes.shuffle();  // Optional
        }
      }
    });
  }
}