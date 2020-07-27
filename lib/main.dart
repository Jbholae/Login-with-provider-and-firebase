import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/models/user.dart';
import 'package:project/screens/home.dart';
import 'package:project/screens/login.dart';
import 'package:project/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => Provider.of<User>(context),
      //initializing provider so every widget can access it in our entire app.
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => User.instance(),
      child: Consumer(
        builder: (context, User user, _) {
          switch (user.status) {
            case Status.Uninitialized:
              return SplashScreen();
            case Status.Unauthenticated:
            case Status.Authenticating:
              return Login();
            case Status.Authenticated:
              return Home(user: user.user);
          }
        },
      ),
    );
    //here we check users status of user and show screen according to user status.
    /*
    if user is not logged in, Uninitialized screen i.e. splash screen will be shown,
    if user is logging in Authenticating screen i.e. login screen will be shown,
    if user is logged in authenticated screen i.e. Home screen will be with users email.
    */
  }
}
