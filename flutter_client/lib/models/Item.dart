import 'package:flutter/material.dart';
import 'package:rest_in_peace/utils/custom_icons.dart';

class Item {
  String name;
  String category;
  String type;
  double price;
  List<SubItem> subItems;
  String status;
  String id;

  Item(this.name, this.category, this.price, this.subItems);

  Item.fromJson(Map json) {
    id = json['id'];
    status = json['status'];
    name = json['name'];
    category = json['category'];
    type = json['type'];
    price = json['price'];
    if (json.containsKey('subitems')) {
      Iterable list = json['subitems'];
      subItems = list.map((subitem) => SubItem.fromJson(subitem)).toList();
      subItems.insert(0, new SubItem(this.name, this.price));
    } else {
      subItems = [];
    }
  }

  Map toJson() {
    return {'name': name, 'category': category, 'price': price};
  }

  double get totalPrice {
    if (subItems.isNotEmpty) {
      return subItems.fold(0, (current, item) => current + item.price);
    } else {
      return this.price;
    }
  }

  get icon {
    if (CATEGORY_ICONS.containsKey(type)) {
      return CATEGORY_ICONS[type];
    } else if (CATEGORY_ICONS.containsKey(category)) {
      return CATEGORY_ICONS[category];
    } else {
      return Icons.question_answer;
    }
  }
}

const Map<String, IconData> CATEGORY_ICONS = const {
  'BEER': CustomIcons.beer,
  'FOOD': CustomIcons.restaurant,
  'SOFT_DRINK': CustomIcons.beer,
  'DESERT': CustomIcons.cake,
  'COKTAIL': CustomIcons.local_bar,
  'WINE': CustomIcons.wine,
  'HAMBURGER': CustomIcons.fast_food
};

class SubItem {
  String name;
  double price;

  SubItem(this.name, this.price);

  SubItem.fromJson(Map json)
      : name = json['name'],
        price = json['price'];

  Map toJson() {
    return {'name': name, 'price': price};
  }
}
