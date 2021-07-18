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
  bool isLiked;

  Post({this.title, this.userImageUrl, this.imageUrl, this.description, this.isLiked});

  Map<String, dynamic> toJson(BuildContext ctx) => {
    'image': imageUrl,
    'title': title,
    'description': description,
    'postImage': imageUrl,
    'isLiked': isLiked,
    'likes': likes,
    'comments': comments,
    'createdAt': Timestamp.now(),
  };
}