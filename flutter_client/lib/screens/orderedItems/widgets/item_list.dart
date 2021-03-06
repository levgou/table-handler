import 'package:flutter/material.dart';
import 'package:rest_in_peace/models/item.dart';
import 'package:rest_in_peace/utils/format.dart';
import 'package:rest_in_peace/widgets/custom_expansion_tile.dart';

class ItemList extends StatelessWidget {
  final List<Item> _items;
  final Function(Item) _addToCartCallback;

  final Function(Item) _requestAddToCart;

  ItemList(this._items, this._requestAddToCart, this._addToCartCallback);

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
      confirmDismiss: (DismissDirection direction) => _requestAddToCart(item),
      key: Key(item.id),
      onDismissed: (DismissDirection direction) => _addToCartCallback(item),
      secondaryBackground: Container(
        color: Theme.of(context).backgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Add To Cart",
              style: Theme.of(context).textTheme.body1,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(
                Icons.add_shopping_cart,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
      background: Container(
        color: Theme.of(context).backgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(
                Icons.add_shopping_cart,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Text(
              "Add To Cart",
              style: Theme.of(context).textTheme.body1,
            ),
          ],
        ),
      ),
      child: CustomExpansionTile(
        title: Text(item.name + (hasSubitems ? " +" : ""),
            style: Theme.of(context).textTheme.body1),
        trailing: Text(formatPrice(item.totalPrice),
            style: Theme.of(context).textTheme.body1),
        leading: new Icon(
          item.icon,
          color: Theme.of(context).primaryColorDark,
        ),
        children:
            item.subItems.map((item) => _buildSubitem(item, context)).toList(),
      ),
    );
  }

  Widget _buildSubitem(SubItem item, context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
      dense: true,
      title: Text(item.name, style: Theme.of(context).textTheme.body2),
      trailing: Text(formatPrice(item.price),
          style: Theme.of(context).textTheme.body2),
    );
  }
}
