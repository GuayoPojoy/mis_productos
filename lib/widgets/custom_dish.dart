import 'package:flutter/material.dart';
import 'package:mis_productos/models/dish.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mis_productos/screens/food_details.dart';

class CustomDish extends StatelessWidget {
  final Dish dish;

  const CustomDish({required this.dish, Key? key}) : super(key: key);

  Future<void> _addToCart(Dish dish) async {
    final response = await http.post(
      Uri.https('atumesa-83fd8-default-rtdb.firebaseio.com', '/Cart.json'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'name': dish.name,
        'image': dish.image,
        'price': dish.price,
        'store': dish.store,
      }),
    );

    if (response.statusCode == 200) {
      // Successfully added to cart
      print('Added to cart');
    } else {
      throw Exception('Failed to add to cart');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(dish.image),
        title: Text(dish.name),
        subtitle: Text(dish.store),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('\$${dish.price.toString()}'),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _addToCart(dish);
              },
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FoodDetails(dish: dish),
            ),
          );
        },
      ),
    );
  }
}
