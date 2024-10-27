import 'package:flutter/material.dart';

class DeliverySetupScreen extends StatefulWidget {
  const DeliverySetupScreen({super.key});

  @override
  State<DeliverySetupScreen> createState() => _DeliverySetupScreenState();
}

class _DeliverySetupScreenState extends State<DeliverySetupScreen> {
  String? selectedLocation; // Store selected location

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Set Up Delivery',
          style: TextStyle(color: Colors.black),
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
                color: Colors.amber[100],
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
              onTap: () => _showLocationSelection(context),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Choose Store Address',
                        style: TextStyle(color: Colors.grey)),
                    Icon(Icons.arrow_drop_down, color: Colors.grey),
                  ],
                ),
              ),
            ),
            const Spacer(),

            // Create Menu Button
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/second_store_profile');
              },
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

  // Function to display the bottom sheet popup
  void _showLocationSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true, // Allow the modal to be scrollable
      builder: (BuildContext context) {
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
                      width:
                          MediaQuery.of(context).size.width * 0.9, // 90% width
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          prefixIcon:
                              const Icon(Icons.search, color: Colors.grey),
                          hintText: 'Search for a location',
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
                    onTap: () {
                      Navigator.pop(context);
                      // Handle current location selection
                    },
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

                  // List of Addresses with active visual feedback
                  RadioListTile(
                    title: const Text('African Leadership University'),
                    subtitle: const Text(
                        '123 Kigali Innovation Boulevard, Kigali, Rwanda'),
                    value: 'alu',
                    groupValue: selectedLocation,
                    onChanged: (value) {
                      setState(() {
                        selectedLocation =
                            value.toString(); // Set selected location
                      });
                    },
                    activeColor: Colors.amber, // Highlight active selection
                  ),
                  RadioListTile(
                    title: const Text('Kigali Tech Hub'),
                    subtitle:
                        const Text('456 Tech Valley Drive, Kigali, Rwanda'),
                    value: 'techhub',
                    groupValue: selectedLocation,
                    onChanged: (value) {
                      setState(() {
                        selectedLocation = value.toString();
                      });
                    },
                    activeColor: Colors.amber,
                  ),
                  RadioListTile(
                    title: const Text('Nyamata Hills Resort'),
                    subtitle: const Text('789 Nyamata Road, Kigali, Rwanda'),
                    value: 'nyamata',
                    groupValue: selectedLocation,
                    onChanged: (value) {
                      setState(() {
                        selectedLocation = value.toString();
                      });
                    },
                    activeColor: Colors.amber,
                  ),

                  const SizedBox(height: 16),

                  // Continue Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // Handle further actions with the selected location
                    },
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
      },
    );
  }
}
