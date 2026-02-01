import 'package:flutter/material.dart';
import 'package:pharmacy/models/cart_item.dart';
import 'package:pharmacy/models/product.dart';
import 'package:pharmacy/view/profile/order_page.dart';
import 'package:pharmacy/widgets/cart_item_tile.dart';
import 'package:pharmacy/widgets/basket_bottom_bar.dart';
import 'package:pharmacy/widgets/cart_action_bar.dart';
import 'package:pharmacy/widgets/pickup_location_selector.dart';

class BasketPage extends StatefulWidget {
  const BasketPage({super.key});

  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  final List<CartItem> _cartItems = [
    CartItem(
      product: Product(
        id: 1,
        name:
            'Название товара в несколько строк, а также объем или штучность товара',
        price: 999.99,
        oldPrice: 1299.99,
      ),
    ),
    CartItem(
      product: Product(
        id: 2,
        name:
            'Название товара в несколько строк, а также объем или штучность товара',
        price: 999.99,
        oldPrice: 1299.99,
      ),
      isSelected: true,
    ),
    CartItem(
      product: Product(
        id: 3,
        name:
            'Название товара в несколько строк, а также объем или штучность товара',
        price: 999.99,
        oldPrice: 1299.99,
      ),
      requiresPrescription: true,
    ),
  ];

  bool _selectAll = false;

  void _toggleSelectAll(bool? value) {
    setState(() {
      _selectAll = value ?? false;
      for (var item in _cartItems) {
        item.isSelected = _selectAll;
      }
    });
  }

  void _toggleItemSelection(bool? value, int index) {
    setState(() {
      _cartItems[index].isSelected = value ?? false;
      _selectAll = _cartItems.every((item) => item.isSelected);
    });
  }

  void _updateQuantity(int index, int delta) {
    setState(() {
      int newQuantity = _cartItems[index].quantity + delta;
      if (newQuantity > 0) {
        _cartItems[index].quantity = newQuantity;
      } else {
        _cartItems.removeAt(index);
      }
    });
  }

  void _deleteSelectedItems() {
    setState(() {
      _cartItems.removeWhere((item) => item.isSelected);
      _selectAll = false;
    });
  }

  String _calculateTotalPrice() {
    double total = 0;
    for (var item in _cartItems) {
      if (item.isSelected) total += item.product.price * item.quantity;
    }
    return '${total.toStringAsFixed(2).replaceAll('.', ',')} ₽';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Выбор пункта выдачи
          const PickupLocationSelector(),

          const Divider(),

          // Панель выбора всех / удаления выбранных
          CartActionBar(
            selectAll: _selectAll,
            onSelectAllChanged: _toggleSelectAll,
            onDeleteSelected: _deleteSelectedItems,
          ),

          // Список товаров
          Expanded(
            child: ListView.builder(
              itemCount: _cartItems.length,
              itemBuilder: (context, index) {
                final item = _cartItems[index];
                return CartItemTile(
                  item: item,
                  onSelected: (v) => _toggleItemSelection(v, index),
                  onQuantityChanged: (delta) => _updateQuantity(index, delta),
                );
              },
            ),
          ),

          // Нижняя панель с кнопкой "Оформить заказ"
          BasketBottomBar(
            totalPrice: _calculateTotalPrice(),
            onCheckout: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const Order()),
              );
            },
          ),
        ],
      ),
    );
  }
}
