import 'package:flutter/material.dart';

class Getstartedpage extends StatefulWidget {
  const Getstartedpage({super.key});

  @override
  State<Getstartedpage> createState() => _GetstartedpageState();
}

class _GetstartedpageState extends State<Getstartedpage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("The second Page"),
      ),
    );
  }
}
