import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {

  final bool isLoading;
  final void Function(String email,String password,String username,String usertype, bool isLogin,BuildContext ctx) submitFn;
  AuthForm(this.submitFn,this.isLoading);

  @override
  _AuthFormState createState() => _AuthFormState();
}


class _AuthFormState extends State<AuthForm> {

  final _formKey = GlobalKey<FormState>();
  List<String> dropDownMenuItems = ['Club', 'Student'];

  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  var _isLogin = true;
  var user = 'Club';
  var _email = '';
  var _userName = '';
  var _password = '';
  var _userType = '';

  var _obscureText = true;
  var _obscureTextcf = true;
  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if(isValid) {
      _formKey.currentState.save();

      widget.submitFn(
        _email.trim(),
        _password.trim(),
        _userName.trim(),
        _userType.trim(),
        _isLogin,
        context,
      );
    }
  }


  Widget dropDown() {
    return DropdownButtonFormField(
      key: ValueKey('dropdown'),
      decoration: InputDecoration(
        labelText: 'User type',
        icon: Icon(Icons.person),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),

      value: user,
      icon: Icon(Icons.arrow_downward_sharp),
      iconSize: 25,
      iconEnabledColor: Colors.pink,
      iconDisabledColor: Colors.pink,
      onChanged: (String selectedValue) {
        setState(() {
          user = selectedValue;
        });
      },
      onSaved: (String value) {
        _userType = value;
      },
      items: dropDownMenuItems.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 20,
        color: Colors.grey[200],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        margin: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 73,
                    backgroundColor: Colors.deepPurple,
                    child: CircleAvatar(
                      radius: 70,
                      backgroundImage: AssetImage('assets/images/welcomeImage.jpg'),
                    ),
                  ),
                  SizedBox(height: 20,),
                  if(!_isLogin)
                    dropDown(),
                  if(!_isLogin)
                    SizedBox(height: 10,),
                  if(!_isLogin)
                    TextFormField(
                      key: ValueKey('username'),
                      decoration: InputDecoration(
                        labelText: 'Username',
                        icon: Icon(Icons.text_fields_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter username';
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        _userName = value;
                      },
                    ),
                  if(!_isLogin)
                    SizedBox(height: 10,),
                  TextFormField(
                    key: ValueKey('email'),
                    decoration: InputDecoration(
                      labelText: 'Email',
                      icon: Icon(Icons.email_sharp),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'This field cannot be empty';
                      }
                      if(!value.contains('@')){
                        return 'Invalid Email';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      _email = value;
                    },
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    key: ValueKey('password'),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      icon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      suffixIcon: IconButton(
                        icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        color: Colors.pink,
                      ),
                    ),
                    obscureText: _obscureText,
                    obscuringCharacter: '*',
                    controller: password,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Password cannot be empty';
                      }
                      if(value.length < 7){
                        return 'Password is too short';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _password = value;
                    },
                  ),
                  if(!_isLogin)
                    SizedBox(height: 10,),
                  if(!_isLogin)
                    TextFormField(
                      key: ValueKey('confirm-password'),
                      decoration: InputDecoration(
                        labelText: 'Confirm password',
                        icon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        suffixIcon: IconButton(
                          icon: Icon(_obscureTextcf ? Icons.visibility : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _obscureTextcf = !_obscureTextcf;
                            });
                          },
                          color: Colors.pink,
                        ),
                      ),
                      obscureText: _obscureTextcf,
                      obscuringCharacter: '*',
                      controller: confirmpassword,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Password can not be empty';
                        }
                        if(value.length < 7){
                          return 'Password is too short';
                        }
                        if(password.text != confirmpassword.text){
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        _password = value;
                      },
                    ),
                  SizedBox(height: 15,),
                  if(widget.isLoading)
                    CircularProgressIndicator(),
                  if(!widget.isLoading)
                    RaisedButton(
                      child: Text(
                        _isLogin ? 'LogIn' : 'SignUp',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      onPressed: _trySubmit,
                    ),
                  if(!widget.isLoading)
                    FlatButton(
                      textColor: Theme.of(context).accentColor,
                      child: Text(
                        _isLogin ? 'Create a new account?' : 'Already have an account?',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
