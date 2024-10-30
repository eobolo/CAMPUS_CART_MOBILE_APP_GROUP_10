import 'package:flutter/material.dart';
import 'package:campus_cart/routes/visuals/icons.dart';


class MealDealProductCard extends StatelessWidget {

  MealDealProductCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        width: 235,
        decoration: BoxDecoration(
          color: const Color(0xffffffff),
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1A000000),
              spreadRadius: 1,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Stack(
                children: [
                  Image.asset(
                    "speciallyReservedImages[0]",
                    width: 235,
                    height: 116,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 5,
                    left: 8,
                    child: GestureDetector(
                      onTap: () {
                        // _incrementCounter();
                      },
                      child: Container(
                        width: 60,
                        height: 28,
                        decoration: BoxDecoration(
                            color: const Color(0xff202020),
                            borderRadius: BorderRadius.circular(16)),
                        child: const Center(
                          child: Text(
                            'Add +',
                            style: TextStyle(
                              color: Color(0xffffffff),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'DM Sans',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Mimi's Jollof Rice",
                    style: TextStyle(
                      color: Color(0xff202020),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'DM Sans',
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "What do you want to get?",
                    style: TextStyle(
                      color: Color(0xff606060),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'DM Sans',
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '2400 RWF',
                        style: TextStyle(
                          color: Color(0xff202020),
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'DM Sans',
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Row(
                          children: [
                            Icon(
                              Icon2.bike,
                              color: Color(0xff606060),
                              size: 12,
                            ),
                            SizedBox(
                              width: 1,
                            ),
                            Text(
                              '300RWF',
                              style: TextStyle(
                                color: Color(0xff606060),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'DM Sans',
                              ),
                            ),
                            SizedBox(width: 3),
                            Icon(
                              Iconify.time,
                              color: Color(0xff606060),
                              size: 12,
                            ),
                            SizedBox(
                              width: 1,
                            ),
                            Text(
                              '15 mins',
                              style: TextStyle(
                                color: Color(0xff606060),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'DM Sans',
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
