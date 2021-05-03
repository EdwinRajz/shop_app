import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/user_products_page.dart';
import './pages/cart_page.dart';
import './pages/orders_page.dart';
import './pages/products_overview_page.dart';
import './pages/product_detail_page.dart';
import './providers/products_provider.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import '../pages/edit_products_page.dart';
import '../pages/auth_page.dart';
void main() => runApp(ShopApp());

//258
class ShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        ),
      ],
      child: MaterialApp(
        title: 'Shop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        home: AuthPage(),
        routes: {
          ProductDetailPage.routeName: (ctx) => ProductDetailPage(),
          CartPage.routeName: (ctx) => CartPage(),
          OrdersPage.routeName: (ctx) => OrdersPage(),
          UserProductsPage.routeName: (ctx) => UserProductsPage(),
          EditProductsPage.routeName: (ctx) => EditProductsPage(),
        },
      ),
    );
  }
}
