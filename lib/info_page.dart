import 'package:flutter/material.dart';

class Tasks extends StatefulWidget {
  @override
  _TasksState createState() => _TasksState();
}
class _TasksState extends State<Tasks> {
  int currentindex = 0;
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: PageView(
          controller: _pageController,
          children: [
            Center(child: Text("Tab for tasks")),
            Center(child: Text("Tab for feed")),
            Center(child: Text("Tab for notifications")),
            Center(child: Text("Tab for posts")),
          ],
          onPageChanged: (int index) {
            setState(() {
              currentindex = index;
            });
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentindex,
          type: BottomNavigationBarType.shifting,
          iconSize: 30,
          elevation: 100000.0,
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.redAccent,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.post_add_sharp),
              title: Text("TASKS"),
              backgroundColor: Colors.grey[800],
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.dynamic_feed_rounded),
              title: Text("FEED"),
              backgroundColor: Colors.grey[800],
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              title: Text("NOTIFICATIONS"),
              backgroundColor: Colors.grey[800],
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.work_outlined),
              title: Text("POSTS"),
              backgroundColor: Colors.grey[800],
            ),
          ],
          onTap: (index) {
            setState(() {
              currentindex = index;
            });
            _pageController.jumpToPage(index);
          },
        ),
      ),
    );
  }
}
