import 'package:flutter/foundation.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserModel {
  String name;
  String email;
  String imageUrl;
  String about;
  List<String> followers;

  UserModel({
    this.name,
    this.email,
    this.imageUrl,
    this.about,
  });

  Map<String, dynamic> toJson(BuildContext ctx) => {
    'imageUrl': imageUrl,
    'username': name,
    'about': about,
    'email': email,
    'followers' : followers,
  };
}

class UserData with ChangeNotifier {

  Future<DocumentSnapshot> getCurrentUserData() async{
    final _auth = FirebaseAuth.instance;
    try{
      return await FirebaseFirestore.instance.collection('users').doc(_auth.currentUser.uid).get();
    }catch (err){
      print(err);
      return null;
    }
  }
}

