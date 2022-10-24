import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ows_myshopline/bloc/auth_cubit.dart';
import 'package:ows_myshopline/bloc/auth_state.dart';
import 'package:ows_myshopline/providers/auth_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:ows_myshopline/core/widgets/widgets.dart';
import 'package:ows_myshopline/home_screen.dart';
import 'package:ows_myshopline/core/constatnts/colors.dart';
import 'package:ows_myshopline/core/constatnts/components.dart';
import 'package:ows_myshopline/movie/view/movie_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'verify_phone.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;



class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _controllerMobile = TextEditingController();
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();

  Future<void> loginUser(String phone, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.verifyPhoneNumber(
      codeAutoRetrievalTimeout: (String verificationId) {},
      phoneNumber: phone,
      timeout: Duration(seconds: 60),
      verificationCompleted: (AuthCredential credential) async {
        Navigator.of(context).pop();
        var result = await _auth.signInWithCredential(credential);
        User? firebaseUser = result.user;
        if (firebaseUser != null) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        } else {
          print("Error");
        }
        //This callback would gets called when verification is done auto maticlly
      },
      verificationFailed: (FirebaseAuthException exception) {
        print(exception);
      },
      codeSent: (String? verificationId, [int? forceResendingToken]) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: Text("Give the code?"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: _codeController,
                    ),
                  ],
                ),
                actions: <Widget>[
                  ElevatedButton(
                    child: Text("Confirm"),
                    onPressed: () async {
                      final code = _codeController.text.trim();
                      AuthCredential credential = PhoneAuthProvider.credential(
                          verificationId: verificationId!, smsCode: code);
                      var result = await _auth.signInWithCredential(credential);
                      User? firebaseUser = result.user;
                      if (firebaseUser != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      } else {
                        print("Error");
                      }
                    },
                  )
                ],
              );
            });
      },
    );
  }
  facebookLogin() async {
    print("FaceBook");
    try {
      final result =
      await FacebookAuth.i.login(permissions: ['public_profile', 'email']);
      if (result.status == LoginStatus.success) {
        final userData = await FacebookAuth.i.getUserData();
        print(userData);
      }
    } catch (error) {
      print(error);
    }
  }


  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    // switch (authProvider.status) {
    //   case Status.authenticateError:
    //     Fluttertoast.showToast(msg: "Sign in fail");
    //     break;
    //   case Status.authenticateCanceled:
    //     Fluttertoast.showToast(msg: "Sign in canceled");
    //     break;
    //   case Status.authenticated:
    //     Fluttertoast.showToast(msg: "Sign in success");
    //     break;
    //   default:
    //     break;
    // }
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                    // Loading
                    authProvider.status == Status.authenticating
                        ? LoadingView()
                        : SizedBox.shrink(),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontFamily: 'Cabin-Bold',
                          ),
                        ),
                        Text('login'.tr(),
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontFamily: 'Cabin-Bold'))
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Container(
                      width: MediaQuery.of(context).size.width * .9,
                      alignment: Alignment.center,
                      padding: EdgeInsets.fromLTRB(1, 3, 20, 0),
                      margin: EdgeInsets.only(left: 10, right: 10),
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.redAccent),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.black,
                        controller: _controllerMobile,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.phone_android_outlined),
                            color: Colors.grey,
                          ),
                          hintText: 'Enter Mobile',
                          hintStyle: TextStyle(color: Colors.black26),
                        ),
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is AuthCodeSentState) {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) =>
                                      VerifyPhoneNumberScreen()));
                        }
                      },
                      builder: (context, state) {
                        if (state is AuthLoadingState) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        return SizedBox(
                          width: MediaQuery.of(context).size.width*.9,
                          child: CupertinoButton(
                            onPressed: () {
                              String phoneNumber =
                                  "+91" + _controllerMobile.text;
                              BlocProvider.of<AuthCubit>(context)
                                  .sendOTP(phoneNumber);
                            },
                            color: Colors.deepOrange,
                            child: Text("Sign In"),
                          ),
                        );
                      },
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 20),
                    //   child: defaultButton(
                    //       function: () {
                    //         // final phone = _phoneController.text.trim();
                    //         // loginUser(phone, context);
                    //         navigateTo(context, OtpVerification(otp: '2345'));
                    //       },
                    //       text: 'Login',
                    //       radius: 30,
                    //       isUpperCase: false,
                    //       fontColor: AppColors.mainColor,
                    //       borderWidth: 1,
                    //       backgroundColor: Colors.white),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          navigateTo(context, MovieScreen());
                        },
                        child: Center(
                          child: Text(
                            'or'.toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .45,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: defaultButton(
                                function: () {
                                  // signInWithFacebook();
                                  facebookLogin();
                                },
                                text: 'Facebook',
                                // prefix: FontAwesomeIcons.googlePlusG,
                                radius: 10,
                                isUpperCase: false,
                                fontColor: AppColors.mainColor,
                                borderWidth: 1,
                                backgroundColor: Colors.white),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .45,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: defaultButton(
                                function: () {
                                  authProvider.handleSignIn().then((isSuccess) {
                                    if (isSuccess) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => HomeScreen(),
                                        ),
                                      );
                                    }
                                  }).catchError((error, stackTrace) {
                                    Fluttertoast.showToast(
                                        msg: error.toString());
                                    authProvider.handleException();
                                  });
                                },
                                text: ' Google',
                                // prefix: FontAwesomeIcons.googlePlusG,
                                radius: 10,
                                isUpperCase: false,
                                fontColor: AppColors.mainColor,
                                borderWidth: 1,
                                backgroundColor: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signInWithFacebook() async {
    try {
      print('saboor1-------------------------------------------');
      final LoginResult result = await FacebookAuth.instance.login(permissions: (['email', 'public_profile']));
      print('saboor2-------------------------------------------');
      final token = result.accessToken!.token;
      print('saboor3-------------------------------------------');
      print('Facebook token userID : ${result.accessToken!.grantedPermissions}');
      print('saboor4-------------------------------------------');
      final graphResponse = await http.get(Uri.parse( 'https://graph.facebook.com/'
          'v2.12/me?fields=name,first_name,last_name,email&access_token=${token}'));
      print('saboor5-------------------------------------------');
      final profile = jsonDecode(graphResponse.body);
      print('saboor6-------------------------------------------');
      print("Profile is equal to $profile");
      try {
        print('saboor7-------------------------------------------');
        final AuthCredential facebookCredential = FacebookAuthProvider.credential(result.accessToken!.token);
        final userCredential = await FirebaseAuth.instance.signInWithCredential(facebookCredential);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }catch(e)
      {
        final snackBar = SnackBar(
          margin: const EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
          content:  Text(e.toString()),
          backgroundColor: (Colors.redAccent),
          action: SnackBarAction(
            label: 'dismiss',
            onPressed: () {
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

    } catch (e) {
      print("error occurred");
      print(e.toString());
    }
  }

}
