import 'package:campus_cart/controllers/all_dishes_controller.dart';
import 'package:campus_cart/controllers/all_users_controller.dart';
import 'package:campus_cart/controllers/cart_controller.dart';
import 'package:campus_cart/controllers/search_controller.dart';
import 'package:campus_cart/controllers/user_controller.dart';
import 'package:campus_cart/routes/home/meal_deal_product_card.dart';
import 'package:campus_cart/routes/visuals/icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

AllSearchController allSearchController = Get.find<AllSearchController>();

class SearchScreen extends StatefulWidget {
  final String query;
  const SearchScreen({super.key, required this.query});

  @override
  // ignore: library_private_types_in_public_api
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _searchController;
  CartController cartController = Get.find<CartController>();
  AllDishesController allDishesController = Get.find<AllDishesController>();
  AllUsersController allUsersController = Get.find<AllUsersController>();
  UserStateController userStateController = Get.find<UserStateController>();

  bool _isSearching = false;
  String _searchQuery = '';
  final Color customYellow = const Color(0xFFF5C147);

  // navigating to pages
  void _navigateToPage(int index, BuildContext context) {
    _saveAsRecentSearch();
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

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.query);
    _searchController.addListener(_onSearchChanged);
  }

  bool _isKitchenOpen(String fromTime, String toTime) {
    // Parse the "to" time
    int kitchenToTime = int.tryParse(toTime) ?? 0;
    int kitchenFromTime = int.tryParse(fromTime) ?? 0;

    final currentHour = DateTime.now().hour;

    // Change kitchen closing time from 0 to 24
    if (kitchenToTime == 0) {
      if (currentHour >= 1 && currentHour < 13) {
        kitchenToTime = 0;
      } else if (currentHour == 0) {
        kitchenFromTime = 0;
      } else {
        kitchenToTime = 24;
      }
    }
    if ((currentHour >= kitchenFromTime) && (currentHour <= kitchenToTime)) {
      return true;
    } else {
      return false;
    }
  }

  void _performSearchOperation() {
    allSearchController.searchResults.clear();

    List<String> list1Fields = [
      "cuisine",
      "dietary",
      "kitchen",
      "mealName",
      "preparationTime",
      "price",
      "type"
    ];
    List<String> list2Fields = [
      "city",
      "from",
      "to",
      "maxFee",
      "minFee",
      "vendorName"
    ];
    // Function to check if query matches any value in the map
    bool matchesQuery(
        Map<Object?, Object?> item, String query, List<String> fields) {
      return fields.any((field) {
        var value = item[field]?.toString().toLowerCase() ?? '';
        return value.contains(query.toLowerCase());
      });
    }

    // Filtered results based on query
    List<dynamic> filteredList1 = allDishesController.processedAllDishes
        .where((item) => matchesQuery(item, _searchQuery, list1Fields))
        .toList();

    List<dynamic> filteredList2 = allUsersController.allUsersInfo
        .where((item) => matchesQuery(item, _searchQuery, list2Fields))
        .toList();
    allSearchController.searchResults
        .addAll([...filteredList1, ...filteredList2]);
    allSearchController.searchResults.refresh();
  }

  void _saveAsRecentSearch({String? searchquery}) {
    if ((searchquery != null || _searchQuery.isNotEmpty) &&
        (searchquery != "")) {
      if (allSearchController.recentSearches.length > 5) {
        allSearchController.recentSearches.removeAt(0);
      }
      allSearchController.recentSearches.add(searchquery ?? _searchQuery);
      allSearchController.recentSearches.refresh();
    }
  }

  void _pickRecentSearchToSearch(int index) {
    _searchController.text = allSearchController.recentSearches[index];
    _onSearchChanged();
  }

  void _removeRecentSearch(int index) {
    allSearchController.recentSearches.removeAt(index);
    allSearchController.recentSearches.refresh();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
      _isSearching = _searchQuery.isNotEmpty;
    });
    if (_isSearching) {
      _performSearchOperation();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 1,
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
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 130.0),
          child: Container(
            color: customYellow,
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 15, left: 10.0, right: 10.0),
                      child: SizedBox(
                        width: 320.0,
                        child: TextField(
                          onSubmitted: (searchquery) =>
                              _saveAsRecentSearch(searchquery: searchquery),
                          controller: _searchController,
                          cursorHeight: 14,
                          decoration: const InputDecoration(
                            hintText:
                                'search anything ..., press enter to save.',
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(80)),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Color(0xffFFFFFF),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: 50,
                      height: 60,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 10,
                            child: Container(
                              width: 50,
                              height: 50,
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
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Obx(() {
          return _isSearching
              ? allSearchController.searchResults.isNotEmpty
                  ? _buildSearchResults()
                  : _buildInitialContent(true)
              : _buildInitialContent(false);
        }));
  }

  Widget _buildInitialContent(bool isError) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Categories
        Container(
          height: 110,
          margin: const EdgeInsets.only(top: 10),
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            children: [
              _buildCategoryItem('Meals', 'assets/images/meal_cat.png'),
              _buildCategoryItem('Dessert', 'assets/images/desert.png'),
              _buildCategoryItem('Drinks', 'assets/images/drinks.png'),
              _buildCategoryItem('Fruits', 'assets/images/fruits.png'),
              _buildCategoryItem('Vegan', 'assets/images/salad.png'),
            ],
          ),
        ),
        SizedBox(height: 5.0),
        isError
            ? Center(
                child: Text(
                'No result(s) found...',
                style: const TextStyle(
                  color: Color.fromARGB(255, 44, 44, 44),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ))
            : SizedBox(),
        // Recent Searches
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Recent Searches',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Flexible(
          child: ListView.builder(
            itemCount: allSearchController.recentSearches.length,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => _pickRecentSearchToSearch(index),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: customYellow.withOpacity(0.3),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.search,
                              size: 18,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          allSearchController.recentSearches[index],
                          style: const TextStyle(fontSize: 15),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => _removeRecentSearch(index),
                      child: const Icon(
                        Icons.close,
                        size: 18,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchResults() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Results found for "$_searchQuery"',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ),
        Obx(() {
          return Flexible(
            child: ListView(
              children: List.generate(
                allSearchController.searchResults.length,
                (index) {
                  Widget listItem;

                  if (allSearchController.searchResults[index]
                      .containsKey("mealName")) {
                    dynamic userDetails = allUsersController.allUsersInfo
                        .firstWhere((eachUser) =>
                            eachUser["buyerId"] ==
                            userStateController.loggedInuser.uid);
                    dynamic dish = allSearchController.searchResults[index];

                    listItem = MealDealProductCard(
                      mealImage: dish["mealImageUrl"],
                      mealName: dish["mealName"],
                      phoneNumber: userDetails["PhoneNumber"],
                      email: userDetails["email"],
                      vendorId: dish["vendorId"],
                      buyerId: userDetails["buyerId"],
                      preparationTime: dish["preparationTime"],
                      price: dish["price"],
                      mealId: dish["mealId"],
                      indexId: index,
                      deliveryPrice: userDetails["maxFee"] ?? 1500,
                    );
                  } else {
                    listItem = _buildKitchenCard(
                        allSearchController.searchResults[index]);
                  }
                  return Column(
                    children: [
                      listItem,
                      SizedBox(height: 10), // Add spacing here
                    ],
                  );
                },
                growable: true,
              ),
            ),
          );
        })
      ],
    );
  }

  Widget _buildCategoryItem(String name, String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(imagePath),
          ),
          const SizedBox(height: 5),
          Text(
            name,
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
  }

  Widget _buildKitchenCard(dynamic kitchen) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        width: 250, // Match the width of MealDealProductCard
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16), // Match the border radius
          boxShadow: const [
            BoxShadow(
              color: Color(0x1A000000),
              spreadRadius: 1,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Image.network(
                "${kitchen["storeLogo"]}",
                width: 250,
                height: 116, // Adjust the height as needed
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 7.5, top: 10, right: 7.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${kitchen["vendorName"]}",
                    style: const TextStyle(
                      color: Color(0xff202020),
                      fontSize: 14,
                      fontWeight: FontWeight.w600, // Match font weight
                      fontFamily: 'DM Sans',
                    ),
                  ),
                  const SizedBox(height: 5),
                  // Add a placeholder for additional information or description
                  Text(
                    "Delivery will be made in 10-30 mins", // Placeholder text
                    style: TextStyle(
                      color: Color(0xff606060),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'DM Sans',
                    ),
                  ),
                  const SizedBox(height: 5),
                  // Kitchen open status
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _isKitchenOpen("${kitchen["from"]}", "${kitchen["to"]}")
                          ? 'Open'
                          : 'Closed',
                      style: TextStyle(
                        color: _isKitchenOpen(
                                "${kitchen["from"]}", "${kitchen["to"]}")
                            ? Colors.green
                            : Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
