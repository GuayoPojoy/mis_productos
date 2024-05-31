// lib/models/dish.dart

class Dish {
  final String name;
  final String store;
  final String image;
  final double price;

  Dish({
    required this.name,
    required this.store,
    required this.image,
    required this.price,
  });

  factory Dish.fromJson(Map<String, dynamic> json) {
    return Dish(
      name: json['name'],
      store: json['store'],
      image: json['image'],
      price: json['price'].toDouble(),
    );
  }
}
