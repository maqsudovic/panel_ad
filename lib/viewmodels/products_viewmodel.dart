import 'package:admin_page/models/product.dart';
import 'package:admin_page/repositories/products_repository';

class ProductsViewmodel {
  final productsRepository = ProductsRepository();
  List<Product> _list = [];

  Future<List<Product>> get list async {
    _list = await productsRepository.getProducts();
    return [..._list];
  }

 Future<void> addProduct(
  String id,
  String name,
  List<String> images,
  String categoryID,
  String description,
  int startprice,
  int endprice,
  int rating,
  String auksiontime,
) async {
  final newProduct = await productsRepository.addProduct(
    id: DateTime.now().toString(),
    name: name,
    images: images,
    categoryID: categoryID,
    description: description,
    startprice: startprice,
    endprice: endprice,
    rating: rating,
    auksiontime: auksiontime,
  );
  if (newProduct != null) {
    _list.add(newProduct);
  }
}

  Future<void> editProduct({
  required String id,
  required String newName,
  required List<String> newImages,
  required String newCategoryID,
  required String newDescription,
  required int newStartprice,
  required int newEndprice,
  required int newRating,
  required String newAuksiontime,
}) async {
  await productsRepository.editProduct(
    newName: newName,
    newImages: newImages,
    newCategoryID: newCategoryID,
    newDescription: newDescription,
    newStartprice: newStartprice,
    newEndprice: newEndprice,
    newRating: newRating,
    newAuksiontime: newAuksiontime,
  );
  
  final index = _list.indexWhere((product) {
    return product.id == id;
  });
  _list[index].name = newName;
  _list[index].images = newImages;
  _list[index].categoryID = newCategoryID;
  _list[index].description = newDescription;
  _list[index].startprice = newStartprice;
  _list[index].endprice = newEndprice;
  _list[index].rating = newRating;
  _list[index].auksiontime = newAuksiontime;
}

  void deleteProduct(String id) async {
    _list.removeWhere((product) {
      return product.id == id;
    });
    productsRepository.deleteProduct(id);
  }
}