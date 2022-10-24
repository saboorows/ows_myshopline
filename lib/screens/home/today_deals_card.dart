import 'package:flutter/material.dart';

class TodayDealsCard extends StatelessWidget {
  const TodayDealsCard(
      {Key? key, required this.image, this.productName, this.details})
      : super(key: key);
  final image, productName, details;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 90,
        height: 100,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 70,
              width: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/loading.gif',
                  image: image??'https://meyertimber.com/uploads/images/presets/product_page_normal/store/products/NO_IMAGE.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 4,),
            Text(productName,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400),)
          ],
        ),
      ),
    );
  }
}
