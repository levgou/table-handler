import 'package:flutter/material.dart';
import 'package:rest_in_peace/models/Item.dart';
import 'package:rest_in_peace/utils/format.dart';

class CartList extends StatelessWidget {
  final List<Item> _items;
  final Function(Item) _removeFromCartCallback;

  CartList(this._items, this._removeFromCartCallback);

  @override
  Widget build(BuildContext context) {
    return _buildCart(_items, context);
  }

  Widget _buildCart(items, context) {
    return Container(
      color: Theme.of(context).highlightColor,
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemBuilder: (context, i) {
            if (i.isOdd) return Divider();
            final index = i ~/ 2;
            return _buildCartRow(items[index], context);
          },
          itemCount: (items.length * 2) - 1),
    );
  }

  Widget _buildCartRow(Item item, context) {
    bool hasSubitems = item.subItems.isNotEmpty;
    return Dismissible(
      key: Key(item.id),
      onDismissed: (direction) {
        _removeFromCartCallback(item);
      },
      background: Container(color: Theme.of(context).primaryColor),
      child: ExpansionTile(
        title: Text(item.name + (hasSubitems ? ' +' : ''),
            style: Theme.of(context).textTheme.body2),
        trailing: Text(formatPrice(item.totalPrice),
            style: Theme.of(context).textTheme.body2),
        children:
            item.subItems.map((item) => _buildSubitem(item, context)).toList(),
      ),
    );
  }

  Widget _buildSubitem(SubItem item, context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
      dense: true,
      title: Text(item.name, style: Theme.of(context).textTheme.display2),
      trailing: Text(
        formatPrice(item.price),
        style: Theme.of(context).textTheme.display2,
      ),
    );
  }
}
