import 'package:flutter/material.dart';
import 'package:campus_cart/routes/visuals/icons.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

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
          currentIndex: 2,
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
              icon: Icon(MyFlutterApp.home),
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
          child: Stack(
            children: [
              // Back button at the top-left
              Positioned(
                top: 55,
                left: 30,
                width: 40,
                height: 40,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_rounded),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: Colors.black,
                  ),
                ),
              ),
              Positioned(
                top: 120,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: const Center(
                    child: Text(
                      'Coming Soon!',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'DM Sans',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
