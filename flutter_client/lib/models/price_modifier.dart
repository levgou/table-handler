class PriceModifier {
  double amount;
  ModifierType type;
  String name;
  PriceModifier(this.name, this.type, this.amount);

  bool get isEffective {
    return amount != 0;
  }

  String get sign {
    switch (type) {
      case ModifierType.discount:
        return "-";
      case ModifierType.addition:
        return "+";
      default:
        return "";
    }
  }
}

enum ModifierType { fixed, discount, addition }
