import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpService {
  final String baseUrl =
      'https://fakestoreapi.com/products/'; // Asegúrate de usar la URL correcta

  // Fetch all products (Read)
  Future<List<dynamic>> fetchProducts() async {
    final response = await http.get(Uri.parse(baseUrl));
    print(response.statusCode);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load products');
    }
  }

  // Fetch single product by ID (Read)
  Future<dynamic> fetchProduct(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load product');
    }
  }
/*
  // Create new product (Create)
  Future<dynamic> createProduct(Map<String, dynamic> product) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(product),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create product');
    }
  }

  // Update existing product (Update)
  Future<dynamic> updateProduct(int id, Map<String, dynamic> product) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(product),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to update product');
    }
  }

  // Delete product by ID (Delete)
  Future<void> deleteProduct(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete product');
    }
  }*/
}
