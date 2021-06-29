import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:question_world/Auth/loginPage.dart';
import 'package:question_world/Auth/signUpPage.dart';
import 'package:question_world/Core/mainPage.dart';
import 'package:question_world/services/authorizationService.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool loading = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Text(
                "Welcome",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Question World",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            child: Text(
              "Question World is a education app for high school students.",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
          ),
        ),
        Container(
          child: Column(
            children: [
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width - 20,
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(width: 1),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width - 20,
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(width: 1),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width - 20,
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainPage()),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.android,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          _signInwithGoogle();
                        },
                        child: Text(
                          "Sign In with Google",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(width: 1),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _signInwithGoogle() async {
    final _authService =
        Provider.of<AuthorizationService>(context, listen: false);
    setState(() {
      loading = true;
    });
    try {
      await _authService.signInWithGoogle();
    } catch (err) {
      setState(() {
        loading = false;
      });
      showAlert(error: err.code);
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
