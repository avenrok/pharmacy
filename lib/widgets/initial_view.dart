import 'package:flutter/material.dart';

class InitialView extends StatelessWidget {
  // Функция, которая будет вызвана при нажатии на кнопку
  final VoidCallback onLoginPressed;

  const InitialView({
    super.key,
    required this.onLoginPressed, 
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
        ),
        // При нажатии вызываем переданную функцию
        onPressed: onLoginPressed,
        child: const Text('Войти', 
          style: 
            TextStyle(
              fontSize: 24,
              fontFamily:'FiraSans',
              fontWeight: FontWeight.w400)
              ),
      ),
    );
  }
}