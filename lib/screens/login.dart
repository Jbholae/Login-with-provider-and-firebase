import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project/models/user.dart';
import 'package:project/screens/signup.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final email = TextEditingController();
  final password = TextEditingController();
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText =! _obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 200,
                      width: 200,
                    ),
                    Text(
                      "Welcome Back",
                      style: TextStyle(
                          fontSize: 35.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0),
                    ),
                    Text(
                      "Log in to your existing account",
                      style: TextStyle(fontSize: 14.0, letterSpacing: 1.0),
                    ),
                    SizedBox(height: 40.0),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                fillColor: Colors.blue,
                                labelText: "email address",
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide:
                                        BorderSide(color: Colors.deepPurple)),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              controller: email,
                              validator: (value) =>
                                  (value.isEmpty) ? "Enter your email" : null,
                                  //checking validation if email field is empty or not
                            ),
                            SizedBox(height: 15.0),
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: TextFormField(
                                      controller: password,
                                      obscureText: _obscureText,
                                      decoration: InputDecoration(
                                        labelText: "password",
                                        hintText:
                                            "password must be atleast 6 character",
                                            
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide: BorderSide(
                                              color: Colors.deepPurple),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide:
                                              BorderSide(color: Colors.blue),
                                        ),
                                      ),
                                      validator: (value) => (value.isEmpty)
                                          ? "Enter your password"
                                          : null,
                                          //checking if password is 6 or more character
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: _toggle,
                                    icon: _obscureText
                                        ? Icon(Icons.visibility)
                                        : Icon(Icons.visibility_off),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15.0),
                            user.status == Status.Authenticating
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : SizedBox(
                                    height: 50,
                                    width: 120,
                                    child: RaisedButton(
                                      child: Text("Login"),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0)),
                                      onPressed: () async {
                                        if (_formKey.currentState.validate()) {
                                          if (!await user.singIn(
                                              email.text, password.text))
                                            _scaffoldKey.currentState
                                                .showSnackBar(
                                              SnackBar(
                                                content:
                                                    Text("Something is wrong"),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                            //users email and password validation is checked here, if email and password is not valid snackbar is shown
                                        }
                                      },
                                    ),
                                  ),
                            SizedBox(
                              height: 15.0,
                            ),
                            RichText(
                                text: TextSpan(
                                    text: 'Dont have an account ?',
                                    style: TextStyle(color: Colors.black),
                                    children: [
                                  TextSpan(
                                      text: 'SignUp !',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SignUp()));
                                                      // lead to signup screen for new user
                                        }),
                                ])),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.dispose();
    password.dispose();
  }
}
