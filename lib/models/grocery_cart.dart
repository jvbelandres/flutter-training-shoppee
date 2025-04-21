import 'package:flutter/material.dart';
import 'package:shoppee/models/grocery_item.dart';

class GroceryCart with ChangeNotifier {
  List<GroceryItem> listOfGroceryItem = [];

  void addGroceryItem(GroceryItem item) {
    listOfGroceryItem.add(item);
    notifyListeners();
  }

  void removeGroceryItem(int index) {
    listOfGroceryItem.removeAt(index);
    notifyListeners();
  }

  void clearGroceryCart() {
    listOfGroceryItem.clear();
    notifyListeners();
  }
}
