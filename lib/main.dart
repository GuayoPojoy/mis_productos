// lib/main.dart

import 'package:flutter/material.dart';
import 'package:mis_productos/screens/home_screen.dart';
import 'package:mis_productos/screens/search_screen.dart';
import 'package:mis_productos/screens/food_details.dart';
import 'package:mis_productos/models/dish.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Delivery App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      routes: {
        '/shop': (context) => HomeScreen(),
        '/search': (context) => SearchScreen(),
        //'/shopping_cart': (context) => ShoppingCartScreen(), // Define esta pantalla si no está definida
        //'/admin': (context) => AdminScreen(), // Define esta pantalla si no está definida
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/food_details') {
          final Dish dish = settings.arguments as Dish;
          return MaterialPageRoute(
            builder: (context) {
              return FoodDetails(dish: dish);
            },
          );
        }
        return null;
      },
    );
  }
}
