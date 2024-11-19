import 'package:campus_cart/controllers/meal_image_controller.dart';
import 'package:campus_cart/controllers/setup_delivery_controller.dart';
import 'package:campus_cart/controllers/setup_operation_controller.dart';
import 'package:campus_cart/controllers/store_logo_controller.dart';
import 'package:campus_cart/controllers/user_controller.dart';
import 'package:campus_cart/routes/visuals/product_card.dart';
import 'package:flutter/material.dart';
import 'package:campus_cart/routes/visuals/icons.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:get/get.dart';

class StoreProfile extends StatelessWidget {
  StoreProfile({super.key});

  final StoreLogoStateController storeLogoStateController =
      Get.find<StoreLogoStateController>();
  final UserStateController userStateController =
      Get.find<UserStateController>();
  final SetupDeliveryController setupDeliveryController =
      Get.find<SetupDeliveryController>();
  final SetupOperationController setupOperationController =
      Get.find<SetupOperationController>();
  final MealImageController mealImageController =
      Get.find<MealImageController>();

  void _setUpDelivery(BuildContext context) {
    Navigator.pushNamed(context, '/setup_delivery');
  }

  void _setUpOperations(BuildContext context) {
    Navigator.pushNamed(context, '/setup_operation');
  }

  void _createMenu(BuildContext context) {
    Navigator.pushNamed(context, '/create_menu');
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
        Navigator.pushNamed(context, '/orders');
        break;
      case 3:
        Navigator.pushNamed(context, '/store_profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          _navigateToPage(index, context);
        },
        currentIndex: 3,
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
            icon: Icon(MyFlutterApp.home, color: Color(0xff606060)),
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
            icon: Icon(MyFlutterApp.shop),
            label: 'Your Store',
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: <Color>[
                Color(0xfff6c85b),
                Color(0xffffffff),
              ],
              begin: Alignment.topCenter,
              end: Alignment.center,
            )),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 100),
                Obx(() {
                  return Center(
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: storeLogoStateController.imageUrl.value == ""
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: Image.asset(
                                'assets/images/person.png',
                                width: 120,
                                height: 120,
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: Image.network(
                                storeLogoStateController.imageUrl.value,
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  );
                }),
                const SizedBox(height: 20),
                Obx(() {
                  return Text(
                    userStateController.campusCartUser["vendorName"] ?? "Classic Name",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'DM Sans',
                      color: Color(0xff202020),
                    ),
                  );
                }),
                const SizedBox(height: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icon2.bike, size: 14, color: Color(0xff606060)),
                    SizedBox(width: 5),
                    Text(
                      'Delivery will be made in 5-15 mins', // as to be change based on operations
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xff606060),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Obx(() {
                          return setupDeliveryController.minFee.value == 0 &&
                                  setupDeliveryController.maxFee.value == 0
                              ? Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 2),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: const Color(0xffE9FFB5),
                                    ),
                                    child: Column(children: [
                                      const Image(
                                        image: AssetImage(
                                            'assets/images/delivery_bike.png'),
                                      ),
                                      const SizedBox(height: 10),
                                      const Text(
                                        'Delivery',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff202020),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      ElevatedButton(
                                        onPressed: () =>
                                            _setUpDelivery(context),
                                        child: const Text('Set Up',
                                            style: TextStyle(
                                              fontSize: 8,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff202020),
                                            )),
                                      ),
                                    ]),
                                  ),
                                )
                              : Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 2),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    decoration: BoxDecoration(
                                      color: const Color(0xffE9FFB5),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10),
                                                  child: ElevatedButton(
                                                    onPressed: () =>
                                                        _setUpDelivery(context),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          const Color(
                                                              0xffFFFFFF),
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10,
                                                          vertical: 5),
                                                      elevation: 0,
                                                      minimumSize:
                                                          const Size(20, 30),
                                                      shadowColor:
                                                          Colors.transparent,
                                                    ),
                                                    child: const Text(
                                                      'See More',
                                                      style: TextStyle(
                                                        fontSize: 8,
                                                        color:
                                                            Color(0xff202020),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily: 'DM Sans',
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start, // width: 50,
                                                children: [
                                                  const Image(
                                                    image: AssetImage(
                                                      'assets/images/delivery_bike.png',
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        'Delivery',
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              Color(0xff202020),
                                                          fontFamily: 'DM Sans',
                                                        ),
                                                      ),
                                                      const SizedBox(width: 3),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 8,
                                                                vertical: 5),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: const Color(
                                                              0xffD3FF68),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(40),
                                                        ),
                                                        width: 30,
                                                        height: 20,
                                                        child: const Text(
                                                          'Fee',
                                                          style: TextStyle(
                                                            fontSize: 8,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Color(
                                                                0xff334801),
                                                            fontFamily:
                                                                'DM Sans',
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Obx(() {
                                                    return Text(
                                                      '${setupDeliveryController.minFee.value}-${setupDeliveryController.maxFee.value}RWF',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color:
                                                            Color(0xff202020),
                                                        fontFamily: 'DM Sans',
                                                      ),
                                                    );
                                                  }),
                                                  const SizedBox(height: 5),
                                                ]),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                        }),
                        const SizedBox(width: 5),
                        Obx(() {
                          return setupOperationController.fromHour.value !=
                                      24 &&
                                  setupOperationController.toHour.value != 24
                              ? Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 2),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    decoration: BoxDecoration(
                                      color: const Color(0xffFDEACB),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10),
                                                  child: ElevatedButton(
                                                    onPressed: () =>
                                                        _setUpOperations(
                                                            context),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          const Color(
                                                              0xffFFFFFF),
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10,
                                                          vertical: 5),
                                                      minimumSize:
                                                          const Size(20, 30),
                                                      elevation: 0,
                                                      shadowColor:
                                                          Colors.transparent,
                                                    ),
                                                    child: const Text(
                                                      'See More',
                                                      style: TextStyle(
                                                        fontSize: 8,
                                                        color:
                                                            Color(0xff202020),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily: 'DM Sans',
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start, // width: 50,
                                                children: [
                                                  const Image(
                                                    image: AssetImage(
                                                      'assets/images/operations.png',
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        'Operations',
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              Color(0xff202020),
                                                          fontFamily: 'DM Sans',
                                                        ),
                                                      ),
                                                      const SizedBox(width: 2),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 8,
                                                                vertical: 5),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: const Color(
                                                              0xffFFD48E),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(40),
                                                        ),
                                                        height: 20,
                                                        child: const Text(
                                                          'Hours',
                                                          style: TextStyle(
                                                            fontSize: 8,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Color(
                                                                0xff644411),
                                                            fontFamily:
                                                                'DM Sans',
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Text(
                                                    'Today: ${setupOperationController.fromHour.value}-${setupOperationController.toHour.value}${setupOperationController.toSymbol.value}',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Color(0xff202020),
                                                      fontFamily: 'DM Sans',
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                ]),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 2),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: const Color(0xffFDEACB),
                                    ),
                                    child: Column(children: [
                                      const Image(
                                        image: AssetImage(
                                            'assets/images/operations.png'),
                                      ),
                                      const SizedBox(height: 10),
                                      const Text(
                                        'Operations',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff202020),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      ElevatedButton(
                                        onPressed: () =>
                                            _setUpOperations(context),
                                        child: const Text('Set Up',
                                            style: TextStyle(
                                              fontSize: 8,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff202020),
                                            )),
                                      ),
                                    ]),
                                  ),
                                );
                        }),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: const Color(0xffE6E6FF),
                            ),
                            child: Column(children: [
                              const Image(
                                image: AssetImage('assets/images/payment.png'),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Payments',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff202020),
                                ),
                              ),
                              const SizedBox(height: 5),
                              ElevatedButton(
                                onPressed: () {},
                                child: const Text('Set Up',
                                    style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff202020),
                                    )),
                              ),
                            ]),
                          ),
                        ),
                      ]),
                ),
                const SizedBox(height: 20),
                const Dash(
                  direction: Axis.horizontal,
                  length: 400,
                  dashLength: 7,
                  dashColor: Color(0xffABABAB),
                ),
                const SizedBox(height: 20),
                Obx(() {
                  return mealImageController.mapOfDishes.length == 0
                      ? Column(
                          children: [
                            const Image(
                              image: AssetImage('assets/images/notepad.png'),
                              width: 124,
                              height: 124,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Empty Menu',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff202020),
                                fontFamily: 'DM Sans',
                              ),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              width: 300,
                              child: const Text(
                                'Your menu is waiting to be filled with your culinary creations! Add your items now and let your customers discover the tasty treats you have to offer.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff606060),
                                  fontFamily: 'DM Sans',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () => _createMenu(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff202020),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 100, vertical: 18),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(80),
                                ),
                              ),
                              child: const Text(
                                'Create Menu',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'DM Sans',
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Your Menu Items',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff202020),
                                  fontFamily: 'DM Sans',
                                ),
                              ),
                              const SizedBox(height: 10),
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                ),
                                itemCount:
                                    mealImageController.mapOfDishes.length +
                                        1, // +1 for the "Create New Menu" card
                                itemBuilder: (context, index) {
                                  if (index == 0) {
                                    // First item as "Create New Menu"
                                    return ProductCard(
                                      mealName: 'Create New Menu',
                                      isCreateNew: true,
                                    );
                                  }

                                  // Get the actual item from the list for other cards
                                  final item = mealImageController
                                      .mapOfDishes[index - 1];
                                  return ProductCard(
                                    editMealId: item["mealId"],
                                    mealName: item['mealName'] as String,
                                    mealDescription: item["mealDescription"],
                                    preparationTime: item["preparationTime"],
                                    cuisine: item["cuisine"],
                                    type: item["type"],
                                    dietary: item["dietary"],
                                    price: '${item['price']}',
                                    imageUrl: item["mealImageUrl"],
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
