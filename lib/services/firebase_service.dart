

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/dish.dart';

class FirebaseService {
  static final String _baseUrl = "atumesa-83fd8-default-rtdb.firebaseio.com";

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
}
