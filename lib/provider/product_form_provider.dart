import 'package:flutter/material.dart';
import 'package:mis_productos/models/product.dart';



class ProductFormProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  Producto product;

  ProductFormProvider( this.product );

  updateAvailability( bool value ) {
    print(value);
    this.product.disponible = value;
    notifyListeners();
  }


  bool isValidForm() {

    print( product.nombre );
    print( product.precio );
    print( product.disponible );

    return formKey.currentState?.validate() ?? false;
  }

}