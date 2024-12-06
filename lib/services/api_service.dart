// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../order.dart';

class ApiService {
  // Replace this URL with your actual API URL
  static const String _baseUrl =
      'https://jsonplaceholder.typicode.com/posts'; // Placeholder URL for testing

  // Fetch orders (using posts as a placeholder for now)
  Future<List<Order>> fetchOrders() async {
    try {
      final response = await http
          .get(Uri.parse(_baseUrl))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((orderData) => Order.fromJson(orderData)).toList();
      } else {
        throw Exception('Failed to load orders: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load orders: $e');
    }
  }

  Future<void> deleteOrder(String orderId) async {
    try {
      final response = await http.delete(
        Uri.parse('$_baseUrl/$orderId'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode != 200) {
        throw Exception('Failed to delete order: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to delete order: $e');
    }
  }
}
