import 'package:flutter/material.dart';
import 'package:question_world/Auth/forgetPassword.dart';
import 'package:question_world/Core/mainPage.dart';
import 'signUpPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          _pageWidgets(),
          _loadingAnimation(),
        ],
      ),
    );
  }

  Widget _loadingAnimation() {
    if (loading) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Center();
    }
  }

  Widget _pageWidgets() {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.only(left: 10, right: 10, top: 60),
        children: [
          Column(),
          SizedBox(
            height: 5,
          ),
          Container(
            child: Center(
              child: Text(
                "Question World",
                style: TextStyle(
                  fontSize: 42,
                  color: Colors.blue[400],
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 50),
          Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.mail),
                      labelText: "Email",
                      hintText: "Please enter your email",
                      errorStyle: TextStyle(fontSize: 15),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Email field can not be empty!";
                      } else if (!value.contains("@")) {
                        return "Value should be an email format";
                      }
                      return null;
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
                      errorStyle: TextStyle(fontSize: 15),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Password field can not be empty!";
                      } else if (value.trim().length < 4) {
                        return "Password can not be less then 4 chars";
                      }
                      return null;
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
                    onPressed: _login,
                    child: Text(
                      "Login",
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
          SizedBox(
            height: 10,
          ),
          Container(
            child: FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ForgetPassword(),
                  ),
                );
              },
              child: Text(
                "Forget Password?",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          Container(
              child: FlatButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUpPage()),
              );
            },
            child: Text(
              "New User? Create Account?",
              style: TextStyle(color: Colors.black87),
            ),
          )),
        ],
      ),
    );
  }

  void _login() {
    if (_formKey.currentState.validate()) {
      setState(() {
        loading = true;
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    }
  }
}
