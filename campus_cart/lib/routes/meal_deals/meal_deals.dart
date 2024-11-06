import 'package:flutter/material.dart';
import 'package:campus_cart/routes/visuals/icons.dart';
import 'package:campus_cart/routes/visuals/meal_deal_cards.dart';

class MealDeals extends StatelessWidget {
  const MealDeals({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5C147),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_rounded, size: 24),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const Text(
                    'Meal Deals',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'DM Sans',
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/orders');
                      },
                      icon: const Icon(Iconify.bagHhappy, size: 24),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, right: 20, left: 20),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "What do you want to get?",
                          hintStyle: const TextStyle(
                            color: Color(0xff909090),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          prefixIcon: const Padding(
                            padding: EdgeInsets.only(left: 25, right: 10),
                            child: Icon(Iconify.search, size: 20),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(80),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: const Color(0xffEBEBEB),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: ListView(
                          children: const [
                            MealCard(
                              imagePath: 'assets/images/meal1.png',
                              mealName: "Mimi's Jollof Rice",
                              kitchenName: "Mimi's Kitchen",
                              description:
                                  'A plate of jollof rice, chicken, beef, and plantain',
                              price: 2400,
                              deliveryFee: '300RWF',
                              deliveryTime: '15 mins',
                            ),
                            SizedBox(height: 16),
                            MealCard(
                              imagePath: 'assets/images/meal3.png',
                              mealName: "Mimi's Jollof Rice",
                              kitchenName: "Mimi's Kitchen",
                              description:
                                  'A plate of jollof rice, chicken, beef, and plantain',
                              price: 5200,
                              deliveryFee: '300RWF',
                              deliveryTime: '15 mins',
                            ),
                            SizedBox(height: 16),
                            MealCard(
                              imagePath: 'assets/images/meal2.png',
                              mealName: "Int. Fried Rice",
                              kitchenName: "Lore's Kitchen",
                              description:
                                  'A plate of jollof rice, chicken, beef, and plantain',
                              price: 4000,
                              deliveryFee: '300RWF',
                              deliveryTime: '15 mins',
                            ),
                            SizedBox(height: 16),
                            MealCard(
                              imagePath: 'assets/images/meal_cat.png',
                              mealName: "Ewa Agoyin",
                              kitchenName: "Lore's Kitchen",
                              description:
                                  'A plate of jollof rice, chicken, beef, and plantain',
                              price: 2400,
                              deliveryFee: '300RWF',
                              deliveryTime: '15 mins',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
