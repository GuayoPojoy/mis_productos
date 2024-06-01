import 'package:flutter/material.dart';
import 'package:mis_productos/services/firebase_service.dart';
import 'package:mis_productos/widgets/bottom_bar.dart';
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
    try {
      List<Dish> loadedItems = await FirebaseService.getCartItems();
      setState(() {
        cartItems = loadedItems;
        calculateTotal();
      });
    } catch (e) {
      _showErrorDialog('Error loading cart items: $e');
    }
  }

  Future<void> addToCart(Dish dish) async {
    try {
      await FirebaseService.addToCart(dish);
      fetchCartItems(); // Refrescar la lista después de agregar
    } catch (e) {
      _showErrorDialog('Error adding to cart: $e');
    }
  }

  Future<void> removeFromCart(String dishId) async {
    try {
      await FirebaseService.removeFromCart(dishId);
      fetchCartItems(); // Refrescar la lista después de eliminar
    } catch (e) {
      _showErrorDialog('Error removing from cart: $e');
    }
  }

  Future<void> moveCartToOrder() async {
    try {
      await FirebaseService.moveCartToOrder();
      setState(() {
        cartItems.clear();
        total = 0;
      });
    } catch (e) {
      _showErrorDialog('Error moving items to orders: $e');
    }
  }

  void calculateTotal() {
    int sum = 0;
    for (var dish in cartItems) {
      sum += dish.price.toInt();
    }
    setState(() {
      total = sum;
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
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
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () async {
                          await addToCart(dish);
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
                  'Total: Q. $total',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await moveCartToOrder();
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
          setState(() {
            switch (index) {
              case 0:
                Navigator.pushReplacementNamed(context, '/store');
                break;
              case 1:
                Navigator.pushReplacementNamed(context, '/search');
                break;
              case 2:
                Navigator.pushReplacementNamed(context, '/shopping_cart');
                break;
              case 3:
                Navigator.pushReplacementNamed(context, '/admin');
                break;
            }
          });
        },
      ),
    );
  }
}
