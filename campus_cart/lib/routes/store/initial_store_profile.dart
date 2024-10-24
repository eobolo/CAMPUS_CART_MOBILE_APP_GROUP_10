import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:campus_cart/routes/visuals/icons.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'dart:io';

class InitialStoreProfile extends StatelessWidget {
  // const StoreProfile({super.key});
  final XFile? storeLogo;

  const InitialStoreProfile({super.key, this.storeLogo});

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
            icon: Icon(MyFlutterApp.search_normal),
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
                            padding: const EdgeInsets.symmetric(vertical: 16),
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
                        const SizedBox(width: 5),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: const Color(0xffFDEACB),
                            ),
                            child: Column(children: [
                              const Image(
                                image:
                                    AssetImage('assets/images/operations.png'),
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
                Container(
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
