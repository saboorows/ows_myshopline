import 'package:flutter/material.dart';
import 'package:ows_myshopline/core/constatnts/colors.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key, required this.title}) : super(key: key);
  final title;

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Text(widget.title),
            )
          ],
        ),
      ),
    );
  }
}
