import 'package:flutter/material.dart';
import 'package:ows_myshopline/screens/home/drawer.dart';
import 'package:ows_myshopline/screens/home/home_tab.dart';
import 'dart:async';
import 'dart:io';
import 'package:ows_myshopline/core/constatnts/colors.dart';
import 'package:ows_myshopline/providers/providers.dart';
import 'package:provider/provider.dart';
import 'package:ows_myshopline/login_screen.dart';
import '../models/models.dart';
import 'package:ows_myshopline/pages/pages.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AuthProvider authProvider;
  late String currentUserId;
  late String currentUserName;

  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    authProvider = context.read<AuthProvider>();
    // homeProvider = context.read<HomeProvider>();
    if (authProvider.getUserFirebaseId()?.isNotEmpty == true) {
      currentUserId = authProvider.getUserFirebaseId()!;
      currentUserName = authProvider.getUserFirebaseName()!;

    } else {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (Route<dynamic> route) => false,
      );
    }
    // registerNotification();
    // configLocalNotification();
    // listScrollController.addListener(scrollListener);
  }

  Future<bool> onBackPress() {
    openDialog();
    return Future.value(false);
  }

  Future<void> handleSignOut() async {
    authProvider.handleSignOut();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (Route<dynamic> route) => false,
    );
  }

  void onItemMenuPress(PopupChoices choice) {
    if (choice.title == 'Log out') {
      handleSignOut();
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SettingsPage()));
    }
  }

  List<PopupChoices> choices = <PopupChoices>[
    PopupChoices(title: 'Settings', icon: Icons.settings),
    PopupChoices(title: 'Log out', icon: Icons.exit_to_app),
  ];

  Widget buildPopupMenu() {
    return PopupMenuButton<PopupChoices>(
      onSelected: onItemMenuPress,
      itemBuilder: (BuildContext context) {
        return choices.map((PopupChoices choice) {
          return PopupMenuItem<PopupChoices>(
              value: choice,
              child: Row(
                children: <Widget>[
                  Icon(
                    choice.icon,
                    color: AppColors.primaryColor,
                  ),
                  Container(
                    width: 10,
                  ),
                  Text(
                    choice.title,
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                ],
              ));
        }).toList();
      },
    );
  }

  Future<void> openDialog() async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            clipBehavior: Clip.hardEdge,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                color: AppColors.themeColor,
                padding: EdgeInsets.only(bottom: 10, top: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.exit_to_app,
                        size: 30,
                        color: Colors.white,
                      ),
                      margin: EdgeInsets.only(bottom: 10),
                    ),
                    Text(
                      'Exit app',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Are you sure to exit app?',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                child: Row(
                  children: [
                    SimpleDialogOption(
                      onPressed: () {
                        Navigator.pop(context, 0);
                      },
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Icon(
                              Icons.cancel,
                              color: AppColors.primaryColor,
                            ),
                            margin: EdgeInsets.only(right: 10),
                          ),
                          Text(
                            'Cancel',
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    SimpleDialogOption(
                      onPressed: () {
                        Navigator.pop(context, 1);
                      },
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Icon(
                              Icons.check_circle,
                              color: AppColors.primaryColor,
                            ),
                            margin: EdgeInsets.only(right: 10),
                          ),
                          Text(
                            'Yes',
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        })) {
      case 0:
        break;
      case 1:
        exit(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.grid_view,
                  color: Colors.purple,
                  size: 24, // Changing Drawer Icon Size
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          actions: <Widget>[
            buildPopupMenu()
          ],
          actionsIconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Image.asset(
            "assets/logo1.jpg",
            width: MediaQuery.of(context).size.width * .5,
            height: 40,
          ),
          centerTitle: true,
        ),
        drawer: ArgonDrawer(currentPage: 'Home',currentUserName:currentUserName),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppColors.primaryColor,
          currentIndex: pageIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              pageIndex = index;
            });
          },
          selectedIconTheme: IconThemeData(size: 27),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          selectedFontSize: 14,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.food_bank), label: 'Market'),
            BottomNavigationBarItem(
                icon: Icon(Icons.chat_bubble_outline), label: "Chat"),
          ],
        ),
        body: WillPopScope(
          child: getBody('1', pageIndex, 'data'),
          onWillPop: onBackPress,
        ));
  }

  getBody(String? userId, int currentPage, var data) {
    switch (currentPage) {
      case 0:
        return const HomeTab(tab: 1);
      case 1:
        return Center(
          child: Text('Tab $pageIndex'),
        );
      case 2:
        return HomePageChatApp();
    }
  }
}
