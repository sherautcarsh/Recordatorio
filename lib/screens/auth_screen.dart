import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/auth_form.dart';
class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>{
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;
  void _submitAuthForm(String email,String password,String username,String usertype, bool isLogin, BuildContext ctx) async {

    UserCredential authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if(isLogin){
        authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
      }else{
        authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user.uid)
            .set({
            'username': username,
            'email': email,
            'userType': usertype,
            'about': 'Start writing about yourself ...',
            'imageUrl': 'https://tse1.mm.bing.net/th?id=OIP.ksA_Oc-OvXQOJn1KRdaamAHaHa&pid=Api&P=0&w=300&h=300',
            'followers': [authResult.user.uid],
            'following' : [],
            'id' : authResult.user.uid,
        });
      }
    } on FirebaseAuthException catch(err) {
      var message = 'An error occured, please check your credentials';
      if(err.message != null){
        message = err.message;
      }
      if(message == 'There is no user record corresponding to this identifier. The user may have been deleted.'){
        message = 'Email does not exist !';
      }
      if(message == 'The password is invalid or the user does not have a password.'){
        message = 'Incorrect Password !';
      }
      if(message == 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.'){
        message = 'Network error, please try again later !';
      }
      //print(message);
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 1),
          content: Text(message),
          backgroundColor: Colors.deepPurple,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (err){
      print(err);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm,_isLoading),
    );
  }
}
