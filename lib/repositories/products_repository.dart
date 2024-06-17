import 'package:admin_page/models/product.dart';
import 'package:admin_page/services/products_http_services.dart';

class ProductsRepository {
  final productsHttpServices = ProductsHttpServices();

  Future<List<Product>> getProducts() async {
    return await productsHttpServices.getProducts();
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
    return await productsHttpServices.addProduct(
      id: id,
      name: name,
      images: images,
      categoryID: categoryID,
      description: description,
      startprice: startprice,
      endprice: endprice,
      rating: rating,
      auksiontime: auksiontime,
    );
  }

  Future<void> editProduct({
  required String newName,
  required List<dynamic> newImages,
  required String newCategoryID,
  required String newDescription,
  required int newStartprice,
  required int newEndprice,
  required int newRating,
  required String newAuksiontime,
}) async {
  await productsHttpServices.editProduct(
    id: DateTime.now().toString(),
    name: newName,
    images: newImages,
    categoryID: newCategoryID,
    description: newDescription,
    startprice: newStartprice,
    endprice: newEndprice,
    rating: newRating,
    auksiontime: newAuksiontime,
  );
}

  Future<void> deleteProduct(String id) async {
    await productsHttpServices.deleteProduct(id);
  }
}