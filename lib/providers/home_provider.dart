import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ows_myshopline/core/constatnts/firestore_constants.dart';
import 'package:ows_myshopline/models/models.dart';

class HomeProvider {
  final FirebaseFirestore firebaseFirestore;

  HomeProvider({required this.firebaseFirestore});

  Future<void> updateDataFirestore(
      String collectionPath, String path, Map<String, String> dataNeedUpdate) {
    return firebaseFirestore
        .collection(collectionPath)
        .doc(path)
        .update(dataNeedUpdate);
  }

  Stream<QuerySnapshot> getStreamFireStore(
      String pathCollection, int limit, String? textSearch) {
    if (textSearch?.isNotEmpty == true) {
      return firebaseFirestore
          .collection(pathCollection)
          .limit(limit)
          .where(FirestoreConstants.nickname, isEqualTo: textSearch)
          .snapshots();
    } else {
      return firebaseFirestore
          .collection(pathCollection)
          .limit(limit)
          .snapshots();
    }
  }

  Stream<QuerySnapshot> getChatUsersFireStore(
      String uid, String pathCollection, int limit, String? textSearch) {
      print('saboor--------uid :${uid}----');
      return firebaseFirestore
          .collection('customer_chat')
          .doc(uid).collection(uid)
          .limit(limit)
          .snapshots();

  }
  Future<UserChat> getUserDetails(String uid) async {
    DocumentSnapshot? snapshot;
    await firebaseFirestore.collection('users').doc(uid).get().then((docSnapshot) {
      snapshot=docSnapshot;
    });
    return _userDataFromSnapshot(snapshot!);
  }
  UserChat _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserChat(
      id:snapshot['id'],
      photoUrl:snapshot['photoUrl'],
     nickname:snapshot['nickname'],
     aboutMe:snapshot['aboutMe'],
    );
  }
  Future<UserChat> getUserDetails2(String uid) async{
    print('getUserDetails2--------uid :${uid}----');
    DocumentSnapshot? snapshot;
    await firebaseFirestore.collection('users').doc(uid).get().then((docSnapshot) {
      snapshot=docSnapshot;
      print('getUserDetails2--------uid :${snapshot}----');
      print(docSnapshot.data());
      print(docSnapshot['nickname']);
      print(docSnapshot['photoUrl']);
    });
    return _userDataFromSnapshot2(snapshot!);
  }
  UserChat _userDataFromSnapshot2(DocumentSnapshot snapshot) {
    print('saboor22--------uid :----');
    return UserChat(
      id:snapshot['id'],
      photoUrl:snapshot['photoUrl'],
      nickname:snapshot['nickname'],
      aboutMe:snapshot['aboutMe'],
    );
  }



  getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data!.docs.map((doc) => print('----${doc}'));
  }
}
