import 'package:rest_in_peace/models/Item.dart';

class RestTable {
  String id;
  String title;
  List<Item> items;
  List<String> cart;

  RestTable.fromJson(Map json) {
    id = json['id'];
    title = json['title'];
    Iterable list = json['items'];
    items = list.map((item) => Item.fromJson(item)).toList();
    cart = List<String>.from(json['cart']);
  }

  get unownedItems {
    return this.items.where((item) {
      return item.status == "PENDING";
    }).toList();
  }

  get myCartItems {
    return this.items.where((item) {
      return this.cart.contains(item.id);
    }).toList();
  }

  Map toJson() {
    return {'id': id, 'title': title, 'items': items};
  }
}
