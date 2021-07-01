import 'package:flutter/material.dart';
import 'package:recordatorio/Pages/add.dart';
import 'package:recordatorio/Pages/connect.dart';
import 'package:recordatorio/Pages/feed.dart';
import 'package:recordatorio/Pages/projects.dart';
import 'package:recordatorio/Pages/user.dart';

class Info extends StatefulWidget {
  @override
  InfoState createState() => InfoState();
}
class InfoState extends State<Info> {

  static const routeName = '/info';
  int currentindex = 0;
  List<Widget> pages = [
    FeedPage(),
    ProjectPage(),
    AddProjectPage(),
    ConnectPage(),
    UserPage()
  ];

  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      initialIndex: 4,
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
}