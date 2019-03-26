import 'package:flutter/material.dart';
import 'package:rest_in_peace/screens/homePage/landing_page/landing_page.dart';
import 'package:rest_in_peace/screens/homePage/scanner_page/scanner_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: PageView(scrollDirection: Axis.vertical, children: [
          LangingPage(),
          ScannerPage(),
        ]),
      ),
    );
  }
}
