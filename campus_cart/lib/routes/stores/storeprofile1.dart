import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:campus_cart/routes/visuals/icons.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'dart:io';

class Storeprofile1 extends StatelessWidget {
  final XFile? storeLogo;

  const Storeprofile1({super.key, this.storeLogo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
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
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 100),
                Center(
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: storeLogo == null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Image.asset(
                              'assets/images/person.png',
                              width: 120,
                              height: 120,
                            ),
                          )
                        : Container(
                            alignment: Alignment.center,
                            child: Image.file(
                              File(storeLogo!.path),
                              width: 120,
                              height: 120,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Lore's Kitchen",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'DM Sans',
                    color: Color(0xff202020),
                  ),
                ),
                const SizedBox(height: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icon2.bike, size: 14, color: Color(0xff606060)),
                    SizedBox(width: 5),
                    Text(
                      'Delivery will be made in 5-15 mins',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xff606060),
                        fontFamily: 'DM Sans',
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
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: const Color(0xffE9FFB5),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            // handle this part
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xffFFFFFF),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            elevation: 0,
                                            minimumSize: const Size(20, 30),
                                            shadowColor: Colors.transparent,
                                          ),
                                          child: const Text(
                                            'See More',
                                            style: TextStyle(
                                              fontSize: 8,
                                              color: Color(0xff202020),
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'DM Sans',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
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
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff202020),
                                                fontFamily: 'DM Sans',
                                              ),
                                            ),
                                            const SizedBox(width: 3),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 5),
                                              decoration: BoxDecoration(
                                                color: const Color(0xffD3FF68),
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                              ),
                                              width: 30,
                                              height: 20,
                                              child: const Text(
                                                'Fee',
                                                style: TextStyle(
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xff334801),
                                                  fontFamily: 'DM Sans',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        const Text(
                                          '550 - 1000RWF',
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
                      ),
                      const SizedBox(width: 2),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: const Color(0xffFDEACB),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            // handle this part
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xffFFFFFF),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            minimumSize: const Size(20, 30),
                                            elevation: 0,
                                            shadowColor: Colors.transparent,
                                          ),
                                          child: const Text(
                                            'See More',
                                            style: TextStyle(
                                              fontSize: 8,
                                              color: Color(0xff202020),
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'DM Sans',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
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
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff202020),
                                                fontFamily: 'DM Sans',
                                              ),
                                            ),
                                            const SizedBox(width: 2),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 5),
                                              decoration: BoxDecoration(
                                                color: const Color(0xffFFD48E),
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                              ),
                                              height: 20,
                                              child: const Text(
                                                'Hours',
                                                style: TextStyle(
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xff644411),
                                                  fontFamily: 'DM Sans',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        const Text(
                                          'Today: 9-5pm',
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
                      ),
                      const SizedBox(width: 2),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: const Color(0xffE6E6FF),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            // handle this part
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xffFFFFFF),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            minimumSize: const Size(20, 30),
                                            elevation: 0,
                                            shadowColor: Colors.transparent,
                                          ),
                                          child: const Text(
                                            'See More',
                                            style: TextStyle(
                                              fontSize: 8,
                                              color: Color(0xff202020),
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'DM Sans',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start, // width: 50,
                                      children: [
                                        const Image(
                                          image: AssetImage(
                                            'assets/images/payment.png',
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: [
                                            const Text(
                                              'Payment',
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff202020),
                                                fontFamily: 'DM Sans',
                                              ),
                                            ),
                                            const SizedBox(width: 3),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 5),
                                              height: 20,
                                              decoration: BoxDecoration(
                                                color: const Color(0xffC3C3FF),
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                              ),
                                              child: const Text(
                                                'GTBank',
                                                style: TextStyle(
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xff282864),
                                                  fontFamily: 'DM Sans',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        const Text(
                                          '054 1875 463',
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
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Dash(
                  direction: Axis.horizontal,
                  length: 400,
                  dashLength: 7,
                  dashColor: Color(0xffABABAB),
                ),
                const SizedBox(height: 20),
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
                  onPressed: () {
                    // handle this part
                  },
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
            ),
          ),
        ],
      ),
    );
  }
}
