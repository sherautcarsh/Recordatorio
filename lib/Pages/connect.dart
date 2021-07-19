import 'package:flutter/material.dart';

class ConnectPage extends StatefulWidget{
  @override
  _ConnectPageState createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        automaticallyImplyLeading: false,
        toolbarHeight: 75,
        elevation: 5,
        centerTitle: true,
        title: TextField(
          decoration: InputDecoration(
            hintText: "Connect with IIT-G",
            hintStyle: TextStyle(fontSize: 30, fontFamily: 'arial',),
          ),
          style: TextStyle(fontSize: 30, fontFamily: 'arial',),
          textAlign: TextAlign.center,
        ),
        actions: [],
      ),
    );
  }
}