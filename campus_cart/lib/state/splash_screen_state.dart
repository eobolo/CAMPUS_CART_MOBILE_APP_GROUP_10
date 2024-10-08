import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SplashScreenStateInheritedWidget extends InheritedWidget {
  final int formNumber;
  late void Function() onPressedVendor;
  late void Function() onPressedBuyer;

  SplashScreenStateInheritedWidget({
    super.key,
    required this.formNumber,
    required this.onPressedBuyer,
    required this.onPressedVendor,
    required super.child,
  });

  // Acess the SplashScreenStateInheritedWidget from the widget tree
  static SplashScreenStateInheritedWidget? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SplashScreenStateInheritedWidget>();
  }

  @override
  bool updateShouldNotify(SplashScreenStateInheritedWidget oldWidget) {
    // only notify dependent widgets if the formNumber changes
    return oldWidget.formNumber != formNumber;
  }
}
