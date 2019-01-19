import 'package:flutter/material.dart';
import 'package:rest_in_peace/models/TableSession.dart';
import 'package:rest_in_peace/models/Item.dart';
import 'package:rest_in_peace/screens/homePage/homepage.dart';
import 'package:rest_in_peace/screens/orderedItems/widgets/CartCounter.dart';
import 'package:rest_in_peace/screens/orderedItems/widgets/CartList.dart';
import 'package:rest_in_peace/screens/payment/payment.dart';
import 'package:rest_in_peace/widgets/ExpandedSection.dart';
import 'package:rest_in_peace/screens/orderedItems/widgets/ItemList.dart';
import 'package:rest_in_peace/screens/orderedItems/widgets/SummeryBar.dart';
import 'package:rest_in_peace/services/table_service.dart';

class OrderedItems extends StatefulWidget {
  final String tableId;
  OrderedItems(this.tableId);

  @override
  OrderedItemsState createState() => new OrderedItemsState(this.tableId);
}

class OrderedItemsState extends State<OrderedItems> {
  bool _isLoading = true;
  bool _isCheckout = false;
  String tableId;
  OrderedItemsState(this.tableId);

  TableSession _table;
  List<Item> _items = new List<Item>();
  List<Item> _cart = new List<Item>();

  initState() {
    super.initState();
    _loadTableState();
  }

  _loadTableState() {
    setState(() {
      _isLoading = true;
    });
    getTable(tableId).then((table) {
      _updateTableState(table);
      setState(() {
        _isLoading = false;
      });
    });
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
      body: Stack(
        children: [
          Column(children: [
            AppBar(
                title: Text('Your check'),
                backgroundColor: Theme.of(context).primaryColor,
                actions: [
                  IconButton(
                    icon: Icon(Icons.home),
                    onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        ),
                  ),
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () => _loadTableState(),
                  )
                ]),
            _isLoading
                ? Expanded(child: Center(child: CircularProgressIndicator()))
                : Expanded(child: ItemList(this._items, _addToCart)),
            SizedBox(height: 100.0, child: Container())
          ]),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ExpandedSection(
              expand: !_isLoading,
              child: Column(
                children: [
                  CartCounter(_cart, _isCheckout, _toggleCart),
                  ExpandedSection(
                      expand: _isCheckout,
                      child: SizedBox(
                          height: MediaQuery.of(context).size.height - 130.0,
                          child: CartList(_cart, _removeFromCart))),
                  SummeryBar(_table, _isCheckout, _checkoutClicked)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
