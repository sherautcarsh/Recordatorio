import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recordatorio/Models/Post.dart';
import 'package:recordatorio/Providers/user_profile.dart';
import 'package:recordatorio/screens/edit_user_profile_screen.dart';

class AddProjectPage extends StatefulWidget{
  final AsyncSnapshot<dynamic> snapshot;
  AddProjectPage(this.snapshot);
  @override
  _AddProjectPageState createState() => _AddProjectPageState();
}

class _AddProjectPageState extends State<AddProjectPage>{

  String networkImage = 'https://www.iconsdb.com/icons/preview/red/upload-2-xxl.png';
  File pickedImage;
  final _auth = FirebaseAuth.instance;
  String imageUrl;
  void _chooseImage(BuildContext ctx) {
    ScaffoldMessenger.of(ctx).hideCurrentSnackBar();
    ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          elevation: 20,
          backgroundColor: Colors.redAccent,
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

    setState(() {
      pickedImage = File(croppedFile.path);
    });

    try {
      var storageImage = FirebaseStorage.instance.ref().child(pickedImage.path);
      var task = storageImage.putFile(pickedImage);

      imageUrl = await (await task.whenComplete(() => null)).ref.getDownloadURL();
      setState(() {
        networkImage = imageUrl;
      });
    }catch (err) {
      print(err);
    }

  }

  @override
  Widget build(BuildContext context){
    final _formkey = GlobalKey<FormState>();
    final newPost = new Post();
    var _isLoading = false;
    setState(() {
      _isLoading = true;
    });
    newPost.title = widget.snapshot.data['username'];
    newPost.userImageUrl = widget.snapshot.data['imageUrl'];
    newPost.imageUrl = imageUrl;
    newPost.likes = new List<String>();

    void _trySubmit(BuildContext context) async {
      final isValid = _formkey.currentState.validate() && imageUrl != null;
      FocusScope.of(context).unfocus();
      if(!isValid){
        print("Not Valid");
        return;
      }
      _formkey.currentState.save();
      try {
        for(final follow in widget.snapshot.data['followers']) {
          await FirebaseFirestore.instance.collection('otherUserData')
              .doc(follow)
              .collection('posts')
              .add(newPost.toJson(context));
        }
      } catch (err) {
        print(err);
        await showDialog<Null>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('An error occurred'),
            content: Text('Something went wrong'),
            actions: [
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          ),
        );
      }
      setState(() {
        _isLoading = false;
      });
      //Navigator.of(context).pop();
      try{
        await FirebaseFirestore.instance.collection('posts')
            .add(newPost.toJson(context));
      }
      catch(err){
        print(err);
        await showDialog<Null>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('ERRORRRRRRR'),
            content: Text('YOOO ERROR'),
            actions: [
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          ),
        );
      }
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          automaticallyImplyLeading: false,
          toolbarHeight: 75,
          elevation: 5,
          centerTitle: true,
          title: Text("Add Post",
            style: TextStyle(fontSize: 30, fontFamily: 'arial',),
            textAlign: TextAlign.center,
          ),
          actions: [],
        ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: new DecorationImage(image: NetworkImage(networkImage), fit: BoxFit.cover)
              ),
              child: TextButton(
                onPressed: (){
                  _chooseImage(context);
                },
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 10,
              color: Colors.redAccent,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
              alignment: Alignment.centerLeft,
              child: Text("Description", textAlign: TextAlign.left, style: TextStyle(fontSize: 24, ),),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    TextFormField(
                      key: ValueKey('description'),
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        labelText: 'Description',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                      ),
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      maxLines: 15,
                      onSaved: (String value){
                        newPost.description = value;
                      }
                    ),
                    SizedBox(height: 5,),
                    (!_isLoading)?CircularProgressIndicator() : Container(
                      width: 80,
                      alignment: Alignment.center,
                      color: Colors.redAccent,
                      child : TextButton(onPressed: (){
                        _trySubmit(context);
                        setState(() {
                          networkImage = 'https://www.iconsdb.com/icons/preview/red/upload-2-xxl.png';
                        });
                      }, child: Text("Publish", style: TextStyle(color: Colors.white),), style: ButtonStyle(),)
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}