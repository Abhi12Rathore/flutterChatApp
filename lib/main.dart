import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'signUp.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _Login();
  }
}

class _Login extends State<MyApp> {
  final _formKey = new GlobalKey<FormState>();
  String _email, _password;

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void _performLogin() {
    if (validateAndSave()) {
// perform firebase login and signup
    }
  }

  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: Stack(
              children: <Widget>[showForm()],
            ),
          ),
        ));
  }

  Widget showForm() {
    return new Container(
      padding: EdgeInsets.all(16.0),
      child: new Form(
        key: _formKey,
        child: new ListView(
          shrinkWrap: true,
          children: <Widget>[
            emailField(),
            passwordField(),
            loginButton(),
            signUp()
          ],
        ),
      ),
    );
  }

  Widget emailField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: "Enter your email-id",
            icon: new Icon(
              Icons.mail,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? "Email is mandatory" : null,
        onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget passwordField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10.0, 20.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: "Enter your password",
            icon: new Icon(
              Icons.lock,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? "Password is mandatory" : null,
        onSaved: (value) => _password = value.trim(),
      ),
    );
  }

  Widget loginButton() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.0, 35.0, 20.0, 0.0),
      child: SizedBox(
        height: 40.0,
        child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(5.0)),
            color: Colors.blue,
            child: new Text(
              "Login",
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            onPressed: _performLogin),
      ),
    );
  }

  Widget signUp() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.0, 35.0, 20.0, 0.0),
      child: SizedBox(
        height: 40.0,
        child: RaisedButton(
          elevation: 0.0,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(5.0)),
          color: Colors.white70,
          child: new Text(
            "Create an account",
            style: TextStyle(fontSize: 20.0, color: Colors.grey),
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SignUp()));
          },
        ),
      ),
    );
  }
}
