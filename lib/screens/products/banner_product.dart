import 'package:flutter/material.dart';

class BannerProduct extends StatelessWidget {
  const BannerProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 90,
        child: Image.asset('assets/banner1.JPG',
            height: 80,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fill),
      ),
    );
  }
}
