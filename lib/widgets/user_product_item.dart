import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

import '../screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;

  UserProductItem(this.id);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final product = productsData.findById(this.id);
    final scaffold = Scaffold.of(context);

    return ListTile(
      title: Text(product.title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).pushNamed(EditProductScreen.routeName,
                      arguments: product.id);
                },
                color: Colors.yellow),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                try {
                  await productsData.deleteProduct(product.id);
                } catch (error) {
                  scaffold.showSnackBar(
                    SnackBar(
                      content: Text('Deleting Failed'),
                    ),
                  );
                }
              },
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
