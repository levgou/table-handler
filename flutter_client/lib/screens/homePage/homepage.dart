import 'package:flutter/material.dart';
import 'package:rest_in_peace/screens/homePage/scannerScreen/scannerScreen.dart';
import 'package:rest_in_peace/screens/homePage/widgets/QRScanner.dart';
import 'package:rest_in_peace/screens/homePage/widgets/ScanButton.dart';
import 'package:rest_in_peace/screens/homePage/widgets/TitleBar.dart';
import 'package:rest_in_peace/screens/orderedItems/ordered_items.dart';
import 'package:rest_in_peace/widgets/ExpandedSection.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  String scannedCode = "";

  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(children: [
          Expanded(child: TitleBar()),
          Expanded(
            child: ScanButton(_scanButtonHandler),
          ),
        ]),
      ),
    );
  }

  _scanButtonHandler() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ScannerScreen()),
    );
  }
}
