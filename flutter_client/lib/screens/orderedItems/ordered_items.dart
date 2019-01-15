import 'package:flutter/material.dart';
import 'package:rest_in_peace/models/TableSession.dart';
import 'package:rest_in_peace/models/Item.dart';
import 'package:rest_in_peace/screens/orderedItems/widgets/CartCounter.dart';
import 'package:rest_in_peace/screens/orderedItems/widgets/CartList.dart';
import 'package:rest_in_peace/screens/orderedItems/widgets/ItemList.dart';
import 'package:rest_in_peace/services/table_service.dart';
import 'package:rest_in_peace/utils/format.dart';

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

  TableSession _table;
  List<Item> _items = new List<Item>();
  List<Item> _cart = new List<Item>();

  initState() {
    super.initState();
    getTable(tableId).then(_updateTableState);
  }

  _updateTableState(table) {
    setState(() {
      _table = table;
      _items = _table.unownedItems;
      _cart = _table.userCartItems;
    });
  }

  _addToCart(Item item) {
    setState(() {
      _table.addToCart(item);
      _items = _table.unownedItems;
      _cart = _table.userCartItems;
    });
  }

  _removeFromCart(Item item) {
    setState(() {
      _table.removeFromCart(item);
      _items = _table.unownedItems;
      _cart = _table.userCartItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              Text('Ordered items', style: Theme.of(context).textTheme.title),
        ),
        body: Center(
            child: Column(children: [
          Expanded(
              flex: this._isCheckout ? 1 : 3, child: ItemList(this._items, _addToCart)),
          Expanded(flex: this._isCheckout ? 6 : 1, child: _buildSummery())
        ])));
  }

  Widget _buildSummery() {
    return InkWell(
        onTap: () {
          setState(() {
            this._isCheckout = !this._isCheckout;
          });
        },
        child: Container(
            color: Theme.of(context).primaryColor,
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Column(children: [
              Expanded(
                  child: this._isCheckout
                      ? CartList(_cart, _removeFromCart)
                      : CartCounter(_cart)),
              Row(children: [
                Expanded(
                    child: Center(
                        child: Text(formatPrice(_table.userTotalCartPrice),
                            style: Theme.of(context).textTheme.title))),
                this._isCheckout
                    ? Expanded(
                        child: IconButton(
                            icon: const Icon(Icons.payment),
                            color: Colors.white,
                            onPressed: () {}))
                    : Container()
              ])
            ])));
  }
}
