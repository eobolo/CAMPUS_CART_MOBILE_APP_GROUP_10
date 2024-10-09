import 'package:campus_cart/routes/home/stackposition_2.dart';
import 'package:campus_cart/routes/state/splash_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:campus_cart/routes/visuals/splashvisuals.dart';

class Starterpage2 extends StatefulWidget {
  const Starterpage2({super.key});

  @override
  State<Starterpage2> createState() => _Starterpage2State();
}

class _Starterpage2State extends State<Starterpage2> {
  @override
  Widget build(BuildContext context) {
    final splashScreenInherited = SplashScreenStateInheritedWidget.of(context);
    Text? displayInfo;

    switch (splashScreenInherited?.formNumber) {
      case 1:
        displayInfo = const Text(
          "As a vendor, you don't need another app to\nmanage your kitchen. Campus cart allows you to\ncreate and manage vendor profile in-app.",
          style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontFamily: "DM Sans"),
        );
        break;
      case 2:
        displayInfo = const Text(
          "As a buyer you don't need another app to\nto look for your favourite dish campus cart\nallows you to order different kinds of dishes\nfrom vendors on your campus, and even become\none.",
          style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontFamily: "DM Sans"),
        );
        break;
      default:
        displayInfo = const Text(
          "As a buyer you don't need another app to\nto look for your favourite dish campus cart\nallows you to order different kinds of dishes\nfrom vendors on your campus, and even become\none.",
          style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontFamily: "DM Sans"),
        );
    }

    return Container(
      decoration: BoxDecoration(
        color: Splashvisuals.backGroundColorA,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 35.0,
                width: 154.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                        width: 28.0,
                        height: 28.0,
                        margin: const EdgeInsets.only(
                          right: 3.0,
                        ),
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/bag-happy.png")))),
                    Text(
                      "Campus Cart",
                      style: Splashvisuals.textStyle(
                        18.0,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 35.0,
                width: 56.18,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3.0),
                      width: 18.0,
                      height: 18.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Splashvisuals.boxDecorationColorB,
                      ),
                      child: Container(
                        width: 16.0,
                        height: 16.0,
                        decoration: BoxDecoration(
                          color: Splashvisuals.boxDecorationColorA,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Container(
                      width: 8.18,
                      height: 3.5,
                      color: Splashvisuals.boxDecorationColorD,
                    ),
                    Container(
                      padding: const EdgeInsets.all(3.0),
                      width: 18.0,
                      height: 18.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Splashvisuals.boxDecorationColorB,
                      ),
                      child: Container(
                        width: 16.0,
                        height: 16.0,
                        decoration: BoxDecoration(
                          color: Splashvisuals.boxDecorationColorA,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 30.0,
          ),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                color: Splashvisuals.boxDecorationColorE,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(35.0),
                  topRight: Radius.circular(35.0),
                )),
            child: Column(children: [
              const SizedBox(
                height: 375.0,
                child: Stackposition2(),
              ),
              Container(
                width: 327.0,
                height: 115.0,
                margin: const EdgeInsets.only(
                  left: 15.0,
                  top: 40.0,
                ),
                child: const Text(
                  "Create and Manage All\nYour Profile one One App.",
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'DM Sans',
                  ),
                ),
              ),
              Container(
                width: 350.0,
                height: 100.0,
                margin: const EdgeInsets.only(
                  left: 15.0,
                  top: 15.0,
                  bottom: 15.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      color: Splashvisuals.boxDecorationColorA,
                      height: 70.0,
                      width: 2.0,
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 10.0,
                      ),
                      height: 63.0,
                      width: 327.0,
                      child: displayInfo,
                    ),
                  ],
                ),
              ),
            ]),
          )),
        ],
      ),
    );
  }
}
