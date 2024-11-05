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
          iconSize: 30,
          padding: const EdgeInsets.all(0),
          icon: Image.asset('assets/images/Frame 24.png'), 
          onPressed: () {
           
          },
        ),
        centerTitle: true,
        title: const Text(
          'Meal Deals',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 16,
            fontFamily: 'DM Sans',
          ),
        ),
        actions: [
          Container(
            width: 65,
            height: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: IconButton(
              iconSize: 20,
              padding: const EdgeInsets.all(0),
              icon: Image.asset('assets/images/Frame 23.png'), 
              onPressed: () {
                
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: SizedBox(
                width: double.infinity, 
                height: 48,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'What do you want to get?',
                    hintStyle: const TextStyle(
                      color: Color(0xFF909090), 
                      fontSize: 15,
                      fontFamily: 'DM Sans', 
                      fontWeight: FontWeight.w500, 
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0), 
                      child: Image.asset(
                        'assets/images/search-normal.png', 
                        height: 20, 
                        width: 20, 
                      ),
                    ),
                    fillColor: const Color(0xFFEBEBEB),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30), 
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 16, 
                    color: Colors.black, 
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
                          '2400', 
                          '300 RWF',
                          '15 mins',
                          'assets/images/jollof_rice_1.png',
                        ),
                        buildMealCard(
                          context,
                          'Mimi’s Jollof Rice',
                          'Mimi’s Kitchen',
                          'A plate of jollof rice, chicken, beef and plantain',
                          '5200', 
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
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: Image.asset(
            imagePath,
            height: 120,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            color: Colors.white, 
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    mealTitle,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'DM Sans',
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F4F9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      kitchen,
                      style: const TextStyle(
                        color: Color(0xFF606060),
                        fontSize: 12,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w400,
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
                    color: Color(0xFF606060),
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              const SizedBox(height: 8),
              if (price.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: price,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'DM Sans',
                              color: Color(0xFF202020),
                            ),
                          ),
                          const TextSpan(
                            text: ' RWF',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'DM Sans',
                              color: Color(0xFF606060),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min, 
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/images/Frame 41.png',
                            width: 64,
                            height: 17,
                          ),
                        ),
                        const SizedBox(width: 2),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/images/Frame 42.png',
                            height: 17,
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