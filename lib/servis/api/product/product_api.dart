import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../modals/products/products.dart';

class ProductsApi {
  Future getCategoriesApi() async {
    Uri url = Uri.parse('https://dummyjson.com/products/categories');
    http.Response response = await http.get(url);
    List categories = jsonDecode(response.body);
    return categories;
  }

  Future<ProductsModal> getProducts(String productName) async {
    Uri url = Uri.parse('https://dummyjson.com/products/category/$productName');
    http.Response response = await http.get(url);
    final data = jsonDecode(response.body);
    final map = ProductsModal.fromJson(data);
    return map;
  }
}
