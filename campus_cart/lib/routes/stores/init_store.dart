import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';

class InitStore extends StatelessWidget {
  const InitStore({super.key});

  void _setUpStore(BuildContext context) {
    Navigator.pushNamed(context, '/setup_store');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: <Color>[
              Color(0xfff6c85b),
              Color(0xffffffff),
            ],
            begin: Alignment.topCenter,
            end: Alignment.center,
          )),
        ),
        SingleChildScrollView(
            child: Column(
          children: <Widget>[
            const SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  border: Border.all(
                    color: const Color(0xffffffff),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/store.png',
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 20),
                          Image.asset(
                            'assets/images/lepra.png',
                          ),
                          const SizedBox(height: 20),
                          const Dash(
                            direction: Axis.horizontal,
                            length: 260,
                            dashLength: 7,
                            dashColor: Color(0xffE5E5E5),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Are You a Food Vendor?',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff202020),
                              fontFamily: 'DM Sans',
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            child: Text(
                              'Campuscart takes your restaurant to the next level. Setting up your store on is easy, simply create an account, add your menu items, and start accepting orders.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff606060),
                                fontFamily: 'DM Sans',
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: () => _setUpStore(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff202020),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 100, vertical: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(80),
                              ),
                            ),
                            child: const Text(
                              '⚡ Set up store',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xffffffff),
                                fontFamily: 'DM Sans',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ))
      ]),
    );
  }
}
