import 'package:flutter/material.dart';
import 'search_bar.dart';
import 'banner_product.dart';
import 'deals_today.dart';
import 'product_by_category.dart';
import 'recent_view.dart';

class ProductTab extends StatefulWidget {
  const ProductTab({Key? key}) : super(key: key);
  @override
  State<ProductTab> createState() => _ProductTabState();
}

class _ProductTabState extends State<ProductTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchBarProduct(),
        BannerProduct(),
        DealsToday(),
        const SizedBox(
          height: 10,
        ),
        const ProductByCategory(),
        RecentView(),
      ],
    );
  }
}
