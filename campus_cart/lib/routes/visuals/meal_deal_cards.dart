import 'package:campus_cart/controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:campus_cart/routes/visuals/icons.dart';
import 'package:get/get.dart';

final CartController cartController = Get.find<CartController>();

class MealCard extends StatefulWidget {
  final String imagePath;
  final String mealName;
  final String kitchenName;
  final String phoneNumber;
  final String email;
  final String vendorId;
  final String buyerId;
  final String description;
  final String preparationTime;
  final int price;
  final int? mealId;
  final int? indexId;
  final int quantity;
  final String deliveryFee;
  final String deliveryTime;

  const MealCard({
    super.key,
    required this.imagePath,
    required this.mealName,
    required this.kitchenName,
    required this.phoneNumber,
    required this.email,
    required this.vendorId,
    required this.buyerId,
    required this.description,
    required this.preparationTime,
    required this.price,
    this.mealId,
    this.indexId,
    this.quantity = 0,
    required this.deliveryFee,
    required this.deliveryTime,
  });

  @override
  // ignore: library_private_types_in_public_api
  _MealCardState createState() => _MealCardState();
}

class _MealCardState extends State<MealCard> {
  void _incrementCartInallAspect() {
    Map<String, dynamic> addToCart = {
      "mealImage": widget.imagePath,
      "mealName": widget.mealName,
      "generalText": widget.description,
      "phoneNumber": widget.phoneNumber,
      "email": widget.email,
      "vendorId": widget.vendorId,
      "buyerId": widget.buyerId,
      "preparationTime": widget.preparationTime,
      "price": widget.price,
      "mealId": widget.mealId,
      "indexId": widget.indexId,
      "quantity": widget.quantity,
      "deliveryPrice": widget.deliveryFee,
    };
    // Add this item to the cart (assuming a method exists in cartController)
    cartController.updateMapOfItemsCount(addToCart);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 223,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: const Color(0xffffffff),
        ),
        child: InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (BuildContext context) => MealDetailModal(
                imagePath: widget.imagePath,
                mealName: widget.mealName,
                kitchenName: widget.kitchenName,
                description: widget.description,
                price: widget.price,
                quantity: widget.quantity,
                deliveryFee: widget.deliveryFee,
                deliveryTime: widget.deliveryTime,
                vendorId: widget.vendorId,
                buyerId: widget.buyerId,
                preparationTime: widget.preparationTime,
                phoneNumber: widget.phoneNumber,
                email: widget.email,
                mealId: widget.mealId,
                indexId: widget.indexId,
              ),
            );
          },
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
                      widget.imagePath,
                      height: 116,
                      width: double.infinity,
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
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 16, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.mealName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            fontFamily: 'DM Sans',
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 105,
                          height: 30,
                          decoration: BoxDecoration(
                            color: const Color(0xffF0F4F9),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              widget.kitchenName,
                              style: const TextStyle(
                                color: Color(0xff606060),
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'DM Sans',
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.description,
                      style: const TextStyle(
                        color: Color(0xff606060),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${widget.price}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(width: 5),
                            const Text(
                              'RWF',
                              style: TextStyle(
                                color: Color(0xff606060),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icon2.bike,
                              size: 14,
                              color: Color(0xff606060),
                            ),
                            const SizedBox(width: 3),
                            Text(
                              widget.deliveryFee,
                              style: const TextStyle(
                                color: Color(0xff606060),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Iconify.time,
                              size: 14,
                              color: Color(0xff606060),
                            ),
                            const SizedBox(width: 3),
                            Text(
                              widget.deliveryTime,
                              style: const TextStyle(
                                color: Color(0xff606060),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MealDetailModal extends StatefulWidget {
  final String imagePath;
  final String mealName;
  final String kitchenName;
  final String phoneNumber;
  final String email;
  final String vendorId;
  final String buyerId;
  final String description;
  final String preparationTime;
  final int price;
  final int? mealId;
  final int? indexId;
  final int quantity;
  final String deliveryFee;
  final String deliveryTime;

  const MealDetailModal({
    super.key,
    required this.imagePath,
    required this.mealName,
    required this.kitchenName,
    required this.phoneNumber,
    required this.email,
    required this.vendorId,
    required this.buyerId,
    required this.description,
    required this.preparationTime,
    required this.price,
    this.mealId,
    this.indexId,
    this.quantity = 0,
    required this.deliveryFee,
    required this.deliveryTime,
  });

  @override
  // ignore: library_private_types_in_public_api
  _MealDetailModalState createState() => _MealDetailModalState();
}

class _MealDetailModalState extends State<MealDetailModal> {
  int currentQuantity = 0;

  @override
  void initState() {
    super.initState();
    currentQuantity = widget.quantity;
  }

  void _decreaseCartItemQuantity() {
    Map<String, dynamic> addToCart = {
      "mealImage": widget.imagePath,
      "mealName": widget.mealName,
      "generalText": widget.description,
      "phoneNumber": widget.phoneNumber,
      "email": widget.email,
      "vendorId": widget.vendorId,
      "buyerId": widget.buyerId,
      "preparationTime": widget.preparationTime,
      "price": widget.price,
      "mealId": widget.mealId,
      "indexId": widget.indexId,
      "quantity": widget.quantity,
      "deliveryPrice": widget.deliveryFee,
    };
    cartController.decreaseMapOfItemsCount(addToCart);
    if (currentQuantity == 0) {
      return;
    } else {
      setState(() {
        currentQuantity--;
      });
    }
  }

  void _increaseCartItemQuantity() {
    Map<String, dynamic> addToCart = {
      "mealImage": widget.imagePath,
      "mealName": widget.mealName,
      "generalText": widget.description,
      "phoneNumber": widget.phoneNumber,
      "email": widget.email,
      "vendorId": widget.vendorId,
      "buyerId": widget.buyerId,
      "preparationTime": widget.preparationTime,
      "price": widget.price,
      "mealId": widget.mealId,
      "indexId": widget.indexId,
      "quantity": widget.quantity,
      "deliveryPrice": widget.deliveryFee,
    };
    cartController.increaseMapOfItemsCount(addToCart);

    setState(() {
      currentQuantity++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.transparent,
      height: 466,
      width: 394,
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
        borderRadius: BorderRadius.circular(60),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(29),
              topRight: Radius.circular(29),
            ),
            child: Image.network(
              widget.imagePath,
              height: 248,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 16, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      widget.mealName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        fontFamily: 'DM Sans',
                        letterSpacing: 0.5,
                        color: Color(0xff202020),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 105,
                      height: 30,
                      decoration: BoxDecoration(
                        color: const Color(0xffF0F4F9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          widget.kitchenName,
                          style: const TextStyle(
                            color: Color(0xff606060),
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'DM Sans',
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  widget.description,
                  style: const TextStyle(
                    color: Color(0xff606060),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.5,
                    fontFamily: 'DM Sans',
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${widget.price}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            letterSpacing: 0.5,
                            color: Color(0xff202020),
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          'RWF',
                          style: TextStyle(
                            color: Color(0xff606060),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icon2.bike,
                          size: 16,
                          color: Color(0xff606060),
                        ),
                        const SizedBox(width: 3),
                        Text(
                          widget.deliveryFee,
                          style: const TextStyle(
                            color: Color(0xff606060),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Iconify.time,
                          size: 16,
                          color: Color(0xff606060),
                        ),
                        const SizedBox(width: 3),
                        Text(
                          widget.deliveryTime,
                          style: const TextStyle(
                            color: Color(0xff606060),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    const SizedBox(width: 15),
                    Container(
                      height: 48,
                      width: 117,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80),
                        border: Border.all(
                          color: const Color(0xffF5C147),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: _increaseCartItemQuantity,
                              icon: const Icon(
                                Icons.add,
                                color: Color(0xff202020),
                              ),
                              constraints: const BoxConstraints(),
                              padding: EdgeInsets.zero,
                            ),
                            Flexible(
                              child: Center(
                                child: Text(
                                  '$currentQuantity',
                                  style: const TextStyle(
                                    color: Color(0xff202020),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: _decreaseCartItemQuantity,
                              icon: const Icon(
                                Icons.remove,
                                color: Color(0xff202020),
                              ),
                              constraints: const BoxConstraints(),
                              padding: EdgeInsets.zero,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/orders');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff202020),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80),
                        ),
                        minimumSize: const Size(197, 48),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Checkout for ${widget.price * currentQuantity + 300}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.8,
                            ),
                          ),
                          const Text(
                            'RWF',
                            style: TextStyle(
                              color: Color(0xffB8B8B8),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
