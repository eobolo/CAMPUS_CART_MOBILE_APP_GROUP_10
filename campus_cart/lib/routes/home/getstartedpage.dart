import 'package:campus_cart/routes/home/starterpage1.dart';
import 'package:campus_cart/routes/home/starterpage2.dart';
import 'package:campus_cart/routes/state/splash_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:campus_cart/routes/visuals/splashvisuals.dart';

class Getstartedpage extends StatefulWidget {
  const Getstartedpage({super.key});

  @override
  State<Getstartedpage> createState() => _GetstartedpageState();
}

class _GetstartedpageState extends State<Getstartedpage> {
  int page = 0;
  final List<Widget> _getStarterPages = [
    const Starterpage1(),
    const Starterpage2(),
  ];

  // central state
  int formNumber = 1;

  void onPressedVendor() {
    setState(() {
      formNumber = 1;
    });
  }

  void onPressedBuyer() {
    setState(() {
      formNumber = 2;
    });
  }

  void onPressedGetStarted1() {
    setState(() {
      page = 1;
    });
  }

  void onPressedGetStarted2() {
    Navigator.pushNamed(context, '/signin');
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreenStateInheritedWidget(
        formNumber: formNumber,
        onPressedBuyer: onPressedBuyer,
        onPressedVendor: onPressedVendor,
        child: Scaffold(
            appBar: PreferredSize(
                preferredSize: const Size(0.0, 15.0),
                child: AppBar(
                  backgroundColor: Splashvisuals.backGroundColorA,
                )),
            backgroundColor: Splashvisuals.backGroundColorA,
            body: _getStarterPages[page],
            floatingActionButton: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Container(
                width: 350.0,
                height: 56.0,
                margin: const EdgeInsets.only(
                    left: 20.0, right: 10.0, bottom: 20.0),
                child: FloatingActionButton(
                  onPressed:
                      page == 1 ? onPressedGetStarted2 : onPressedGetStarted1,
                  backgroundColor: Splashvisuals.boxDecorationColorA,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(25.0), // Adjust corner radius
                  ),
                  child: const Text(
                    "Get Started",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            )));
  }
}
