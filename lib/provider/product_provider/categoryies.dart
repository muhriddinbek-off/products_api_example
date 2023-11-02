import 'package:api/servis/api/product/product_api.dart';
import 'package:flutter/material.dart';

class Categories extends ChangeNotifier {
  List category = [];
  bool isSelect = false;

  Future<void> getCategories() async {
    isLoading();
    final data = await ProductsApi().getCategoriesApi();
    category = data;
    isLoading();
    notifyListeners();
  }

  void isLoading() {
    isSelect = !isSelect;
    notifyListeners();
  }
}
