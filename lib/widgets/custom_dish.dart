import 'package:flutter/material.dart';
import 'package:mis_productos/models/dish.dart';

class CustomDish extends StatelessWidget {
  final Dish dish;

  const CustomDish({Key? key, required this.dish}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(dish.image, width: 50, height: 50, fit: BoxFit.cover),
        title: Text(dish.name),
        subtitle: Text('\$${dish.price} - ${dish.store}'),
      ),
    );
  }
}
