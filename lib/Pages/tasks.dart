import 'package:flutter/material.dart';
import '../widgets/tasksListItem.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/new_task_box.dart';

class TasksScreen extends StatefulWidget {

  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {

  // Stream<QuerySnapshot> getUserTaskStreamSnapshots(BuildContext context) async* {
  //   final uid = FirebaseAuth.instance.currentUser.uid;
  //   yield*
  // }
  @override
  Widget build(BuildContext context) {

    // final tasksProvider = Provider.of<Tasks>(context);
    // final tasksList = tasksProvider.tasks;
    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        automaticallyImplyLeading: false,
        toolbarHeight: 75,
        elevation: 5,
        centerTitle: true,
        title: Text("Tasks",
          style: TextStyle(fontSize: 30, fontFamily: 'arial',),
          textAlign: TextAlign.center,
        ),
        actions: [],
      ),
      body: Column(
        children: [

          Expanded(
            child: Padding(
                padding: const EdgeInsets.only(right: 10,left: 10,bottom: 0,top: 10),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('otherUserData').doc(FirebaseAuth.instance.currentUser.uid).collection('tasks').orderBy('createdAt', descending: true).snapshots(),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const Center(child: CircularProgressIndicator(),);
                    }
                    if(!snapshot.hasData){
                      return const Center(child: Text('No data yet...'),);
                    }
                    return new ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext context,int index) => TaskListItem(context, snapshot.data.docs[index]),
                    );
                  }
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          return showDialog(
          context: context,
          builder: (ctx) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 20,
            backgroundColor: Colors.white,
            child: NewTaskBox(),
          ),
        );
        },
      ),
    );
  }
}




















/*
import 'package:flutter/material.dart';

class ProjectPage extends StatefulWidget{
  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage>{
  String filterType = "timeline";
  bool today = true,tomorrow = false,later = false;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xFFF3CACA),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            AppBar(
              backgroundColor: Colors.redAccent,
              automaticallyImplyLeading: false,
              toolbarHeight: 75,
              elevation: 5,
              centerTitle: true,
              title: Text("Tasks & Projects",
                style: TextStyle(fontSize: 30, fontFamily: 'arial',),
                textAlign: TextAlign.center,
              ),
              actions: [
                IconButton(
                  icon:Icon(Icons.short_text, color: Colors.white,size: 30,),
                  onPressed: null,
                ),
              ],
            ),
            Container(
              height: 60,
              color: Colors.redAccent,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: (){changeFilter("timeline");},
                        child: Text("Timeline", style: TextStyle(
                          color: Colors.white,
                          fontSize: 26
                        ),)
                      ),
                      SizedBox(height: 10,),
                      Container(
                        height: 4,
                        width: MediaQuery.of(context).size.width/2,
                        color: (filterType=="timeline")?Colors.white:Colors.transparent,
                      ),
                      ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                          onTap: (){changeFilter("projects");},
                          child: Text("Projects", style: TextStyle(
                              color: Colors.white,
                              fontSize: 26
                          ),)
                      ),
                      SizedBox(height: 10,),
                      Container(
                        height: 4,
                        width: MediaQuery.of(context).size.width/2,
                        color: (filterType=="projects")?Colors.white:Colors.transparent,
                      ),
                    ],
                  ),
                ],
                ),
              ),
              (filterType=="timeline")?
                  Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child :
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                        TextButton(onPressed: (){
                          today = !today;
                          //print(today);
                          setState(() {

                          });
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 8.0,),
                          height: 60,
                          color: Colors.white,
                          child: Row(
                            children: [
                              SizedBox(height: 0,width:12),
                              Text("Today", style: TextStyle(color: Colors.redAccent,fontSize: 20),),
                            ],
                          ),
                        ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                return Color(0xFFF3CACA);// Use the component's default.
                              },
                            ),
                          ),
                        ),

                //TODAY STARTS HERE
                (today)?Column(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(6, 6, 6, 0),
                            padding: EdgeInsets.all(2),
                            height: 50,
                            color: Color(0xFFCE3636),
                            child: Row(
                              children: [
                                SizedBox(height: 0,width:10),
                                IconButton(onPressed: (){}, icon: Icon(Icons.check_circle_outline_outlined), highlightColor: Colors.blue,),
                                Text("Run away Happily", style: TextStyle(color: Color(0xFFFFFFFF),fontSize: 20),)
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(6, 6, 6, 0),
                            padding: EdgeInsets.all(2),
                            height: 50,
                            color: Color(0xFFCE3636),
                            child: Row(
                              children: [
                                SizedBox(height: 0,width:10),
                                IconButton(onPressed: (){}, icon: Icon(Icons.check_circle_outline_outlined), highlightColor: Colors.blue,),
                                Text("Find a girlfriend", style: TextStyle(color: Colors.white,fontSize: 20),)
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(6, 6, 6, 0),
                            padding: EdgeInsets.all(2),
                            height: 50,
                            color: Color(0xFFCE3636),
                            child: Row(
                              children: [
                                SizedBox(height: 0,width:10),
                                IconButton(onPressed: (){}, icon: Icon(Icons.check_circle_outline_outlined), highlightColor: Colors.blue,),
                                Text("Come back sad", style: TextStyle(color: Colors.white,fontSize: 20),)
                              ],
                            ),
                          )
                        ],
                      ):Container(),

                      //TOMORROW STARTS HERE
                      TextButton(onPressed: (){
                        tomorrow = !tomorrow;
                        print(tomorrow);
                        setState(() {

                        });
                      },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          height: 60,
                          color: Colors.white,
                          child: Row(
                            children: [
                              SizedBox(height: 0,width:10),
                              Text("Tomorrow", style: TextStyle(color: Colors.redAccent,fontSize: 20),),
                            ],
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              return Color(0xFFF3CACA);// Use the component's default.
                            },
                          ),
                        ),
                      ),
                  (tomorrow)?Column(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(6, 6, 6, 0),
                            padding: EdgeInsets.all(2),
                            height: 50,
                            color: Color(0xFFCE3636),
                            child: Row(
                              children: [
                                SizedBox(height: 0,width:10),
                                IconButton(onPressed: (){}, icon: Icon(Icons.check_circle_outline_outlined), highlightColor: Colors.blue,),
                                Text("Plan Better", style: TextStyle(color: Colors.white,fontSize: 20),)
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(6, 6, 6, 0),
                            padding: EdgeInsets.all(2),
                            height: 50,
                            color: Color(0xFFCE3636),
                            child: Row(
                              children: [
                                SizedBox(height: 0,width:10),
                                IconButton(onPressed: (){}, icon: Icon(Icons.check_circle_outline_outlined), highlightColor: Colors.blue,),
                                Text("Arranged Marriage?", style: TextStyle(color: Colors.white,fontSize: 20),)
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(6, 6, 6, 0),
                            padding: EdgeInsets.all(2),
                            height: 50,
                            color: Color(0xFFCE3636),
                            child: Row(
                              children: [
                                SizedBox(height: 0,width:10),
                                IconButton(onPressed: (){}, icon: Icon(Icons.check_circle_outline_outlined), highlightColor: Colors.blue,),
                                Text("Prepare to Live Alone", style: TextStyle(color: Colors.white,fontSize: 20),)
                              ],
                            ),
                          ),
                        ],
                      ):Container(),

                      //LATER STARTS HERE
                      TextButton(onPressed: (){
                        later = !later;
                        print(later);
                        setState(() {

                        });
                      },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          height: 60,
                          color: Colors.white,
                          child: Row(
                            children: [
                              SizedBox(height: 0,width:10),
                              Text("Later", style: TextStyle(color: Colors.redAccent,fontSize: 20),),
                            ],
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              return Color(0xFFF3CACA);// Use the component's default.
                            },
                          ),
                        ),
                      ),
                  (later)?Column(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(6, 6, 6, 0),
                            padding: EdgeInsets.all(2),
                            height: 50,
                            color: Color(0xFFCE3636),
                            child: Row(
                              children: [
                                SizedBox(height: 0,width:10),
                                IconButton(onPressed: (){}, icon: Icon(Icons.check_circle_outline_outlined), highlightColor: Colors.blue,),
                                Text("Make a to-do app", style: TextStyle(color: Colors.white,fontSize: 20),)                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(6, 6, 6, 0),
                            padding: EdgeInsets.all(2),
                            height: 50,
                            color: Color(0xFFCE3636),
                            child: Row(
                              children: [
                                SizedBox(height: 0,width:10),
                                IconButton(onPressed: (){}, icon: Icon(Icons.check_circle_outline_outlined), highlightColor: Colors.blue,),
                                Text("Accept your fate", style: TextStyle(color: Colors.white,fontSize: 20),)
                              ],
                            ),
                          ),
                        ],
                      ):Container(),


                ],)))

                  //PROJECTS
                  : Container(


                  ),
        ],
      ),
      ],
    ),);
  }
  changeFilter(String filter){
    filterType = filter;
    setState(() {

    });

}
  changeShow(bool show){
    print(show.toString());
    show = !show;
    setState(() {

    });
  }
}
*/
