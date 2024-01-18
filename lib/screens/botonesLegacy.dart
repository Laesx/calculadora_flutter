import 'package:flutter/material.dart';

// creating Stateless Widget for buttons
class MyButton extends StatelessWidget {
  // declaring variables
  final color;
  final textColor;
  final String buttonText;
  final buttontapped;
  final IconData? icon;

  //Constructor
  const MyButton(
      {super.key,
      this.color,
      this.textColor,
      required this.buttonText,
      this.buttontapped,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttontapped,
      child: Padding(
        padding: const EdgeInsets.all(0.2),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Container(
            color: color,
            child: Center(
              // Si el icono es nulo, no se muestra y se muestra texto
              child: icon != null
                  ? Icon(
                      icon,
                      color: textColor,
                    )
                  : Text(
                      buttonText,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
