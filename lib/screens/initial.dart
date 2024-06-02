import 'package:flutter/material.dart';
import 'package:mis_productos/widgets/custom_button.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage("assets/images/backgorund1.png"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5),
              BlendMode.darken,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            Image.asset(
              "assets/images/logo.png",
              width: 300,
              height: 300,
            ),
            SizedBox(height: 32),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  color: const Color.fromARGB(156, 255, 23, 23),
                  iconVisible: false,
                  text: "Iniciar sesión",
                  textColor: const Color.fromARGB(255, 255, 255, 255),
                  onPressed: () => _navigateTo(context, '/login'),
                ),
                SizedBox(height: 16),
                CustomButton(
                  color: const Color.fromARGB(156, 255, 255, 255),
                  iconVisible: false,
                  text: "Continuar con Google",
                  textColor: const Color.fromARGB(255, 0, 0, 0),
                  onPressed: () => _continueWithGoogle(),
                ),
                SizedBox(height: 16),
                CustomButton(
                  color: const Color.fromARGB(156, 23, 120, 255),
                  iconVisible: false,
                  text: "Crear Cuenta",
                  textColor: const Color.fromARGB(255, 255, 255, 255),
                  onPressed: () => _navigateTo(context, '/register'),
                ),
                SizedBox(height: 32),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _navigateTo(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName).catchError((error) {
      
      print('Error navigating to $routeName: $error');
    });
  }

  void _continueWithGoogle() {
    
    print('Continuar con Google');
  }
}
