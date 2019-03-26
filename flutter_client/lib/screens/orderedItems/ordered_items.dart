import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rest_in_peace/models/request_status.dart';
import 'package:rest_in_peace/services/table_service.dart';
import 'package:rest_in_peace/models/table_status.dart';
import 'package:rest_in_peace/models/item.dart';
import 'package:rest_in_peace/widgets/expanded_section.dart';
import 'package:rest_in_peace/screens/orderedItems/widgets/cart_counter.dart';
import 'package:rest_in_peace/screens/orderedItems/widgets/cart_list.dart';
import 'package:rest_in_peace/screens/payment/payment.dart';
import 'package:rest_in_peace/screens/orderedItems/widgets/item_list.dart';
import 'package:rest_in_peace/screens/orderedItems/widgets/summery_bar.dart';

class OrderedItems extends StatefulWidget {
  final String tableId;
  OrderedItems(this.tableId);

  @override
  OrderedItemsState createState() => new OrderedItemsState(this.tableId);
}

class OrderedItemsState extends State<OrderedItems> {
  bool _isCheckout = false;
  String tableId;
  OrderedItemsState(this.tableId);
  TableService service;
  TableStatus _table;

  initState() {
    super.initState();
    service = new TableService();
    _requestTableUpdate();
  }

  dispose() {
    super.dispose();
    service.terminate(); //todo: causing problem
  }

  _requestTableUpdate() {
    service.requestTableUpdate();
  }

  _updateTable(TableStatus table) {
    _table = table;
  }

  Future<bool> _requestAddToCart(Item item) async {
    RequestStatus requestStatus = await service.requestAddToCart(item);
    return requestStatus.status == StatusType.success;
  }

  Future<bool> _requestRemoveFromCart(Item item) async {
    RequestStatus requestStatus = await service.requestRemoveFromCart(item);
    return requestStatus.status == StatusType.success;
  }

  _addToCart(Item item) {
    setState(() {
      _table.addToCart(item);
    });
  }

  _removeFromCart(Item item) {
    setState(() {
      _table.removeFromCart(item);
    });
  }

  _toggleCart() {
    setState(() {
      _isCheckout = !_isCheckout;
    });
  }

  _checkoutClicked() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Payment(_table.userTotalCartPrice)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: service.streamRouter.tableStatusUpdateStream,
        builder: (context, AsyncSnapshot<TableStatus> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.done:
            case ConnectionState.active:
              _updateTable(snapshot.data);
              return Stack(
                children: [
                  Column(children: [
                    AppBar(
                      title: Text('Your check',
                          style: Theme.of(context).accentTextTheme.subtitle),
                      backgroundColor: Theme.of(context).primaryColorDark,
                      actions: [
                        IconButton(
                          icon: Icon(Icons.refresh,
                              color: Theme.of(context).accentColor),
                          onPressed: () => _requestTableUpdate(),
                        ),
                      ],
                    ),
                    Expanded(
                        child: ItemList(_table.unownedItems, _requestAddToCart,
                            _addToCart)),
                    SizedBox(height: 100.0, child: Container())
                  ]),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        CartCounter(
                          _table.userCartItems,
                          _isCheckout,
                          _toggleCart,
                        ),
                        ExpandedSection(
                            expand: _isCheckout,
                            child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height - 130.0,
                                child: CartList(_table.userCartItems,
                                    _requestRemoveFromCart, _removeFromCart))),
                        SummeryBar(_table, _isCheckout, _checkoutClicked)
                      ],
                    ),
                  ),
                ],
              );
          }
        },
      ),
    );
  }
}
