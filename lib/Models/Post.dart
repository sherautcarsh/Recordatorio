import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'User.dart';

class Post{
  String title;
  String userImageUrl;
  String description;
  String imageUrl;
  List<String> likes;
  List<String> comments;

  Post({this.title, this.userImageUrl, this.imageUrl, this.description});

  Map<String, dynamic> toJson(BuildContext ctx) => {
    'image': userImageUrl,
    'title': title,
    'description': description,
    'postImage': imageUrl,
    'likes': likes,
    'comments': comments,
    'createdAt': Timestamp.now(),
  };
}