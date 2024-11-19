import 'package:campus_cart/controllers/setup_operation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetupOperationsScreen extends StatefulWidget {
  const SetupOperationsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SetupOperationsScreenState createState() => _SetupOperationsScreenState();
}

class _SetupOperationsScreenState extends State<SetupOperationsScreen> {
  final TextEditingController storePolices = TextEditingController();
  final SetupOperationController setupOperationController =
      Get.find<SetupOperationController>();
  int? _fromHour; // Selected "from" hour
  int? _toHour; // Selected "to" hour

  void _setupOperation() async {
    setupOperationController.fromHour.value = _fromHour ?? 24;
    setupOperationController.toHour.value = _toHour ?? 24;
    setupOperationController.storePolicies.value = storePolices.text;

    int fromHour = setupOperationController.fromHour.value;
    int toHour = setupOperationController.toHour.value;
    if (fromHour >= 0 && fromHour <= 11) {
      setupOperationController.fromSymbol.value = "am";
    } else {
      setupOperationController.fromSymbol.value = "pm";
    }
    if (toHour >= 12 && toHour <= 23) {
      setupOperationController.toSymbol.value = "pm";
    } else {
      setupOperationController.toSymbol.value = "am";
    }

    try {
      await setupOperationController.postSetupOperationToDb();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: const Color.fromARGB(255, 116, 255, 121),
          content: Center(
            child: Text(
              "operations setup completed ⏲️",
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
          content: Center(
            child: Text(
              "operations setup failed: $e",
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
    }
  }

  void _fetchSetupOperationFromDb() async {
    try {
      await setupOperationController.getSetupOperationFromDb();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: const Color.fromARGB(255, 116, 255, 121),
          content: Center(
            child: Text(
              "operation set up fetch gotten",
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
          content: Center(
            child: Text(
              "operation setup fetch failed: $e",
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
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchSetupOperationFromDb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5C147),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Set Up Operations',
          style: TextStyle(color: Colors.black),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded),
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.black,
              padding: const EdgeInsets.all(10),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Note: All delivery are done with.',
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Enter your operating hours',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        labelText: 'From',
                        labelStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      value: _fromHour,
                      items: List.generate(24, (index) => index).map((hour) {
                        return DropdownMenuItem(
                          value: hour,
                          child: Text(hour.toString().padLeft(2, '0')),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _fromHour = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'TO',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        labelText: 'To',
                        labelStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      value: _toHour,
                      items: List.generate(24, (index) => index).map((hour) {
                        return DropdownMenuItem(
                          value: hour,
                          child: Text(hour.toString().padLeft(2, '0')),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _toHour = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Enter Store Policies',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: storePolices,
                maxLines: 5,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  hintText: 'Enter Store Policies',
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _setupOperation,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Set Up Operations',
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
