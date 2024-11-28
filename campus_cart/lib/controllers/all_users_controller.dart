import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';

class AllUsersController extends GetxController {
  dynamic allUsersInfo = [].obs;
  final DatabaseReference _usersRef =
      FirebaseDatabase.instance.ref('campusCartUsers');

  @override
  void onInit() {
    super.onInit();
    _setupListeners();
    _fetchInitialData();
  }

  /*
    real time updates for dishes created an updated by vendors
  */

  // Initial data fetch from the database
  void _fetchInitialData() async {
    final AllUsersController allUsersController =
        Get.find<AllUsersController>();
    final DataSnapshot snapshot = await _usersRef.get();
    if (snapshot.exists && snapshot.value != null) {
      final data = snapshot.value as Map<Object?, Object?>;
      allUsersController.allUsersInfo.clear(); // Clear any existing data
      allUsersController.allUsersInfo
          .addAll(data.values.toList()); // Add each user info to the list
      allUsersController.allUsersInfo
          .shuffle(); // Optional: Randomize the order
      allUsersController.allUsersInfo.refresh(); // Update the UI
    }
  }

  void _setupListeners() {
    _usersRef.onChildAdded.listen((DatabaseEvent event) {
      final AllUsersController allUsersController =
          Get.find<AllUsersController>();
      final data = event.snapshot.value;
      if (data != null) {
        allUsersController.allUsersInfo.add(data);
      } else {
        // do nothing
      }
      allUsersController.allUsersInfo.shuffle();
      allUsersController.allUsersInfo.refresh();
    });

    _usersRef.onChildChanged.listen((DatabaseEvent event) {
      final AllUsersController allUsersController =
          Get.find<AllUsersController>();
      final data = event.snapshot.value;
      if (data != null) {
        int index = allUsersController.allUsersInfo.indexWhere(
            (user) => (user as Map)['buyerId'] == (data as Map)["buyerId"]);
        allUsersController.allUsersInfo[index] = data;
      } else {
        // do nothing
      }
      allUsersController.allUsersInfo.shuffle();
      allUsersController.allUsersInfo.refresh();
    });
  }
}
