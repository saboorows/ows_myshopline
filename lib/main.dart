import 'package:flutter/material.dart';
import 'package:ows_myshopline/bloc/auth_cubit.dart';
import 'package:ows_myshopline/bloc/bottom_nav/bottom_nav_cubit.dart';
import 'package:ows_myshopline/bloc/data_connection_checker/network_cubit.dart';
import 'package:ows_myshopline/bloc/theme/theme_cubit.dart';
import 'package:ows_myshopline/home_screen.dart';
import 'package:ows_myshopline/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/pages.dart';
import 'providers/providers.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ows_myshopline/providers/product_provider.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  var dio = Dio();
  HttpOverrides.global = new MyHttpOverrides();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(EasyLocalization(
      path: 'assets/locales',
      supportedLocales: [Locale('hi', 'IN'),Locale('en', 'UK')],
      child: MyApp(prefs: prefs)));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  MyApp({required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(
            firebaseAuth: FirebaseAuth.instance,
            googleSignIn: GoogleSignIn(),
            prefs: this.prefs,
            firebaseFirestore: this.firebaseFirestore,
          ),
        ),
        Provider<SettingProvider>(
          create: (_) => SettingProvider(
            prefs: this.prefs,
            firebaseFirestore: this.firebaseFirestore,
            firebaseStorage: this.firebaseStorage,
          ),
        ),
        Provider<ProductProvider>(
          create: (_) => ProductProvider(
            prefs: this.prefs,
            firebaseFirestore: this.firebaseFirestore,
            firebaseStorage: this.firebaseStorage,
          ),
        ),
        Provider<HomeProvider>(
          create: (_) => HomeProvider(
            firebaseFirestore: this.firebaseFirestore,
          ),
        ),
        Provider<ChatProvider>(
          create: (_) => ChatProvider(
            prefs: this.prefs,
            firebaseFirestore: this.firebaseFirestore,
            firebaseStorage: this.firebaseStorage,
          ),
        ),
        BlocProvider<AuthCubit>(
          create: (BuildContext context) => AuthCubit(),
        ),
        BlocProvider<ThemeCubit>(
          create: (BuildContext context) => ThemeCubit(),
        ),
        BlocProvider<NetworkCubit>(
          create: (BuildContext context) => NetworkCubit.instence,
        ),
        BlocProvider<BottomNavCubit>(
          create: (BuildContext context) => BottomNavCubit(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MyApp',
          initialRoute: "/splash",
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          routes: <String, WidgetBuilder>{
            "/onboarding": (BuildContext context) => new LoginScreen(),
            "/home": (BuildContext context) => new HomeScreen(),
            "/profile": (BuildContext context) => new Container(),
            "/articles": (BuildContext context) => new Container(),
            "/elements": (BuildContext context) => new Container(),
            "/account": (BuildContext context) => new Container(),
            "/splash": (BuildContext context) => new SplashPage(),
          })
    );
  }
}