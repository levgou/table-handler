import 'package:flutter/material.dart';
import 'package:rest_in_peace/utils/format.dart';

class Payment extends StatefulWidget {
  final double amount;
  Payment(this.amount);

  @override
  PaymentState createState() => new PaymentState(this.amount);
}

class PaymentState extends State<Payment> {
  double amount;
  PaymentState(this.amount);

  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: SizedBox.expand(
          child: Center(
            child: Hero(
              tag: 'totalAmountToPay',
                          child: Text(
                formatPrice(amount),
                style: Theme.of(context).textTheme.title,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
