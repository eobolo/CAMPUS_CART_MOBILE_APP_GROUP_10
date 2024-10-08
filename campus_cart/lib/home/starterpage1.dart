import 'package:flutter/material.dart';
import 'package:campus_cart/home/stackposition_1.dart';
import 'package:campus_cart/visuals/splashvisuals.dart';

class Starterpage1 extends StatelessWidget {
  const Starterpage1({super.key});

  @override
  Widget build(BuildContext context) {
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
                      width: 18.0,
                      height: 18.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Splashvisuals.boxDecorationColorC,
                      ),
                    )
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
                  color: Splashvisuals.boxDecorationColorB,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(35.0),
                    topRight: Radius.circular(35.0),
                  )),
              child: Column(
                children: [
                  const SizedBox(
                    height: 375.0,
                    child: Stackposition(),
                  ),
                  Container(
                    width: 327.0,
                    height: 115.0,
                    margin: const EdgeInsets.only(
                      left: 15.0,
                      top: 40.0,
                    ),
                    child: const Text(
                      "We Bring Your Favorite\nDishes to you, all on\nYour Campus.",
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
                          child: const Text(
                            "With our user-friendly food ordering app, you will\nenjoy the ultimate convenience by getting all\nkinds of dishes from vendors on your campus.",
                            style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                fontFamily: "DM Sans"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
