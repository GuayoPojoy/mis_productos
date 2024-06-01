import 'package:flutter/material.dart';
import 'package:mis_productos/screens/home_screen.dart';
import 'package:mis_productos/screens/initial.dart';
import 'package:mis_productos/screens/login.dart';
import 'package:mis_productos/screens/register.dart';
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
      initialRoute: Routes.initial,
      routes: Routes.getRoutes(),
    );
  }
}

class Routes {
  static const String initial = '/';
  static const String home = '/home';
  static const String search = '/search';
  static const String shoppingCart = '/shopping_cart';
  static const String login = '/login';
  static const String register = '/register';
  static const String store = '/home'; // Verifica si esta ruta debe ser /home

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      initial: (context) => InitialScreen(),
      home: (context) => HomeScreen(),
      search: (context) => SearchScreen(),
      shoppingCart: (context) => ShoppingCartScreen(),
      login: (context) => LoginScreen(),
      register: (context) => RegisterScreen(),
      store: (context) => HomeScreen(), // Verifica esta línea
    };
  }
}
