import 'package:flutter/material.dart';

class Stackposition extends StatelessWidget {
  const Stackposition({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 40.0,
          child: Container(
            width: 190.0,
            height: 250.35,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/image_19.png"),
                  fit: BoxFit.cover),
            ),
          ),
        ),
        Positioned(
          left: 20.0,
          child: Container(
            width: 200.0,
            height: 160.35,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/image_14.png"),
                  fit: BoxFit.cover),
            ),
          ),
        ),
        Positioned(
          left: 60.0,
          child: Container(
            width: 200.0,
            height: 200.35,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/image_14.png"),
                  fit: BoxFit.cover),
            ),
          ),
        ),
        Positioned(
          left: 100.0,
          child: Container(
            width: 200.0,
            height: 165.35,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/image_14.png"),
                  fit: BoxFit.cover),
            ),
          ),
        ),
        Positioned(
          left: 110.0,
          child: Container(
            width: 250.0,
            height: 250.35,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/image_18.png"),
                  fit: BoxFit.cover),
            ),
          ),
        ),
        Positioned(
          left: 80.0,
          child: Container(
            width: 130.0,
            height: 110.35,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/image_16.png"),
                  fit: BoxFit.cover),
            ),
          ),
        ),
        Positioned(
          top: 30.0,
          left: 140.0,
          child: Container(
            width: 130.0,
            height: 110.35,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/image_16.png"),
                  fit: BoxFit.cover),
            ),
          ),
        ),
        Positioned(
          top: 90.0,
          left: 80.0,
          child: Container(
            width: 130.0,
            height: 110.35,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/image_16.png"),
                  fit: BoxFit.cover),
            ),
          ),
        ),
        Positioned(
          top: 90.0,
          left: 140.0,
          child: Container(
            width: 130.0,
            height: 110.35,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/image_16.png"),
                  fit: BoxFit.cover),
            ),
          ),
        ),
        Positioned(
          top: 185.0,
          left: 10.0,
          child: Container(
            width: 400.0,
            height: 190.35,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/image_10.png"),
                  fit: BoxFit.cover),
            ),
          ),
        ),
        Positioned(
          left: 320.0,
          top: 40.0,
          child: Container(
            width: 30.0,
            height: 30.0,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/bag_happy.png"),
                  fit: BoxFit.cover),
            ),
          ),
        ),
        Positioned(
          top: 110.0,
          left: 10.0,
          child: Container(
            width: 35.0,
            height: 35.0,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/bag_happy_1.png"),
                  fit: BoxFit.cover),
            ),
          ),
        ),
        Positioned(
          top: 170.0,
          left: 350.0,
          child: Container(
            width: 35.0,
            height: 35.0,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/bag_happy_2.png"),
                  fit: BoxFit.cover),
            ),
          ),
        ),
      ],
    );
  }
}
