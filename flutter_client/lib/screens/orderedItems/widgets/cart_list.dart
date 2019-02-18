import 'package:flutter/material.dart';
import 'package:rest_in_peace/models/item.dart';
import 'package:rest_in_peace/utils/format.dart';
import 'package:rest_in_peace/widgets/custom_expansion_tile.dart';

class CartList extends StatelessWidget {
  final List<Item> _items;
  final Function(Item) _removeFromCartCallback;
  final Function(Item) _requestRemoveFromCart;

  CartList(
      this._items, this._requestRemoveFromCart, this._removeFromCartCallback);

  @override
  Widget build(BuildContext context) {
    return _buildCart(_items, context);
  }

  Widget _buildCart(items, context) {
    return Container(
      color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemBuilder: (context, i) {
            if (i.isOdd) return Divider(color: Theme.of(context).accentColor);
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
      confirmDismiss: (DismissDirection direction) =>
          _requestRemoveFromCart(item),
      secondaryBackground: Container(
        color: Theme.of(context).primaryColorLight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Remove From Cart",
              style: Theme.of(context).accentTextTheme.body1,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(
                Icons.remove_shopping_cart,
                color: Theme.of(context).accentColor,
              ),
            ),
          ],
        ),
      ),
      background: Container(
        color: Theme.of(context).primaryColorLight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(
                Icons.remove_shopping_cart,
                color: Theme.of(context).accentColor,
              ),
            ),
            Text(
              "Remove From Cart",
              style: Theme.of(context).accentTextTheme.body1,
            ),
          ],
        ),
      ),
      onDismissed: (direction) {
        _removeFromCartCallback(item);
      },
      child: CustomExpansionTile(
        title: Text(item.name + (hasSubitems ? ' +' : ''),
            style: Theme.of(context).accentTextTheme.body1),
        trailing: Text(formatPrice(item.totalPrice),
            style: Theme.of(context).accentTextTheme.body1),
        children:
            item.subItems.map((item) => _buildSubitem(item, context)).toList(),
      ),
    );
  }

  Widget _buildSubitem(SubItem item, context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
      dense: true,
      title: Text(item.name, style: Theme.of(context).accentTextTheme.body2),
      trailing: Text(
        formatPrice(item.price),
        style: Theme.of(context).accentTextTheme.body2,
      ),
    );
  }
}
