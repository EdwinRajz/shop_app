import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import './cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final String url =
        'https://shop-app-f2200-default-rtdb.europe-west1.firebasedatabase.app/orders.json';
    final timestamp = DateTime.now();
    final response = await http.post(Uri.parse(url),
        body: json.encode(
          {
            'amount': total,
            'products': cartProducts.map((cartProducts) => {
                  'id': cartProducts.id,
                  'title': cartProducts.title,
                  'quantity': cartProducts.quantity,
                  'price': cartProducts.price,
                }).toList(),
            'dateTime': timestamp.toIso8601String(),
          },
        ));
    _orders.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        dateTime: timestamp,
        products: cartProducts,
      ),
    );
    notifyListeners();
  }
}
