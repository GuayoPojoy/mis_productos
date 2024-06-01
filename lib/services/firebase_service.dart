// services/firebase_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/dish.dart';
import '../models/user.dart';

class FirebaseService {
  static final String _baseUrl = "atumesa-83fd8-default-rtdb.firebaseio.com";

  // Obtener todos los platillos
  static Future<List<Dish>> getDishes() async {
    final response = await http.get(Uri.https(_baseUrl, '/Comida.json'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      List<Dish> dishes = [];
      data.forEach((key, value) {
        dishes.add(Dish.fromJson(value));
      });
      return dishes;
    } else {
      throw Exception('Failed to load dishes');
    }
  }

  // Agregar un platillo al carrito
  static Future<void> addToCart(Dish dish) async {
    final response = await http.post(
      Uri.https(_baseUrl, '/Cart.json'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(dish.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add to cart');
    }
  }

  // Eliminar un platillo del carrito
  static Future<void> removeFromCart(String dishId) async {
    final response = await http.delete(
      Uri.https(_baseUrl, '/Cart/$dishId.json'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to remove from cart');
    }
  }

  // Mover los platillos del carrito a órdenes
  static Future<void> moveCartToOrder() async {
    final cartResponse = await http.get(
      Uri.https(_baseUrl, '/Cart.json'),
    );

    if (cartResponse.statusCode == 200) {
      final Map<String, dynamic> cartData = json.decode(cartResponse.body);

      // Agregar los elementos del carrito a la sección de órdenes
      final orderResponse = await http.post(
        Uri.https(_baseUrl, '/Orders.json'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(cartData),
      );

      if (orderResponse.statusCode == 200) {
        // Eliminar los elementos del carrito después de moverlos a órdenes
        await clearCart();
      } else {
        throw Exception('Failed to move items to orders');
      }
    } else {
      throw Exception('Failed to load cart items');
    }
  }

  // Limpiar el carrito
  static Future<void> clearCart() async {
    final response = await http.delete(
      Uri.https(_baseUrl, '/Cart.json'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to clear cart');
    }
  }

  // Obtener datos del usuario para inicio de sesión
  static Future<User?> getUser(String email, String password) async {
    final response = await http.get(Uri.https(_baseUrl, '/users.json'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['mail'] == email && data['pass'].toString() == password) {
        return User.fromJson(data);
      } else {
        return null;
      }
    } else {
      throw Exception('Failed to load user data');
    }
  }

  // Crear un nuevo usuario
  static Future<void> createUser(User user) async {
    final response = await http.post(
      Uri.https(_baseUrl, '/users.json'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create user');
    }
  }
}
