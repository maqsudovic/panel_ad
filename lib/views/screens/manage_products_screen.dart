import 'package:admin_page/models/product.dart';
import 'package:admin_page/viewmodels/products_viewmodel.dart';
import 'package:flutter/material.dart';

class ManageProductsScreen extends StatefulWidget {
  final Product? product;
  final ProductsViewmodel productsViewModel;
  const ManageProductsScreen({
    super.key,
    this.product,
    required this.productsViewModel,
  });
  

  @override
  State<ManageProductsScreen> createState() => _ManageProductsScreenState();
}

class _ManageProductsScreenState extends State<ManageProductsScreen> {
  final formKey = GlobalKey<FormState>();
  String? id;
  String? name;
  List<String>? images;
  String? categoryID;
  String? description;
  int? startprice;
  int? endprice;
  int? rating;
  String? auksiontime;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    if (widget.product != null) {
      id = widget.product!.id;
      name = widget.product!.name;
      images = widget.product!.images as List<String>?;
      categoryID = widget.product!.categoryID;
      description = widget.product!.description;
      startprice = widget.product!.startprice;
      endprice = widget.product!.endprice;
      rating = widget.product!.rating;
      auksiontime = widget.product!.auksiontime;
    }
  }

  void submit() {
  if (formKey.currentState != null && formKey.currentState!.validate()) {
    formKey.currentState!.save();
    setState(() {
      isLoading = true;
    });
    if (widget.product == null) {
      widget.productsViewModel
          .addProduct(
        id!,
        name!,
        images!,
        categoryID!,
        description!,
        startprice!,
        endprice!,
        rating!,
        auksiontime!,
      )
          .then((_) {
        Navigator.pop(context, true);
      });
    } else {
    }
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product == null
              ? "Mahsulot qo'shish"
              : "Mahsulotni tahrirlash",
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              initialValue: name,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Nomi",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Iltimos mahsulot nomini kiriting";
                }

                return null;
              },
              onSaved: (newValue) {
                name = newValue!;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: startprice?.toString(),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Boshlanish narxi",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Iltimos mahsulot boshlanish narxini kiriting";
                }

                return null;
              },
              onSaved: (newValue) {
                startprice = int.parse(newValue!);
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: endprice?.toString(),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Tugash narxi",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Iltimos mahsulot tugash narxini kiriting";
                }

                return null;
              },
              onSaved: (newValue) {
                endprice = int.parse(newValue!);
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: images?.toString(),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Rasmlar",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Iltimos mahsulot rasmlarini kiriting(url tarzida)";
                }

                return null;
              },
              onSaved: (newValue) {
                images = newValue!.split(',').map((e) => e.trim()).toList();
              },
            ),
            const SizedBox(height: 20),
            isLoading
                ? const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                    ],
                  )
                : FilledButton.icon(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.black,
                      ),
                    ),
                    onPressed: submit,
                    label:
                        Text(widget.product == null ? "SAQLASH" : "YANGILASH"),
                    icon: const Icon(Icons.save),
                  ),
          ],
        ),
      ),
    );
  }
}