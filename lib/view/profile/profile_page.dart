import 'package:flutter/material.dart';
import 'package:pharmacy/theme/app_colors.dart';
import 'package:pharmacy/res/styles/styles.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          // Секция "Текущие заказы"
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0), // Немного больше отступ сверху
            child: Text(
              'Текущие заказы',
              style: AppTextStyles.headline.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          _buildOrderList(context, true), // true для текущих заказов
          const SizedBox(height: 16),

          // Секция "Завершенные заказы"
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0), // Немного больше отступ сверху
            child: Text(
              'Завершенные заказы',
              style: AppTextStyles.headline.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          _buildOrderList(context, false), // false для завершенных заказов
          const SizedBox(height: 16),

        ],
      ),
    );
  }

  Widget _buildOrderList(BuildContext context, bool isCurrent) {
    // Демо-данные для заказов
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
      // Добавьте больше заказов по мере необходимости
    ];

    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Container(
            width: 180,
            margin: const EdgeInsets.only(right: 16.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: order['isBordered'] ? AppColors.error : Colors.grey[300]!,
                width: order['isBordered'] ? 2.0 : 1.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.1),
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
                      "lib/res/icons/tmc.png",
                      width: 60,
                      height: 60,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Text(
                    '№ ${order['id']}',
                    style: AppTextStyles.bodyText.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Text(
                    order['status'],
                    style: AppTextStyles.bodyText.copyWith(
                      color: order['isBordered'] ? AppColors.error : AppColors.success,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Text(
                    order['address'],
                    style: AppTextStyles.caption.copyWith(color: Colors.grey[600]),
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