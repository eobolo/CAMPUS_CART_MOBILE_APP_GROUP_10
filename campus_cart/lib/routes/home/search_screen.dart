import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
<<<<<<< HEAD
  const SearchScreen({super.key});

  @override
=======
  const SearchScreen({super.key, required String query});

  @override
  // ignore: library_private_types_in_public_api
>>>>>>> 3b4c3c914189ca03ba5566265a1c990f65d308e8
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _recentSearches = [
    'Pizza',
    'Burger and Fries',
    'Fried rice and salad'
  ];

  final List<Map<String, String>> kitchens = [
    {
      'name': "Love's Kitchen",
      'deliveryTime': '15-16 mins',
      'imageUrl': 'assets/images/test.png',
    },
    {
      'name': "Divine's Kitchen",
      'deliveryTime': '15-20 mins',
      'imageUrl': 'assets/images/test.png',
    },
  ];

  final List<Map<String, String>> foodItems = [
    {
      'name': "Mimi's Jollof Rice",
      'kitchen': "Mimi's Kitchen",
      'description': 'A plate of jollof rice, chicken, beef and plantain',
      'price': '2400',
      'cookTime': '15 mins',
      'imageUrl': 'assets/images/vegan.png',
    },
  ];

  bool _isSearching = false;
  String _searchQuery = '';
  final Color customYellow = const Color(0xFFF5C147);

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
      _isSearching = _searchQuery.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200.0),
        child: Container(
          color: customYellow,
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Container(
                      height: 55,
                      decoration: BoxDecoration(
                        color: Colors.white,
<<<<<<< HEAD
                        borderRadius: BorderRadius.circular(18),
=======
                        borderRadius: BorderRadius.circular(40),
>>>>>>> 3b4c3c914189ca03ba5566265a1c990f65d308e8
                      ),
                      child: Center(
                        child: TextField(
                          controller: _searchController,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child:
                                  Icon(Icons.search, color: Colors.grey[600]),
                            ),
                            contentPadding: const EdgeInsets.only(top: 12),
                            hintText: 'Search for food...',
                            hintStyle: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Image.asset("assets/images/cup.png")),
                ],
              ),
            ),
          ),
        ),
      ),
      body: _isSearching ? _buildSearchResults() : _buildInitialContent(),
    );
  }

  Widget _buildInitialContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Categories
        Container(
          height: 110,
          margin: const EdgeInsets.only(top: 10),
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            children: [
              _buildCategoryItem('Meals', 'assets/images/meals.png'),
              _buildCategoryItem('Dessert', 'assets/images/dessert.png'),
              _buildCategoryItem('Drinks', 'assets/images/drinks.png'),
              _buildCategoryItem('Fruits', 'assets/images/fruits.png'),
              _buildCategoryItem('Vegan', 'assets/images/vegan.png'),
            ],
          ),
        ),

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

        Expanded(
          child: ListView.builder(
            itemCount: _recentSearches.length,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: customYellow.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.search,
                          size: 20, color: Colors.black54),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _recentSearches[index],
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _recentSearches.removeAt(index);
                        });
                      },
                      child: const Icon(Icons.close,
                          size: 20, color: Colors.black54),
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
<<<<<<< HEAD
            'Results found for $_searchQuery',
=======
            'Results found for "$_searchQuery"',
>>>>>>> 3b4c3c914189ca03ba5566265a1c990f65d308e8
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: ListView(
            children: [
<<<<<<< HEAD
              ...kitchens.map((kitchen) => _buildKitchenCard(kitchen)),
              ...foodItems.map((food) => _buildFoodCard(food)),
=======
              ...kitchens
                  .where((kitchen) => kitchen['name']!
                      .toLowerCase()
                      .contains(_searchQuery.toLowerCase()))
                  .map((kitchen) => _buildKitchenCard(kitchen)),
              ...foodItems
                  .where((food) => food['name']!
                      .toLowerCase()
                      .contains(_searchQuery.toLowerCase()))
                  .map((food) => _buildFoodCard(food)),
>>>>>>> 3b4c3c914189ca03ba5566265a1c990f65d308e8
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryItem(String name, String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipOval(
            child: Image.asset(
              imagePath,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKitchenCard(Map<String, String> kitchen) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFFE4E4E4),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: Image.asset(
                    'assets/images/wavy.png',
                    width: double.infinity,
                    height: 80,
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          kitchen['name']!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Open',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Row(
                    children: [
                      Icon(
                        Icons.delivery_dining,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
<<<<<<< HEAD
                        'Delivery will be made in ${kitchen['deliveryTime']!}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
=======
                        kitchen['deliveryTime']!,
                        style: TextStyle(color: Colors.grey[600]),
>>>>>>> 3b4c3c914189ca03ba5566265a1c990f65d308e8
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
<<<<<<< HEAD
          Positioned(
            top: 50,
            left: 16,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                kitchen['imageUrl']!,
                width: 64,
                height: 64,
                fit: BoxFit.cover,
              ),
            ),
          ),
=======
>>>>>>> 3b4c3c914189ca03ba5566265a1c990f65d308e8
        ],
      ),
    );
  }

  Widget _buildFoodCard(Map<String, String> food) {
    return Container(
<<<<<<< HEAD
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(
                  food['imageUrl']!,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 8,
                right: 8,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Add +',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Food Details
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
=======
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFFE4E4E4),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: Image.asset(
                    food['imageUrl']!,
                    width: double.infinity,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
>>>>>>> 3b4c3c914189ca03ba5566265a1c990f65d308e8
                        food['name']!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
<<<<<<< HEAD
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        food['kitchen']!,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  food['description']!,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      'RWF ${food['price']}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${food['cookTime']} mins',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.delivery_dining,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${food['deliveryCost']} RWF',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
=======
                      const SizedBox(height: 4),
                      Text(
                        food['description']!,
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'RWF ${food['price']}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            food['cookTime']!,
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
>>>>>>> 3b4c3c914189ca03ba5566265a1c990f65d308e8
              ],
            ),
          ),
        ],
      ),
    );
  }
}
