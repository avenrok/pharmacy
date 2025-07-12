import 'package:flutter/material.dart';
import 'package:pharmacy/widgets/initial_view.dart';
import 'package:pharmacy/widgets/phone_input.dart';
import 'package:pharmacy/widgets/phone_verifications.dart';
import 'package:pharmacy/view/main_page/main_page.dart';

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
    // final phoneNumber = _phoneController.text;
    // print('Отправляем код на номер: $phoneNumber');
    
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

   void _verifyAndNavigateToMain() {
    // final code = _codeController.text;
    // print('Проверяем код: $code');
    // Здесь будет реальная логика проверки кода:
    // если код верный -> выполняем навигацию
    // если неверный -> показываем ошибку (не реализовано здесь)

    // При успешной верификации:
    _codeController.clear(); // Очищаем поле кода
    // ИСПРАВЛЕНИЕ: Выполняем переход на MainScreen
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const MainScreen()));
  }

  void _resendCode() {
    // print('Отправляем код повторно на номер: ${_phoneController.text}');
    // В реальном приложении здесь будет API вызов для повторной отправки
    // Возможно, сброс таймера или что-то еще.
    // _codeController.clear(); // Опционально очистить поле кода
    // Можно также остаться на текущем состоянии PhoneVerificationView
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
        onVerifyAndLoginPressed: _verifyAndNavigateToMain,
        onResendCodePressed: _resendCode);        
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _codeController.dispose();
    super.dispose();
  }
}