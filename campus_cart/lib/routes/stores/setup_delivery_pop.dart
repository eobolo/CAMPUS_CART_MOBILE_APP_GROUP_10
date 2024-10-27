import 'package:campus_cart/controllers/setup_delivery_controller.dart';
import 'package:campus_cart/routes/stores/setup_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DeliverySetupScreen extends StatefulWidget {
  const DeliverySetupScreen({super.key});

  @override
  State<DeliverySetupScreen> createState() => _DeliverySetupScreenState();
}

class _DeliverySetupScreenState extends State<DeliverySetupScreen> {
  final SetupDeliveryController setupDeliveryController =
      Get.find<SetupDeliveryController>();
  final TextEditingController minFeeController = TextEditingController();
  final TextEditingController maxFeeController = TextEditingController();

  // Function to display the bottom sheet popup
  void _showLocationSelection() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true, // Allow the modal to be scrollable
      builder: (BuildContext context) {
        return LocationSelectionSheet();
      },
    );
  }

  void _sendSetupDeliveryToDb() async {
    try {
      await setupDeliveryController.postSetupDeliveryToDb();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: const Color.fromARGB(255, 116, 255, 121),
          content: Center(
            child: Text(
              "Delivery set up completed 🚚",
              style: TextStyle(
                color: Color(0xFF202020),
                fontSize: 14,
                fontFamily: "DM Sans",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: const Color.fromARGB(255, 255, 63, 49),
          content: Text(
            "Delivery setup failed: $e",
            style: TextStyle(
              color: Color(0xFF202020),
              fontSize: 14,
              fontFamily: "DM Sans",
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
      }
    }
  }

  void _fetchSetupDeliveryFromDb() async {
    try {
      await setupDeliveryController.getSetupDeliveryFromDb();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: const Color.fromARGB(255, 116, 255, 121),
          content: Center(
            child: Text(
              "Delivery set up fetch gotten 🚚",
              style: TextStyle(
                color: Color(0xFF202020),
                fontSize: 14,
                fontFamily: "DM Sans",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: const Color.fromARGB(255, 116, 255, 121),
          content: Text(
            "Delivery setup fetch failed: $e",
            style: TextStyle(
              color: Color(0xFF202020),
              fontSize: 14,
              fontFamily: "DM Sans",
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchSetupDeliveryFromDb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5C147),
        elevation: 0,
        centerTitle: true, // Center the title "Set Up Delivery"
        title: const Text(
          'Set Up Delivery',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'DM Sans',
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0), // Space from the edge
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white, // Background color
              shape: BoxShape.circle, // Make it circular
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded),
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.black, // Color of the icon
              padding: const EdgeInsets.all(10), // Padding inside the circle
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Delivery Note
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF5C147),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Note: All deliveries will be made by the vendor using their own motorbike. We\'re currently working on partnering with a delivery service, so you can soon enjoy convenient delivery options directly on the app.',
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ),
            const SizedBox(height: 24),

            // Delivery Fee Range
            const Text(
              'Set Your Delivery Fee Range',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: minFeeController,
                    onChanged: (value) {
                      setupDeliveryController.minFee.value = int.parse(value);
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      labelText: 'Min Fee in RWF',
                      labelStyle: const TextStyle(
                        color: Colors.grey, // Set the label color to gray
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'TO',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: maxFeeController,
                    onChanged: (value) {
                      setupDeliveryController.maxFee.value = int.parse(value);
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      labelText: 'Max Fee in RWF',
                      labelStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Choose Current Store Address Button
            const Text(
              'Choose Current Store Address',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () => _showLocationSelection(),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() {
                      return ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 300.0),
                        child: Text(setupDeliveryController.storeAddress.value,
                            overflow: TextOverflow
                                .ellipsis, // Adds "..." if text overflows
                            maxLines: 1,
                            style: TextStyle(color: Colors.grey)),
                      );
                    }), // update it to store Address picked based on listindex
                    Icon(Icons.arrow_drop_down, color: Colors.grey),
                  ],
                ),
              ),
            ),
            const Spacer(),

            // Create setup delivery Button
            ElevatedButton(
              onPressed: _sendSetupDeliveryToDb,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'Complete Set Up',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
