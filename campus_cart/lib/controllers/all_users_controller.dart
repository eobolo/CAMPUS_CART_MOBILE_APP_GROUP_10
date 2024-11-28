import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';

class AllUsersController extends GetxController {
  var allUsersInfo = <dynamic>[].obs; // RxList for reactive UI updates
  final DatabaseReference _usersRef =
      FirebaseDatabase.instance.ref('campusCartUsers');

  @override
  void onInit() {
    super.onInit();
    _fetchInitialData();
    _setupListeners();
  }

  // Fetch initial data from the Firebase Realtime Database
  void _fetchInitialData() async {
    try {
      final DataSnapshot snapshot = await _usersRef.get();
      if (snapshot.exists && snapshot.value != null) {
        final data = snapshot.value as Map<dynamic, dynamic>;
        allUsersInfo.clear(); // Clear existing data
        allUsersInfo.addAll(data.values.toList()); // Populate with new data
        allUsersInfo.shuffle(); // Optional: Randomize the order
      }
    } catch (e) {
      print(
          'Error fetching initial user data: $e'); // Log the error (consider using a logger)
    }
  }

  // Set up real-time listeners for updates from Firebase
  void _setupListeners() {
    _usersRef.onChildAdded.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      if (data != null) {
        allUsersInfo.add(data); // Add new user data
        allUsersInfo.shuffle(); // Optional: Randomize after adding
      }
    });

    _usersRef.onChildChanged.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      if (data != null) {
        final updatedUser = data as Map<dynamic, dynamic>;
        int index = allUsersInfo
            .indexWhere((user) => user['buyerId'] == updatedUser['buyerId']);

        if (index != -1) {
          allUsersInfo[index] = updatedUser; // Update existing user data
          allUsersInfo.shuffle(); // Optional: Randomize after updating
        }
      }
    });
  }
}
