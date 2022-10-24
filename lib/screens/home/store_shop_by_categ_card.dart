import 'package:flutter/material.dart';

class TodayRatedShopCard2 extends StatelessWidget {
  const TodayRatedShopCard2(
      {Key? key, required this.image, this.productName, this.details})
      : super(key: key);
  final image, productName, details;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              height: 70,
              width: 100,
              decoration: BoxDecoration(
                borderRadius:
                BorderRadius.all(
                    Radius.circular(
                        6.0)),
                image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.cover),
              )),
          SizedBox(height: 4,),
          Container(
              height: 15,
              child: Text(productName,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400),))
        ],
      ),
    );
  }
}
