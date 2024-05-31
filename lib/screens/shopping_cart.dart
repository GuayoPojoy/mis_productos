import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mis_productos/widgets/bottom_bar.dart';
import 'dart:convert';
import '../models/dish.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({Key? key}) : super(key: key);

  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  List<Dish> cartItems = [];
  int total = 0;

  @override
  void initState() {
    super.initState();
    fetchCartItems();
  }

  Future<void> fetchCartItems() async {
    final response = await http.get(Uri.https('atumesa-83fd8-default-rtdb.firebaseio.com', '/Cart.json'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<Dish> loadedItems = [];
      data.forEach((key, value) {
        final dish = Dish.fromJson(value);
        dish.id = key; // Asigna la clave de Firebase al campo id del plato
        loadedItems.add(dish);
      });
      setState(() {
        cartItems = loadedItems;
        calculateTotal();
      });
    } else {
      throw Exception('Failed to load cart items');
    }
  }

  Future<void> addToCart(Dish dish) async {
    final response = await http.post(
      Uri.https('atumesa-83fd8-default-rtdb.firebaseio.com', '/Cart.json'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(dish.toJson()),
    );

    if (response.statusCode == 200) {
      // Successfully added to cart
      print('Added to cart');
    } else {
      throw Exception('Failed to add to cart');
    }
  }

  Future<void> removeFromCart(String dishId) async {
    final response = await http.delete(
      Uri.https('atumesa-83fd8-default-rtdb.firebaseio.com', '/Cart/$dishId.json'),
    );

    if (response.statusCode == 200) {
      // Successfully removed from cart
      print('Removed from cart');
    } else {
      throw Exception('Failed to remove from cart');
    }
  }

  void calculateTotal() {
    int sum = 0;
    for (var dish in cartItems) {
      sum += dish.price.toInt(); // Asegúrate de que el precio sea int
    }
    setState(() {
      total = sum;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orden'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final dish = cartItems[index];
                return ListTile(
                  title: Text(dish.name),
                  subtitle: Text('${dish.price}'),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(dish.image),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () async {
                          await removeFromCart(dish.id!);
                          setState(() {
                            cartItems.removeAt(index);
                            calculateTotal();
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () async {
                          await addToCart(dish);
                          setState(() {
                            cartItems.add(dish);
                            calculateTotal();
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: Q. $total', // Muestra el total de la compra
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Lógica para realizar la orden
                    // Puedes implementar tu lógica aquí
                  },
                  child: Text('Ordenar'),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomBar(
        selectedIndex: 2,
        onTabSelected: (index) {
          if (index != 2) {
            Navigator.of(context).pushReplacementNamed(
              index == 0 ? '/shop' : '/search',
            );
          } else {
            print('Selected shopping cart');
          }
        },
      ),
    );
  }
}
