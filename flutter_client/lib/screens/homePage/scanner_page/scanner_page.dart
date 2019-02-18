import 'package:flutter/material.dart';
import 'package:qr_mobile_vision/qr_camera.dart';
import 'package:rest_in_peace/screens/orderedItems/ordered_items.dart';
import 'package:rest_in_peace/utils/colors.dart';

class ScannerPage extends StatefulWidget {
  ScannerPage();

  @override
  ScannerPageState createState() => new ScannerPageState();
}

class ScannerPageState extends State<ScannerPage> {
  ScannerPageState();

  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final headerHeight = 110.0;
    final cameraZoneSize = MediaQuery.of(context).size.width;
    final baseBorderWidth = 30.0;
    final verticalBordersWidth =
        (MediaQuery.of(context).size.height - headerHeight - cameraZoneSize) /
                2 +
            baseBorderWidth;
    final borderColor = PieceColors.backDrop;

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(5.0),
          height: headerHeight,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: SizedBox(
                  height: 55.0,
                  width: 55.0,
                  child: Container(
                    color: Theme.of(context).primaryColor,
                    child: IconButton(
                      iconSize: 30.0,
                      icon: Icon(Icons.close),
                      color: Theme.of(context).accentColor,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 10.0,
                    ),
                    child: Text(
                      'Please scan the code on your table',
                      style: Theme.of(context).accentTextTheme.subtitle,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              QrCamera(
                notStartedBuilder: (context) {
                  return Container(
                    child: SizedBox.expand(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                },
                qrCodeCallback: _proccessCode,
              ),
              SizedBox.expand(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: borderColor,
                        width: baseBorderWidth,
                      ),
                      right: BorderSide(
                        color: borderColor,
                        width: baseBorderWidth,
                      ),
                      top: BorderSide(
                        color: borderColor,
                        width: verticalBordersWidth,
                      ),
                      bottom: BorderSide(
                        color: borderColor,
                        width: verticalBordersWidth,
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: cameraZoneSize - (2 * baseBorderWidth),
                  height: cameraZoneSize - (2 * baseBorderWidth) - 20.0,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 5.0,
                      color: PieceColors.transperentTeal,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _proccessCode(String code) {
    setState(() {
      // _isActive = false;
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => OrderedItems(code)),
    );
  }
}
