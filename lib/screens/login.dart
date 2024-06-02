import 'package:flutter/material.dart';
import 'package:mis_productos/services/firebase_service.dart';
import 'package:mis_productos/screens/home_screen.dart'; 
import 'package:mis_productos/widgets/custom_button.dart';
import '../models/user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _userName;

  Future<void> _login() async {
    try {
      User? user = await FirebaseService.getUser(
        _emailController.text,
        _passwordController.text,
      );
      if (user != null) {
        setState(() {
          _userName = user.name;
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),  
        );
      } else {
        _showErrorDialog('Usuario o contraseña incorrectos.');
      }
    } catch (e) {
      _showErrorDialog('Error al iniciar sesión: $e');
    }
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
      backgroundColor: const Color(0xFFFFFCFC),
      appBar: AppBar(
        title: Text('Iniciar Sesión'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 300,
                  width: 300,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Usuario',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 16.0),
                    CustomButton(
                      color: const Color.fromARGB(156, 255, 23, 23),
                      iconVisible: false,
                      text: "Iniciar sesión",
                      textColor: const Color.fromARGB(255, 255, 255, 255),
                      onPressed: _login,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
