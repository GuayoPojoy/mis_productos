// lib/screens/food_details.dart

import 'package:flutter/material.dart';
import 'package:mis_productos/models/dish.dart';

class FoodDetails extends StatelessWidget {
  final Dish dish;

  const FoodDetails({Key? key, required this.dish}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(dish.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(dish.image),
            SizedBox(height: 16),
            Text(
              dish.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text('Store: ${dish.store}'),
            SizedBox(height: 16),
            Text('\$${dish.price}', style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
