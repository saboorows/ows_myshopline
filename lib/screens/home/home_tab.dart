import 'package:flutter/material.dart';
import 'package:ows_myshopline/screens/products/product_tab.dart';
import 'package:ows_myshopline/jsons/products.dart';
import 'package:ows_myshopline/screens/shops/store_tab.dart';
import 'package:ows_myshopline/screens/home/today_deals_card.dart';
import 'package:ows_myshopline/core/constatnts/colors.dart';
import 'button_store_product.dart';
import 'product_page.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key, required this.tab}) : super(key: key);
  final tab;

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  bool isProduct = true;
  TextEditingController _controllerSearch = TextEditingController();
  late int tabIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabIndex = widget.tab;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonStoreAndProduct(
                  onTap: () {
                    setState(() {
                      isProduct = true;
                      tabIndex = 1;
                    });
                  },
                  title: 'Products',
                  isProduct: true,
                  color1: isProduct?AppColors.secondaryColor:AppColors.primaryColor,
                ),
                ButtonStoreAndProduct(
                  onTap: () {
                    setState(() {
                      isProduct = false;
                      tabIndex = 2;
                    });
                  },
                  title: 'Stores',
                  isProduct: false,
                  color1: isProduct?AppColors.primaryColor:AppColors.secondaryColor,
                ),
              ],
            ),
            _selectBody(tabIndex)
            // getTabView(tabIndex)
          ],
        ),
      ),
    );
  }

  _selectBody(int ind) {
    switch (ind) {
      case 1:
        return ProductTab();
      case 2:
        return StoreTab(controller: _controllerSearch);
    }
  }
}
