import 'package:flutter/material.dart';
import 'package:rest_in_peace/utils/custom_icons.dart';

class ScanButton extends StatelessWidget {
  final Function() _callback;
  ScanButton(this._callback);

  @override
  Widget build(BuildContext context) {
    return _buildScanButton(_callback, context);
  }

  Widget _buildScanButton(callback, context) {
    return Container(
      height: 115.0,
      child: Column(
        children: [
          Text(
            'Scan QR',
            style: Theme.of(context).accentTextTheme.button,
          ),
          Icon(CustomIcons.keyboard_arrow_down,
              size: 35.0, color: Theme.of(context).accentColor),
          ClipOval(
            child: SizedBox(
              height: 55.0,
              width: 55.0,
              child: Container(
                color: Theme.of(context).accentColor,
                child: IconButton(
                  icon: Icon(CustomIcons.qrcode),
                  iconSize: 30.0,
                  color: Theme.of(context).primaryColor,
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
