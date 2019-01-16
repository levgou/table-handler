import 'package:flutter/material.dart';
import 'package:rest_in_peace/models/TableSession.dart';
import 'package:rest_in_peace/utils/format.dart';

class SummeryBar extends StatelessWidget {
  final TableSession _table;
  final Function() _checkoutClicked;
  final bool _isCartOpen;

  SummeryBar(this._table, this._isCartOpen, this._checkoutClicked);

  @override
  Widget build(BuildContext context) {
    return _buildSummery(_table, context);
  }

  Widget _buildSummery(TableSession table, context) {
    return SizedBox(
        height: 50.0,
        child: Container(
            color: Theme.of(context).primaryColorDark,
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(children: [
              this._isCartOpen
                  ? Expanded(
                      child: IconButton(
                          icon: const Icon(Icons.payment),
                          color: Colors.white,
                          onPressed: _checkoutClicked))
                  : Container(),
              Expanded(
                  child: Center(
                      child: Text(formatPrice(table.userTotalCartPrice),
                          style: Theme.of(context).textTheme.title)))
            ])));
  }
}
