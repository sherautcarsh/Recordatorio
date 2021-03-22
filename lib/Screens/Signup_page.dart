import 'package:flutter/material.dart';
import 'package:recordatorio/Screens/welcome_page.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  List<TextEditingController> control = new List(4);
  void dispose() {
    // Clean up the controller when the widget is disposed.
    for(TextEditingController controller in control){
      controller.dispose();
    }
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
            buildTextField('Name',Icons.account_circle,0),
            SizedBox(height : 20.0),
            buildTextField('Email',Icons.email,1),
            SizedBox(height : 20.0),
            buildTextField('Password',Icons.lock,2),
            SizedBox(height : 20.0),
            buildTextField('Confirm Password',Icons.lock,3),
            SizedBox(height : 20.0),
            SizedBox(height: 60),
            MaterialButton(
              minWidth: double.minPositive,
              height: 50,
              onPressed: () {
                name = control[0].text;
                email = control[1].text;
                password = control[2].text;
                rePassword = control[3].text;
                if(name == null || email == null || password == null || rePassword == null){
                  return "Fields are empty";
                }
                else{
                if(password == rePassword)
                {
                Navigator.push(context, MaterialPageRoute(
                    builder:


                            (context)=>WelcomeLogin()
                    ));
                }
                else {
                  return AlertDialog(
                    content: Text("Your password does not match"),
                  );
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
  buildTextField(String labelText,IconData icon, int index){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      height: 60.0,
      decoration: BoxDecoration(

        color: Colors.blue[600],
      ),
      child: TextField(
        controller: control[index],
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


