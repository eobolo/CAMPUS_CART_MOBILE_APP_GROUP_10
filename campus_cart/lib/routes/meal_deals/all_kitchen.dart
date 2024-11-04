import 'package:flutter/material.dart';
import 'package:campus_cart/routes/visuals/icons.dart';
import 'package:campus_cart/routes/visuals/kitchen_card.dart';

class AllKitchens extends StatelessWidget {
  const AllKitchens({super.key});

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
                    'All Kitchens',
                    style: TextStyle(
                      fontSize: 16,
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
                    const Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(24),
                        child: Column(
                          children: [
                            KitchenCard(
                              imagePath: 'assets/images/store1.png',
                              kitchenName: "Lore's Kitchen",
                              deliveryTime: 'Delivery will be in 5 - 15 mins',
                              status: 'Open',
                              profileImagePath: 'assets/images/person1.png',
                            ),
                            SizedBox(height: 10),
                            KitchenCard(
                              imagePath: 'assets/images/store1.png',
                              kitchenName: "Divine's Kitchen",
                              deliveryTime: 'Delivery will be in 5 - 15 mins',
                              status: 'Closed',
                              profileImagePath: 'assets/images/person.png',
                            ),
                            SizedBox(height: 10),
                            KitchenCard(
                              imagePath: 'assets/images/store1.png',
                              kitchenName: "Papi Sharwama",
                              deliveryTime: 'Delivery will be in 5 - 15 mins',
                              status: 'Open',
                              profileImagePath: 'assets/images/person.png',
                            ),
                            SizedBox(height: 10),
                            KitchenCard(
                              imagePath: 'assets/images/store1.png',
                              kitchenName: "Mama's Kitchen",
                              deliveryTime: 'Delivery will be in 5 - 15 mins',
                              status: 'Closed',
                              profileImagePath: 'assets/images/person1.png',
                            ),
                          ],
                        ),
                      ),
                    )
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
