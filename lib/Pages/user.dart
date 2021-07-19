import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:recordatorio/Pages/add.dart';

import '../Providers/user_profile.dart';
import '../screens/edit_user_profile_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
class UserPage extends StatefulWidget{
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>{
  File pickedImage;
  final _auth = FirebaseAuth.instance;

  void _choseImage(BuildContext ctx) {
    ScaffoldMessenger.of(ctx).hideCurrentSnackBar();
    ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          elevation: 20,
          backgroundColor: Colors.white,
          duration: Duration(seconds: 2),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                icon: Icon(Icons.camera_alt_outlined),
                label: Text('Camera'),
                onPressed: () {
                  _pickImage(ImageSource.camera);
                },
              ),
              TextButton.icon(
                icon: Icon(Icons.image_outlined),
                label: Text('Gallery'),
                onPressed: () {
                  _pickImage(ImageSource.gallery);
                },
              ),
              TextButton.icon(
                icon: Icon(Icons.delete_outline_outlined),
                label: Text('Remove'),
                onPressed: _removeImage,
              ),
            ],
          ),
        )
    );
  }

  void _removeImage() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_auth.currentUser.uid)
          .update({
            'imageUrl': 'https://tse1.mm.bing.net/th?id=OIP.ksA_Oc-OvXQOJn1KRdaamAHaHa&pid=Api&P=0&w=300&h=300',
          }).then((value) => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 3),
                  content: Text('Refresh to see the changes',),
                ),
              ),);
    }catch (err) {
      print(err);
    }
  }

  void _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImageFile = await picker.getImage(
      source: source,
    );

    File croppedFile = await ImageCropper.cropImage(
        sourcePath: pickedImageFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.blue,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false
        ),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        )
    );

    // var result = await FlutterImageCompress.compressAndGetFile(
    //   croppedFile.path,
    //   croppedFile.path,
    //   quality: 88,
    // );

    setState(() {
      pickedImage = File(croppedFile.path);
    });

    try {
      String imageUrl;
      var storageImage = FirebaseStorage.instance.ref().child(pickedImage.path);
      var task = storageImage.putFile(pickedImage);
      imageUrl = await (await task.whenComplete(() => null)).ref.getDownloadURL();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_auth.currentUser.uid)
          .update({
              'imageUrl': imageUrl,
          }).then((value) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 3),
          content: Text('Refresh to see the changes',),
        ),
      ),);
    }catch (err) {
      print(err);
    }

  }

  void _editData(String name,String about) async{
    await showModalBottomSheet<dynamic>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50.0),
          topRight: Radius.circular(50.0),
        ),
      ),
      builder: (_) {
        return EditUserProfileScreen(name,about);
      },
    );
  }
  Future<DocumentSnapshot<Object>> _future = UserData().getCurrentUserData();
  Future<void> _refresh() {
    setState(() {
      _future = UserData().getCurrentUserData();
    });
  }

  @override
  Widget build(BuildContext context){
    return ChangeNotifierProvider(
      create: (ctx) => UserData(),
      child: Scaffold(
        backgroundColor: Colors.blueAccent,
        body: FutureBuilder(
            future: _future,
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          //alignment: Alignment.topRight,
                          margin: EdgeInsets.all(10),
                          child: IconButton(
                            icon: Icon(
                              Icons.add_box_outlined,
                              size: 35,
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Container(
                          //alignment: Alignment.topRight,
                          margin: EdgeInsets.all(10),
                          child: IconButton(
                            icon: Icon(
                              Icons.exit_to_app_sharp,
                              size: 35,
                            ),
                            onPressed: () {
                              return  showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: Text('Logout'),
                                  content: Text('Are you sure you want to logout?'),
                                  elevation: 20,
                                  actions: [
                                    FlatButton(
                                      child: Text(
                                        'NO',
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop(false);
                                      },
                                    ),
                                    FlatButton(
                                      child: Text(
                                        'YES',
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                      onPressed: () {
                                        FirebaseAuth.instance.signOut();
                                        Navigator.of(context).pop(true);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: _refresh,
                        child: ListView(
                          physics: AlwaysScrollableScrollPhysics(),
                          children: [
                            SizedBox(height: 10,),
                            Center(
                              child: Stack(
                                children: [
                                  ClipOval(
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        child: CircleAvatar(
                                          radius: 104,
                                          backgroundColor: Colors.black,
                                          child: CircleAvatar(
                                            radius: 100,
                                            backgroundColor: Colors.white,
                                            backgroundImage: NetworkImage(snapshot.data.get('imageUrl')),
                                            // backgroundImage: pickedImage != null ? FileImage(pickedImage) :
                                            // AssetImage('assets/images/userImage.jpg'),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 10,
                                    child: ClipOval(
                                      child: Container(
                                        padding: EdgeInsets.all(1),
                                        color: Colors.white,
                                        child: ClipOval(
                                          child: Container(
                                            //padding: EdgeInsets.all(1),
                                            color: Colors.redAccent,
                                            child: IconButton(
                                              icon: Icon(Icons.edit),
                                              color: Colors.white,
                                              onPressed: () {
                                                _choseImage(context);
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // profile pic widget ended.......

                            const SizedBox(height: 30,),
                            Column(
                              children: [
                                Text(
                                  snapshot.data.get('username'),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  ),
                                ),
                                SizedBox(height: 4,),
                                Text(
                                  snapshot.data.get('email'),
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                )
                              ],
                            ),

                            // name and email completed ....

                            const SizedBox(height: 50,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 48,),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Description',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                    ),
                                  ),
                                  const SizedBox(height: 15,),
                                  Text(
                                    snapshot.data.get('about'),
                                    style: TextStyle(
                                      fontSize: 16,
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // description ended ......
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Center(
                      child: RaisedButton(
                        elevation: 0,
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        onPressed: () {
                          _editData(snapshot.data.get('username'),snapshot.data.get('about'));
                        },
                      ),
                    ),
                  ],
                );
              }

              return Center(child: CircularProgressIndicator());
            }
          ),
        ),
      );


  }
}