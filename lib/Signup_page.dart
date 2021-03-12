import 'package:flutter/material.dart';
import 'package:recordatorio/welcome_page.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 250.0),
            buildTextField('Name',Icons.account_circle),
            SizedBox(height : 20.0),
            buildTextField('Email',Icons.email),
            SizedBox(height : 20.0),
            buildTextField('Password',Icons.lock),
            SizedBox(height : 20.0),
            buildTextField('Confirm Password',Icons.lock),
            SizedBox(height : 20.0),
            SizedBox(height: 60),
            MaterialButton(
              minWidth: double.minPositive,
              height: 50,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>WelcomeLogin()
                ));
              },
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
  buildTextField(String labelText,IconData icon){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      height: 60.0,
      decoration: BoxDecoration(

        color: Colors.blue[600],
      ),
      child: TextField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
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

