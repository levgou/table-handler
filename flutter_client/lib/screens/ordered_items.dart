import 'package:flutter/material.dart';
import 'package:rest_in_peace/models/TableSession.dart';
import 'package:rest_in_peace/models/Item.dart';
import 'package:rest_in_peace/services/table_service.dart';

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
    getTable(tableId).then((table) {
      setState(() {
        _table = table;
        _items = _table.unownedItems;
        _cart = _table.myCartItems;
      });
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
            child: Column(
          children: [
            Expanded(
                flex: this._isCheckout ? 1 : 3,
                child: _buildItems(this._items)),
            Expanded(flex: this._isCheckout ? 6 : 1, child: _buildSummery())
          ],
        )));
  }

  int getTotalAmount() {
    return _cart.fold(0, (total, item) => total += item.totalPrice);
  }

  Widget _buildItems(items) {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();
          final index = i ~/ 2;
          return _buildRow(items[index]);
        },
        itemCount: (items.length * 2) - 1);
  }

  Widget _buildRow(Item item) {
    bool hasSubitems = item.subItems.isNotEmpty;
    return Dismissible(
        key: Key(item.id),
        onDismissed: (direction) {
          setState(() {
            _cart.add(item);
            _items.remove(item);
          });
        },
        background: Container(color: Colors.red),
        child: hasSubitems
            ? ExpansionTile(
                title: Text(item.name + " +",
                    style: Theme.of(context).textTheme.body1),
                trailing: Text(item.totalPrice.toString() + ' ₪',
                    style: Theme.of(context).textTheme.body1),
                leading:
                    new Icon(item.icon, color: Theme.of(context).primaryColor),
                children: item.subItems.map(_buildSubitem).toList(),
              )
            : ListTile(
                title:
                    Text(item.name, style: Theme.of(context).textTheme.body1),
                trailing: Text(item.totalPrice.toString() + ' ₪',
                    style: Theme.of(context).textTheme.body1),
                leading:
                    new Icon(item.icon, color: Theme.of(context).primaryColor),
              ));
  }

  Widget _buildCart(items) {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();
          final index = i ~/ 2;
          return _buildCartRow(items[index]);
        },
        itemCount: (items.length * 2) - 1);
  }

  Widget _buildCartRow(Item item) {
    bool hasSubitems = item.subItems.isNotEmpty;
    return Dismissible(
        key: Key(item.id),
        onDismissed: (direction) {
          setState(() {
            _cart.remove(item);
            _items.add(item);
          });
        },
        background: Container(color: Colors.red),
        child: hasSubitems
            ? ExpansionTile(
                title: Text(item.name + " +",
                    style: Theme.of(context).textTheme.body1),
                trailing: Text(item.totalPrice.toString() + ' ₪',
                    style: Theme.of(context).textTheme.body1),
                children: item.subItems.map(_buildSubitem).toList(),
              )
            : ListTile(
                title:
                    Text(item.name, style: Theme.of(context).textTheme.body1),
                trailing: Text(item.totalPrice.toString() + ' ₪',
                    style: Theme.of(context).textTheme.body1)));
  }

  Widget _buildSubitem(SubItem item) {
    return ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
        dense: true,
        title: Text(item.name, style: Theme.of(context).textTheme.body2),
        trailing: Text(item.price.toString() + ' ₪'));
  }

  Map<IconData, int> _categoryCount() {
    Map categoriesCount = new Map<IconData, int>();

    _cart.forEach((item) {
      if (categoriesCount.containsKey(item.icon)) {
        categoriesCount[item.icon] += 1;
      } else {
        categoriesCount[item.icon] = 1;
      }
    });
    return categoriesCount;
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
                      ? _buildCart(this._cart)
                      : ListView.builder(
                          padding: const EdgeInsets.all(16.0),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, i) {
                            return Container(
                                width: 45.0,
                                height: 50.0,
                                child: Stack(children: [
                                  Icon(_categoryCount().keys.elementAt(i)),
                                  Positioned(
                                      left: 18.0,
                                      top: -5.0,
                                      child: Text(
                                          'x' +
                                              _categoryCount()
                                                  .values
                                                  .elementAt(i)
                                                  .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption))
                                ]));
                          },
                          itemCount: (_categoryCount().entries.length))),
              Row(children: [
                Expanded(
                    child: Center(
                        child: Text(getTotalAmount().toString() + ' ₪',
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
