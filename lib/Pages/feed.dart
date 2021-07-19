import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/Posts/postsListItem.dart';

class FeedPage extends StatefulWidget{
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage>{

  bool done = false;

  @override
  Widget build(BuildContext context){
    double width = MediaQuery.of(context).size.width;
    return Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          automaticallyImplyLeading: false,
          toolbarHeight: 75,
          elevation: 5,
          centerTitle: true,
          title: Text("Recrio",
            style: TextStyle(fontSize: 30, fontFamily: 'arial',),
            textAlign: TextAlign.center,
          ),
          actions: [],
        ),
        body:/*SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
                children: [

                  Container(
                    height: 48,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black,
                    child:
                    Row(
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,

                              ),
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(26))
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(8, 6, 0, 0),
                          child: Text("research_club", style: TextStyle(color: Colors.white, fontSize: 16),),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    height: MediaQuery.of(context).size.width,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: new DecorationImage(image: NetworkImage('https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg'), fit: BoxFit.cover),
                    ),
                  ),
                  Stack(

                      children: [
                        Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.white70,
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Stack(
                                  alignment: Alignment(0,0),
                                  children: <Widget>[
                                    Icon(Icons.favorite, color: (done) ? Colors.red : Colors.black,size: 30,),
                                    IconButton(icon: Icon(Icons.favorite,), color: (done)?Colors.red:Colors.white,onPressed: (){
                                      setState(() {
                                        done = !done;
                                      });
                                    },splashColor: Colors.purple, splashRadius: 15,)
                                  ],),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Stack(
                                  alignment: Alignment(0,0),
                                  children: <Widget>[
                                    Icon(Icons.chat_bubble, color: Colors.black,size: 30,),
                                    IconButton(icon: Icon(Icons.chat_bubble,), color: Colors.white,onPressed: (){},splashColor: Colors.purple, splashRadius: 15,)
                                  ],),),
                              Container(
                                margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width - 144, 0, 0, 0),
                                alignment: Alignment.centerRight,
                                child: Stack(
                                  alignment: Alignment(0,0),
                                  children: <Widget>[
                                    Icon(Icons.bookmark, color: Colors.black,size: 30,),
                                    IconButton(icon: Icon(Icons.bookmark,), color: Colors.white,onPressed: (){},splashColor: Colors.purple, splashRadius: 15,)
                                  ],),),
                            ],),
                        ),
                      ]
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(6, 0, 0, 0),
                    width: width,
                    child: Row(children:[
                      Icon(Icons.circle, color:Colors.black),
                      Container(margin: EdgeInsets.fromLTRB(6, 0, 0, 0),child: Text("Liked by Utcarsh and 12 others", style: TextStyle(fontSize: 12),),)
                    ],),),
                  Container(
                    height: 1,
                    width: width,
                    color: Colors.purple,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(6, 6, 0, 0),
                    child: Text("And here we go again.\n "
                        "\n"
                        "Research section of IIT Guwahati has done it again. It has done what no other has ever been able to do. The photo might tell you what it is.\n"
                        "Yup. You heard right. We have produced sun from within a tree using the theory of atomic molecules and hundred other concepts you will never understand.",
                      style: TextStyle(fontSize: 20, ),),
                  )
                ]
            )
        )*/
          Column(
            children: [
              Expanded(
                child: StreamBuilder(
                        stream:
                        FirebaseFirestore.instance
                            .collection('otherUserData')
                            .doc(FirebaseAuth.instance.currentUser.uid)
                            .collection('posts')
                            .orderBy('createdAt', descending: true)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),);
                          }
                          if (!snapshot.hasData) {
                            print("No Posts here");
                            return const Center(child: Text('No Posts yet'));
                          }
                          print(
                              FirebaseAuth.instance.currentUser.uid.toString());
                          print(snapshot.data.docs.length);
                          return new ListView.builder(
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  Column(
                                    children: [
                                      PostsListItem(context, snapshot.data.docs[index]),
                                      SizedBox(height: 20,),
                                      Divider(
                                        color: Colors.black,
                                        thickness: 5,
                                      ),
                                      Divider(
                                        color: Colors.black,
                                        thickness: 5,
                                      ),
                                      SizedBox(height: 20,),
                                    ],
                                  )
                          );
                        }
                ),
              )
            ],
          )

    );
  }
}