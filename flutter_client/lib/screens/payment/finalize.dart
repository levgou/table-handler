import 'package:flutter/material.dart';
import 'package:rest_in_peace/utils/format.dart';

class Finalize extends StatelessWidget {
  final double amount;
  Finalize(this.amount);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Hero(
                  tag: 'totalAmountToPay',
                  child: Text(
                    formatPrice(amount),
                    style: Theme.of(context).accentTextTheme.title,
                  ),
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
