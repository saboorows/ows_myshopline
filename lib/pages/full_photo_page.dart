import 'package:flutter/material.dart';
import 'package:ows_myshopline/core/constatnts/app_constants.dart';
import 'package:ows_myshopline/core/constatnts/colors.dart';
import 'package:photo_view/photo_view.dart';

class FullPhotoPage extends StatelessWidget {
  final String url;

  FullPhotoPage({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.black,
        leading: IconButton(
          icon: Icon(Icons.cancel_outlined),
          onPressed: () => Navigator.pop(context, false),
        ),
        title: Text(
          AppConstants.fullPhotoTitle,
          style: TextStyle(color: AppColors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: PhotoView(
          imageProvider: NetworkImage(url),
        ),
      ),
    );
  }
}
