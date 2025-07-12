import 'package:flutter/material.dart';
import 'package:pharmacy/theme/app_colors.dart'; 

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Блок с информацией о пользователе
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: const AssetImage("lib/res/icons/avatar.png"),
                    onBackgroundImageError: (exception, stackTrace) {
                    },
                  ),
                const SizedBox(width: 16),
                const Text(
                  'Фамилия Имя', // Здесь будет реальное имя пользователя
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          const Divider(), 
          // Секция "Текущие заказы"
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Текущие заказы',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          _buildOrderList(context, true), // true для текущих заказов
          const SizedBox(height: 16),

          // Секция "Завершенные заказы"
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Завершенные заказы',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          _buildOrderList(context, false), // false для завершенных заказов
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildOrderList(BuildContext context, bool isCurrent) {
    final List<Map<String, dynamic>> orders = [
      {
        'id': '12345786',
        'status': isCurrent ? 'сборка' : 'готов к выдаче',
        'address': isCurrent ? 'ул. Ленина, д. ...' : 'ул. Пушкина, д...',
        'isBordered': isCurrent, 
      },
      {
        'id': '12345787',
        'status': isCurrent ? 'на рассмотрении' : 'получен',
        'address': isCurrent ? 'ул. Павловский...' : 'ул. Гоголя, д...',
        'isBordered': isCurrent,
      },
    ];

    return SizedBox(
      height: 220, // Фиксированная высота для Horizontal ListView
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Container(
            width: 180, // Ширина одной карточки заказа
            margin: const EdgeInsets.only(right: 16.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: order['isBordered'] ? Colors.red : Colors.grey[300]!, // Красная рамка для текущих
                width: order['isBordered'] ? 2.0 : 1.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Center(
                    child: Image.asset(
                      "lib/res/icons/tmc.png", // Изображение-заполнитель для заказа
                      width: 60,
                      height: 60,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Text(
                    '№ ${order['id']}',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Text(
                    order['status'],
                    style: TextStyle(
                      fontSize: 12,
                      color: order['isBordered'] ? Colors.red : Colors.green[700], // Цвет статуса
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Text(
                    order['address'],
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          );
        },
      ),
    );
  }
}