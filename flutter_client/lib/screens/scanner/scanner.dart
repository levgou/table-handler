import 'package:flutter/material.dart';
import 'package:rest_in_peace/screens/scanner/widgets/qr_scanner.dart';
import 'package:rest_in_peace/screens/orderedItems/ordered_items.dart';

class Scanner extends StatefulWidget {
  Scanner();

  @override
  ScannerState createState() => new ScannerState();
}

class ScannerState extends State<Scanner> {
  ScannerState();

  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(5.0),
              height: 130.0,
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: ClipOval(
                      child: SizedBox(
                        height: 50.0,
                        width: 50.0,
                        child: Container(
                          color: Theme.of(context).primaryColor,
                          child: IconButton(
                            icon: Icon(Icons.close),
                            color: Theme.of(context).accentColor,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Please scan the code on your table',
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: QrScanner(_handleCode),
            ),
          ],
        ),
      ),
    );
  }

  _handleCode(code) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => OrderedItems(code)),
    );
  }
}
