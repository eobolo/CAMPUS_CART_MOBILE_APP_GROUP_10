import 'package:flutter/material.dart';

class SplashStore extends StatefulWidget {
  const SplashStore({Key? key}) : super(key: key);

  @override
  _SplashStoreState createState() => _SplashStoreState();
}

class _SplashStoreState extends State<SplashStore> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('HEY'), // Your logo here
      ),
    );
  }
}
