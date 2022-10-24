import 'package:flutter/material.dart';

class CommonContainer extends StatelessWidget {
  const CommonContainer({Key? key,this.title}) : super(key: key);
  final title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title),),
      body: Center(
        child: Text(title),
      ),
    );
  }
}
