import 'package:flutter/material.dart';
import 'package:qr_mobile_vision/qr_camera.dart';
import 'package:rest_in_peace/screens/ordered_items.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  bool isScanning = true;
  String scannedCode = "";

  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox.expand(
            child: Container(
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                      image: new AssetImage("assets/background.jpg"),
                      fit: BoxFit.cover,
                      colorFilter: new ColorFilter.mode(
                          Colors.red.withOpacity(0.8), BlendMode.color)),
                ),
                child: Column(children: [
                  Icon(Icons.local_bar),
                  Text('Scan the QR on your table',
                      style: Theme.of(context).textTheme.subtitle),
                  isScanning
                      ? Container(
                        width: 300,
                        height: 300,
                          child: new QrCamera(
                              qrCodeCallback: (code) => _handleCode(code)))
                      // IconButton(
                      //     icon: Icon(Icons.code),
                      //     onPressed: () => _handleCode('some-uuid')))
                      : Expanded(child: Text(scannedCode))
                ]))));
  }

  _handleCode(code) {
    setState(() {
      isScanning = false;
      scannedCode = code;
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OrderedItems(code)),
    );
  }
}
