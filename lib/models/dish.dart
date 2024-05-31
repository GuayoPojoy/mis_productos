class Dish {
  String? id; // Añadir el campo id
  final String name;
  final double price;
  final String image;
  final String store;

  Dish({
    this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.store,
  });

  factory Dish.fromJson(Map<String, dynamic> json) {
    return Dish(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      image: json['image'],
      store: json['store'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'image': image,
      'store': store,
    };
  }
}
