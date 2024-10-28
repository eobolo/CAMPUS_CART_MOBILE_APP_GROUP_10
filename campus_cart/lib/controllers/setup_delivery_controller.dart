import 'package:campus_cart/controllers/user_controller.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SetupDeliveryController extends GetxController {
  /*
    setup delivery rective variables and other variables
  */
  RxInt minFee = 0.obs;
  RxInt maxFee = 0.obs;
  RxString storeAddress = "".obs;
  RxString selectedLocationIndex = "0".obs; // Store selected location
  RxList<Map<int, Map<String, String>>> allAddressStored = [
    {
      1: {
        "name": "African Leadership University",
        "address": "123 Kigali Innovation Boulevard, Kigali, Rwanda",
      }
    },
    {
      2: {
        "name": "Kigali Tech Hub",
        "address": "456 Tech Valley Drive, Kigali, Rwanda",
      }
    },
    {
      3: {
        "name": "Nyamata Hills Resort",
        "address": "789 Nyamata Road, Kigali, Rwanda",
      }
    }
  ].obs;

  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  // FUNCTIONS

  void processFirstElement(Map<dynamic, dynamic> setupDelivery) {
    if (setupDelivery.containsKey('allAddressStored')) {
      List<dynamic> allAddressStored = setupDelivery['allAddressStored'];

      if (allAddressStored.isNotEmpty) {
        var firstItem = allAddressStored[0];

        if (firstItem == null) {
          // Remove null first element
          allAddressStored.removeAt(0);
        } else if (firstItem is List &&
            firstItem.length == 2 &&
            firstItem[0] == null &&
            firstItem[1] is Map) {
          // Convert list with null and object to Map with key 1
          allAddressStored[0] = {
            1: firstItem[1]
          }; // Replace the list with a map having key 1
        }
      }
    }
  }

  Future<void> getSetupDeliveryFromDb() async {
    final SetupDeliveryController setupDeliveryController =
        Get.find<SetupDeliveryController>();
    final UserStateController userStateController =
        Get.find<UserStateController>();
    try {
      final event = await _dbRef
          .child("setupDelivery/${userStateController.loggedInuser.uid}")
          .once(DatabaseEventType.value);
      Map<dynamic, dynamic> userSetupDeliveryInfo =
          event.snapshot.value as Map<dynamic, dynamic>;
      // process data for null or list<null and object with key 1
      processFirstElement(userSetupDeliveryInfo);
      // save in controller
      setupDeliveryController.minFee.value = userSetupDeliveryInfo["minFee"];
      setupDeliveryController.maxFee.value = userSetupDeliveryInfo["maxFee"];
      setupDeliveryController.storeAddress.value =
          userSetupDeliveryInfo["storeAddress"];
    } catch (e) {
      throw Exception("$e");
    }
  }

  Future<void> postSetupDeliveryToDb() async {
    final SetupDeliveryController setupDeliveryController =
        Get.find<SetupDeliveryController>();
    final UserStateController userStateController =
        Get.find<UserStateController>();
    try {
      Map<dynamic, dynamic> delivery = {
        "minFee": setupDeliveryController.minFee.value,
        "maxFee": setupDeliveryController.maxFee.value,
        "storeAddress": setupDeliveryController.storeAddress.value,
        "allAddressStored": setupDeliveryController.allAddressStored,
      };
      await _dbRef
          .child("setupDelivery")
          .child(userStateController.loggedInuser.uid)
          .set(delivery);
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

  // check and grant permission
  Future<void> _checkLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Request permission
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Handle permanently denied case
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions, grant location permission or manually put your location');
    }
  }

  // GET CURRENT LOCATION
  Future<Position> _getCurrentLocation() async {
    try {
      await _checkLocationPermission(); // Ensure permissions are granted
    } catch (e) {
      return Future.error(e);
    }

    // Create LocationSettings
    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high, // Set desired accuracy
      distanceFilter:
          100, // Minimum distance (in meters) between location updates
    );
    return await Geolocator.getCurrentPosition(
      locationSettings: locationSettings, // Use the new settings parameter
    );
  }

  // REVERSE GEOCODE TO GET ADDRESS
  Future<dynamic> _getAddressFromCoordinates(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Map<dynamic, dynamic> placeMarkObject;
    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0]; // Get the first result
      placeMarkObject = {
        "street": place.street,
        "locality": place.locality,
        "postalCode": place.postalCode,
        "country": place.country,
        "name": place.name,
        "isoCountryCode": place.isoCountryCode,
        "administrativeArea": place.administrativeArea
      };
      return placeMarkObject;
    } else {
      return "No address found"; // Handle case where no placemarks are returned
    }
  }

  // get location and address
  Future<dynamic> getLocationAndAddress() async {
    try {
      Position position = await _getCurrentLocation();
      dynamic placeMarkObject = await _getAddressFromCoordinates(position);
      return placeMarkObject;
    } catch (e) {
      throw Exception(e);
    }
  }
}
