import 'package:flutter/material.dart';
import 'package:rest_in_peace/models/item.dart';
import 'package:rest_in_peace/utils/format.dart';
import 'package:rest_in_peace/widgets/custom_expansion_tile.dart';

class ItemList extends StatelessWidget {
  final List<Item> _items;
  final Function(Item) _addToCartCallback;

  ItemList(this._items, this._addToCartCallback);

  @override
  Widget build(BuildContext context) {
    return _buildItems(_items, context);
  }

  Widget _buildItems(items, context) {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();
          final int itemIndex = i ~/ 2;
          return _buildItemsTile(items[itemIndex], context);
        },
        itemCount: (items.length * 2) - 1);
  }

  Widget _buildItemsTile(Item item, context) {
    bool hasSubitems = item.subItems.isNotEmpty;
    return Dismissible(
      key: Key(item.id),
      onDismissed: (direction) {
        _addToCartCallback(item);
      },
      child: CustomExpansionTile(
        title: Text(item.name + (hasSubitems ? " +" : ""),
            style: Theme.of(context).textTheme.body1),
        trailing: Text(formatPrice(item.totalPrice),
            style: Theme.of(context).textTheme.body1),
        leading: new Icon(item.icon, color: Theme.of(context).primaryColor),
        children:
            item.subItems.map((item) => _buildSubitem(item, context)).toList(),
      ),
    );
  }

  Widget _buildSubitem(SubItem item, context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
      dense: true,
      title: Text(item.name, style: Theme.of(context).textTheme.display1),
      trailing: Text(formatPrice(item.price),
          style: Theme.of(context).textTheme.display1),
    );
  }
}
