import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'screens/auth_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/info_page.dart';
void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, appSnapShot) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'RECORDATORIO',
          theme: ThemeData(
            primarySwatch: Colors.pink,
            backgroundColor: Colors.pink,
            accentColor: Colors.deepPurple,
            accentColorBrightness: Brightness.dark,
            buttonTheme: ButtonTheme.of(context).copyWith(
              buttonColor: Colors.pink,
              textTheme: ButtonTextTheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          home: appSnapShot.connectionState != ConnectionState.done ? SplashScreen() :  StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (ctx, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return SplashScreen();
                }
                if (userSnapshot.hasData) {
                  return Info();
                }
                return AuthScreen();
              }
          ),
          routes: {
          },
        );
      },
    );
  }
}
