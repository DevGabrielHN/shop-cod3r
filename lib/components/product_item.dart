import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/utils/app_routes.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({
    Key? key,
    required this.product,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    _deleteProduct(Product removeProduct){

      final Product productRollback = removeProduct;


      TextButton cancelButton = TextButton(
        child: Text("Cancelar"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );

      TextButton okButton = TextButton(
        child: Text("Sim"),
        onPressed: () {
          Provider.of<ProductList>(
                  context,
                  listen: false
                  ).removeProduct(product);
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Produto deletado com sucesso!'),
              duration: Duration(seconds: 2),
            ),
          );
        },
      );

      AlertDialog alert = AlertDialog(
        title: Text("Alerta"),
        content: Text("Deseja apagar o produto?"),
        actions: [
          cancelButton,
          okButton,
        ],
      );

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },  
      );

    }


    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(product.name),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.PRODUCT_FORM,
                  arguments: product
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: () {
                _deleteProduct(product);
              },
            ),
          ]),
      ),
    );
  }
}