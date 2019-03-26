import 'package:flutter/material.dart';
import 'package:rest_in_peace/screens/homePage/landing_page/widgets/scan_button.dart';

class LangingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 20.0,
      ),
      child: Column(
        children: [
          Container(
            height: 50.0,
            child: Row(
              children: [
                Icon(
                  Icons.nfc,
                  size: 40.0,
                  color: Theme.of(context).accentColor,
                ),
                Spacer(),
                Icon(
                  Icons.person,
                  size: 40.0,
                  color: Theme.of(context).accentColor,
                ),
              ],
            ),
          ),
          Container(
            height: 260.0,
            width: 230.0,
            padding: EdgeInsets.only(bottom: 20.0, top: 10.0),
            child: Image.asset('assets/Logo.png', fit: BoxFit.scaleDown),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              'Rest In Piece',
              style: Theme.of(context).accentTextTheme.title,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              'Pay your share quick and easy',
              style: Theme.of(context).accentTextTheme.subtitle,
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ScanButton(() {}),
            ),
          ),
        ],
      ),
    );
  }
}
