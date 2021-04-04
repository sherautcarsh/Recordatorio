import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'httpexception.dart';

class Authentication with ChangeNotifier
{

  Future<void> signUp(String email, String password) async
  {
    const url = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBeh82tRcLsRhpR7jiVr4bvxSJye6XIKBk';
    try{
      final response = await http.post(url, body: json.encode(
          {
            'email' : email,
            'password' : password,
            'returnSecureToken' : true
          }
      ));
      final responseData = json.decode(response.body);
      if(responseData['error'] != null){
        throw HttpException(responseData['error']['message']);
      }
      //print(responseData);
    }

    catch(error){
      throw error;
    }

  }


  Future<void> logIn(String email, String password) async
  {
    const url = 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBeh82tRcLsRhpR7jiVr4bvxSJye6XIKBk';
  try{
    final response = await http.post(url, body: json.encode(
        {
          'email' : email,
          'password' : password,
          'returnSecureToken' : true
        }
    ));
    final responseData = json.decode(response.body);
    if(responseData['error'] != null){
      throw HttpException(responseData['error']['message']);
    }
    //print(responseData);
    }
    catch(error){
      throw error;
    }
  }
}