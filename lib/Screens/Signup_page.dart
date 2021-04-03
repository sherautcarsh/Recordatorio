//import 'package:flutter/foundation.dart';
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

  bool _validate = false;
  bool _passwordMatch = false;
  var name = '', email = '', password = '', rePassword = '';
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
              onPressed: () async {
                /*print(name);
                print(email);
                print(password);
                print(rePassword);*/

                if(name.isEmpty || email.isEmpty || password.isEmpty || rePassword.isEmpty){
                  setState(() {
                   _validate = true;
                  });
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
                  setState(() {
                    _passwordMatch = true;
                  });
                  }
                }
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
  buildTextField(String labelText,IconData icon, int index){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.0),
      height: 60.0,
      decoration: BoxDecoration(
        color: Colors.blue[600],
          border: Border.all(
            color: Colors.blue[600],
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),

      ),
      child: TextField(
        controller: control[index],
        onChanged: (val){
          setState(() {
            if(index == 0){
              name = val;
            }else if(index==1){
              email = val;
            }else if(index==2){
              password = val;
            }else{
              rePassword = val;
            }
          });
        },



        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10.0),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            alignLabelWithHint: true,
            errorText: _validate ? 'Fields cannot be empty !!' : (_passwordMatch) ? 'Passwords do not match !!' : null,
            errorStyle: TextStyle(
              color: Colors.yellowAccent,
            ),
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
            border: InputBorder.none,

        ),
        obscureText: (index==2||index==3)?true:false,
        obscuringCharacter: '*',

        cursorColor: Colors.white,
        style: TextStyle(
          color: Colors.red,

        ),
      ),
    );
  }

  
}


