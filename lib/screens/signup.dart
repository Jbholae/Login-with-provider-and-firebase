import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project/models/user.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final email = TextEditingController();
  final password = TextEditingController();
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Divider(
                    height: 30.0,
                  ),
                  Text(
                    "Let's Get Started",
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0),
                  ),
                  Text("Create an accont",
                      style: TextStyle(fontSize: 14.0, letterSpacing: 1.0)),
                  SizedBox(height: 55.0),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          TextFormField(
                            controller: email,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              fillColor: Colors.blue,
                              labelText: "email",
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
                            validator: (val) {
                              if (val.isEmpty) {
                                return "Please enter your email";
                              }
                              //checking if email field is empty or not
                            },
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
                                    validator: (val) {
                                      if (val.length < 5 || val.isEmpty) {
                                        return "password must be atleast 6 character";
                                      } else {
                                        return null;
                                        // checking if password is 6 or more character
                                      }
                                    },
                                  ),
                                ),
                                IconButton(
                                    icon: _obscureText
                                        ? Icon(Icons.visibility)
                                        : Icon(Icons.visibility_off),
                                    onPressed: _toggle),
                              ],
                            ),
                          ),
                          SizedBox(height: 15.0),
                          SizedBox(
                            height: 50.0,
                            width: 120.0,
                            child: RaisedButton(
                              child: Text("SignUp"),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0)),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  if (!await user.signUp(
                                      email.text, password.text))
                                    _scaffoldKey.currentState.showSnackBar(
                                        SnackBar(
                                            content: Text("Something is wrong"),
                                            backgroundColor: Colors.red));
                                }
                                //validating field and registering users, if not valid snackbar is shown
                              },
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          RichText(
                              text: TextSpan(
                                  text: 'Already have an account ?',
                                  style: TextStyle(color: Colors.black),
                                  children: [
                                TextSpan(
                                    text: 'SignIn !',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pop(context);
                                      }),
                                      // leads to login page.
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
