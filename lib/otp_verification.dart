import 'package:flutter/material.dart';
import 'package:ows_myshopline/registration.dart';
import 'package:ows_myshopline/core/constatnts/colors.dart';
import 'package:flutter/services.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({Key? key, required this.otp, this.mobile})
      : super(key: key);
  final otp, mobile;

  @override
  _OtpVerificationState createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  _OtpVerificationState();

  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  TextEditingController _controller4 = TextEditingController();
  late FocusNode text1, text2, text3, text4;

  @override
  void initState() {
    super.initState();
    text1 = FocusNode();
    text2 = FocusNode();
    text3 = FocusNode();
    text4 = FocusNode();
  }


  @override
  void dispose() {
    text1.dispose();
    text2.dispose();
    text3.dispose();
    text4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * .5,
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .2,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .7,
                      child: Image.asset("assets/logo1.jpg"),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * .5,
                width: double.infinity,
                color: AppColors.primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height*.05,),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Please Enter the OTP",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 28),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(height: 30,),
                    _boxBuilder(context),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: SizedBox(
                    //     height:75,
                    //     child: Form(
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           // Container(
                    //           //   height: 70,
                    //           //   width: 70,
                    //           //   decoration: BoxDecoration(
                    //           //     borderRadius: BorderRadius.circular(16),
                    //           //     color: AppColors.greyColor2,
                    //           //   ),
                    //           //   padding: const EdgeInsets.all(8),
                    //           //   alignment: Alignment.center,
                    //           //   child: TextFormField(
                    //           //     style: Theme.of(context).textTheme.headlineMedium,
                    //           //     decoration: const InputDecoration(
                    //           //       contentPadding: EdgeInsets.all(0),
                    //           //       border: InputBorder.none,
                    //           //     ),
                    //           //     textAlign: TextAlign.center,
                    //           //     keyboardType: TextInputType.number,
                    //           //     inputFormatters: [
                    //           //       LengthLimitingTextInputFormatter(1),
                    //           //       FilteringTextInputFormatter.digitsOnly,
                    //           //     ],
                    //           //     onChanged: (value) {
                    //           //       if (value.isEmpty) {
                    //           //         return;
                    //           //       }
                    //           //       FocusScope.of(context).nextFocus();
                    //           //     },
                    //           //   ),
                    //           // ),
                    //           // Container(
                    //           //   height: 86,
                    //           //   width: 72,
                    //           //   decoration: BoxDecoration(
                    //           //     borderRadius: BorderRadius.circular(16),
                    //           //     color: AppColors.primarySwatch[50]?.withOpacity(0.5),
                    //           //   ),
                    //           //   padding: const EdgeInsets.all(8),
                    //           //   alignment: Alignment.center,
                    //           //   child: TextFormField(
                    //           //     style: Theme.of(context).textTheme.headlineMedium,
                    //           //     decoration: const InputDecoration(
                    //           //       contentPadding: EdgeInsets.all(0),
                    //           //       border: InputBorder.none,
                    //           //     ),
                    //           //     textAlign: TextAlign.center,
                    //           //     inputFormatters: [
                    //           //       LengthLimitingTextInputFormatter(1),
                    //           //       FilteringTextInputFormatter.digitsOnly,
                    //           //     ],
                    //           //     onChanged: (value) {
                    //           //       if (value.isEmpty) {
                    //           //         FocusScope.of(context).previousFocus();
                    //           //         return;
                    //           //       }
                    //           //       FocusScope.of(context).nextFocus();
                    //           //     },
                    //           //   ),
                    //           // ),
                    //           // Container(
                    //           //   height: 86,
                    //           //   width: 72,
                    //           //   decoration: BoxDecoration(
                    //           //     borderRadius: BorderRadius.circular(16),
                    //           //     color: AppColors.primarySwatch[50]?.withOpacity(0.5),
                    //           //   ),
                    //           //   padding: const EdgeInsets.all(8),
                    //           //   alignment: Alignment.center,
                    //           //   child: TextFormField(
                    //           //     style: Theme.of(context).textTheme.headlineMedium,
                    //           //     decoration: const InputDecoration(
                    //           //       contentPadding: EdgeInsets.all(0),
                    //           //       border: InputBorder.none,
                    //           //     ),
                    //           //     textAlign: TextAlign.center,
                    //           //     inputFormatters: [
                    //           //       LengthLimitingTextInputFormatter(1),
                    //           //       FilteringTextInputFormatter.digitsOnly,
                    //           //     ],
                    //           //     onChanged: (value) {
                    //           //       if (value.isEmpty) {
                    //           //         FocusScope.of(context).previousFocus();
                    //           //         return;
                    //           //       }
                    //           //       FocusScope.of(context).nextFocus();
                    //           //     },
                    //           //   ),
                    //           // ),
                    //           // Container(
                    //           //   height: 86,
                    //           //   width: 72,
                    //           //   decoration: BoxDecoration(
                    //           //     borderRadius: BorderRadius.circular(16),
                    //           //     color: AppColors.primarySwatch[50]?.withOpacity(0.5),
                    //           //   ),
                    //           //   padding: const EdgeInsets.all(8),
                    //           //   alignment: Alignment.center,
                    //           //   child: TextFormField(
                    //           //     style: Theme.of(context).textTheme.headlineMedium,
                    //           //     decoration: const InputDecoration(
                    //           //       contentPadding: EdgeInsets.all(0),
                    //           //       border: InputBorder.none,
                    //           //     ),
                    //           //     textAlign: TextAlign.center,
                    //           //     inputFormatters: [
                    //           //       LengthLimitingTextInputFormatter(1),
                    //           //       FilteringTextInputFormatter.digitsOnly,
                    //           //     ],
                    //           //     onChanged: (value) {
                    //           //       if (value.isEmpty) {
                    //           //         FocusScope.of(context).previousFocus();
                    //           //         return;
                    //           //       }
                    //           //     },
                    //           //   ),
                    //           // ),
                    //         ],
                    //       ),)),
                    // ),
                    SizedBox(height: 30,),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * .4,
                        height:45,
                        child: ElevatedButton(
                          onPressed: () {
                            // _verify();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => Registration()));
                            // Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Registration()));
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              textStyle:
                              TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                          child: Text(
                            "Verify",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22,color: Colors.black),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _verify() async {
    if (formKey.currentState!.validate()) {
      String otp = _controller1.text +
          _controller2.text +
          _controller3.text +
          _controller4.text;
      if (widget.otp.toString() == otp.toString()) {
        // CustomSnackBar.snackBar(
        //     context: context,
        //     data: 'Otp Verified Successfully !',
        //     color: Colors.green);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => Registration()));
      } else {
        // CustomSnackBar.snackBar(
        //     context: context, data: 'Wrong otp!', color: Colors.red);
      }
    }
  }

  Widget _boxBuilder(BuildContext context) {
    return Form(
        key: formKey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _box(context, _controller1, false, text1, text2,(value) {
              if (value.isEmpty) {
                return;
              }
              FocusScope.of(context).nextFocus();
            },),
            _box(context, _controller2, false, text2, text3, (value) {
              if (value.isEmpty) {
                FocusScope.of(context).previousFocus();
                return;
              }
              FocusScope.of(context).nextFocus();
            },),
            _box(context, _controller3, false, text3, text4, (value) {
              if (value.isEmpty) {
                FocusScope.of(context).previousFocus();
                return;
              }
              FocusScope.of(context).nextFocus();
            },),
            _box(context, _controller4, false, text4, text1, (value) {
              if (value.isEmpty) {
                FocusScope.of(context).previousFocus();
                return;
              }
            },),
          ],
        ));
  }

  Widget _box(BuildContext context, TextEditingController customController,
      bool focus, FocusNode text, FocusNode changeFocus,var onChange) {
    return  Container(
      height: 70,
      width: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.greyColor2,
      ),
      padding: const EdgeInsets.all(8),
      alignment: Alignment.center,
      child: TextFormField(
        style: Theme.of(context).textTheme.headlineMedium,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(0),
          border: InputBorder.none,
        ),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: onChange
      ),
    );
  }
}
