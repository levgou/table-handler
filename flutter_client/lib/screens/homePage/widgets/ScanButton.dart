import 'package:flutter/material.dart';
import 'package:rest_in_peace/utils/custom_icons.dart';

class ScanButton extends StatelessWidget {
  Function() _callback;
  ScanButton(this._callback);

  @override
  Widget build(BuildContext context) {
    return _buildScanButton(_callback, context);
  }

  Widget _buildScanButton(callback, context) {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).accentColor,
      child: Column(
        children: [
          Text(
            'Scan QR',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
          Icon(CustomIcons.keyboard_arrow_down,
              color: Theme.of(context).primaryColor),
          Hero(
            tag: 'scannerBox',
            child: ClipOval(
              child: SizedBox(
                height: 50.0,
                width: 50.0,
                child: Container(
                  color: Theme.of(context).primaryColor,
                  child: IconButton(
                    icon: Icon(CustomIcons.qrcode),
                    color: Color(0xFFF5F5FA),
                    onPressed: () => callback(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
