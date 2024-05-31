

import 'dart:convert';


class Producto {
    Producto({
        required this.disponible,
        this.imagen,
        required this.nombre,
        required this.precio,
        this.id
    });

    bool disponible;
    String nombre;
    String? imagen;
    double precio;
    String? id;

    factory Producto.fromJson(String str) => Producto.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Producto.fromMap(Map<String, dynamic> json) => Producto(
        disponible: json["disponible"],
        nombre: json["nombre"],
        imagen: json["imagen"],
        precio: json["precio"].toDouble(),
    );

    Map<String, dynamic> toMap() => {
        "disponible": disponible,
        "nombre": nombre,
        "imagen": imagen,
        "precio": precio,
    };

    Producto copy() => Producto(
      disponible: this.disponible,
      nombre: this.nombre,
      imagen: this.imagen,
      precio: this.precio,
      id: this.id,
    );

}
