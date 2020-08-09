import 'package:flutter/material.dart';
import 'package:terawe_flutter_project/models/product_data.dart';
import 'package:terawe_flutter_project/widgets/product_tile.dart';
import 'package:provider/provider.dart';

class ProductsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductData>(
      builder: (context, productData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final product = productData.products[index];
            return ProductTile(
              productName: product.productName,
              UPN: product.UPN,
              aisleNumber: product.aisleNumber,
              shelf: product.shelf,
//              longPressCallback: () {
//                productData.deleteProduct(product);
//              },
            );
          },
          itemCount: productData.productCount,
        );
      },
    );
  }
}
