import 'package:flutter/material.dart';
import 'package:rest_in_peace/screens/homePage/widgets/QrScanner.dart';
import 'package:rest_in_peace/screens/orderedItems/ordered_items.dart';

class ScannerScreen extends StatefulWidget {
  ScannerScreen();

  @override
  ScannerScreenState createState() => new ScannerScreenState();
}

class ScannerScreenState extends State<ScannerScreen> {
  ScannerScreenState();

  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: SizedBox.expand(
          child: Hero(
            tag: 'scannerBox',
            child: QrScanner(_handleCode),
          ),
        ),
      ),
    );
  }

  _handleCode(code) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OrderedItems(code)),
    );
  }
}
