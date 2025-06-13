import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import '../models/item.dart';

class AuthService extends ChangeNotifier {
  bool _isAuthenticated = false;
  String? _userEmail;

  bool get isAuthenticated => _isAuthenticated;
  String? get userEmail => _userEmail;

  Future<bool> login(String email, String password) async {
    // Simulate API call
    await Future.delayed(Duration(seconds: 1));

    if (email == 'demo@example.com' && password == 'password') {
      _isAuthenticated = true;
      _userEmail = email;
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout() {
    _isAuthenticated = false;
    _userEmail = null;
    notifyListeners();
  }
}

class ItemService extends ChangeNotifier {
  List<Item> _items = [];
  bool _isLoading = false;

  List<Item> get items => _items;
  bool get isLoading => _isLoading;

  List<String> get categories {
    return _items.map((item) => item.category).toSet().toList();
  }

  Future<void> loadItems() async {
    _isLoading = true;
    notifyListeners();

    try {
      final String response = await rootBundle.loadString('data/items.json');
      final List<dynamic> data = json.decode(response);
      _items = data.map((json) => Item.fromJson(json)).toList();
    } catch (e) {
      print('Error loading items: $e');
      // Fallback to dummy data
      _items = _getDummyItems();
    }

    _isLoading = false;
    notifyListeners();
  }

  List<Item> getFilteredItems(String searchQuery, String category) {
    List<Item> filtered = _items;

    if (category != 'All') {
      filtered = filtered.where((item) => item.category == category).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((item) =>
          item.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
          item.description.toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    return filtered;
  }

  List<Item> _getDummyItems() {
    return [
      Item(
        id: 1,
        title: 'Smartphone Pro',
        description: 'Latest smartphone with advanced features',
        image: 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=400',
        price: 899.99,
        category: 'Electronics',
        rating: 4.5,
        inStock: true,
      ),
      Item(
        id:2,
        title: 'Wireless Headphones',
        description: 'Premium wireless headphones with noise cancellation',
        image: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400',
        price: 299.99,
        category: 'Electronics',
        rating: 4.3,
        inStock: true,
      ),
      Item(
        id: 3,
        title: 'Coffee Maker',
        description: 'Automatic coffee maker with programmable settings',
        image: 'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=400',
        price: 199.99,
        category: 'Home & Kitchen',
        rating: 4.2,
        inStock: false,
      ),
    ];
  }
}
