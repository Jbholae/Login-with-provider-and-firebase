import 'package:flutter/material.dart';
import 'package:project/models/user.dart';
import 'package:provider/provider.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    // var a = Provider.of<User>(context);
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text("Second Screen"),
        // ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Second Screen",
                style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 25.0,
              ),
              RaisedButton(
                child: Text('Back to Home Screen'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
