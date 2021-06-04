import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/models/user.dart';
import 'package:project/screens/second_screen.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  final FirebaseUser user;
  Home({this.user});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var a = Provider.of<User>(context);
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text(
                  "Welcome Home",
                  style: TextStyle(
                      fontSize: 30.9,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  '${a.user.email}',
                  //shows user email address used to register
                  style: TextStyle(fontSize: 25.0, fontStyle: FontStyle.italic),
                ),
                SizedBox(
                  height: 30.0,
                ),
                ElevatedButton(
                  child: Text("Second Page"),
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SecondScreen(),
                      )),
                  //leads to next screen
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    a.signOut();
                  },
                  child: Text("Signout"),
                  //logout from app and leads to login page
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
