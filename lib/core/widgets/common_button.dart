import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({Key? key,required this.text, required this.color, required this.onPress}) : super(key: key);
final String text;
final Color color;
final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPress, child: Text(text),style: ElevatedButton.styleFrom(
      primary: color,
      padding: EdgeInsets.symmetric(horizontal: 50,vertical: 15),
      textStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)
    ),);
  }
}
