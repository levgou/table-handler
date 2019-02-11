import 'package:flutter/material.dart';
import 'package:qr_mobile_vision/qr_camera.dart';

class QrScanner extends StatefulWidget {
  final Function(String code) _callback;
  QrScanner(this._callback);

  @override
  State<StatefulWidget> createState() => new QrScannerState(_callback);
}

class QrScannerState extends State<QrScanner> {
  final Function(String code) _callback;
  bool _isActive = true;

  QrScannerState(this._callback);

  @override
  Widget build(BuildContext context) {
    return _buildScanner(_callback, context);
  }

  _proccessCode(String code) {
    setState(() {
      _isActive = false;
    });
    _callback(code);
  }

  Widget _buildScanner(callback, context) {
    return Stack(
      children: [
        _isActive
            ? new QrCamera(
                notStartedBuilder: (context) {
                  return Container(
                    child: CircularProgressIndicator(),
                  );
                },
                qrCodeCallback: _proccessCode,
              )
            : Container(
                child: CircularProgressIndicator(),
              ),
        SizedBox.expand(
          child: Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/qr.png"),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
