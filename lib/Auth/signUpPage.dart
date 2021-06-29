import 'package:flutter/material.dart';
import 'package:question_world/Auth/loginPage.dart';
import 'package:question_world/Core/categories.dart';
import 'package:question_world/Core/mainPage.dart';
import 'package:question_world/services/authorizationService.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  String userName, email, password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: ListView(
        children: [
          loading
              ? LinearProgressIndicator()
              : SizedBox(
                  height: 0,
                ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Center(
                    child: Text(
                      "Question World",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 42,
                        color: Colors.blue[400],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            labelText: "Username",
                            hintText: "Please enter your username",
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Username field can not be empty!";
                            } else if (value.trim().length < 4 ||
                                value.trim().length > 10) {
                              return "Username can be at least 4 and most 10 chars.";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            userName = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.mail),
                            labelText: "Email",
                            hintText: "Please enter your email",
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Email field can not be empty!";
                            } else if (!value.contains("@")) {
                              return "Value should be an email format";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            email = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            labelText: "Password",
                            hintText: "Please enter your password",
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Password field can not be empty!";
                            } else if (value.trim().length < 4) {
                              return "Password can not be less then 4 chars";
                            }

                            return null;
                          },
                          onSaved: (value) {
                            password = value;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width - 10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(width: 1),
                          color: Colors.blue,
                        ),
                        child: FlatButton(
                          onPressed: _createUser,
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Text("Do you have your account?"),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _createUser() async {
    var _formState = _formKey.currentState;
    if (_formState.validate()) {
      _formState.save();
      setState(() {
        loading = true;
      });
      try {
        await AuthorizationService().signUpWithEmail(email, password);
        Navigator.pop(context);
      } catch (err) {}
    }
  }
}
