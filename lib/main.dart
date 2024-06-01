import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mis_productos/screens/home_screen.dart';
import 'package:mis_productos/screens/initial.dart';
import 'package:mis_productos/screens/login.dart';
import 'package:mis_productos/screens/register.dart';
import 'package:mis_productos/screens/search_screen.dart';
import 'package:mis_productos/screens/shopping_cart.dart';
import 'package:mis_productos/screens/admin.dart'; // Importar AdminScreen
import 'package:mis_productos/screens/reservation.dart'; // Importar ReservationScreen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "YOUR_API_KEY",
      authDomain: "YOUR_AUTH_DOMAIN",
      projectId: "YOUR_PROJECT_ID",
      storageBucket: "YOUR_STORAGE_BUCKET",
      messagingSenderId: "YOUR_MESSAGING_SENDER_ID",
      appId: "YOUR_APP_ID",
      measurementId: "YOUR_MEASUREMENT_ID",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Delivery App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => InitialScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/store': (context) => HomeScreen(),
        '/search': (context) => SearchScreen(),
        '/shopping_cart': (context) => ShoppingCartScreen(),
        '/admin': (context) => AdminScreen(), // Añadir la ruta de AdminScreen
        '/reservation': (context) => ReservationScreen(), // Añadir la ruta de ReservationScreen
      },
    );
  }
}
