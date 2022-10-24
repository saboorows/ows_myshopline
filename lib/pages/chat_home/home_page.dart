import 'dart:async';
import 'dart:io';
import 'package:ows_myshopline/core/constatnts/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:ows_myshopline/core/constatnts/firestore_constants.dart';
import 'package:ows_myshopline/providers/providers.dart';
import 'package:ows_myshopline/core/utils/utils.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import '../../models/models.dart';
import 'package:ows_myshopline/core/widgets/widgets.dart';
import '../pages.dart';
import 'card_user_chat.dart';

class HomePageChatApp extends StatefulWidget {
  HomePageChatApp({Key? key}) : super(key: key);
  @override
  State createState() => HomePageChatAppState();
}

class HomePageChatAppState extends State<HomePageChatApp> {
  HomePageChatAppState({Key? key});

  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final ScrollController listScrollController = ScrollController();

  int _limit = 20;
  int _limitIncrement = 20;
  String _textSearch = "";
  bool isLoading = false;

  late AuthProvider authProvider;
  late String currentUserId;
  late HomeProvider homeProvider;
  Debouncer searchDebouncer = Debouncer(milliseconds: 300);
  StreamController<bool> btnClearController = StreamController<bool>();
  TextEditingController searchBarTec = TextEditingController();

  List<PopupChoices> choices = <PopupChoices>[
    PopupChoices(title: 'Settings', icon: Icons.settings),
    PopupChoices(title: 'Log out', icon: Icons.exit_to_app),
  ];

  @override
  void initState() {
    super.initState();
    authProvider = context.read<AuthProvider>();
    homeProvider = context.read<HomeProvider>();

    if (authProvider.getUserFirebaseId()?.isNotEmpty == true) {
      currentUserId = authProvider.getUserFirebaseId()!;
    } else {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginPage()),
        (Route<dynamic> route) => false,
      );
    }
    registerNotification();
    configLocalNotification();
    listScrollController.addListener(scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    btnClearController.close();
  }

  void registerNotification() {
    firebaseMessaging.requestPermission();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('onMessage: $message');
      if (message.notification != null) {
        showNotification(message.notification!);
      }
      return;
    });

    firebaseMessaging.getToken().then((token) {
      print('push token: $token');
      if (token != null) {
        homeProvider.updateDataFirestore(FirestoreConstants.pathUserCollection,
            currentUserId, {'pushToken': token});
      }
    }).catchError((err) {
      Fluttertoast.showToast(msg: err.message.toString());
    });
  }

  void configLocalNotification() {
    AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings();
    InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void scrollListener() {
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange) {
      setState(() {
        _limit += _limitIncrement;
      });
    }
  }

  void onItemMenuPress(PopupChoices choice) {
    if (choice.title == 'Log out') {
      handleSignOut();
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SettingsPage()));
    }
  }

  void showNotification(RemoteNotification remoteNotification) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      Platform.isAndroid
          ? 'com.dfa.flutterchatdemo'
          : 'com.duytq.flutterchatdemo',
      'Flutter chat demo',
      playSound: true,
      enableVibration: true,
      importance: Importance.max,
      priority: Priority.high,
    );
    IOSNotificationDetails iOSPlatformChannelSpecifics =
        IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    print(remoteNotification);

    await flutterLocalNotificationsPlugin.show(
      0,
      remoteNotification.title,
      remoteNotification.body,
      platformChannelSpecifics,
      payload: null,
    );
  }

  Future<void> handleSignOut() async {
    authProvider.handleSignOut();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginPage()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            // List
            Column(
              children: [
                // buildSearchBar(),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: homeProvider.getChatUsersFireStore(
                        currentUserId,
                        FirestoreConstants.pathMessageCollection,
                        _limit,
                        _textSearch),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        print(
                            '-StreamBuilder22----${snapshot.data?.docs.length}-------------------');
                        if ((snapshot.data?.docs.length ?? 0) > 0) {
                          getExpenseItems(snapshot);
                          return ListView.builder(
                            padding: EdgeInsets.all(10),
                            itemBuilder: (context, index) {
                              print('www------------------------${snapshot.data?.docs[index].id??'null'}');
                              // return Container(height:50,color: Colors.red,);
                              return CardChatUser(
                                  document: snapshot.data?.docs[index].id??'null');
                            },
                            itemCount: snapshot.data?.docs.length,
                            controller: listScrollController,
                          );
                        } else {
                          print('--l-----------${(snapshot.data?.docs.length ?? 0)}');
                          return Center(
                            child: Text("No users"),
                          );
                        }
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            color: AppColors.themeColor,
                          ),
                        );
                      }
                    },
                  ),
                ),
                isLoading ? LoadingView() : SizedBox.shrink(),
              ],
            ),
            // Loading
          ],
        ),
      ),
    );
  }

  getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot) {
    print('getExpenseItems called');
    print('getExpenseItems called le ${snapshot.data!.docs.length}');
    for (int i = 0; i < snapshot.data!.docs.length; i++) {
      print('${snapshot.data?.docs[i].id}');
      snapshot.data!.docs.map((doc) {
        print('----${doc}');
      });
    }
  }

// Widget buildItem(BuildContext context, DocumentSnapshot? document){
//   print('---buildItem-----------------');
//   print('-----buildItem---------------${document!.id}');
//   if (document != null) {
//     // homeProvider.getUserDetails(document['userId']);
//     if(userChat!=null){
//       userChat = UserChat.fromDocument(document);
//     }else{
//       return Container();
//     }
//     if (userChat!.id == currentUserId) {
//       return SizedBox.shrink();
//     } else {
//       return Container(
//         child: TextButton(
//           child: Row(
//             children: <Widget>[
//               Material(
//                 child: userChat.photoUrl.isNotEmpty
//                     ? Image.network(
//                   userChat.photoUrl,
//                   fit: BoxFit.cover,
//                   width: 50,
//                   height: 50,
//                   loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
//                     if (loadingProgress == null) return child;
//                     return Container(
//                       width: 50,
//                       height: 50,
//                       child: Center(
//                         child: CircularProgressIndicator(
//                           color: AppColors.themeColor,
//                           value: loadingProgress.expectedTotalBytes != null
//                               ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
//                               : null,
//                         ),
//                       ),
//                     );
//                   },
//                   errorBuilder: (context, object, stackTrace) {
//                     return Icon(
//                       Icons.account_circle,
//                       size: 50,
//                       color: AppColors.greyColor,
//                     );
//                   },
//                 )
//                     : Icon(
//                   Icons.account_circle,
//                   size: 50,
//                   color: AppColors.greyColor,
//                 ),
//                 borderRadius: BorderRadius.all(Radius.circular(25)),
//                 clipBehavior: Clip.hardEdge,
//               ),
//               Flexible(
//                 child: Container(
//                   child: Column(
//                     children: <Widget>[
//                       Container(
//                         child: Text(
//                           'Nickname: ${userChat.nickname}',
//                           maxLines: 1,
//                           style: TextStyle(color: AppColors.primaryColor),
//                         ),
//                         alignment: Alignment.centerLeft,
//                         margin: EdgeInsets.fromLTRB(10, 0, 0, 5),
//                       ),
//                       Container(
//                         child: Text(
//                           'About me: ${userChat.aboutMe}',
//                           maxLines: 1,
//                           style: TextStyle(color: AppColors.primaryColor),
//                         ),
//                         alignment: Alignment.centerLeft,
//                         margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
//                       )
//                     ],
//                   ),
//                   margin: EdgeInsets.only(left: 20),
//                 ),
//               ),
//             ],
//           ),
//           onPressed: () {
//             if (Utilities.isKeyboardShowing()) {
//               Utilities.closeKeyboard(context);
//             }
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => ChatPage(
//                   arguments: ChatPageArguments(
//                     peerId: userChat!.id,
//                     peerAvatar: userChat!.photoUrl,
//                     peerNickname: userChat!.nickname,
//                   ),
//                 ),
//               ),
//             );
//           },
//           style: ButtonStyle(
//             backgroundColor: MaterialStateProperty.all<Color>(AppColors.greyColor2),
//             shape: MaterialStateProperty.all<OutlinedBorder>(
//               RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(10)),
//               ),
//             ),
//           ),
//         ),
//         margin: EdgeInsets.only(bottom: 10, left: 5, right: 5),
//       );
//     }
//   } else {
//     return SizedBox.shrink();
//   }
// }
}
