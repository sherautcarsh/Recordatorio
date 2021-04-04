import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recordatorio/Models/authentication.dart';

import 'Signup_page.dart';
import 'info_page.dart';


 class WelcomeLogin extends StatefulWidget {
  @override
  _WelcomeLoginState createState() => _WelcomeLoginState();
}

Map<String, String> _authData = {
  'email' : '',
  'password' : ''
};

class _WelcomeLoginState extends State<WelcomeLogin> {

  final control0 = TextEditingController();
  final control1 = TextEditingController();

  void dispose() {
    // Clean up the controller when the widget is disposed.
    control1.dispose();
    control0.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                child: TextLiquidFill(
                  text: 'WELCOME',
                  waveColor: Colors.yellowAccent,
                  boxBackgroundColor: Colors.blue,
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 70.0,
                  ),
                  boxHeight: 350.0,
                ),
              ),
              /////////
              buildTextField('Email', Icons.account_circle, control0, false),
              SizedBox(height: 20.0),
              buildTextField('Password', Icons.lock, control1, true),
              SizedBox(height: 60),
              MaterialButton(
                minWidth: double.minPositive,
                height: 50,
                onPressed: () {
                  _authData['email'] = control0.text;
                  _authData['password'] = control1.text;
                  _submit();

                },
                color: Colors.green[400],
                child: Text("LOGIN",
                    style: TextStyle(color: Colors.white, fontSize: 30)),
                //textColor: Colors.white,
              ),
              SizedBox(height: 80.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Do not have an account?",
                    style: TextStyle(
                      color: Colors.blue[900],
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),

                  ),
                  MaterialButton(
                    minWidth: double.minPositive,
                    height: 20,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => Signup()
                      ));

                    },
                    color: Colors.blue,
                    child: Text("SIGNUP",
                        style: TextStyle(
                            color: Colors.grey[300], fontSize: 20)),
                    textColor: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async
  {
    try {
      await Provider.of<Authentication>(context, listen: false).logIn(
          _authData['email'],
          _authData['password']
      );
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => Tasks()
      ));

    } catch (error) {
      var errorMessage = 'Authentication Failed. Please try again later.';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Authentication Failed'),
      )
      );
    }
  }

  buildTextField(String labelText, IconData icon,
      TextEditingController control, bool pass) {
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
