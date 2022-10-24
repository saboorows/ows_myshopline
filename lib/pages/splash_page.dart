import 'package:flutter/material.dart';
import 'package:ows_myshopline/bloc/auth_cubit.dart';
import 'package:ows_myshopline/bloc/auth_state.dart';
import 'package:ows_myshopline/core/constatnts/colors.dart';
import 'package:ows_myshopline/core/constatnts/components.dart';
import 'package:ows_myshopline/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:ows_myshopline/login_screen.dart';
import 'package:ows_myshopline/home_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);
  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      // just delay for showing this slash page clearer because it too fast
      navigateTo(context, LandingScreen());
    });
  }

  void checkSignedIn() async {
    AuthProvider authProvider = context.read<AuthProvider>();
    bool isLoggedIn = await authProvider.isLoggedIn();
    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
      return;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/logo1.jpg",
              width: MediaQuery.of(context).size.width*.6,
              height: 100,
            ),
            SizedBox(height: 20),
            Container(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(color: AppColors.themeColor),
            ),
          ],
        ),
      ),
    );
  }
}

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthCubit, AuthState>(
        buildWhen: (oldState, newState) {
          return oldState is AuthInitialState;
        },
        builder: (context, state) {
          AuthLoggedInState obj;
          if(state is AuthLoggedInState) {
            return HomeScreen();
          }
          else if(state is AuthLoggedOutState) {
            return LoginScreen();
          }
          else {
            return Scaffold();
          }
        },
      ),
    );
  }
}
