import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:ows_myshopline/screens/products/product_tab.dart';
import 'package:ows_myshopline/jsons/products.dart';
import 'package:ows_myshopline/screens/shops/store_tab.dart';
import 'package:ows_myshopline/screens/home/today_deals_card.dart';
import 'package:ows_myshopline/core/constatnts/colors.dart';
import 'button_store_product.dart';


class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  TextEditingController _controllerSearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(3, 3, 3, 0),
            margin: EdgeInsets.only(left: 5, right: 5),
            height: 40,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              cursorColor: Colors.black,
              controller: _controllerSearch,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.indigoAccent,
                ),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.camera_alt_outlined),
                  color: Colors.grey,
                ),
                hintText: 'Search Products',
                hintStyle: TextStyle(color: Colors.black12),
              ),
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 90,
            child: Image.asset('assets/banner1.JPG',
                height: 80,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              alignment: Alignment.topLeft,
              child: Text(
                "Deals Today",
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
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              alignment: Alignment.topLeft,
              child: Text(
                "Products By Category",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 28.0, right: 28),
          child: GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: List.generate(
              products2.length,
                  (index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Container(
                        width: 80,
                        height: 70,
                        child: Image.network(
                          products2[index]['image']!,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Text('${products2[index]['name']!}')
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Container(
              alignment: Alignment.topLeft,
              child: Text(
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
      ],
    );
  }
}
