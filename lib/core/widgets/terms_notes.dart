import 'package:flutter/material.dart';
import 'package:ows_myshopline/core/constatnts/colors.dart';

class TermsOfServices extends StatelessWidget {
  const TermsOfServices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text('Terms And Services'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'TERMS & CONDITIONS AND PRIVACY POLICY',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 16, color: Colors.red),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Text(
                  'Effective Date: May 2015',
                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, color: Colors.black),
                ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child:const Text(
                  'Flutter is a free online story-sharing platform that gives patients and parents/ legal guardians the opportunity to share the story of their experience at Nationwide Children’s Hospital (“NCH”). Create a profile, post your story and Flutter will allow you to share your story with others while finding others with a similar journey.',
                  style: TextStyle(
                      fontSize: 12, color: Colors.black),
                ),)
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Effective Date: June 2016',
              style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child:const Text(
                  'Flutter is a free online story-sharing platform that gives patients and parents/ legal guardians the opportunity to share the story of their experience at Nationwide Children’s Hospital (“NCH”). Create a profile, post your story and Flutter will allow you to share your story with others while finding others with a similar journey.',
                  style: TextStyle(
                      fontSize: 12, color: Colors.black),
                ),)
          )
        ],
      ),
    );
  }
}
