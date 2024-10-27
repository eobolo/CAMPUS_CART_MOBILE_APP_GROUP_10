import 'package:campus_cart/controllers/user_controllers.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:campus_cart/routes/visuals/icons.dart';
// import 'package:campus_cart/routes/store/create_store.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  UserStateController userStateController = Get.find<UserStateController>();

  Map<String, int> itemQuantity = {
    'item1': 0,
    'item2': 0,
    'item3': 0,
  };

  void incrementItemQuantity(String item) {
    setState(() {
      itemQuantity[item] = (itemQuantity[item] ?? 0) + 1;
    });
  }

  void decrementItemQuantity(String item) {
    setState(() {
      if (itemQuantity[item] != null && itemQuantity[item]! > 0) {
        itemQuantity[item] = itemQuantity[item]! - 1;
      }
    });
  }

  final TextEditingController _searchController = TextEditingController();

  final List<String> speciallyReservedImages = [
    'assets/images/meal1.png',
    'assets/images/meal3.png',
    'assets/images/meal2.png',
  ];

  final List<String> categoriesImages = [
    'assets/images/meal_cat.png',
    'assets/images/desert.png',
    'assets/images/drinks.png',
    'assets/images/fruits.png',
    'assets/images/salad.png',
  ];

  final List<String> categoriesNames = [
    'Meals',
    'Deserts',
    'Drinks',
    'Fruits',
    'Vegan',
  ];

  @override
  void initState() {
    super.initState();

    // Check if the user is logged in
    // if (FirebaseAuth.instance.currentUser == null ||
    //     userStateController.loggedInuser == null) {
    //   // Navigate to login if not authenticated
    //   Future.delayed(Duration.zero, () {
    //     if (mounted) {
    //       Navigator.pushReplacementNamed(context, '/login');
    //     }
    //   });
    // } else {
    //   // Optionally, update the reactive loggedInuser from FirebaseAuth
    //   userStateController.loggedInuser = FirebaseAuth.instance.currentUser;
    // }
  }

  @override
  Widget build(BuildContext context) {
    //   body: Center(
    //     child: Text(userStateController.loggedInuser?.email),
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: _changeScreen,
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
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(MyFlutterApp.home_bold),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(MyFlutterApp.search_normal),
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
                      // handle click
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
                  // handle search
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
                                      // handle click
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
                              SizedBox(
                                height: 218,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Container(
                                          width: 235,
                                          decoration: BoxDecoration(
                                            color: const Color(0xffffffff),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Color(0x1A000000),
                                                spreadRadius: 1,
                                                offset: Offset(0, 0),
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(16),
                                                  topRight: Radius.circular(16),
                                                ),
                                                child: Stack(
                                                  children: [
                                                    Image.asset(
                                                      speciallyReservedImages[
                                                          0],
                                                      width: 235,
                                                      height: 116,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    Positioned(
                                                      bottom: 5,
                                                      left: 8,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          // handle click
                                                        },
                                                        child: Container(
                                                          width: 60,
                                                          height: 28,
                                                          decoration: BoxDecoration(
                                                              color: const Color(
                                                                  0xff202020),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16)),
                                                          child: const Center(
                                                            child: Text(
                                                              'Add +',
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xffffffff),
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontFamily:
                                                                    'DM Sans',
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 15, top: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Mimi’s Jollof Rice",
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xff202020),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily: 'DM Sans',
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Text(
                                                      "What do you want to get?",
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xff606060),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily: 'DM Sans',
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          '2400 RWF',
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xff202020),
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontFamily:
                                                                'DM Sans',
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 15),
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icon2.bike,
                                                                color: Color(
                                                                    0xff606060),
                                                                size: 12,
                                                              ),
                                                              SizedBox(
                                                                width: 1,
                                                              ),
                                                              Text(
                                                                '300RWF',
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xff606060),
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontFamily:
                                                                      'DM Sans',
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: 3),
                                                              Icon(
                                                                Iconify.time,
                                                                color: Color(
                                                                    0xff606060),
                                                                size: 12,
                                                              ),
                                                              SizedBox(
                                                                width: 1,
                                                              ),
                                                              Text(
                                                                '15 mins',
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xff606060),
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontFamily:
                                                                      'DM Sans',
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Container(
                                          width: 235,
                                          decoration: BoxDecoration(
                                            color: const Color(0xffffffff),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Color(0x1A000000),
                                                spreadRadius: 1,
                                                offset: Offset(0, 0),
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(16),
                                                  topRight: Radius.circular(16),
                                                ),
                                                child: Stack(
                                                  children: [
                                                    Image.asset(
                                                      speciallyReservedImages[
                                                          1],
                                                      width: 235,
                                                      height: 116,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    Positioned(
                                                      bottom: 5,
                                                      left: 8,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          // handle click
                                                        },
                                                        child: Container(
                                                          width: 60,
                                                          height: 28,
                                                          decoration: BoxDecoration(
                                                              color: const Color(
                                                                  0xff202020),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16)),
                                                          child: const Center(
                                                            child: Text(
                                                              'Add +',
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xffffffff),
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontFamily:
                                                                    'DM Sans',
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 15, top: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Ewa Agoyin",
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xff202020),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily: 'DM Sans',
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Text(
                                                      "What do you want to get?",
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xff606060),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily: 'DM Sans',
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          '5200 RWF',
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xff202020),
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontFamily:
                                                                'DM Sans',
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 15),
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icon2.bike,
                                                                color: Color(
                                                                    0xff606060),
                                                                size: 12,
                                                              ),
                                                              SizedBox(
                                                                width: 1,
                                                              ),
                                                              Text(
                                                                '300RWF',
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xff606060),
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontFamily:
                                                                      'DM Sans',
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: 3),
                                                              Icon(
                                                                Iconify.time,
                                                                color: Color(
                                                                    0xff606060),
                                                                size: 12,
                                                              ),
                                                              SizedBox(
                                                                width: 1,
                                                              ),
                                                              Text(
                                                                '15 mins',
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xff606060),
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontFamily:
                                                                      'DM Sans',
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Container(
                                          width: 235,
                                          decoration: BoxDecoration(
                                            color: const Color(0xffffffff),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Color(0x1A000000),
                                                spreadRadius: 1,
                                                offset: Offset(0, 0),
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(16),
                                                  topRight: Radius.circular(16),
                                                ),
                                                child: Stack(
                                                  children: [
                                                    Image.asset(
                                                      speciallyReservedImages[
                                                          0],
                                                      width: 235,
                                                      height: 116,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    Positioned(
                                                      bottom: 5,
                                                      left: 8,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          // handle click
                                                        },
                                                        child: Container(
                                                          width: 60,
                                                          height: 28,
                                                          decoration: BoxDecoration(
                                                              color: const Color(
                                                                  0xff202020),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16)),
                                                          child: const Center(
                                                            child: Text(
                                                              'Add +',
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xffffffff),
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontFamily:
                                                                    'DM Sans',
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 15, top: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Mimi’s Jollof Rice",
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xff202020),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily: 'DM Sans',
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Text(
                                                      "What do you want to get?",
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xff606060),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily: 'DM Sans',
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          '2400 RWF',
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xff202020),
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontFamily:
                                                                'DM Sans',
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 15),
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icon2.bike,
                                                                color: Color(
                                                                    0xff606060),
                                                                size: 12,
                                                              ),
                                                              SizedBox(
                                                                width: 1,
                                                              ),
                                                              Text(
                                                                '300RWF',
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xff606060),
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontFamily:
                                                                      'DM Sans',
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: 3),
                                                              Icon(
                                                                Iconify.time,
                                                                color: Color(
                                                                    0xff606060),
                                                                size: 12,
                                                              ),
                                                              SizedBox(
                                                                width: 1,
                                                              ),
                                                              Text(
                                                                '15 mins',
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xff606060),
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontFamily:
                                                                      'DM Sans',
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
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
                                      // handle click
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
                                height: 270,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Container(
                                          width: 235,
                                          height: 270,
                                          decoration: BoxDecoration(
                                            color: const Color(0xffffffff),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Color(0x1A000000),
                                                spreadRadius: 1,
                                                offset: Offset(0, 0),
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(16),
                                                  topRight: Radius.circular(16),
                                                ),
                                                child: Stack(
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/store.png',
                                                      height: 116.0,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    // Positioned(
                                                    //     top: 90,
                                                    //     left: 15.0,
                                                    //     height: 52.0,
                                                    //     width: 52.0,
                                                    //     child:
                                                    //         Transform.translate(
                                                    //       offset:
                                                    //           Offset(10, -10),
                                                    //       child: Image.asset(
                                                    //           'assets/images/person.png'),
                                                    //     )),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15, top: 50),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          const Text(
                                                            "Lore's Kitchen",
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xff202020),
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontFamily:
                                                                  'DM Sans',
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 15),
                                                          Container(
                                                            width: 47,
                                                            height: 20,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16),
                                                              color: const Color(
                                                                  0xffFFE4E4),
                                                            ),
                                                            child: const Center(
                                                              child: Text(
                                                                'Closed',
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xffFF5A5A),
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontFamily:
                                                                      'DM Sans',
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(height: 5),
                                                      const Row(
                                                        children: [
                                                          Icon(
                                                            Icon2.bike,
                                                            color: Color(
                                                                0xff606060),
                                                            size: 14,
                                                          ),
                                                          SizedBox(width: 2),
                                                          Text(
                                                            'Delivery will be made in 5-15 mins',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xff606060),
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontFamily:
                                                                  'DM Sans',
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Container(
                                          width: 235,
                                          decoration: BoxDecoration(
                                            color: const Color(0xffffffff),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Color(0x1A000000),
                                                spreadRadius: 1,
                                                offset: Offset(0, 0),
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(16),
                                                  topRight: Radius.circular(16),
                                                ),
                                                child: Stack(
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/store.png',
                                                      height: 116,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15, top: 45),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          const Text(
                                                            "Divine's Kitchen",
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xff202020),
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontFamily:
                                                                  'DM Sans',
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 15),
                                                          Container(
                                                            width: 47,
                                                            height: 20,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16),
                                                              color: const Color(
                                                                  0xffFFE4E4),
                                                            ),
                                                            child: const Center(
                                                              child: Text(
                                                                'Closed',
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xffFF5A5A),
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontFamily:
                                                                      'DM Sans',
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(height: 5),
                                                      const Row(
                                                        children: [
                                                          Icon(
                                                            Icon2.bike,
                                                            color: Color(
                                                                0xff606060),
                                                            size: 14,
                                                          ),
                                                          SizedBox(width: 2),
                                                          Text(
                                                            'Delivery will be made in 5-15 mins',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xff606060),
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontFamily:
                                                                  'DM Sans',
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ))
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
