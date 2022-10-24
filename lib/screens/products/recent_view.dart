import 'package:flutter/material.dart';
import 'package:ows_myshopline/jsons/products.dart';
import 'package:ows_myshopline/screens/home/today_deals_card.dart';

class RecentView extends StatelessWidget {
  const RecentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
            alignment: Alignment.topLeft,
            child: const Text(
              "Recently Viewed",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            )),
      ),
      Container(
          height: 130,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: TodayDealsCard(
                    image: products[index]['image'],
                    details: products[index]['detail'],
                    productName: products[index]['name'],
                  ),
                  onTap: () async {},
                );
              })),
    ],);
  }
}
