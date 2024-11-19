import 'package:flutter/material.dart';
import 'package:campus_cart/routes/visuals/icons.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String? price;
  final String? imageUrl;
  final bool isCreateNew;

  const ProductCard({
    super.key,
    required this.title,
    this.price,
    this.imageUrl,
    this.isCreateNew = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isCreateNew) {
      return Container(
        decoration: BoxDecoration(
          color: const Color(0xff202020),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            const Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Image(
                      image: AssetImage('assets/images/notepad.png'),
                      height: 24,
                      width: 24),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, bottom: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Create New Menu',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xffffffff),
                          fontFamily: 'DM Sans',
                        ),
                      ),
                      Icon(
                        Icons.more_horiz,
                        size: 20,
                        color: Color(0xffffffff),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 10,
              right: 12,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/create_menu');
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xffF5C147),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'ADD',
                        style: TextStyle(
                          color: Color(0xff202020),
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'DM Sans',
                        ),
                      ),
                      Icon(
                        Iconify.add,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 1,
                blurRadius: 7,
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
                child: Image.asset(
                  imageUrl ?? '',
                  fit: BoxFit.cover,
                  height: 120,
                  width: double.infinity,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff202020),
                        fontFamily: 'DM Sans',
                      ),
                    ),
                    const SizedBox(height: 3),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => _buildMealDetailsModal(context),
                        );
                      },
                      child: const Text(
                        "View more details",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Color(0xffD49400),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Price Badge
        if (price != null)
          Positioned(
            top: 10,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xff202020),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white),
              ),
              child: Text(
                price!,
                style: const TextStyle(
                  color: Color(0xffffffff),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'DM Sans',
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildMealDetailsModal(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: 405,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(9),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                    child: Image.asset(
                      imageUrl ?? '',
                      fit: BoxFit.fill,
                      height: 248,
                      width: double.infinity,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff202020),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Fluffy jasmine rice stir-fried with your choice of protein, vegetables, and soy sauce, served with a fried egg and sweet chili sauce.",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff606060),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              price ?? 'N/A',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Row(
                              children: [
                                Icon(Iconify.time, size: 16),
                                SizedBox(width: 4),
                                Text(
                                  "15 mins",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff606060),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/edit_menu');
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 60),
                        backgroundColor: const Color(0xff202020),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 100),
                      ),
                      child: const Text(
                        "Edit Meal Details",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 350,
          right: 16,
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ],
    );
  }
}
