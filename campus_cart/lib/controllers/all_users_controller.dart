import 'dart:async';

import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';

class AllUsersController extends GetxController {
  var allUsersInfo = <dynamic>[].obs;
  final DatabaseReference _usersRef =
      FirebaseDatabase.instance.ref('campusCartUsers');

  // Create a variable to store the subscriptions
  late StreamSubscription<DatabaseEvent> _childAddedSubscription;
  late StreamSubscription<DatabaseEvent> _childChangedSubscription;

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
    super.onClose();
  }

  void reset() {
    allUsersInfo.clear(); // Clear the list
    allUsersInfo.refresh(); // Ensure the UI updates

    // After resetting, you can reinitialize the listeners if necessary.
    _setupListeners();
  }

  Future<void> fetchInitialData() async {
    final DataSnapshot snapshot = await _usersRef.get();
    if (snapshot.exists && snapshot.value != null) {
      final data = snapshot.value as Map<Object?, Object?>;
      allUsersInfo.clear();
      allUsersInfo.addAll(data.values.toList());
      allUsersInfo.shuffle();
      allUsersInfo.refresh();
    }
  }

  void _setupListeners() async {
    // Add listeners again (after reset)
    _childAddedSubscription =
        _usersRef.onChildAdded.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      if (data != null) {
        allUsersInfo.add(data);
      }
      allUsersInfo.shuffle();
      allUsersInfo.refresh();
    });

    _childChangedSubscription =
        _usersRef.onChildChanged.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      if (data != null) {
        int index = allUsersInfo.indexWhere(
            (user) => (user as Map)['buyerId'] == (data as Map)["buyerId"]);
        allUsersInfo[index] = data;
      }
      allUsersInfo.shuffle();
      allUsersInfo.refresh();
    });
  }
}
