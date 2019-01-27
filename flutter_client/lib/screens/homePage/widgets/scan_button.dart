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
      height: 130.0,
      padding: EdgeInsets.symmetric(vertical: 15.0),
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
          ClipOval(
            child: SizedBox(
              height: 50.0,
              width: 50.0,
              child: Container(
                color: Theme.of(context).primaryColor,
                child: IconButton(
                  icon: Icon(CustomIcons.qrcode),
                  color: Theme.of(context).accentColor,
                  onPressed: () => callback(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
