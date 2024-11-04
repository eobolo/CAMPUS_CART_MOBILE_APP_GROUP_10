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
        leading: IconButton(
          icon: Image.asset(
            'assets/images/Frame 24.png',
            width: 40,
            height: 40,
          ),
          onPressed: () {
            
          },
        ),
        centerTitle: true,
        title: const Text(
          'Meal Deals',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontFamily: 'DM Sans',
          ),
        ),
        actions: [
          IconButton(
            icon: Image.asset(
              'assets/images/Frame 23.png',
              width: 40,
              height: 40,
            ),
            onPressed: () {
              
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 8),
                      hintText: 'What do you want to get?',
                      hintStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: "DM Sans",
                        color: Color(0xFF909090),
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          'assets/images/search-normal.png',
                          width: 16,
                          height: 16,
                        ),
                      ),
                      fillColor: const Color(0xFFEBEBEB),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
                    '5200 RWF', // Updated price for the second card
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
                    'assets/images/fried_rice.png',
                  ),
                ],
              ),
            ),
          ],
        ),
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
  bool isMimisJollof = mealTitle == "Mimi’s Jollof Rice";

  return Card(
    color: isMimisJollof ? Colors.white : Colors.white, // Main card color
    margin: const EdgeInsets.symmetric(vertical: 8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    elevation: 2,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ), // Rounded only on the top corners
          child: Image.asset(
            imagePath,
            height: 120,
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
                    style: TextStyle(
                      fontFamily: 'DM Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                      letterSpacing: -0.01,
                      color: isMimisJollof ? Colors.black : Colors.black87,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 240, 244, 249),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      kitchen,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 96, 96, 96),
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
                  style: const TextStyle(
                    fontSize: 12,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF606060),
                  ),
                ),
              const SizedBox(height: 8),
              if (price.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          price.split(' ')[0], // Extracts and displays the numeric part of the price
                          style: const TextStyle(
                            fontSize: 15, // Adjust size of price
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w700,
                            color: Colors.black, // Color for price
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'RWF',
                          style: const TextStyle(
                            fontSize: 12, // Adjust size of RWF
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF606060),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/Frame 41.png',
                          width: 64,
                          height: 17,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(width: 2),
                        Image.asset(
                          'assets/images/Frame 42.png',
                          width: 57,
                          height: 17,
                          fit: BoxFit.contain,
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