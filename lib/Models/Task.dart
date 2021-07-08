import 'Post.dart';
import 'User.dart';

class Task{
  User user;
  String heading;
  String description;
  String tag;
  bool done;
  DateTime start;
  DateTime end;
  Post correspondingPost;

  Task(this.heading, this.description, this.tag, this.done, this.start, this.end, this.correspondingPost);
}



/*
   title
   description
   completed
   time

 */