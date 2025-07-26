import 'package:flutter/material.dart';
import 'package:pharmacy/theme/app_colors.dart';
import 'package:pharmacy/res/styles/styles.dart';


class Order extends StatelessWidget {
  const Order({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Возвращаемся на предыдущий экран в ProfileNavigator
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Оформление заказа',
          style: AppTextStyles.headline.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Пункт выдачи заказа: ул. Павловский тракт, д. 283',
              style:
                  AppTextStyles.bodyText.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16.0),
            // Пример товаров в заказе (можно сделать динамическими, передавая список)
            _buildOrderItem(
              productName:
                  'Название товара такое длинное, что даже не может поместиться в одну строку',
              price: '999,99 ₽',
              quantity: '99 шт.',
              totalPrice: '1 999,99 ₽',
              imagePath: 'lib/res/icons/tmc.png',
            ),
            const SizedBox(height: 16.0),
            _buildOrderItem(
              productName:
                  'Название товара такое длинное, что даже не может поместиться в одну строку',
              price: '999,99 ₽',
              quantity: '99 шт.',
              totalPrice: '1 999,99 ₽',
              imagePath: 'lib/res/icons/tmc.png',
              hasWarning: true,
            ),
            const SizedBox(height: 16.0),
            _buildOrderItem(
              productName:
                  'Название товара такое длинное, что даже не может поместиться в одну строку',
              price: '999,99 ₽',
              quantity: '99 шт.',
              totalPrice: '1 999,99 ₽',
              imagePath: 'lib/res/icons/tmc.png',
            ),
            const SizedBox(height: 32.0),
            const SizedBox(
                height:
                    100), // Достаточно, чтобы прокрутить контент выше кнопки
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color:
              Theme.of(context).scaffoldBackgroundColor, // Цвет фона Scaffold
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, -3), // Тень сверху
            ),
          ],
        ),
        child: SafeArea(
          // Убедимся, что не залезает под системные UI-элементы
          child: Column(
            mainAxisSize: MainAxisSize
                .min, // Занимать минимальное пространство по вертикали
            children: [
              Align(
                alignment:
                    Alignment.centerRight, // Выравниваем вправо, как на макете
                child: Row(
                  mainAxisSize: MainAxisSize
                      .min, // Чтобы Row занимал только необходимую ширину
                  children: [
                    Text(
                      'Итоговая сумма заказа:',
                      style: AppTextStyles.headline
                          .copyWith(fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(width: 8.0),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 6.0),
                      decoration: BoxDecoration(
                        color: AppColors.error, // Красный фон
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Text(
                        '1 999,99 ₽', // Динамическая сумма
                        style: AppTextStyles.headline.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16), // Промежуток между суммой и кнопкой
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.success, // Зеленый цвет
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  child: Text(
                    'Заказать',
                    style: AppTextStyles.buttonTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderItem({
    required String productName,
    required String price,
    required String quantity,
    required String totalPrice,
    required String imagePath,
    bool hasWarning = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Изображение товара
          Container(
            width: 80,
            height: 80,
            color: Colors.white,
            child: Center(
              child: Image.asset(imagePath, width: 60, height: 60),
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: AppTextStyles.bodyText
                      .copyWith(fontWeight: FontWeight.bold),
                  maxLines: 2,
                  selectionColor: Colors.white,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    const SizedBox(height: 4.0),
                    Text(
                      price.split(' ')[0],
                      style: AppTextStyles.headline.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.error,
                      ),
                    ),
                    const SizedBox(width: 4.0),
                    Image.asset(
                      'lib/res/icons/valutRu.png',
                      width: 14,
                      height: 14,
                      color: AppColors.error,
                    ),
                    const SizedBox(width: 32),
                    Text(
                      quantity,
                      style:
                          AppTextStyles.bodyText.copyWith(color: Colors.grey),
                    ),
                    const SizedBox(width: 64),
                    Text(
                      totalPrice,
                      style: AppTextStyles.bodyText.copyWith(
                          color: AppColors.success,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                if (hasWarning) ...[
                  const SizedBox(height: 4.0),
                  Row(
                    children: [
                      Icon(Icons.warning_amber_rounded,
                          size: 16, color: Colors.orange),
                      const SizedBox(width: 4.0),
                      Text(
                        'Товар отпускается по рецепту',
                        style: AppTextStyles.hintText
                            .copyWith(color: Colors.orange),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
