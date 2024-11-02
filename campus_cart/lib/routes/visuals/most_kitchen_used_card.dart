import 'package:flutter/material.dart';
import 'package:campus_cart/routes/visuals/icons.dart';

class MostKitchenUsedCard extends StatelessWidget {
  final dynamic kitchen;
  const MostKitchenUsedCard({super.key, this.kitchen});

  bool _isKitchenOpen(String fromTime, String toTime) {
    // Parse the "to" time
    int kitchenToTime = int.tryParse(toTime) ?? 0;
    int kitchenFromTime = int.tryParse(fromTime) ?? 0;

    final currentHour = DateTime.now().hour;

    // Change kitchen closing time from 0 to 24
    if (kitchenToTime == 0) {
      if (currentHour >= 1 && currentHour < 13) {
        kitchenToTime = 0;
      } else if (currentHour == 0) {
        kitchenFromTime = 0;
      } else {
        kitchenToTime = 24;
      }
    }
    if ((currentHour >= kitchenFromTime) && (currentHour <= kitchenToTime)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        width: 250,
        height: 218,
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
            SizedBox(
              height: 160,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/images/store1.png',
                      height: 116.0,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 90,
                      left: 15.0,
                      height: 52.0,
                      width: 52.0,
                      child: Transform.translate(
                        offset: const Offset(10, -10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.elliptical(8, 8),
                            topRight: Radius.elliptical(8, 8),
                            bottomLeft: Radius.elliptical(8, 8),
                            bottomRight: Radius.elliptical(8, 8),
                          ), // Half of the width and height for a circular effect
                          child: kitchen["storeLogo"] != null
                              ? Image.network(
                                  "${kitchen["storeLogo"]}",
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  "assets/images/person.png",
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 3.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "${kitchen["vendorName"] ?? "N/A"}",
                          style: TextStyle(
                            color: Color(0xff202020),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'DM Sans',
                          ),
                        ),
                        const SizedBox(width: 15),
                        Container(
                          width: 47,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: const Color(0xffFFE4E4),
                          ),
                          child: Center(
                            child:
                                kitchen["from"] != null && kitchen["to"] != null
                                    ? Text(
                                        _isKitchenOpen("${kitchen["from"]}",
                                                "${kitchen["to"]}")
                                            ? 'Open'
                                            : 'Closed',
                                        style: TextStyle(
                                          color: _isKitchenOpen(
                                                  "${kitchen["from"]}",
                                                  "${kitchen["to"]}")
                                              ? Colors.green
                                              : Colors.red,
                                          fontSize: 12,
                                        ),
                                      )
                                    : Text("N/A"),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 5),
                    const Row(
                      children: [
                        Icon(
                          Icon2.bike,
                          color: Color(0xff606060),
                          size: 14,
                        ),
                        SizedBox(width: 2),
                        Text(
                          'Delivery will be made in 10-30 mins',
                          style: TextStyle(
                            color: Color(0xff606060),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'DM Sans',
                          ),
                        )
                      ],
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
