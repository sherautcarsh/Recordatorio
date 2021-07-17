import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'User.dart';

class Post{
  User user;
  String description;
  String imageUrl;
  List<User> likes;
  List<User> comments;
  bool isLiked;

  Post(this.user, this.imageUrl, this.description, this.likes, this.comments, this.isLiked);

  Map<String, dynamic> toJson(BuildContext ctx) => {
    'title': user.username,
    'description': description,
    'image': imageUrl,
    'isLiked': isLiked,
    'likes': likes,
    'comments': comments,
    'createdAt': Timestamp.now(),
    
  };
}