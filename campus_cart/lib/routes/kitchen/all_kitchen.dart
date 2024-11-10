import 'package:campus_cart/controllers/all_dishes_controller.dart';
import 'package:campus_cart/controllers/all_users_controller.dart';
import 'package:campus_cart/controllers/cart_controller.dart';
import 'package:campus_cart/controllers/search_controller.dart';
import 'package:campus_cart/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:campus_cart/routes/visuals/icons.dart';
import 'package:campus_cart/routes/visuals/kitchen_card.dart';
import 'package:get/get.dart';

AllSearchController allSearchController = Get.find<AllSearchController>();

class AllKitchens extends StatefulWidget {
  const AllKitchens({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AllKitchensState createState() => _AllKitchensState();
}

class _AllKitchensState extends State<AllKitchens> {
  final TextEditingController _searchController = TextEditingController();
  final CartController cartController = Get.find<CartController>();
  final AllDishesController allDishesController =
      Get.find<AllDishesController>();
  final AllUsersController allUsersController = Get.find<AllUsersController>();
  final UserStateController userStateController =
      Get.find<UserStateController>();

  void _performSearchOperation(String searchQuery) {
    allSearchController.allKitchenSearchResults.clear();

    List<String> usersInfoField = [
      "city",
      "from",
      "to",
      "maxFee",
      "minFee",
      "vendorName"
    ];

    bool matchesQuery(
        Map<Object?, Object?> item, String query, List<String> fields) {
      return fields.any((field) {
        var value = item[field]?.toString().toLowerCase() ?? '';
        return value.contains(query.toLowerCase());
      });
    }

    List<dynamic> filteredList = allUsersController.allUsersInfo
        .where((item) => matchesQuery(item, searchQuery, usersInfoField))
        .toList();
    allSearchController.allKitchenSearchResults.addAll([...filteredList]);
    allSearchController.allKitchenSearchResults.refresh();
  }

  void _onSearchChanged(String? searchQuery) {
    if (searchQuery != null) {
      _performSearchOperation(searchQuery);
    }
  }

  bool _isKitchenOpen(String fromTime, String toTime) {
    dynamic kitchenToTime = int.tryParse(toTime);
    dynamic kitchenFromTime = int.tryParse(fromTime);

    if (kitchenToTime == null || kitchenFromTime == null) {
      return false;
    }

    final currentHour = DateTime.now().hour;

    if (kitchenToTime == 0) {
      if (currentHour >= 1 && currentHour < 13) {
        kitchenToTime = 0;
      } else if (currentHour == 0) {
        kitchenFromTime = 0;
      } else {
        kitchenToTime = 24;
      }
    }
    return (currentHour >= kitchenFromTime) && (currentHour <= kitchenToTime);
  }

  @override
  void initState() {
    super.initState();
    // Delay the update of allKitchenSearchResults until after the first build completes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      allSearchController.allKitchenSearchResults.clear();
      allSearchController.allKitchenSearchResults
          .addAll([...allUsersController.allUsersInfo]);
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
                  const Text(
                    'All Kitchens',
                    style: TextStyle(
                      fontSize: 16,
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
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(24),
                        child: Obx(() {
                          return Column(
                            children: List.generate(
                              allSearchController
                                  .allKitchenSearchResults.length,
                              (index) {
                                dynamic kitchen = allSearchController
                                    .allKitchenSearchResults[index];
                                String status = _isKitchenOpen(
                                        "${kitchen["from"]}",
                                        "${kitchen["to"]}")
                                    ? 'Open'
                                    : 'Closed';
                                return KitchenCard(
                                  imagePath: "assets/images/store1.png",
                                  kitchenName: kitchen["vendorName"],
                                  deliveryTime:
                                      "Delivery will be in 10 - 30 mins",
                                  status: status,
                                  profileImagePath: kitchen["storeLogo"],
                                );
                              },
                              growable: true,
                            ),
                          );
                        }),
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
