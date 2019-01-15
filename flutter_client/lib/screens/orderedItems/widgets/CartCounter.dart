import 'package:flutter/material.dart';
import 'package:rest_in_peace/models/Item.dart';

class CartCounter extends StatelessWidget {
  final List<Item> _items;

  CartCounter(this._items);

  @override
  Widget build(BuildContext context) {
    return _buildCounter(_items, context);
  }

  Widget _buildCounter(items, context) {
    return ListView.builder(
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
                        'x' + _categoryCount().values.elementAt(i).toString(),
                        style: Theme.of(context).textTheme.caption))
              ]));
        },
        itemCount: (_categoryCount().entries.length));
  }

  Map<IconData, int> _categoryCount() {
    Map categoriesCount = new Map<IconData, int>();

    _items.forEach((item) {
      if (categoriesCount.containsKey(item.icon)) {
        categoriesCount[item.icon] += 1;
      } else {
        categoriesCount[item.icon] = 1;
      }
    });
    return categoriesCount;
  }
}
