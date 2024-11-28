import 'dart:async';

import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';

class AllUsersController extends GetxController {
  var allUsersInfo = <dynamic>[].obs;
  final DatabaseReference _usersRef =
      FirebaseDatabase.instance.ref('campusCartUsers');

  @override
  void onInit() {
    super.onInit();
    _setupListeners();
  }

  void reset() {
    allUsersInfo.clear(); // Clear the list
    allUsersInfo.refresh(); // Ensure the UI updates
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
    _usersRef.onChildAdded.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      if (data != null) {
        allUsersInfo.add(data);
      }
      allUsersInfo.shuffle();
      allUsersInfo.refresh();
    });

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
