import 'package:flutter/material.dart';
import 'package:ows_myshopline/core/constatnts/colors.dart';
import 'package:ows_myshopline/screens/profile/profile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Theme.dart';
import 'drawer-tile.dart';

class ArgonDrawer extends StatelessWidget {
  final String? currentPage;
  final String? currentUserName;
  ArgonDrawer({this.currentPage,this.currentUserName});

  _launchURL() async {
    const url = 'https://creative-tim.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width*.7,
        child: Column(children: [
          Container(
            color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.105,
              width: MediaQuery.of(context).size.width * 0.85,
              child: SafeArea(
                bottom: false,
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset("assets/logo1.jpg",width: MediaQuery.of(context).size.width,height: 70,),
                ),
              )),
          Container(
            height: 50,
            color: AppColors.primaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 28),
                  child: Row(
                    children: [
                    CircleAvatar(
                      radius: 22.0,
                      backgroundImage:
                      NetworkImage('https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80'),
                      backgroundColor: Colors.transparent,
                    ),
                    SizedBox(width: 10,),
                    Column(
                      children: [
                        Text('Ankit Agarwal',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.white),),
                        SizedBox(width: 10,),
                        Text('ankit12@gmail.com',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14,color: Colors.white),)
                      ],
                    ),
                  ],),
                ),
              ],
            ),),
          SizedBox(height: 5,),
          Container(
              padding: EdgeInsets.only(left: 8, right: 16),
              height: MediaQuery.of(context).size.height*.75,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DrawerTile(
                        icon: Icons.home,
                        onTap: () {
                          if (currentPage != "Home")
                            Navigator.pushReplacementNamed(context, '/home');
                        },
                        iconColor: ArgonColors.primary,
                        title: "Home",
                        isSelected: currentPage == "Home" ? true : false),
                    DrawerTile(
                        icon: Icons.account_circle,
                        onTap: () {
                         Navigator.of(context).push(MaterialPageRoute(builder: (_)=>MyProfile(title: 'My Profile')));
                        },
                        iconColor: ArgonColors.info,
                        title: "My Profile",
                        isSelected: currentPage == "Account" ? true : false),
                    DrawerTile(
                        icon: Icons.pie_chart,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_)=>MyProfile(title: 'Change Password')));
                          // if (currentPage != "change_password")
                          //   Navigator.pushReplacementNamed(context, '/profile');
                        },
                        iconColor: ArgonColors.warning,
                        title: "Change Password",
                        isSelected: currentPage == "Profile" ? true : false),
                    DrawerTile(
                        icon: Icons.production_quantity_limits,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_)=>MyProfile(title: 'Favorite Products')));
                        },
                        iconColor: ArgonColors.error,
                        title: "Favorite Products",
                        isSelected: currentPage == "Elements" ? true : false),
                    DrawerTile(
                        icon: Icons.store,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_)=>MyProfile(title: 'Liked Stores')));
                          // if (currentPage != "Elements")
                          //   Navigator.pushReplacementNamed(context, '/elements');
                        },
                        iconColor: ArgonColors.error,
                        title: "Liked Stores",
                        isSelected: currentPage == "Elements" ? true : false),
                    DrawerTile(
                        icon: Icons.notification_important_outlined,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_)=>MyProfile(title: 'Notifications Setting')));

                        },
                        iconColor: ArgonColors.error,
                        title: "Notifications Setting",
                        isSelected: currentPage == "Elements" ? true : false),
                    DrawerTile(
                        icon: Icons.share,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_)=>MyProfile(title: 'Refer & Earns')));

                        },
                        iconColor: ArgonColors.error,
                        title: "Refer & Earns",
                        isSelected: currentPage == "Articles" ? true : false),
                    DrawerTile(
                        icon: Icons.baby_changing_station,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_)=>MyProfile(title: 'How to Purchase')));

                        },
                        iconColor: ArgonColors.error,
                        title: "How to Purchase",
                        isSelected: currentPage == "Articles" ? true : false),
                    DrawerTile(
                        icon: Icons.language,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_)=>MyProfile(title: 'Language Setting')));
                        },
                        iconColor: ArgonColors.error,
                        title: "Language Setting",
                        isSelected: currentPage == "Articles" ? true : false),
                    Divider(height: 4, thickness: 0, color: ArgonColors.muted),
                    DrawerTile(
                        icon: Icons.info_outline,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_)=>MyProfile(title: 'About Us')));
                        },
                        iconColor: ArgonColors.primary,
                        title: "About Us",
                        isSelected: currentPage == "Articles" ? true : false),
                    DrawerTile(
                        icon: Icons.ads_click,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_)=>MyProfile(title: 'Follow Us')));
                        },
                        iconColor: ArgonColors.primary,
                        title: "Folow Us",
                        isSelected: currentPage == "Articles" ? true : false),
                    DrawerTile(
                        icon: Icons.star,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_)=>MyProfile(title: 'Rate Us')));
                        },
                        iconColor: ArgonColors.primary,
                        title: "Rate Us",
                        isSelected: currentPage == "Articles" ? true : false),
                    DrawerTile(
                        icon: Icons.security,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_)=>MyProfile(title: 'Privacy Policy')));
                        },
                        iconColor: ArgonColors.primary,
                        title: "Privacy Policy",
                        isSelected: currentPage == "Articles" ? true : false),
                    DrawerTile(
                        icon: Icons.add_box_outlined,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_)=>MyProfile(title: 'Term & Conditions')));
                        },
                        iconColor: ArgonColors.primary,
                        title: "Term & Conditions",
                        isSelected: currentPage == "Articles" ? true : false),
                  ],
                ),
              )),
          Container(
              color: AppColors.primaryColor,
              height: MediaQuery.of(context).size.height * 0.04,
              child: Center(child: Text('Customer Support',style: TextStyle(color: Colors.white,fontSize: 16),),)),
        ]));
  }
}
