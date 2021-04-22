import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../widgets/user_products_item.dart';
import '../providers/products_provider.dart';
import '../pages/edit_products_page.dart';

class UserProductsPage extends StatelessWidget {
  static const String routeName = '/user-products';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your products'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductsPage.routeName);
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Consumer<Products>(
          builder: (_, productsData, child) => ListView.builder(
            itemCount: productsData.items.length,
            itemBuilder: (_, index) => Column(
              children: [
                UserProductsItem(
                  productsData.items[index].title,
                  productsData.items[index].imageUrl,
                ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
