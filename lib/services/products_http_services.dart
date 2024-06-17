import 'dart:convert';

import 'package:admin_page/models/product.dart';
import 'package:http/http.dart' as http;
class ProductsHttpServices {
  Future<List<Product>> getProducts() async {
    Uri url = Uri.parse("https://fir-73d12-default-rtdb.firebaseio.com/products.json");
    final response = await http.get(url);
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    List<Product> loadedProducts = [];
    if (data != null) {
      data.forEach((key, value) {
        value['id'] = key;
        loadedProducts.add(Product.fromJson(value));
      });
    }
    return loadedProducts;
  }

  Future<Product?> addProduct({
    required String id,
    required String name,
    required List<dynamic> images,
    required String categoryID,
    required String description,
    required int startprice,
    required int endprice,
    required int rating,
    required String auksiontime,
  }) async {
    Uri url = Uri.parse("https://fir-73d12-default-rtdb.firebaseio.com/products/$id.json");
    Map<String, dynamic> productData = {
      "id": id,
      "name": name,
      "images": images,
      "categoryID": categoryID,
      "description": description,
      "startprice": startprice,
      "endprice": endprice,
      "rating": rating,
      "auksiontime": auksiontime,
    };
    final response = await http.post(url, body: jsonEncode(productData));
    final data = jsonDecode(response.body);
    if (data != null) {
      productData['id'] = data['name'];
      return Product.fromJson(productData);
    }
    return null;
  }

  Future<void> editProduct({
    required String id,
    required String name,
    required List<dynamic> images,
    required String categoryID,
    required String description,
    required int startprice,
    required int endprice,
    required int rating,
    required String auksiontime,
  }) async {
    Uri url = Uri.parse("https://fir-73d12-default-rtdb.firebaseio.com/products/$id.json");
    Map<String, dynamic> productData = {
      "id": id,
      "name": name,
      "images": images,
      "categoryID": categoryID,
      "description": description,
      "startprice": startprice,
      "endprice": endprice,
      "rating": rating,
      "auksiontime": auksiontime,
    };
    await http.patch(url, body: jsonEncode(productData));
  }

  Future<void> deleteProduct(String id) async {
    Uri url = Uri.parse("https://fir-73d12-default-rtdb.firebaseio.com/products/$id.json");
    await http.delete(url);
  }
}