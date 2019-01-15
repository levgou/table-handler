import 'package:flutter/material.dart';

class Item {
  String name;
  IconData icon;
  int price;
  List<SubItem> subItems;
  String status;
  String id;

  Item(this.name, this.icon, this.price, this.subItems);

  Item.fromJson(Map json) {
    id = json['id'];
    status = json['status'];
    name = json['name'];
    icon = CATEGORY_ICONS[json['category']];
    price = json['price'];
    if(json.containsKey('subitems')){
      Iterable list = json['subitems'];
      subItems = list.map((subitem) => SubItem.fromJson(subitem)).toList();
      subItems.insert(0, new SubItem(this.name, this.price));
    } else {
      subItems = [];
    }
  }
        
  Map toJson() {
    return {'name': name, 'icon': icon, 'price': price};
  }

  get totalPrice {
    if(subItems.isNotEmpty){
      return subItems.fold(0, (current, item) => current + item.price);
    } else {
      return this.price;
    }
  }
}

const Map<String, IconData> CATEGORY_ICONS = const {
  'BEER': Icons.local_drink,
  'FOOD': Icons.fastfood
};

class SubItem {
  String name;
  int price;

  SubItem(this.name, this.price);

  SubItem.fromJson(Map json)
      : name = json['name'],
        price = json['price'];
        
  Map toJson() {
    return {'name': name, 'price': price};
  }
}