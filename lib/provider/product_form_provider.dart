import 'package:flutter/material.dart';
import 'package:mis_productos/models/product.dart';

class ProductFormProvider extends ChangeNotifier {
  late GlobalKey<FormState> formKey;

  Producto product;

  ProductFormProvider(this.product) {
    formKey = GlobalKey<FormState>();
  }

  void updateAvailability(bool value) {
    print(value);
    product.disponible = value;
    notifyListeners();
  }

  bool isValidForm() {
    print(product.nombre);
    print(product.precio);
    print(product.disponible);

    return formKey.currentState?.validate() ?? false;
  }
}
