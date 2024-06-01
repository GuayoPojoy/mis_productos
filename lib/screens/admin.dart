import 'package:flutter/material.dart';
import 'package:mis_productos/screens/reservation.dart'; // Importar ReservationScreen
import 'package:mis_productos/widgets/bottom_bar.dart';
import 'package:mis_productos/widgets/square_button.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Acción para cerrar sesión
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
                Text('Nombre de usuario'),
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
                          // Acción para llamar al mesero
                        },
                      ),
                      AdminActionButton(
                        icon: Icons.book,
                        label: 'Pedir Cuenta',
                        onPressed: () {
                          // Acción para pedir la cuenta
                        },
                      ),
                      AdminActionButton(
                        icon: Icons.payment,
                        label: 'Pagar Cuenta',
                        onPressed: () {
                          // Acción para pagar la cuenta
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
                      // Agregar más botones aquí si es necesario
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
              // Ya estás en la pantalla de administrador, no necesitas navegar a ella
              break;
            default:
              break;
          }
        },
      ),
    );
  }
}
