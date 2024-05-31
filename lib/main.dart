import 'package:flutter/material.dart';
import 'package:mis_productos/screens/food_details.dart';
import 'package:mis_productos/screens/home_screen.dart'; // Asegúrate de importar tus pantallas
import 'package:mis_productos/screens/search_screen.dart';
import 'package:mis_productos/screens/shopping_cart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mis Productos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(), // Pantalla de inicio por defecto
        '/home': (context) => HomeScreen(), // Asegúrate de que la ruta '/home' esté definida
        '/search': (context) => SearchScreen(),
        '/shopping_cart': (context) => ShoppingCartScreen(),
        // Agrega más rutas según sea necesario
      },
    );
  }
}
