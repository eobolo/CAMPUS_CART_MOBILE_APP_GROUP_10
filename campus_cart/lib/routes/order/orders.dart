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
            icon: Icon(MyFlutterApp.searchNormal),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/images/bag-2.png'),
            ),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconify1.shop),
            label: 'Your Store',
          ),
        ],
      ),
      backgroundColor: const Color(0xffF5C147),
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
          // const SingleChildScrollView(
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 100),
              Center(
                child: Column(
                  children: <Widget>[
                    const Image(
                      image: AssetImage('assets/images/moving_cart.png'),
                      width: 160,
                      height: 160,
                    ),
                    const Text(
                      'Coming Soon!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff202020),
                        letterSpacing: 0.2,
                        fontFamily: 'DM Sans',
                      ),
                    ),
                    // SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.only(right: 50, left: 50, top: 10),
                      child: Text(
                        "Order History is currently empty. But don't worry, it won't be for long! In the meantime, keep exploring our delicious menu and placing new orders.",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff606060),
                          letterSpacing: 0.2,
                          fontFamily: 'DM Sans',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/home');
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(350, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80),
                        ),
                        backgroundColor: const Color(0xff202020),
                      ),
                      child: const Text(
                        'Explore Meal Options',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xffffffff),
                          letterSpacing: 0.9,
                          fontFamily: 'DM Sans',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
