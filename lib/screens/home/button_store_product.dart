import 'package:flutter/material.dart';
import 'package:ows_myshopline/core/constatnts/colors.dart';

class ButtonStoreAndProduct extends StatelessWidget {
  const ButtonStoreAndProduct(
      {Key? key,
      required this.onTap,
      required this.isProduct,
      required this.title,
      required this.color1})
      : super(key: key);
  final VoidCallback onTap;
  final bool isProduct;
  final String title;
  final color1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width * .5,
      child: Container(
        color:color1,
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
