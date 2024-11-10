import 'package:campus_cart/controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:campus_cart/routes/visuals/icons.dart';
import 'package:get/get.dart';

class MealDealProductCard extends StatelessWidget {
  // instance variables
  final String mealImage;
  final String mealName;
  final String generalText;
  final String phoneNumber;
  final String email;
  final String vendorId;
  final String buyerId;
  final int preparationTime;
  final int price;
  final int? mealId;
  final int? indexId;
  final int quantity;
  final int? deliveryPrice;

  // controller variable
  final CartController cartController = Get.find<CartController>();

  MealDealProductCard({
    super.key,
    this.mealImage = "",
    this.mealName = "",
    this.generalText = "What do you want to get?",
    this.phoneNumber = "",
    this.email = "",
    this.vendorId = "",
    this.buyerId = "",
    this.preparationTime = 0,
    this.price = 0,
    this.mealId,
    this.indexId,
    this.quantity = 0,
    this.deliveryPrice,
  });

  void _incrementCartInallAspect() {
    Map<String, dynamic> addToCart = {
      "mealImage": mealImage,
      "mealName": mealName,
      "generalText": "campus cart",
      "phoneNumber": phoneNumber,
      "email": email,
      "vendorId": vendorId,
      "buyerId": buyerId,
      "preparationTime": preparationTime,
      "price": price,
      "mealId": mealId,
      "indexId": indexId,
      "quantity": quantity,
      "deliveryPrice": deliveryPrice,
    };
    cartController.updateMapOfItemsCount(addToCart);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        width: 250,
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
                  Image.network(
                    mealImage,
                    width: 250,
                    height: 116,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 5,
                    right: 8,
                    child: GestureDetector(
                      onTap: _incrementCartInallAspect,
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
            Padding(
              padding: EdgeInsets.only(left: 7.5, top: 10, right: 7.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mealName,
                    style: TextStyle(
                      color: Color(0xff202020),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'DM Sans',
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    generalText,
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
                        '$price RWF',
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
                              '$deliveryPrice RWF',
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
                            ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: 30.0),
                              child: Text(
                                '$preparationTime mins',
                                overflow: TextOverflow
                                    .ellipsis, // Adds "..." if text overflows
                                maxLines: 1,
                                style: TextStyle(
                                  color: Color(0xff606060),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'DM Sans',
                                ),
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
