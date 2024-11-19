import 'package:campus_cart/routes/state/splash_screen_state.dart';
import 'package:campus_cart/routes/visuals/splashvisuals.dart';
import 'package:flutter/material.dart';

class Stackposition2 extends StatelessWidget {
  const Stackposition2({super.key});

  @override
  Widget build(BuildContext context) {
    final splashScreenInherited = SplashScreenStateInheritedWidget.of(context);
    Color vendorButton = splashScreenInherited?.formNumber == 1
        ? Splashvisuals.boxDecorationColorB
        : Splashvisuals.boxDecorationColorA;
    Color vendorText = splashScreenInherited?.formNumber == 1
        ? Splashvisuals.textColor
        : Splashvisuals.backGroundColorA;
    Color buyerButton = splashScreenInherited?.formNumber == 2
        ? Splashvisuals.boxDecorationColorB
        : Splashvisuals.boxDecorationColorA;
    Color buyerText = splashScreenInherited?.formNumber == 2
        ? Splashvisuals.textColor
        : Splashvisuals.backGroundColorA;

    return Stack(
      children: [
        Positioned(
            left: 20.0,
            top: 55.0,
            height: 75.0,
            child: Container(
              width: 74.86,
              height: 64.0,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/images/image_9.png"),
                fit: BoxFit.cover,
              )),
            )),
        Positioned(
            left: 170.0,
            top: 40.0,
            child: Container(
              width: 64.92,
              height: 62.0,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/images/image_5.png"),
                fit: BoxFit.cover,
              )),
            )),
        Positioned(
            left: 320.0,
            top: 55.0,
            height: 80.0,
            child: Transform.rotate(
              angle: 1.3,
              child: Container(
                width: 64.92,
                height: 62.0,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("assets/images/image_22.png"),
                  fit: BoxFit.cover,
                )),
              ),
            )),
        Positioned(
            left: 320.0,
            top: 55.0,
            height: 80.0,
            child: Transform.rotate(
              angle: 0.7,
              child: Container(
                width: 64.92,
                height: 62.0,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("assets/images/image_22.png"),
                  fit: BoxFit.cover,
                )),
              ),
            )),
        Positioned(
            left: 320.0,
            top: 55.0,
            height: 80.0,
            child: Container(
              width: 64.92,
              height: 62.0,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/images/image_22.png"),
                fit: BoxFit.cover,
              )),
            )),
        Positioned(
            left: 30.0,
            top: 180.0,
            child: SizedBox(
              height: 160.0,
              width: 138.0,
              child: Stack(
                children: [
                  Container(
                    width: 138.0,
                    height: 138.0,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/image_0.png"))),
                  ),
                  Positioned(
                    left: 20.0,
                    top: 100.0,
                    child: SizedBox(
                      width: 100.0,
                      height: 60.0,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                            backgroundColor: vendorButton),
                        onPressed: splashScreenInherited?.onPressedVendor,
                        child: Text(
                          "Vendor",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: vendorText,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )),
        Positioned(
            left: 250.0,
            top: 180.0,
            child: SizedBox(
              height: 160.0,
              width: 138.0,
              child: Stack(
                children: [
                  Container(
                    width: 138.0,
                    height: 138.0,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/image_1.png"))),
                  ),
                  Positioned(
                    left: 25.0,
                    top: 100.0,
                    child: SizedBox(
                      width: 100.0,
                      height: 60.0,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                            backgroundColor: buyerButton),
                        onPressed: splashScreenInherited?.onPressedBuyer,
                        child: Text(
                          "Buyer",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: buyerText,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )),
        Positioned(
            left: 195.0,
            top: 230.0,
            child: Container(
              width: 30.0,
              height: 30.0,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/images/black_bag_happy.png"),
                fit: BoxFit.cover,
              )),
            )),
      ],
    );
  }
}
