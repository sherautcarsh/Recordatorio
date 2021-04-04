
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:recordatorio/Models/authentication.dart';
import 'package:recordatorio/Screens/welcome_page.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}


Map<String, String> _authData = {
  'email' : '',
  'password' : ''
};

class _SignupState extends State<Signup> {

  final control0 = TextEditingController();
  final control1 = TextEditingController();
  final control2 = TextEditingController();
  final control3 = TextEditingController();

  void dispose() {

    // Clean up the controller when the widget is disposed.
    control3.dispose();
    control2.dispose();
    control1.dispose();
    control0.dispose();
    super.dispose();
  }



  var name, email, password, rePassword;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 250.0),
            buildTextField('Name',Icons.account_circle, control0, false),
            SizedBox(height : 20.0),
            buildTextField('Email',Icons.email, control1, false),
            SizedBox(height : 20.0),
            buildTextField('Password',Icons.lock, control2, true),
            SizedBox(height : 20.0),
            buildTextField('Confirm Password',Icons.lock, control3, true),
            SizedBox(height : 20.0),
            SizedBox(height: 60),
            MaterialButton(
              minWidth: double.minPositive,
              height: 50,
              onPressed: () {

                name = control0.text;
                email = control1.text;
                password = control2.text;
                rePassword = control3.text;
                if(name == "" || email == ""|| password == "" || rePassword == ""){
                  final snackBar = SnackBar(
                    content: Text("Fields are Empty"),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                else{
                if(password == rePassword)
                {
                  _authData['email'] = email;
                  _authData['password'] = password;
                  _submit();

                }
                else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Passwords do not match"),
                  ));
                  }
                }
                }
                ,
              color: Colors.green[400],
              child: Text("SIGN UP",
                  style: TextStyle(color: Colors.white, fontSize: 30)),
              textColor: Colors.white,
            ),
            SizedBox(height: 80.0,),
          ],
        ),
      ),
    );
  }

  Future<void> _submit() async
  {

    try{
      await Provider.of<Authentication>(context, listen: false).signUp(
          _authData['email'],
          _authData['password']
      );
      Navigator.push(context, MaterialPageRoute(
          builder:


              (context)=>WelcomeLogin()
      ));

    } catch(error)
    {
      var errorMessage = 'Authentication Failed. Please try again later.';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text ('Authentication Failed'),
      )
      );
    }

  }

  buildTextField(String labelText,IconData icon, TextEditingController control, bool pass){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      height: 60.0,
      decoration: BoxDecoration(

        color: Colors.blue[600],
      ),
      child: TextField(

        controller: control,
        obscureText: pass,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 100),
            labelText: labelText,
            labelStyle: TextStyle(
              fontSize: 15.0,
              color: Colors.white,
            ),
            icon: Icon(
              icon,
              size: 35.0,
              color: Colors.white,
            ),
            // prefix: Icon(icon),
            border: InputBorder.none),
      ),
    );
  }

}


