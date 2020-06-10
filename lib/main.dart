import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  String errorMsg = "";
  String _email, _password;
  String _displayName;
  bool _autoValidate = false;
  var apiCall = false;

  void _performLogin() async {
    final form = _formKey.currentState;
    if (_formKey.currentState.validate()) {
      form.save();
      setState(() {
        apiCall = true;
      });
      try {
        FirebaseUser firebaseUser = (await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _email, password: _password)) as FirebaseUser;
        UserUpdateInfo userUpdateInfo = new UserUpdateInfo();
        userUpdateInfo.displayName = _displayName;
        firebaseUser.updateProfile(userUpdateInfo).then((onValue) {
          // Navigator.of(context).pushReplacementNamed('/home');
          /*Firestore.instance.collection('users').document().setData(
              {'email': _email, 'displayName': _displayName}).then((onValue) {
            setState(() {

            });
          });*/
        });
        setState(() {
          apiCall = false;
        });
      } catch (e) {
        switch (e.code) {
          case "ERROR_INVALID_EMAIL":
            {
              setState(() {
                errorMsg = "This email is already in use.";
                apiCall = false;
              });
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Container(
                        child: Text(errorMsg),
                      ),
                    );
                  });
            }
            break;

          case "ERROR_WEAK_PASSWORD":
            {
              setState(() {
                errorMsg = "The password must be 6 characters long or more.";
                apiCall = false;
              });
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Container(
                        child: Text(errorMsg),
                      ),
                    );
                  });
            }
            break;

          default:
            {
              setState(() {
                errorMsg = "";
              });
            }
            break;
        }
      }
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  void initState() {
    super.initState();
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
          height: 50.0,
          child: new RaisedButton(
              elevation: 5.0,
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(5.0)),
              color: Colors.blue,
              child: apiCall
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : new Text(
                      "Login",
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
              onPressed: _performLogin),
        ));
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
          color: Color.fromARGB(250, 250, 250, 250),
          child: new Text(
            "Create an account",
            style: TextStyle(fontSize: 20.0, color: Colors.grey),
          ),
          onPressed: () {
            Navigator.of(context).pushNamed("/");
          },
        ),
      ),
    );
  }
}
