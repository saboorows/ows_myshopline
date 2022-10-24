import 'package:flutter/material.dart';

class ShopCard extends StatelessWidget {
  const ShopCard(
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
            height: 100,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/loading.gif',
                image: image!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 4,),
          Container(
              height: 20,
              child: Text(productName,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),)),
        ],
      ),
    );
  }
}
