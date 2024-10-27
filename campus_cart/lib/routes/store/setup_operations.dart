import 'package:flutter/material.dart';



class SetupOperationsScreen extends StatelessWidget {
  const SetupOperationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        elevation: 0,
        centerTitle: true, // Center the title "Set Up Delivery"
        title: const Text(
          'Set Up Operations',
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  // color: Colors.amber[100],
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
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        labelText: '8:00 Am ',
                        labelStyle: const TextStyle(color: Colors.grey),
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
                    style:
                    TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        labelText: 'Max Fee in RWF',
                        labelStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: BorderSide.none,
                        ),
                      ),
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
                maxLines: 5,
                decoration: InputDecoration(
                  filled: true, // Adds background color
                  fillColor: Colors.grey.shade200, // Use grey shade 200
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
                onPressed: () {},
                style:
                ElevatedButton.styleFrom(backgroundColor:
                Colors.black, minimumSize:
                const Size(double.infinity, 50), shape:
                RoundedRectangleBorder(borderRadius:
                BorderRadius.circular(20),),),
                child:
                const Text('Set Up Operations', style:
                TextStyle(fontSize:
                18, color:
                Colors.white),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}