import 'package:flutter/material.dart';
import 'package:ows_myshopline/core/constatnts/app_constants.dart';
import 'package:ows_myshopline/core/constatnts/colors.dart';
import 'package:ows_myshopline/providers/auth_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:ows_myshopline/core/widgets/widgets.dart';
import 'pages.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    switch (authProvider.status) {
      case Status.authenticateError:
        Fluttertoast.showToast(msg: "Sign in fail");
        break;
      case Status.authenticateCanceled:
        Fluttertoast.showToast(msg: "Sign in canceled");
        break;
      case Status.authenticated:
        Fluttertoast.showToast(msg: "Sign in success");
        break;
      default:
        break;
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(
            AppConstants.loginTitle,
            style: TextStyle(color: AppColors.primaryColor),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Stack(
              children: <Widget>[
                Center(
                  child: TextButton(
                    onPressed: () async {
                      authProvider.handleSignIn().then((isSuccess) {
                        if (isSuccess) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePageChatApp(),
                            ),
                          );
                        }
                      }).catchError((error, stackTrace) {
                        Fluttertoast.showToast(msg: error.toString());
                        authProvider.handleException();
                      });
                    },
                    child: Text(
                      'Sign in with Google',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) return Color(0xffdd4b39).withOpacity(0.8);
                          return Color(0xffdd4b39);
                        },
                      ),
                      splashFactory: NoSplash.splashFactory,
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.fromLTRB(30, 15, 30, 15),
                      ),
                    ),
                  ),
                ),
                // Loading
              ],
            ),
                authProvider.status == Status.authenticating ? LoadingView() : SizedBox.shrink(),
          ],
        ));
  }
}
