import 'package:flutter/material.dart';
import 'package:rest_in_peace/models/Item.dart';

class CartCounter extends StatelessWidget {
  final List<Item> _items;
  final Function() _toggleCart;
  final bool _isCartOpen;

  CartCounter(this._items, this._isCartOpen, this._toggleCart);

  @override
  Widget build(BuildContext context) {
    return _buildCounter(_items, context);
  }

  Widget _buildCounter(items, context) {
    return Container(
      color: Theme.of(context).primaryColorLight,
      child: SizedBox(
        height: 55.0,
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, i) {
                  return Container(
                    width: 45.0,
                    height: 45.0,
                    child: Stack(
                      children: [
                        Icon(_categoryCount().keys.elementAt(i),
                            color: Theme.of(context).accentColor),
                        Positioned(
                          left: 18.0,
                          bottom: 4.0,
                          child: Text(
                              'x' +
                                  _categoryCount()
                                      .values
                                      .elementAt(i)
                                      .toString(),
                              style: Theme.of(context).textTheme.caption),
                        )
                      ],
                    ),
                  );
                },
                itemCount: (_categoryCount().entries.length),
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                icon: Icon(_isCartOpen ? Icons.close : Icons.shopping_cart),
                color: Theme.of(context).accentColor,
                onPressed: () => _toggleCart(),
              ),
            ),
          ],
        ),
      ),
    );
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
