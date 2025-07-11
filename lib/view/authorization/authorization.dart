import 'package:flutter/material.dart';
import 'package:pharmacy/widgets/initial_view.dart';
import 'package:pharmacy/widgets/phone_input.dart';
import 'package:pharmacy/widgets/phone_verifications.dart';

enum AuthState { initial, phoneInput, phoneVerifications }

class Authorization extends StatefulWidget {
  const Authorization({super.key});

  @override
  State<Authorization> createState() => _AuthorizationState();
}

class _AuthorizationState extends State<Authorization> {
  AuthState _authState = AuthState.initial;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  // Логика перехода на экран верификации
  void _sendCode() {
    final phoneNumber = _phoneController.text;
    print('Отправляем код на номер: $phoneNumber');
    
     setState(() {
            _authState = AuthState.phoneVerifications;
          });
  }

  // Логика смены состояния UI
  void _showPhoneInput() {
    setState(() {
      _authState = AuthState.phoneInput;
    });
  }
  void _verifyCode() {
    final code = _codeController.text;
    print('Проверяем код: $code');
    // Здесь будет логика проверки кода:
    // если код верный -> переход на главный экран приложения
    // если неверный -> показать ошибку
    
    // Например, после успешной верификации:
    // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomePage()));

    setState(() {
      _codeController.clear();
      _authState = AuthState.phoneInput;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Авторизация'),
        centerTitle: true,
      ),
      body: _buildUI(), // Тело осталось прежним
    );
  }

  // Метод выбора виджета стал намного проще
  Widget _buildUI() {
    switch (_authState) {
      case AuthState.initial:
        // Используем InitialView и передаем ему функцию
        return InitialView(onLoginPressed: _showPhoneInput);
      case AuthState.phoneInput:
        // Используем PhoneInputView и передаем ему контроллер и функцию
        return PhoneInputView(
          phoneController: _phoneController,
          onSendCodePressed: _sendCode,
        );
       case AuthState.phoneVerifications:
       return PhoneVerificationView(
        phoneNumber: _phoneController.text,
        codeController: _codeController,
        onVerifyAndLoginPressed: _sendCode,
        onResendCodePressed: _verifyCode);        
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }
}