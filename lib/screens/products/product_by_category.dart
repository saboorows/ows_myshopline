import 'package:flutter/material.dart';
import 'package:ows_myshopline/jsons/products.dart';
import 'package:ows_myshopline/screens/products/view_top_products.dart';

class ProductByCategory extends StatelessWidget {
  const ProductByCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Container(
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  Text(
                    "Products by Category",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => ViewTopProducts(
                            title: "Products by Category",
                          )));
                    },
                    child: Text(
                      "View All",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.red),
                    ),
                  ),
                ],
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            color: Colors.white,
            child: GridView.count(
              primary: false,
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
              crossAxisCount: 3,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(
                products2.length,
                    (index) {
                  return InkWell(
                    onTap: () {},
                    child: Container(
                      height: 120,
                      child: Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            child: FadeInImage.assetNetwork(
                              placeholder: 'assets/loading.gif',
                              image: products2[index]['image']!,
                            ),
                          ),
                          Text('${products2[index]['name']!}')
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
