import 'package:flutter/material.dart';
import 'package:ows_myshopline/core/constatnts/colors.dart';
import 'package:ows_myshopline/jsons/stores.dart';
import 'package:ows_myshopline/screens/shops/card_shop.dart';

class ViewTopRatedShop extends StatefulWidget {
  const ViewTopRatedShop({Key? key, required this.title}) : super(key: key);
  final title;

  @override
  State<ViewTopRatedShop> createState() => _ViewTopRatedShopState();
}

class _ViewTopRatedShopState extends State<ViewTopRatedShop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 20.0,
          mainAxisSpacing: 10.0,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: List.generate(
            stores.length,
            (index) {
              return Container(
                child: ShopCard(
                  image: stores[index]['image'],
                  details: stores[index]['detail'],
                  productName: stores[index]['name'],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
