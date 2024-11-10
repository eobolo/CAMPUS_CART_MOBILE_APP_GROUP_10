import 'package:campus_cart/controllers/all_dishes_controller.dart';
import 'package:campus_cart/controllers/all_users_controller.dart';
import 'package:campus_cart/controllers/cart_controller.dart';
import 'package:campus_cart/controllers/search_controller.dart';
import 'package:campus_cart/controllers/user_controller.dart';
import 'package:campus_cart/routes/visuals/icons.dart';
import 'package:campus_cart/routes/visuals/meal_deal_cards.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MealType extends StatefulWidget {
  final String mealType;
  const MealType({super.key, required this.mealType});

  @override
  State<MealType> createState() => _MealTypeState();
}

class _MealTypeState extends State<MealType> {
  final TextEditingController _searchController = TextEditingController();
  final CartController cartController = Get.find<CartController>();
  AllSearchController allSearchController = Get.find<AllSearchController>();
  UserStateController userStateController = Get.find<UserStateController>();
  AllDishesController allDishesController = Get.find<AllDishesController>();
  AllUsersController allUsersController = Get.find<AllUsersController>();

  void _performSearchOperation(String searchQuery) {
    allSearchController.mealTypeSearchResults.clear();

    List<String> mealInfoField = [
      "cuisine",
      "kitchen",
      "mealName",
      "preparationTime",
      "price",
    ];

    bool matchesQuery(
        Map<Object?, Object?> item, String query, List<String> fields) {
      return fields.any((field) {
        var value = item[field]?.toString().toLowerCase() ?? '';
        return value.contains(query.toLowerCase());
      });
    }

    List<dynamic> filteredList = allDishesController.processedAllDishes
        .where((item) => matchesQuery(item, searchQuery, mealInfoField))
        .toList();
    allSearchController.mealTypeSearchResults.addAll([...filteredList]);
    allSearchController.mealTypeSearchResults.refresh();
  }

  void _performFirstSearch(String searchMealType) {
    allSearchController.mealTypeSearchResults.clear();

    List<String> mealInfoField = [
      "type",
      "dietary",
    ];

    bool matchesQuery(
        Map<Object?, Object?> item, String query, List<String> fields) {
      return fields.any((field) {
        var value = item[field]?.toString().toLowerCase() ?? '';
        return value.contains(query.toLowerCase());
      });
    }

    List<dynamic> filteredList = allDishesController.processedAllDishes
        .where((item) => matchesQuery(item, searchMealType, mealInfoField))
        .toList();
    allSearchController.mealTypeSearchResults.addAll([...filteredList]);
    allSearchController.mealTypeSearchResults.refresh();
  }

  void _onSearchChanged(String? searchQuery) {
    if (searchQuery != null) {
      _performSearchOperation(searchQuery);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _performFirstSearch(widget.mealType);
    });
  }

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
                  Text(
                    widget.mealType,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'DM Sans',
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    height: 60,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 10,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/orders');
                                },
                                child: const Icon(
                                  Iconify.bagHhappy,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 10,
                          top: 10,
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
                                style: const TextStyle(
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
                        onChanged: (value) => _onSearchChanged(value),
                        controller: _searchController,
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
                    Obx(() {
                      // Check if there are search results
                      if (allSearchController.mealTypeSearchResults.isEmpty) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(24.0),
                            child: Text(
                              "No search results found",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        );
                      }

                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: ListView(
                            children: List.generate(
                              allSearchController.mealTypeSearchResults.length,
                              (index) {
                                Widget listItem;
                                dynamic buyerDetails = allUsersController
                                    .allUsersInfo
                                    .firstWhere((eachUser) =>
                                        eachUser["buyerId"] ==
                                        userStateController.loggedInuser.uid);
                                dynamic dish = allSearchController
                                    .mealTypeSearchResults[index];
                                dynamic vendorDetails = allUsersController
                                    .allUsersInfo
                                    .firstWhere((eachUser) =>
                                        eachUser["buyerId"] ==
                                        dish["vendorId"]);
                                String itemInCart =
                                    "${dish["vendorId"]}-${dish["mealId"]}";
                                int? quantity = cartController
                                    .mapOfItemsCount.entries
                                    .firstWhere(
                                      (entry) => entry.key == itemInCart,
                                      orElse: () =>
                                          MapEntry(itemInCart, {"quantity": 0}),
                                    )
                                    .value["quantity"];
                                listItem = MealCard(
                                  imagePath: dish["mealImageUrl"],
                                  mealName: dish["mealName"],
                                  kitchenName: dish["kitchen"],
                                  phoneNumber: buyerDetails["PhoneNumber"],
                                  email: buyerDetails["email"],
                                  vendorId: dish["vendorId"],
                                  buyerId: buyerDetails["buyerId"],
                                  description: dish["mealDescription"],
                                  preparationTime: "${dish["preparationTime"]}",
                                  price: dish["price"],
                                  mealId: dish["mealId"],
                                  indexId: index,
                                  quantity: quantity ?? 0,
                                  deliveryFee:
                                      "${vendorDetails["maxFee"] ?? 1500}",
                                  deliveryTime: "15 mins",
                                );
                                return Column(
                                  children: [
                                    listItem,
                                    const SizedBox(height: 16),
                                  ],
                                );
                              },
                              growable: true,
                            ),
                          ),
                        ),
                      );
                    }),
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