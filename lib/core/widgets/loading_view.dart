import 'package:flutter/material.dart';
import 'package:ows_myshopline/core/constatnts/colors.dart';

class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(
          color: AppColors.themeColor,
        ),
      ),
      color: Colors.white.withOpacity(0.8),
    );
  }
}
