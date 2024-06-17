import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  String id;
  String name;
  List images;
  String categoryID;
  String description;
  int startprice;
  int endprice;
  int rating;
  String auksiontime;
  Product({
    required this.id,
    required this.name,
    required this.images,
    required this.categoryID,
    required this.description,
    required this.endprice,
    required this.startprice,
    required this.rating,
    required this.auksiontime,
  });
  factory Product.fromJson(Map<String, dynamic> json) {
  return _$ProductFromJson(json);
}
  Map<String, dynamic> toJson() {
    return _$ProductToJson(this);
  }
}
