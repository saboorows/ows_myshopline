import 'package:flutter/material.dart';
class CustomSnackBar{
  static snackBar({required BuildContext context, required String data, required Color color}){
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar( content: Text(data),
        backgroundColor: color,
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.fixed));
  }
}
