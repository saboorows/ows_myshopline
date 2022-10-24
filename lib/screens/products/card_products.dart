import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard(
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
              height: 120,
              width: MediaQuery.of(context).size.width*.45,
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/loading.gif',
                image:image!,
              ),),
          SizedBox(height: 4,),
          Container(
              height: 20,
              child: Text(productName,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),)),
        ],
      ),
    );
  }
}
