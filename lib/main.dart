import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/products_overview_page.dart';
import '../pages/splash_page.dart';
import '../providers/auth.dart';
import '../pages/user_products_page.dart';
import './pages/cart_page.dart';
import './pages/orders_page.dart';
import './pages/product_detail_page.dart';
import './providers/products_provider.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import '../pages/edit_products_page.dart';
import '../pages/auth_page.dart';

void main() => runApp(ShopApp());

//267
class ShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(), //error prone
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (_) => Products(),
          update: (ctx, auth, previousProducts) => Products()
            ..update(
              auth.token,
              auth.userID,
              previousProducts == null ? [] : previousProducts.items,
            ),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (_) => Orders(),
          update: (ctx, auth, previousOrders) => Orders()
            ..update(
              auth.token,
              auth.userID,
              previousOrders == null ? [] : previousOrders.orders,
            ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Shop',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
          ),
          home: auth.isAuth
              ? ProductsOverviewPage()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashPage()
                          : AuthPage(),
                ),
          routes: {
            ProductDetailPage.routeName: (ctx) => ProductDetailPage(),
            CartPage.routeName: (ctx) => CartPage(),
            OrdersPage.routeName: (ctx) => OrdersPage(),
            UserProductsPage.routeName: (ctx) => UserProductsPage(),
            EditProductsPage.routeName: (ctx) => EditProductsPage(),
          },
        ),
      ),
    );
  }
}
