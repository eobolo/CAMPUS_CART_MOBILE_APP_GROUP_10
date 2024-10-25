import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Meal Deals',
      home: MealDealsScreen(),
    );
  }
}

class MealDealsScreen extends StatelessWidget {
  const MealDealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5C147),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5C147),
        elevation: 0,
        leading: Container(
          width: 10, // Set width for the circular background of the arrow
          height: 10, // Set height for the circular background of the arrow
          decoration: const BoxDecoration(
            shape: BoxShape.circle, // Circular shape
            color: Colors.white,    // White background
          ),
          child: IconButton(
            iconSize: 18, // Adjust icon size
            padding: const EdgeInsets.all(8), // Add padding inside the circle
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              // Handle back action
            },
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Meal Deals',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          Container(
            width: 65, // Set width for the circular background of the cart icon
            height: 40, // Set height for the circular background of the cart icon
            decoration: const BoxDecoration(
              shape: BoxShape.circle, // Circular shape for the white background
              color: Colors.white,    // White background for the cart icon
            ),
            child: IconButton(
              iconSize: 20, // Adjust icon size
              padding: const EdgeInsets.all(10), // Add padding inside the circle
              icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
              onPressed: () {
                // Handle cart action
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Adding a white background to the search bar area
          Container(
            color: Colors.white, // Change this to the desired background color
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'What do you want to get?',
                  prefixIcon: const Icon(Icons.search),
                  fillColor: const Color(0xFFEBEBEB), // Updated fill color
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        buildMealCard(
                          context,
                          'Mimi’s Jollof Rice',
                          'Mimi’s Kitchen',
                          'A plate of jollof rice, chicken, beef and plantain',
                          '2400 RWF',
                          '300 RWF',
                          '15 mins',
                          'assets/images/jollof_rice_1.png',
                        ),
                        buildMealCard(
                          context,
                          'Mimi’s Jollof Rice',
                          'Mimi’s Kitchen',
                          'A plate of jollof rice, chicken, beef and plantain',
                          '5200 RWF',
                          '300 RWF',
                          '15 mins',
                          'assets/images/jollof_rice_2.png',
                        ),
                        buildMealCard(
                          context,
                          'Int. Fried Rice',             
                          'Lore’s Kitchen',              
                          '',                            
                          '',                            
                          '300 RWF',                     
                          '20 mins',                    
                          'assets/images/fried_rice.png' 
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMealCard(
    BuildContext context,
    String mealTitle,
    String kitchen,
    String description,
    String price,
    String deliveryFee,
    String time,
    String imagePath,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(20), // Consistent border radius for all images
            ),
            child: Image.asset(
              imagePath,
              height: 120, // Adjusted the height to fit everything in screen
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      mealTitle,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        kitchen,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (description.isNotEmpty)
                  Text(
                    description,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                const SizedBox(height: 8),
                if (price.isNotEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        price,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.shopping_cart,
                            size: 14,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            deliveryFee,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Icon(
                            Icons.access_time,
                            size: 14,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            time,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
