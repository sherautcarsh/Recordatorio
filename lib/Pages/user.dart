import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class UserPage extends StatefulWidget{
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>{
  @override
  Widget build(BuildContext context){
    return Container(
      color: Colors.blueAccent,
      child: Center(
        child: IconButton(
          icon: Icon(
            Icons.logout,
            size: 40,
          ),
          onPressed: () {
            FirebaseAuth.instance.signOut();
          },
        ),
      ),
    );
  }
}