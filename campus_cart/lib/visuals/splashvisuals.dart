import 'package:flutter/material.dart';

class Splashvisuals {
  static Color textColor = const Color(0xFF000000);
  static Color backGroundColorA = const Color.fromARGB(255, 255, 255, 255);
  static Color boxDecorationColorA = const Color.fromARGB(255, 5, 5, 5);
  static Color boxDecorationColorB = const Color.fromARGB(255, 219, 173, 64);
  static Color boxDecorationColorC = const Color(0xFFD9D9D9);
  static Color boxDecorationColorD = const Color.fromARGB(255, 109, 108, 108);
  static Color boxDecorationColorE = const Color(0xFFCBCBFD);

  static TextStyle textStyle(double userFontSize,
      {String useFontFamily = "Recoleta"}) {
    return TextStyle(
      color: textColor,
      fontSize: userFontSize,
      fontWeight: FontWeight.w700,
      fontFamily: useFontFamily,
    );
  }
}
