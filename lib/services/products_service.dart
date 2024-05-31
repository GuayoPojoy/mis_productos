import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mis_productos/models/product.dart';

class ProductsService extends ChangeNotifier {
  final String _baseUrl = 'productosumg-538f1-default-rtdb.firebaseio.com';
  final List<Producto> products = [];
  late Producto selectedProduct;
  File? newPictureFile;

  bool isLoading = true;
  bool isSaving = false;

  ProductsService() {
    loadProducts();
  }

  Future<List<Producto>> loadProducts() async {
    _setLoadingState(true);
    try {
      final url = Uri.https(_baseUrl, 'Productos.json');
      final resp = await http.get(url);
      final Map<String, dynamic> productsMap = json.decode(resp.body);

      productsMap.forEach((key, value) {
        final tempProduct = Producto.fromMap(value);
        tempProduct.id = key;
        products.add(tempProduct);
      });

      _setLoadingState(false);
      return products;
    } catch (e) {
      _setLoadingState(false);
      throw Exception('Failed to load products: $e');
    }
  }

  Future<void> saveOrCreateProduct(Producto product) async {
    _setSavingState(true);
    try {
      if (product.id == null) {
        await createProduct(product);
      } else {
        await updateProduct(product);
      }
    } finally {
      _setSavingState(false);
    }
  }

  Future<String> updateProduct(Producto product) async {
    final url = Uri.https(_baseUrl, 'Productos/${product.id}.json');
    final resp = await http.put(url, body: product.toJson());
    final decodedData = resp.body;

    final index = products.indexWhere((element) => element.id == product.id);
    products[index] = product;

    return product.id!;
  }

  Future<String> createProduct(Producto product) async {
    final url = Uri.https(_baseUrl, 'Productos.json');
    final resp = await http.post(url, body: product.toJson());
    final decodedData = json.decode(resp.body);

    product.id = decodedData['name'];
    products.add(product);

    return product.id!;
  }

  void updateSelectedProductImage(String path) {
    selectedProduct.imagen = path;
    newPictureFile = File.fromUri(Uri(path: path));
    notifyListeners();
  }

  Future<String?> uploadImage() async {
    if (newPictureFile == null) return null;

    _setSavingState(true);
    try {
      final url = Uri.parse('https://api.cloudinary.com/v1_1/dx0pryfzn/image/upload?upload_preset=autwc6pa');
      final imageUploadRequest = http.MultipartRequest('POST', url);
      final file = await http.MultipartFile.fromPath('file', newPictureFile!.path);
      imageUploadRequest.files.add(file);

      final streamResponse = await imageUploadRequest.send();
      final resp = await http.Response.fromStream(streamResponse);

      if (resp.statusCode != 200 && resp.statusCode != 201) {
        throw Exception('Failed to upload image: ${resp.body}');
      }

      newPictureFile = null;
      final decodedData = json.decode(resp.body);
      return decodedData['secure_url'];
    } finally {
      _setSavingState(false);
    }
  }

  void _setLoadingState(bool state) {
    isLoading = state;
    notifyListeners();
  }

  void _setSavingState(bool state) {
    isSaving = state;
    notifyListeners();
  }
}
