import 'package:flutter/cupertino.dart';

import 'User.dart';

class Post{
  User user;
  String description;
  String imageUrl;
  List<User> likes;
  List<User> comments;
  DateTime date;
  bool isLiked;

  Post(this.user, this.imageUrl, this.description, this.likes, this.comments, this.date, this.isLiked);
}