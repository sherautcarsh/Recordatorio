import 'package:recordatorio/Providers/Task.dart';
import 'Post.dart';

class User{
  String username;
  String imageUrl;
  List<Task> tasks;
  List<Post> posts;
  List<User> followers;
  List<User> following;
}