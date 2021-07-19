import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recordatorio/Pages/add.dart';
import 'package:recordatorio/Pages/connect.dart';
import 'package:recordatorio/Pages/feed.dart';
import 'package:recordatorio/Pages/tasks.dart';
import 'package:recordatorio/Pages/user.dart';
import 'package:recordatorio/Providers/user_profile.dart';

class Info extends StatefulWidget {
  @override
  InfoState createState() => InfoState();
}
class InfoState extends State<Info> {

  //Future<DocumentSnapshot<Object>> _future = UserData().getCurrentUserData();
  /*Future<void> _refresh() {
    setState(() {
      _future = UserData().getCurrentUserData();
    });
  }*/


  static const routeName = '/info';
  int currentindex = 0;


  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
        }
        List<Widget> pages = [
          FeedPage(),
          TasksScreen(),
          AddProjectPage(snapshot),
          ConnectPage(),
          UserPage()
        ];
        return new DefaultTabController(
          length: 5,
          initialIndex: 3,
          child: Scaffold(
            body: TabBarView(
                children: pages
            ),
            bottomNavigationBar: Container(
              child: new TabBar(
                tabs: [
                  Tab(
                      icon: Icon(Icons.home)
                  ),
                  Tab(
                      icon: Icon(Icons.notes)
                  ),
                  Tab(
                      icon: Icon(Icons.add)
                  ),
                  Tab(
                      icon: Icon(Icons.connect_without_contact)
                  ),
                  Tab(
                      icon: Icon(Icons.perm_identity)
                  )
                ],
                unselectedLabelColor: Colors.black,
                labelColor: Colors.blue,
                indicatorColor: Colors.transparent,
              ),
            ),
          ),
        );
      }
    );
  }
}

