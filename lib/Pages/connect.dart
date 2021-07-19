import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/clubListItem.dart';
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
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 10,left: 10,bottom: 0,top: 10),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).snapshots(),
                builder: (context, snapshot1){
                if(snapshot1.connectionState == ConnectionState.waiting){
                  return const Center(child: CircularProgressIndicator(),);
                }
                if(!snapshot1.hasData){
                  return const Center(child: Text('No data yet...'),);
                }
                    return StreamBuilder(
                        stream: FirebaseFirestore.instance.collection('users').where('userType', isEqualTo: 'Club').snapshots(),
                        builder: (context, snapshot) {
                          if(snapshot.connectionState == ConnectionState.waiting){
                            return const Center(child: CircularProgressIndicator(),);
                          }
                          if(!snapshot.hasData){
                            return const Center(child: Text('No data yet...'),);
                          }
                          return new ListView.builder(
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (BuildContext context,int index) => ClubListItem(context, snapshot.data.docs[index], snapshot1),
                          );
                        }
                    );

                  }
              ),
            ),
          ),
        ],
      ),
    );
  }
}