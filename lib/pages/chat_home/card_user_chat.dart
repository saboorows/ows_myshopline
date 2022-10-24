import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ows_myshopline/models/models.dart';
import 'package:ows_myshopline/providers/home_provider.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:ows_myshopline/core/constatnts/colors.dart';
import 'package:ows_myshopline/providers/providers.dart';
import 'package:ows_myshopline/core/utils/utils.dart';
import '../pages.dart';

class CardChatUser extends StatefulWidget {
  const CardChatUser({Key? key, required this.document}) : super(key: key);
  final String document;

  @override
  State<CardChatUser> createState() => _CardChatUserState();
}

class _CardChatUserState extends State<CardChatUser> {
  UserChat? userChat;
  late HomeProvider homeProvider;

  getUserData() async {
    userChat = await homeProvider.getUserDetails2(widget.document);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeProvider = context.read<HomeProvider>();
    print('---------------------hay ');
    print('---------------------hay ${widget.document}');
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    // return Container(height:50,color: Colors.red,);
    return userChat == null
        ? Center(child: CircularProgressIndicator(color: AppColors.primaryColor,),)
        : widget.document == userChat!.id
            ? Container(
                child: TextButton(
                  child: Row(
                    children: <Widget>[
                      Material(
                        child: userChat!.photoUrl.isNotEmpty
                            ? Image.network(
                                userChat!.photoUrl,
                                fit: BoxFit.cover,
                                width: 50,
                                height: 50,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Container(
                                    width: 50,
                                    height: 50,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.themeColor,
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      ),
                                    ),
                                  );
                                },
                                errorBuilder: (context, object, stackTrace) {
                                  return Icon(
                                    Icons.account_circle,
                                    size: 50,
                                    color: AppColors.greyColor,
                                  );
                                },
                              )
                            : Icon(
                                Icons.account_circle,
                                size: 50,
                                color: AppColors.greyColor,
                              ),
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        clipBehavior: Clip.hardEdge,
                      ),
                      Flexible(
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Text(
                                  '${userChat!.nickname}',
                                  maxLines: 1,
                                  style:
                                      TextStyle(color: AppColors.black),
                                ),
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.fromLTRB(10, 0, 0, 5),
                              ),
                              Container(
                                child: Text(
                                  'About me: ${userChat!.aboutMe}',
                                  maxLines: 1,
                                  style:
                                      TextStyle(color: AppColors.black),
                                ),
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              )
                            ],
                          ),
                          margin: EdgeInsets.only(left: 20),
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    if (Utilities.isKeyboardShowing()) {
                      Utilities.closeKeyboard(context);
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatPage(
                          imageUrl: '',
                          isImageSend: false,
                          arguments: ChatPageArguments(
                            peerId: userChat!.id,
                            peerAvatar: userChat!.photoUrl,
                            peerNickname: userChat!.nickname,
                          ),
                        ),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(AppColors.greyColor2),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                ),
                margin: EdgeInsets.only(bottom: 10, left: 5, right: 5),
              ):Container(height:50,color: Colors.green,);
  }
}
