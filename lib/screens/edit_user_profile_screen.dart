import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../Providers/user_profile.dart';
class EditUserProfileScreen extends StatefulWidget {

  final String _name;
  final String _about;
  EditUserProfileScreen(this._name,this._about);
  static const routeName = '/edit-user-profile-screen';

  @override
  _EditUserProfileScreenState createState() => _EditUserProfileScreenState();
}

class _EditUserProfileScreenState extends State<EditUserProfileScreen> {
  final _form = GlobalKey<FormState>();
  final _nameFocusNode = FocusNode();
  final _aboutFocusNode = FocusNode();
  var _isLoading = false;
  String _editedName;
  String _editedAbout;
  final _auth = FirebaseAuth.instance;
  Future<void> _submit() async{
    var _isvalid = _form.currentState.validate();
    if(!_isvalid){
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });

    try{
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_auth.currentUser.uid)
          .update({
            'username': _editedName,
            'about': _editedAbout,
          }).then((value) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 3),
          content: Text('Refresh to see the changes',),
        ),
      ),);
    } catch (err) {
      print(err);
    }
    setState(() {
      _isLoading = false;
    });
    //Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => UserData(),
      child: Container(
          height: MediaQuery.of(context).size.height*1.0,
          child: SingleChildScrollView(
            child: Card(
              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.0),
                  topRight: Radius.circular(50.0),
                  bottomLeft: Radius.circular(50.0),
                  bottomRight: Radius.circular(50.0),
                ),
              ),
              margin: EdgeInsets.all(25),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _form,
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                      TextFormField(
                        key: ValueKey('username'),
                        initialValue: widget._name,
                        decoration: InputDecoration(
                        labelText: 'Username',
                        icon: Icon(Icons.text_fields_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                        style: TextStyle(
                          letterSpacing: 1.5,
                        ),
                        keyboardType: TextInputType.name,
                        focusNode: _nameFocusNode,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter a valid username';
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          _editedName = value;
                        },
                      ),
                      SizedBox(height: 15,),
                      TextFormField(
                        key: ValueKey('about'),
                        initialValue: widget._about,
                        decoration: InputDecoration(
                          labelText: 'User description',
                          icon: Icon(Icons.text_snippet_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                        keyboardType: TextInputType.multiline,
                        focusNode: _aboutFocusNode,
                        maxLines: 5,
                        style: TextStyle(
                          letterSpacing: 1.5,
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter decription';
                          }
                          if(value.length < 30){
                            return 'Too short!';
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          _editedAbout = value;
                        },
                      ),
                      SizedBox(height: 20,),
                      _isLoading ? CircularProgressIndicator() : RaisedButton(
                        child: Text('Save'),
                        onPressed: _submit,
                      ),
                      SizedBox(height: 20,),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ),
    );
  }
}