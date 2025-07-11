import 'package:flutter/material.dart';

class PhoneInputView extends StatelessWidget {
  final TextEditingController phoneController;
  final VoidCallback onSendCodePressed;

  const PhoneInputView({
    super.key,
    required this.phoneController,
    required this.onSendCodePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Введите номер телефона',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          TextField(
            // Используем переданный контроллер
            controller: phoneController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              labelText: 'Номер телефона',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.phone),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            // Вызываем переданный колбэк
            onPressed: onSendCodePressed,
            child: const Text(
              'Отправить код подтверждения',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}