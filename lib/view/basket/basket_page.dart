import 'package:flutter/material.dart';
import 'package:pharmacy/theme/app_colors.dart';
import 'package:pharmacy/res/styles/styles.dart'; 
import 'package:pharmacy/view/search/search_page.dart'; 

class BasketPage extends StatefulWidget {
  const BasketPage({super.key});

  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  // Список товаров в корзине (пример данных)
  // В реальном приложении это будет из State Management (Provider, BLoC, Riverpod и т.д.)
  final List<CartItem> _cartItems = [
    CartItem(
      product: Product(name: 'Название товара в несколько строк, а также объем или штучность товара', price: '999,99 ₽', oldPrice: '1 299,99 ₽'),
      quantity: 1,
      isSelected: false,
      requiresPrescription: false,
    ),
    CartItem(
      product: Product(name: 'Название товара в несколько строк, а также объем или штучность товара', price: '999,99 ₽', oldPrice: '1 299,99 ₽'),
      quantity: 1,
      isSelected: true, // Этот товар выбран по умолчанию, как на макете
      requiresPrescription: false,
    ),
    CartItem(
      product: Product(name: 'Название товара в несколько строк, а также объем или штучность товара', price: '999,99 ₽', oldPrice: '1 299,99 ₽'),
      quantity: 1,
      isSelected: false,
      requiresPrescription: true, // Пример товара по рецепту
    ),
  ];

  bool _selectAll = false; // Состояние "Выбрать все"

  // Метод для переключения выбора всех товаров
  void _toggleSelectAll(bool? value) {
    setState(() {
      _selectAll = value ?? false;
      for (var item in _cartItems) {
        item.isSelected = _selectAll;
      }
    });
    _calculateTotalPrice(); // Пересчитываем сумму после выбора/снятия выбора
  }

  // Метод для переключения выбора отдельного товара
  void _toggleItemSelection(bool? value, int index) {
    setState(() {
      _cartItems[index].isSelected = value ?? false;
      // Если какой-то товар не выбран, то "Выбрать все" тоже не должен быть выбран
      if (!_cartItems[index].isSelected) {
        _selectAll = false;
      } else {
        // Если все товары выбраны, то "Выбрать все" должен быть выбран
        _selectAll = _cartItems.every((item) => item.isSelected);
      }
    });
    _calculateTotalPrice();
  }

  // Метод для изменения количества товара
  void _updateQuantity(int index, int delta) {
    setState(() {
      int newQuantity = _cartItems[index].quantity + delta;
      if (newQuantity > 0) { // Количество не может быть меньше 1
        _cartItems[index].quantity = newQuantity;
      } else {
        // Опционально: удалить товар, если количество стало 0
        _cartItems.removeAt(index);
      }
    });
    _calculateTotalPrice();
  }

  // Метод для удаления выбранных товаров
  void _deleteSelectedItems() {
    setState(() {
      _cartItems.removeWhere((item) => item.isSelected);
      _selectAll = false; // Сбросить "Выбрать все" после удаления
    });
    _calculateTotalPrice();
  }

  // Метод для расчета общей суммы
  String _calculateTotalPrice() {
    double total = 0.0;
    for (var item in _cartItems) {
      if (item.isSelected) {
        // Пример парсинга цены (предполагаем, что цена в формате "X XXX,YY ₽")
        // Это упрощенная логика, в реальном проекте используйте более надежный парсинг
        try {
          String priceString = item.product.price.replaceAll(' ', '').replaceAll('₽', '').replaceAll(',', '.');
          double price = double.parse(priceString);
          total += price * item.quantity;
        } catch (e) {
          // print('Ошибка парсинга цены: ${item.product.price}, $e');
        }
      }
    }
    return '${total.toStringAsFixed(2).replaceAll('.', ',')} ₽';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Заголовок "Укажите пункт выдачи заказа" и выбор пункта
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Укажите пункт выдачи заказа',
                style: AppTextStyles.bodyText.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              // Например, DropdownButton или IconButton для открытия карты/списка
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.textHint.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Выбрать пункт выдачи...', style: AppTextStyles.bodyText.copyWith(color: AppColors.textHint)),
                    const Icon(Icons.location_on, color: AppColors.textHint),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(), // Разделитель

        // Выбрать все / Удалить выбранные
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: _selectAll,
                    onChanged: _toggleSelectAll,
                    activeColor: AppColors.success,
                  ),
                  Text('Выбрать все', style: AppTextStyles.bodyText),
                ],
              ),
              TextButton.icon(
                onPressed: _deleteSelectedItems,
                icon: const Icon(Icons.delete_outline, color: Colors.grey),
                label: Text('Удалить выбранные', style: AppTextStyles.bodyText.copyWith(color: Colors.grey)),
              ),
            ],
          ),
        ),

        // Список товаров в корзине
        Expanded(
          child: ListView.builder(
            itemCount: _cartItems.length,
            itemBuilder: (context, index) {
              final item = _cartItems[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Checkbox товара
                    Checkbox(
                      value: item.isSelected,
                      onChanged: (value) => _toggleItemSelection(value, index),
                      activeColor: AppColors.success,
                    ),
                    // Изображение товара
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.success),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Image.asset("lib/res/icons/tmc.png"), // Изображение товара
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Детали товара
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.product.name,
                            style: AppTextStyles.bodyText.copyWith(fontWeight: FontWeight.bold),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          // Количество и цена
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.success.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: AppColors.success),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () => _updateQuantity(index, -1),
                                      child: Icon(Icons.remove, size: 16, color: AppColors.success),
                                    ),
                                    Text(' ${item.quantity} ', style: AppTextStyles.bodyText.copyWith(color: AppColors.success)),
                                    GestureDetector(
                                      onTap: () => _updateQuantity(index, 1),
                                      child: Icon(Icons.add, size: 16, color: AppColors.success),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                item.product.price,
                                style: AppTextStyles.bodyText.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          if (item.requiresPrescription) // Показываем, если нужен рецепт
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                children: [
                                  const Icon(Icons.warning_amber_rounded, color: AppColors.warning, size: 16),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Товар отпускается по рецепту',
                                    style: AppTextStyles.hintText.copyWith(color: AppColors.warning),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        // Нижняя панель с кнопкой "Оформить заказ" и итоговой суммой
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor, // Используем цвет фона Scaffold
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, -3), // Тень сверху
              ),
            ],
          ),
          child: SafeArea( // Чтобы не залезать под системные UI-элементы
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Логика оформления заказа
                      // print('Оформить заказ на сумму: ${_calculateTotalPrice()}');
                  
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.success,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      'Оформить заказ',
                      style: AppTextStyles.buttonTextStyle,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Итоговая сумма заказа
                Text(
                  _calculateTotalPrice(),
                  style: AppTextStyles.headline.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary, // Или AppColors.success, если сумма зеленая
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// Вспомогательный класс для элемента корзины
class CartItem {
  final Product product;
  int quantity;
  bool isSelected;
  final bool requiresPrescription;

  CartItem({
    required this.product,
    this.quantity = 1,
    this.isSelected = false,
    this.requiresPrescription = false,
  });
}