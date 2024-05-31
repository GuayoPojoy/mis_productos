import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final bool iconVisible; // Define el parámetro como opcional
  final Color color;
  final String text;
  final Color textColor;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    this.iconVisible = true, // Asigna un valor por defecto
    required this.color,
    required this.text,
    required this.textColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0), // Añade espacio a ambos lados
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconVisible) // Verifica si el icono es visible
              Icon(Icons.add), // Agrega el icono si es visible
            SizedBox(width: iconVisible ? 8.0 : 0), // Agrega un espacio si el icono es visible
            Text(
              text,
              style: TextStyle(color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
