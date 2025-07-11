import 'package:flutter/material.dart';

class PhoneVerificationView extends StatelessWidget {
  // Просто строка для отображения номера
  final String phoneNumber;
  // Контроллер для поля ввода КОДА
  final TextEditingController codeController;
  // Колбэки для КАЖДОЙ кнопки
  final VoidCallback onVerifyAndLoginPressed; // Кнопка "Войти"
  final VoidCallback onResendCodePressed;     // Кнопка "Отправить повторно"

  const PhoneVerificationView({
    super.key,
    required this.phoneNumber,
    required this.codeController,
    required this.onVerifyAndLoginPressed,
    required this.onResendCodePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Код отправлен на номер\n$phoneNumber',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: codeController,
            keyboardType: TextInputType.number, // Клавиатура для цифр
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24, letterSpacing: 8),
            decoration: const InputDecoration(
              labelText: 'Код подтверждения',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          // Основная кнопка "Войти"
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            onPressed: onVerifyAndLoginPressed, // Используем колбэк для входа
            child: const Text('Войти', style: TextStyle(fontSize: 18)),
          ),
          const SizedBox(height: 12),
          // Дополнительная кнопка для повторной отправки кода
          TextButton(
            onPressed: onResendCodePressed, // Используем колбэк для повторной отправки
            child: const Text('Отправить код повторно'),
          ),
        ],
      ),
    );
  }
}