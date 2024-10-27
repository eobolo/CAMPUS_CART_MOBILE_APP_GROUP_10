import 'package:campus_cart/controllers/setup_delivery_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationSelectionSheet extends StatefulWidget {
  const LocationSelectionSheet({super.key});

  @override
  State<LocationSelectionSheet> createState() => _LocationSelectionSheetState();
}

class _LocationSelectionSheetState extends State<LocationSelectionSheet> {
  final SetupDeliveryController setupDeliveryController =
      Get.find<SetupDeliveryController>();
  final TextEditingController inputAddressController = TextEditingController();
  String useLocationMessage = "";

  // getting address from user as input
  void _updateAllAdressViaInput() {
    int allAddressLength = setupDeliveryController.allAddressStored.isNotEmpty
        ? setupDeliveryController
            .allAddressStored[
                setupDeliveryController.allAddressStored.length - 1]
            .keys
            .first
        : 0;
    if (inputAddressController.text.isEmpty ||
        inputAddressController.text == "") {
      // do nothing
    } else {
      setupDeliveryController.storeAddress.value = inputAddressController.text;
      setupDeliveryController.allAddressStored.add({
        allAddressLength + 1: {
          "name": inputAddressController.text,
          "address": inputAddressController.text,
        }
      });
    }
    Navigator.pop(context);
  }

  void _saveCurrentLocation(dynamic placeMarkObject) {
    int allAddressLength = setupDeliveryController.allAddressStored.isNotEmpty
        ? setupDeliveryController
            .allAddressStored[
                setupDeliveryController.allAddressStored.length - 1]
            .keys
            .first
        : 0;
    String userCurrentLocationAddress =
        "${placeMarkObject["street"]}, ${placeMarkObject["locality"]}, ${placeMarkObject["administrativeArea"]}, ${placeMarkObject["country"]}";
    String userCurrentLocationName =
        "${placeMarkObject["name"]}, ${placeMarkObject["postalCode"]}, ${placeMarkObject["isoCountryCode"]}";

    setupDeliveryController.storeAddress.value = userCurrentLocationAddress;
    setupDeliveryController.allAddressStored.add({
      allAddressLength + 1: {
        "name": userCurrentLocationName,
        "address": userCurrentLocationAddress,
      }
    });
    Navigator.pop(context);
  }

  void _useGeolocatorGeocoding() async {
    try {
      dynamic placeMarkObject =
          await setupDeliveryController.getLocationAndAddress();
      if (placeMarkObject is Map) {
        _saveCurrentLocation(placeMarkObject);
      } else {
        useLocationMessage = placeMarkObject;
      }
    } catch (e) {
      setState(() {
        useLocationMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),

              // Search Box (90% of the screen width)
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9, // 90% width
                  child: TextField(
                    controller: inputAddressController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      hintText: 'Enter an address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Use Current Location Option
              GestureDetector(
                onTap: _useGeolocatorGeocoding,
                child: const Row(
                  children: [
                    Icon(Icons.my_location, color: Colors.amber),
                    SizedBox(width: 8),
                    Text(
                      'Use your current Location',
                      style: TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                useLocationMessage,
                style: TextStyle(
                  color: const Color.fromARGB(255, 1, 1, 1),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Obx(() {
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: setupDeliveryController.allAddressStored.length,
                  itemBuilder: (context, index) {
                    return RadioListTile(
                      title: Text(
                          setupDeliveryController.allAddressStored[index][
                                  setupDeliveryController
                                      .allAddressStored[index]
                                      .keys
                                      .first]?["name"] ??
                              "unknown"),
                      subtitle: Text(
                          setupDeliveryController.allAddressStored[index]
                                  [setupDeliveryController
                                      .allAddressStored[index]
                                      .keys
                                      .first]?["address"] ??
                              "unknown"),
                      value: setupDeliveryController
                          .allAddressStored[index].keys.first
                          .toString(),
                      groupValue:
                          setupDeliveryController.selectedLocationIndex.value,
                      onChanged: (selected) {
                        setState(() {
                          int index = int.parse(selected ?? "0");
                          setupDeliveryController.selectedLocationIndex.value =
                              selected.toString();
                          setupDeliveryController.storeAddress
                              .value = setupDeliveryController.allAddressStored
                                  .firstWhere((map) => map.containsKey(index),
                                      orElse: () {
                                return {};
                              })[index]?["address"] ??
                              "unknown";
                        });
                      },
                      activeColor: Colors.amber,
                    );
                  },
                );
              }),
              const SizedBox(height: 16),
              // Continue Button
              ElevatedButton(
                onPressed: _updateAllAdressViaInput,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
