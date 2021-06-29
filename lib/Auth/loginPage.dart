import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:question_world/Auth/forgetPassword.dart';
import 'package:question_world/Auth/signUpPage.dart';
import 'package:question_world/services/authorizationService.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool loading = false;
  String email, password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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

  void _login() async {
    final _authService =
        Provider.of<AuthorizationService>(context, listen: false);
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        loading = true;
      });

      try {
        await _authService.signInWithEmail(email, password);
        Navigator.pop(context);
      } catch (err) {
        setState(() {
          loading = false;
        });
        showAlert(error: err.code);
      }
    }
  }

  showAlert({error}) {
    String errorMessage;

    if (error == "ERROR_INVALID_EMAIL") {
      errorMessage = "Email is invalid";
    } else if (error == "ERROR_USER_NOT_FOUND") {
      errorMessage = "The user is not found.";
    } else if (error == "ERROR_WRONG_PASSWORD") {
      errorMessage = "The password is wrong.";
    } else if (error == "ERROR_USER_DISABLED") {
      errorMessage = "The user is disabled.";
    } else {
      errorMessage = "There is an error that we can not define.$error";
    }

    var snackBar = SnackBar(content: Text(errorMessage));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
