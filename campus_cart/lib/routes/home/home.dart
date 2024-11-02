import 'package:campus_cart/controllers/all_dishes_controller.dart';
import 'package:campus_cart/controllers/all_users_controller.dart';
import 'package:campus_cart/controllers/cart_controller.dart';
import 'package:campus_cart/controllers/search_controller.dart';
import 'package:campus_cart/controllers/user_controller.dart';
import 'package:campus_cart/routes/stores/meal_deal_product_card.dart';
import 'package:campus_cart/routes/visuals/most_kitchen_used_card.dart';
import 'package:campus_cart/routes/home/search_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:campus_cart/routes/visuals/icons.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  UserStateController userStateController = Get.find<UserStateController>();
  AllDishesController allDishesController = Get.find<AllDishesController>();
  AllUsersController allUsersController = Get.find<AllUsersController>();
  CartController cartController = Get.find<CartController>();
  AllSearchController allSearchController = Get.find<AllSearchController>();

  // text controller for the search bar
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Check if the user is logged in
    if (FirebaseAuth.instance.currentUser == null ||
        userStateController.loggedInuser == null) {
      // Navigate to login if not authenticated
      Future.delayed(Duration.zero, () {
        if (mounted) {
          // send user to splash store for now, will change to home later
          Navigator.pushReplacementNamed(context, '/login');
        }
      });
    }
  }

  // navigating to pages
  void _navigateToPage(int index, BuildContext context) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        Navigator.pushNamed(context, '/search');
        break;
      case 2:
        // Navigator.pushNamed(context, '/orders');
        break;
      case 3:
        if (userStateController.campusCartUser["isVendor"] != null) {
          Navigator.pushNamed(context, '/store_profile');
        } else {
          Navigator.pushNamed(context, '/splash_store');
        }
        break;
    }
  }

  // list of categories images
  final List<String> categoriesImages = [
    'assets/images/meal_cat.png',
    'assets/images/desert.png',
    'assets/images/drinks.png',
    'assets/images/fruits.png',
    'assets/images/salad.png',
  ];

  // list of categories names
  final List<String> categoriesNames = [
    'Meals',
    'Deserts',
    'Drinks',
    'Fruits',
    'Vegan',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color(0xff202020),
        ),
        selectedItemColor: const Color(0xff202020),
        unselectedItemColor: const Color(0xff606060),
        unselectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color(0xff606060),
        ),
        onTap: (index) {
          _navigateToPage(index, context);
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(MyFlutterApp.homeBold),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(MyFlutterApp.searchNormal),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(MyFlutterApp.bag_2),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconify1.shop),
            label: 'Your Store',
          ),
        ],
      ),
      backgroundColor: const Color(0xffF5C147),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/user_profile');
                    },
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                      child: const CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            AssetImage('assets/images/profile.png'),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 15),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Iconify1.location,
                                color: Color(0xff292D32), size: 20),
                            SizedBox(width: 5),
                            Text(
                              'Current Location',
                              style: TextStyle(
                                color: Color(0xff3A3A3A),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'DM Sans',
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'African Leadership Uni...',
                          style: TextStyle(
                            color: Color(0xff292D32),
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'DM Sans',
                          ),
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  Stack(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              // handle click
                            },
                            child: const Icon(
                              Iconify1.notification,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 7,
                        top: 7,
                        child: Container(
                          width: 14,
                          height: 14,
                          decoration: const BoxDecoration(
                            color: Color(0xffFF5A5A),
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Text(
                              '2',
                              style: TextStyle(
                                color: Color(0xff202020),
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'DM Sans',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Stack(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              // handle click
                            },
                            child: const Icon(
                              Iconify.bagHhappy,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 7,
                        top: 7,
                        child: Container(
                          width: 14,
                          height: 14,
                          decoration: const BoxDecoration(
                            color: Color(0xffFF5A5A),
                            shape: BoxShape.circle,
                          ),
                          child: Center(child: Obx(() {
                            return Text(
                              '${cartController.itemsInCart.value}',
                              style: TextStyle(
                                color: Color(0xff202020),
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'DM Sans',
                              ),
                            );
                          })),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: TextField(
                controller: _searchController,
                cursorHeight: 14,
                decoration: const InputDecoration(
                  hintText: 'What do you want to get?',
                  hintStyle: TextStyle(
                    color: Color(0xff9B9B9B),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'DM Sans',
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 25, right: 10),
                    child: Icon(Iconify.search),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(80)),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Color(0xffFFFFFF),
                ),
                onSubmitted: (String value) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchScreen(query: value),
                    ),
                  );
                  _searchController.clear();
                },
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Expanded(
              child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xffffffff),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(top: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: List.generate(
                            categoriesImages.length,
                            (index) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 19),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundImage:
                                          AssetImage(categoriesImages[index]),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      categoriesNames[index],
                                      style: const TextStyle(
                                        color: Color(0xff606060),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'DM Sans',
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Specially Reserved For You ❤️',
                                    style: TextStyle(
                                      color: Color(0xff202020),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'DM Sans',
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, '/meal_deals');
                                    },
                                    child: const Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 0),
                                          child: Text(
                                            'View All',
                                            style: TextStyle(
                                              color: Color(0xffD49400),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'DM Sans',
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: -2,
                                          child: Text(
                                            '_________',
                                            style: TextStyle(
                                              color: Color(0xffD49400),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'DM Sans',
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              // enclosed this in a reactive variable
                              SizedBox(
                                height: 218,
                                child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Obx(() {
                                      return Row(
                                        children: List.generate(
                                          allDishesController.processedAllDishes
                                                      .length >=
                                                  10
                                              ? 10
                                              : allDishesController
                                                  .processedAllDishes.length,
                                          (index) {
                                            dynamic userDetails =
                                                allUsersController
                                                    .allUsersInfo
                                                    .firstWhere((eachUser) =>
                                                        eachUser["buyerId"] ==
                                                        userStateController
                                                            .loggedInuser.uid);
                                            dynamic dish = allDishesController
                                                .processedAllDishes[index];
                                            return MealDealProductCard(
                                              mealImage: dish["mealImageUrl"],
                                              mealName: dish["mealName"],
                                              phoneNumber:
                                                  userDetails["PhoneNumber"],
                                              email: userDetails["email"],
                                              vendorId: dish["vendorId"],
                                              buyerId: userDetails["buyerId"],
                                              preparationTime:
                                                  dish["preparationTime"],
                                              price: dish["price"],
                                              mealId: dish["mealId"],
                                              indexId: index,
                                              deliveryPrice:
                                                  userDetails["maxFee"] ?? 1500,
                                            );
                                          },
                                          growable: true,
                                        ),
                                      );
                                    })),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Most Used Kitchens',
                                    style: TextStyle(
                                      color: Color(0xff202020),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'DM Sans',
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, '/most_used_kitchens');
                                    },
                                    child: const Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 0),
                                          child: Text(
                                            'See All',
                                            style: TextStyle(
                                              color: Color(0xffD49400),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'DM Sans',
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: -2,
                                          child: Text(
                                            '_________',
                                            style: TextStyle(
                                              color: Color(0xffD49400),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'DM Sans',
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: 218,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Obx(() {
                                    return Row(
                                        children: List.generate(
                                      allUsersController.allUsersInfo.length >=
                                              10
                                          ? 10
                                          : allUsersController
                                              .allUsersInfo.length,
                                      (index) {
                                        dynamic kitchen = allUsersController
                                            .allUsersInfo[index];
                                        return MostKitchenUsedCard(
                                          kitchen: kitchen,
                                        );
                                      },
                                      growable: true,
                                    ));
                                  }),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
