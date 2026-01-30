// //{
//   "id": 1,
//   "name": "Название товара",
//   "price": "999,99 ₽",
//   "old_price": "1299,99 ₽",
//   "discount_percentage": 25,
//   "is_action_product": true,
//   "image_base64": "iVBORw0KGgoAAAANSUhEUgAA..."
// // }

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:pharmacy/models/product.dart';

class ProductApi {
  final String baseUrl;

  ProductApi({required this.baseUrl});

  Future<List<Product>> fetchActionProducts() async {
    final response = await http.get(
      Uri.parse('$baseUrl/action-products'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Ошибка загрузки товаров');
    }

    final List<dynamic> data = jsonDecode(response.body);

    return data.map((json) => Product.fromJson(json)).toList();
  }

  Future<List<Product>> fetchWeeklyProducts() async {
    final response = await http.get(
      Uri.parse('$baseUrl/weekly-products'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Ошибка загрузки товаров');
    }

    final List<dynamic> data = jsonDecode(response.body);

    return data.map((json) => Product.fromJson(json)).toList();
  }

  Future<List<Product>> fetchHurryToBuyProducts() async {
    final response = await http.get(
      Uri.parse('$baseUrl/hurry-products'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Ошибка загрузки товаров');
    }

    final List<dynamic> data = jsonDecode(response.body);

    return data.map((json) => Product.fromJson(json)).toList();
  }
}
