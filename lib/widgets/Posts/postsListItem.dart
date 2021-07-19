import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PostsListItem extends StatefulWidget{
  final BuildContext ctx;
  final DocumentSnapshot post;
  PostsListItem(this.ctx,this.post);

  @override
  _PostListItemState createState() => _PostListItemState();
}
class _PostListItemState extends State<PostsListItem>{

  @override
  Widget build(BuildContext context) {
    //print("yo" + widget.post['title']);
    //User user = FirebaseAuth.instance.currentUser;
    var likes = widget.post['likes'];
    // TODO: implement build
    return Column(
      children:[
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
                    image: DecorationImage(image : NetworkImage(widget.post['image'])),
                    borderRadius: BorderRadius.all(Radius.circular(26))
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(8, 6, 0, 0),
                child: Text(widget.post['title'], style: TextStyle(color: Colors.white, fontSize: 16),),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          height: MediaQuery.of(context).size.width,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: new DecorationImage(image: NetworkImage(widget.post['postImage']), fit: BoxFit.cover),
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
                          Icon(Icons.favorite, color: (likes != null  &&likes.contains(FirebaseAuth.instance.currentUser.uid.toString())) ? Colors.red : Colors.black,size: 30,),
                          IconButton(icon: Icon(Icons.favorite,), color: (likes != null  &&likes.contains(FirebaseAuth.instance.currentUser.uid.toString()))?Colors.red:Colors.white,
                            onPressed: ()async{

                            setState(() {
                              if(likes != null  &&likes.contains(FirebaseAuth.instance.currentUser.uid.toString())){
                                likes.remove(FirebaseAuth.instance.currentUser.uid);
                              }
                              else {
                                if(likes == null){
                                  likes = new List<dynamic>();
                                }
                                likes.add(FirebaseAuth.instance.currentUser
                                    .uid);
                              }
                            });
                            final uid = FirebaseAuth.instance.currentUser.uid;
                            await FirebaseFirestore.instance.collection('otherUserData').doc(FirebaseAuth.instance.currentUser.uid).collection('posts').doc(widget.post.id).update({
                              'likes' : likes,
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
          width: MediaQuery.of(context).size.width,
          child: Row(children:[
            Icon(Icons.circle, color:Colors.black),
            Container(margin: EdgeInsets.fromLTRB(6, 0, 0, 0),child: Text("Liked by ${(likes!=null)?widget.post['likes'].length:0} people", style: TextStyle(fontSize: 12),),)
          ],),),
        Container(
          height: 1,
          width: MediaQuery.of(context).size.width,
          color: Colors.purple,
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.fromLTRB(6, 6, 0, 0),
          child: Text(widget.post['description'],
            style: TextStyle(fontSize: 18, ),textAlign: TextAlign.left,),
        ),
        SizedBox(height: 10,)
    ]
    );
  }
}