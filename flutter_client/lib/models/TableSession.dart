import 'package:rest_in_peace/models/Item.dart';

class TableSession {
  String id;
  String title;
  List<Item> items;
  List<String> cart;

  TableSession.fromJson(Map json) {
    id = json['id'];
    title = json['title'];
    Iterable list = json['items'];
    items = list.map((item) => Item.fromJson(item)).toList();
    cart = List<String>.from(json['cart']);
  }

  List<Item> get unownedItems {
    return this.items.where((item) {
      return item.status == "PENDING";
    }).toList();
  }

  List<Item> get userCartItems {
    return this.items.where((item) {
      return this.cart.contains(item.id);
    }).toList();
  }

  removeFromCart(Item item) {
    item.status = 'PENDING';
    cart.remove(item.id);
  }

  addToCart(Item item) {
    item.status = 'IN_CART';
    cart.add(item.id);
  }

  int get userTotalCartPrice {
    return userCartItems.fold(0, (total, item) => total += item.totalPrice);
  
  }

  Map toJson() {
    return {'id': id, 'title': title, 'items': items};
  }
}
