import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';

class AllUsersController extends GetxController {
  dynamic allUsersInfo = [].obs;
  final DatabaseReference _dishesRef =
      FirebaseDatabase.instance.ref('campusCartUsers');

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
      final AllUsersController allUsersController =
          Get.find<AllUsersController>();
      final data = event.snapshot.value;
      if (data != null) {
        allUsersController.allUsersInfo.add(data);
      } else {
        // do nothing
      }
      allUsersController.allUsersInfo.refresh();
    });

    _dishesRef.onChildChanged.listen((DatabaseEvent event) {
      final AllUsersController allUsersController =
          Get.find<AllUsersController>();
      final data = event.snapshot.value;
      if (data != null) {
        int index = allUsersController.allUsersInfo.indexWhere(
            (dish) => (dish as Map)['buyerId'] == (data as Map)["buyerId"]);
        allUsersController.allUsersInfo[index] = data;
      } else {
        // do nothing
      }
      allUsersController.allUsersInfo.refresh();
    });
  }
}
