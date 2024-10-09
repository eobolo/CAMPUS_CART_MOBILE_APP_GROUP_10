import 'package:campus_cart/routes/visuals/splashvisuals.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Splashvisuals.backGroundColorA,
        body: Center(
          widthFactor: 243.0,
          heightFactor: 44.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40.0,
                height: 40.0,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/bag-happy.png"))),
              ),
              const SizedBox(
                width: 8.0,
                height: 40.0,
              ),
              Text("Campus Cart",
                  style: Splashvisuals.textStyle(
                    32.0,
                  ))
            ],
          ),
        ));
  }
}
