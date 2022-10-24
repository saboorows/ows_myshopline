import 'package:flutter/material.dart';
import 'package:ows_myshopline/core/constatnts/colors.dart';
import 'package:ows_myshopline/jsons/products.dart';
import 'package:ows_myshopline/screens/products/card_products.dart';


class ViewTopProducts extends StatefulWidget {
  const ViewTopProducts({Key? key, required this.title}) : super(key: key);
  final title;

  @override
  State<ViewTopProducts> createState() => _ViewTopProductsState();
}

class _ViewTopProductsState extends State<ViewTopProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 20.0,
        mainAxisSpacing: 10.0,
        shrinkWrap: true,
        children: List.generate(
          products.length,
          (index) {
            return Container(
              child: ProductCard(
                image: products[index]['image'],
                details: products[index]['detail'],
                productName: products[index]['name'],
              ),
            );
          },
        ),
      ),
    );
  }
}
