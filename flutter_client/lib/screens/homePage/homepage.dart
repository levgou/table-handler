import 'package:flutter/material.dart';
import 'package:rest_in_peace/screens/scanner/scanner.dart';
import 'package:rest_in_peace/screens/homePage/widgets/scan_button.dart';
import 'package:rest_in_peace/screens/homePage/widgets/title_bar.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            TitleBar(),
            Expanded(
              child: Container(
                color: Theme.of(context).backgroundColor,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ScanButton(_scanButtonHandler),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _scanButtonHandler() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Scanner()),
    );
  }
}
