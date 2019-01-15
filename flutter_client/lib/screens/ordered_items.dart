import 'package:flutter/material.dart';
import 'package:rest_in_peace/models/RestTable.dart';
import 'package:rest_in_peace/models/Item.dart';
import 'package:rest_in_peace/services/table_service.dart';

class OrderedItems extends StatefulWidget {
  final String tableId;
  OrderedItems(this.tableId);

  @override
  OrderedItemsState createState() => new OrderedItemsState(this.tableId);
}

class OrderedItemsState extends State<OrderedItems> {
  String tableId;
  OrderedItemsState(this.tableId);

  RestTable _table;
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
            Expanded(child: _buildItems()),
            SizedBox(height: 120.0, child: _buildSummery())
          ],
        )));
  }

  int getTotalAmount() {
    return _cart.fold(0, (total, item) => total += item.price);
  }

  void _payNowPressed() {
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _cart.map(
            (Item item) {
              return new ListTile(
                title: new Text(item.name,
                    style: Theme.of(context).textTheme.body1),
              );
            },
          );
          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return new Scaffold(
              appBar: new AppBar(
                backgroundColor: Theme.of(context).primaryColor,
                title: Text('Your peice',
                    style: Theme.of(context).textTheme.title),
              ),
              body: Center(
                  child: Column(children: [
                Expanded(child: ListView(children: divided)),
                _buildPayment()
              ])));
        },
      ),
    );
  }

  Widget _buildItems() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();
          final index = i ~/ 2;
          return _buildRow(_items[index]);
        },
        itemCount: (_items.length * 2) - 1);
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
                title:
                    Text(item.name + " +", style: Theme.of(context).textTheme.body1),
                trailing: Text(item.totalPrice.toString() + ' ₪',
                    style: Theme.of(context).textTheme.body1),
                leading:
                    new Icon(item.icon, color: Theme.of(context).accentColor),
                children: item.subItems.map(_buildSubitem).toList(),
              )
            : ListTile(
                title:
                    Text(item.name, style: Theme.of(context).textTheme.body1),
                trailing: Text(item.totalPrice.toString() + ' ₪',
                    style: Theme.of(context).textTheme.body1),
                leading:
                    new Icon(item.icon, color: Theme.of(context).accentColor),
              ));
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
    return Container(
        color: Theme.of(context).accentColor,
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(children: [
          Expanded(
              child: ListView.builder(
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
                                  style: Theme.of(context).textTheme.caption))
                        ]));
                  },
                  itemCount: (_categoryCount().entries.length))),
          Row(children: [
            Expanded(
                child: Center(
                    child: Text(getTotalAmount().toString() + ' ₪',
                        style: Theme.of(context).textTheme.title))),
            Expanded(
              child: IconButton(
                  icon: const Icon(Icons.payment),
                  color: Colors.white,
                  onPressed: _payNowPressed),
            )
          ])
        ]));
  }

  Widget _buildPayment() {
    return Container(
        color: Theme.of(context).accentColor,
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(children: [
          Expanded(
              child: Center(
                  child: Text(getTotalAmount().toString(),
                      style: Theme.of(context).textTheme.title))),
          Expanded(
            child: IconButton(
                icon: const Icon(Icons.check), onPressed: _doPayment),
          )
        ]));
  }

  void _doPayment() {}
}
