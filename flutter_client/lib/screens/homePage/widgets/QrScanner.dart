import 'package:flutter/material.dart';
import 'package:qr_mobile_vision/qr_camera.dart';

class QrScanner extends StatelessWidget {
  final Function(String code) _callback;
  QrScanner(this._callback);

  @override
  Widget build(BuildContext context) {
    return _buildScanner(_callback, context);
  }

  Widget _buildScanner(callback, context) {
    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height - 270.0,
          child: Container(
            child: new QrCamera(
              qrCodeCallback: callback,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height - 270.0,
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
