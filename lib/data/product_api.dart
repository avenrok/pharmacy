import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pharmacy/models/product.dart';
import 'package:pharmacy/data/app_config.dart';

class ProductApi {
  final String baseUrl;

  ProductApi({String? baseUrl}) : baseUrl = baseUrl ?? AppConfig.apiBaseUrl;

  // Получение товаров
  Future<List<Product>> fetchActionProducts() async {
    return _fetchProducts('/action-products');
  }

  Future<List<Product>> fetchWeeklyProducts() async {
    return _fetchProducts('/weekly-products');
  }

  Future<List<Product>> fetchHurryToBuyProducts() async {
    return _fetchProducts('/hurry-products');
  }

  Future<List<Product>> _fetchProducts(String endpoint) async {
    final response = await http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Ошибка загрузки товаров');
    }

    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => Product.fromJson(json)).toList();
  }

  // Добавление товара в корзину
  Future<void> addToCart(int productId, {int quantity = 1}) async {
    final url = Uri.parse('$baseUrl/cart');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'product_id': productId, 'quantity': quantity}),
    );

    if (response.statusCode != 200) {
      throw Exception('Не удалось добавить товар в корзину');
    }
  }
}
