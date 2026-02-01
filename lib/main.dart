import 'package:flutter/material.dart';
import 'view/authorization/authorization.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  runApp(const Pharmacy());
}

class Pharmacy extends StatelessWidget {
  const Pharmacy({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Auth Demo',
      theme: ThemeData(
        splashColor: const Color.fromARGB(255, 18, 184, 26),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      
      home: const Authorization(), // Начинаем с экрана авторизации
    );
  }
}
