import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:question_world/services/authorizationService.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Forget Password"),
      ),
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
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
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
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width - 10,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.blueAccent,
                    border: Border.all(
                      width: 1,
                    )),
                child: FlatButton(
                  onPressed: _forgetPassword,
                  child: Text(
                    "Request Password Reset",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _forgetPassword() async {
    final _authService =
        Provider.of<AuthorizationService>(context, listen: false);
    var _formState = _formKey.currentState;
    if (_formState.validate()) {
      _formState.save();
      setState(() {
        loading = true;
      });
      try {
        await _authService.forgetPassword(email);
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
      errorMessage = "There is no user with this e mail.";
    }

    var snackBar = SnackBar(content: Text(errorMessage));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
