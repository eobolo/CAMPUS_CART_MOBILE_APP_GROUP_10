import 'package:flutter/material.dart';
import 'package:campus_cart/routes/visuals/icons.dart';

class KitchenCard extends StatelessWidget {
  final String imagePath;
  final String kitchenName;
  final String deliveryTime;
  final String status;
  final String profileImagePath;

  const KitchenCard({
    super.key,
    required this.imagePath,
    required this.kitchenName,
    required this.deliveryTime,
    required this.status,
    required this.profileImagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 179,
        decoration: BoxDecoration(
          color: const Color(0xffffffff),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: Image.asset(
                    imagePath,
                    height: 86,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 60,
                  left: 20,
                  child: Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        profileImagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        kitchenName,
                        style: const TextStyle(
                          color: Color(0xff202020),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'DM Sans',
                        ),
                      ),
                      const SizedBox(width: 5),
                      Container(
                        width: 47,
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: status == 'Open'
                              ? const Color(0xffE6FFAA)
                              : const Color(0xffFFE4E4),
                        ),
                        child: Center(
                          child: Text(
                            status,
                            style: TextStyle(
                              color: status == 'Open'
                                  ? const Color(0xff125F17)
                                  : const Color(0xffFF5A5A),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'DM Sans',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(height: 5/),
                  Row(
                    children: [
                      const Icon(
                        Icon2.bike,
                        color: Color(0xff606060),
                        size: 14,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        deliveryTime,
                        style: const TextStyle(
                          color: Color(0xff606060),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'DM Sans',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
