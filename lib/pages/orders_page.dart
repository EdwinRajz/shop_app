import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';

class OrdersPage extends StatelessWidget {
  static const String routeName = '/orders';
  
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('you orders'),
      ),
      body: ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (ctx, index) => OrderItem(orderData.orders[index]),
      ),
    );
  }
}
