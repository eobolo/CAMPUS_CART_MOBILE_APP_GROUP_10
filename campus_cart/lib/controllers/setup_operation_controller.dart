// ignore_for_file: unused_local_variable

import 'package:campus_cart/controllers/user_controller.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SetupOperationController extends GetxController {
  RxInt fromHour = 24.obs;
  RxInt toHour = 24.obs;
  RxString fromSymbol = "".obs;
  RxString toSymbol = "".obs;
  RxString storePolicies = "".obs;

  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  void reset() {
    fromHour.value = 24;
    toHour.value = 24;
    fromSymbol.value = "";
    toSymbol.value = "";
    storePolicies.value = "";
  }

  Future<void> postSetupOperationToDb() async {
    final SetupOperationController setupOperationController =
        Get.find<SetupOperationController>();
    final UserStateController userStateController =
        Get.find<UserStateController>();
    try {
      Map<String, dynamic> operation = {
        "from": setupOperationController.fromHour.value,
        "to": setupOperationController.toHour.value,
        "fromSymbol": setupOperationController.fromSymbol.value,
        "toSymbol": setupOperationController.toSymbol.value,
        "storePolicies": setupOperationController.storePolicies.value,
      };
      await _dbRef
          .child("setupOperation")
          .child(userStateController.loggedInuser.uid)
          .set(operation);

      // add set opearations to the campus user db
      await _dbRef
          .child("campusCartUsers")
          .child(userStateController.loggedInuser.uid)
          .update({
        "from": setupOperationController.fromHour.value,
        "to": setupOperationController.toHour.value,
        "fromSymbol": setupOperationController.fromSymbol.value,
        "toSymbol": setupOperationController.toSymbol.value,
        "storePolicies": setupOperationController.storePolicies.value,
      });

      // now add this to the campuscart reactive variable
      userStateController.campusCartUser.value = {
        ...userStateController.campusCartUser,
        "from": setupOperationController.fromHour.value,
        "to": setupOperationController.toHour.value,
        "fromSymbol": setupOperationController.fromSymbol.value,
        "toSymbol": setupOperationController.toSymbol.value,
        "storePolicies": setupOperationController.storePolicies.value,
      };
      userStateController.campusCartUser.refresh();
    } on FirebaseException catch (e) {
      // Handle Firebase Database errors
      switch (e.code) {
        case 'permission-denied':
          throw Exception('Permission denied: ${e.message}');
        case 'disconnected':
          throw Exception('Disconnected from the database: ${e.message}');
        case 'invalid-argument':
          throw Exception('Invalid argument: ${e.message}');
        default:
          throw Exception('Database error: ${e.message}');
      }
    } catch (e) {
      // Handle general errors
      throw Exception('An error occurred: $e');
    }
  }

  Future<void> getSetupOperationFromDb() async {
    final SetupOperationController setupOperationController =
        Get.find<SetupOperationController>();
    final UserStateController userStateController =
        Get.find<UserStateController>();
    try {
      final event = await _dbRef
          .child("setupOperation/${userStateController.loggedInuser.uid}")
          .once(DatabaseEventType.value);
      Map<dynamic, dynamic> userSetupOperationInfo =
          event.snapshot.value as Map<dynamic, dynamic>;
      setupOperationController.fromHour.value = userSetupOperationInfo["from"];
      setupOperationController.toHour.value = userSetupOperationInfo["to"];
      setupOperationController.storePolicies.value =
          userSetupOperationInfo["storePolicies"];
      setupOperationController.fromSymbol.value =
          userSetupOperationInfo["fromSymbol"];
      setupOperationController.toSymbol.value =
          userSetupOperationInfo["toSymbol"];
    } catch (e) {
      throw Exception("$e");
    }
  }
}
