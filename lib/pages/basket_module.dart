import 'package:flutter/material.dart';

class ShoppingBasket with ChangeNotifier {
  List<dynamic> _items = [];

  List<dynamic> get items => _items;

  void addItem(dynamic item) {
    _items.add(item);
    notifyListeners();
  }

  void removeItem(dynamic item) {
    _items.remove(item);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
