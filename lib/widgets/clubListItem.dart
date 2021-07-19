import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Providers/user_profile.dart';
class ClubListItem extends StatefulWidget {

  final BuildContext ctx;
  final DocumentSnapshot club;
  final AsyncSnapshot<dynamic> user;
  ClubListItem(this.ctx,this.club, this.user);
  @override
  _ClubListItemState createState() => _ClubListItemState();
}

class _ClubListItemState extends State<ClubListItem> {

  /*dynamic data;

  Future<dynamic> getData() async {

    final DocumentReference document =   FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid);

    await document.get().then<dynamic>(( DocumentSnapshot snapshot) async{
      setState(() {
        data =snapshot.data;
      });
    });
  }

  List followers = data['followers'];

  @override
  void initState() {

    super.initState();
    getData();
  }*/

  //DocumentSnapshot snapshot = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).snapshots();
  /*Stream<DocumentSnapshot> snapshot =  FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).snapshots();
  final followers = snapshot.*/


  /*Future<void> getFollowers() async {
    return await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).snapshots().listen((event) {
      setState(() {
        followers = event.get('followers');
      });
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    getFollowers();
    super.initState();
  }*/


  @override
  Widget build(BuildContext context) {
  var followers = widget.club['followers'];
  var following = widget.user.data['following'];
    return Container(
            child: Card(
              elevation: 20,
              child: ListTile(
                onTap: () {},
                title: Container(
                  child: Text(
                    widget.club['username'],
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                trailing: RaisedButton(
                    onPressed: () async {
                      setState(() {
                        if (following != null && following.contains(
                            widget.club['id'])) {
                          following.remove(widget.club['id']);
                          followers.remove(FirebaseAuth.instance.currentUser.uid);
                        }
                        else {
                          if (following == null) {
                            following = new List<dynamic>();
                          }
                          following.add(widget.club['id']);
                          followers.add(FirebaseAuth.instance.currentUser.uid);
                        }
                      });
                      final uid = FirebaseAuth.instance.currentUser.uid;
                      await Future.wait([FirebaseFirestore.instance.collection('users')
                          .doc(uid)
                          .update({
                        'following': following,
                      },),
                      FirebaseFirestore.instance.collection('users').doc(widget.club['id']).update(
                          {
                            'followers':followers,
                          }),
                      ]);

                    },
                  color: (following !=null && following.contains(widget.club['id']))
                      ? Colors.grey
                      : Colors.red,
                  child: Text(
                    (following!=null && following.contains(widget.club['id']))
                        ? 'Subscribed'
                        : 'Subscribe',
                  ),
                ),
              ),
            ),
          );

  }
}
