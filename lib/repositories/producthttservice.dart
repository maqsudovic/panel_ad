import 'dart:convert';
import 'package:admin_page/models/product.dart';
import 'package:http/http.dart' as http;

class ProductHttpService {
  List<Product> _productList = [];
  List<Product> _computercategory = [];
  List<Product> _housecategory = [];
  List<String> _allcategories = [];
  List<Product> _carcategory = [];

  Future<List<Product>> getProducts([int id = 0]) async {
    Uri url = Uri.parse(
        'https://examproject-6ab96-default-rtdb.firebaseio.com/products.json');
    final response = await http.get(url);

    // Clear the lists
    _productList.clear();
    _computercategory.clear();
    _housecategory.clear();
    _carcategory.clear();
    _allcategories.clear();

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      data.forEach((key, value) {
        _allcategories.add(key);
        if (value is List) {
          value.forEach((productData) {
            final product = Product(
              id: productData['id']?.toString() ??
                  DateTime.now().millisecondsSinceEpoch.toString(),
              name: productData['name'],
              images: List<Map<String, dynamic>>.from(productData['images'] ?? []),
              categoryID: productData['categoryname'],
              description: productData['description'],
              startprice: productData['startprice'],
              endprice: productData['endprice'],
              rating: productData['rating'],
              auksiontime: productData['auksiontime'],
            );
            if (key == 'computer') {
              _computercategory.add(product);
            } else if (key == 'car') {
              _carcategory.add(product);
            } else if (key == 'uylar') {
              _housecategory.add(product);
            }
            _productList.add(product);
          });
        }
      });

      if (!_allcategories.contains('all')) {
        _allcategories.insert(0, 'all');
      }
    } else {
      print('Failed to load products. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to load products');
    }

    switch (id) {
      case 1:
        return _carcategory;
      case 2:
        return _computercategory;
      case 3:
        return _housecategory;
      default:
        return _productList;
    }
  }

  Future<List<String>> getAllCategories() async {
    if (_allcategories.isEmpty) {
      await getProducts();
    }
    return [..._allcategories];
  }

  Future<void> updateStartPrice(
      String productName, String categoryID, int newStartPrice) async {
    bool productFound = false;
    for (var product in _productList) {
      if (product.name == productName && product.categoryID == categoryID) {
        productFound = true;
        product.startprice = newStartPrice;
        print('Product ID: ${product.id}');

        Uri url = Uri.parse(
            'https://examproject-6ab96-default-rtdb.firebaseio.com/products/$categoryID/${product.id}.json');
        final response = await http.patch(
          url,
          body: jsonEncode({'startprice': newStartPrice}),
        );

        if (response.statusCode != 200) {
          print(
              'Failed to update startprice. Status code: ${response.statusCode}');
          print('Response body: ${response.body}');
          throw Exception('Failed to update startprice');
        }
        break;
      }
    }

    if (!productFound) {
      print('Product not found: $productName in category $categoryID');
      throw Exception('Product not found');
    }
  }
}