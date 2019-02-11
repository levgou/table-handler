String formatPrice(double price) {
  return price.toStringAsFixed(2) + ' ₪';
}

String formatPriceNoSign(double price) {
  return price.toStringAsFixed(2);
}
