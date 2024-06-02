import 'package:flutter/material.dart';
import 'package:mis_productos/services/firebase_service.dart';
import 'package:mis_productos/widgets/bottom_bar.dart';
import 'package:mis_productos/widgets/square_button.dart';

class AdminScreen extends StatelessWidget {
  final String userName;

  const AdminScreen({Key? key, required this.userName}) : super(key: key);

  void _sendNotification(BuildContext context, String message) async {
    try {
      await FirebaseService.sendNotification(message);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Notificación enviada: $message')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al enviar notificación: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/profile_image.jpg'),
                  radius: 50,
                ),
                SizedBox(height: 8),
                Text(userName),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AdminActionButton(
                        icon: Icons.call,
                        label: 'Llamar Mesero',
                        onPressed: () {
                          _sendNotification(context, 'Mesa está llamando al mesero');
                        },
                      ),
                      AdminActionButton(
                        icon: Icons.book,
                        label: 'Pedir Cuenta',
                        onPressed: () {
                          _sendNotification(context, 'Mesa pidió la cuenta');
                        },
                      ),
                      AdminActionButton(
                        icon: Icons.payment,
                        label: 'Pagar Cuenta',
                        onPressed: () {
                          Navigator.pushNamed(context, '/payment');
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AdminActionButton(
                        icon: Icons.restaurant,
                        label: 'Reservar Mesa',
                        onPressed: () {
                          Navigator.pushNamed(context, '/reservation');
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomBar(
        selectedIndex: 3,
        onTabSelected: (index) {
          switch (index) {
            case 0:
              Navigator.of(context).pushReplacementNamed('/store');
              break;
            case 1:
              Navigator.of(context).pushReplacementNamed('/search');
              break;
            case 2:
              Navigator.of(context).pushReplacementNamed('/shopping_cart');
              break;
            case 3:
              // Already in admin screen, no action needed
              break;
            default:
              break;
          }
        },
      ),
    );
  }
}
