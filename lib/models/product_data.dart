import 'package:flutter/foundation.dart';
import 'dart:collection';
import 'product.dart';

class ProductData extends ChangeNotifier {
  List<Product> _products = [
    Product(
        UPN: '123456 789012',
        productName: 'Coca Cola',
        aisleNumber: 'D24',
        shelf: 'Middle')
  ];

  UnmodifiableListView<Product> get products {
    return UnmodifiableListView(_products);
  }

  int get productCount {
    return _products.length;
  }

  void addProduct(
      String newUPN, String newProductName, String newAisle, String newShelf) {
    final product = Product(
        UPN: newUPN,
        productName: newProductName,
        aisleNumber: newAisle,
        shelf: newShelf);
    _products.add(product);
    notifyListeners();
  }

//  void updateTask(Task task) {
//    task.toggleDone();
//    notifyListeners();
//  }

//  void deleteProduct(Product product) {
//    _products.remove(product);
//    notifyListeners();
//  }
}
