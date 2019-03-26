import 'package:flutter/material.dart';
import 'package:rest_in_peace/models/price_modifier.dart';
import 'package:rest_in_peace/screens/payment/finalize.dart';
import 'package:rest_in_peace/utils/format.dart';

class Payment extends StatefulWidget {
  final double baseAmount;
  Payment(this.baseAmount);

  @override
  PaymentState createState() => new PaymentState(this.baseAmount);
}

class PaymentState extends State<Payment> {
  final double baseAmount;
  bool _roundUp = true;
  List<PriceModifier> modifiers;
  PaymentState(this.baseAmount);

  initState() {
    super.initState();
    modifiers = [
      new PriceModifier("base", ModifierType.fixed, baseAmount),
      new PriceModifier("discount", ModifierType.discount, 0.1 * baseAmount),
      new PriceModifier("tip", ModifierType.addition, 0.0),
    ];
  }

  _getTotalAmount() {
    double amount = modifiers.fold(0, (current, modifier) {
      switch (modifier.type) {
        case ModifierType.fixed:
          return modifier.amount;
        case ModifierType.addition:
          return current + modifier.amount;
        case ModifierType.discount:
          return current - modifier.amount;
      }
    });
    return _roundUp ? amount.ceilToDouble() : amount;
  }

  _setTipPercent(double percent) {
    setState(() {
      modifiers.singleWhere((modifier) => modifier.name == 'tip').amount =
          percent * baseAmount;
    });
  }

  _getTipPercent() {
    return modifiers.singleWhere((modifier) => modifier.name == 'tip').amount /
        baseAmount;
  }

  payClicked() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Finalize(_getTotalAmount()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10.0),
                child: Text("You are the man",
                    style: Theme.of(context).accentTextTheme.title),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: Text("Tip maybe?",
                    style: Theme.of(context).accentTextTheme.subtitle),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 35.0),
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    showValueIndicator: ShowValueIndicator.always,
                    valueIndicatorTextStyle: Theme.of(context).textTheme.body2,
                  ),
                  child: Slider(
                    activeColor: Theme.of(context).accentColor,
                    inactiveColor: Theme.of(context).primaryColorLight,
                    min: 0.0,
                    max: 0.30,
                    label:
                        "${(_getTipPercent() * 100).toStringAsPrecision(2)}%",
                    onChanged: _setTipPercent,
                    value: _getTipPercent(),
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.loose,
                child: _buildModifiers(modifiers, context),
              ),
              Expanded(
                child: Center(
                  child: Hero(
                    tag: 'totalAmountToPay',
                    child: Text(
                      formatPrice(_getTotalAmount()),
                      style: Theme.of(context).accentTextTheme.subtitle,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 35.0),
                child: RaisedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Pay Now",
                        style: Theme.of(context).textTheme.body1,
                      ),
                      Icon(Icons.check)
                    ],
                  ),
                  onPressed: payClicked,
                ),
              ),
              // Row(
              //   children: [
              //     Checkbox(
              //       onChanged: (value) {
              //         setState(() {
              //           _roundUp = value;
              //         });
              //       },
              //       value: _roundUp,
              //     ),
              //     Text("round up",
              //         textAlign: TextAlign.center,
              //         style: Theme.of(context).textTheme.subtitle),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModifiers(modifiers, context) {
    List<PriceModifier> effectiveModifiers = modifiers
        .where((PriceModifier modifier) => modifier.isEffective)
        .toList();
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      itemBuilder: (context, i) {
        return _buildModifiersRow(effectiveModifiers[i], context);
      },
      itemCount: (effectiveModifiers.length),
    );
  }

  Widget _buildModifiersRow(PriceModifier modifier, context) {
    String sign = modifier.sign;
    return ListTile(
      dense: true,
      title:
          Text(modifier.name, style: Theme.of(context).accentTextTheme.body2),
      trailing: Text("$sign ${formatPriceNoSign(modifier.amount)}",
          style: Theme.of(context).accentTextTheme.body2),
    );
  }
}
