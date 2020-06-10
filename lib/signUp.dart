import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _Registration();
  }
}

class _Registration extends State<SignUp> {

  final _formKey = new GlobalKey<FormState>();
  String _email, _password;
  final navigatorKey = GlobalKey<NavigatorState>();


  final pagesRouteFactories = {
    /*"/": () => MaterialPageRoute(
      builder: (context) => Center(
        child: Text("HomePage",style: Theme.of(context).textTheme.body1,),
      ),
    ),
    "takeOff": () => MaterialPageRoute(
      builder: (context) => Center(
        child: Text("Take Off",style: Theme.of(context).textTheme.body1,),
      ),
    ),
    "landing": () => MaterialPageRoute(
      builder: (context) => Center(
        child: Text("Landing",style: Theme.of(context).textTheme.body1,),
      ),
    ),
    "settings": () => MaterialPageRoute(
      builder: (context) => Center(
        child: Text("Settings",style: Theme.of(context).textTheme.body1,),
      ),
    ),*/
  };
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
  Widget _buildBody() =>
      MaterialApp(home: Scaffold(
        body: Center(
          child: Stack(
            children: <Widget>[showForm()],
          ),
        ),
      ),
          navigatorKey: navigatorKey,
          onGenerateRoute: (route) => pagesRouteFactories[route.name]()
      );

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    return MaterialApp(
      home: _buildBody(),
      debugShowCheckedModeBanner: false,
    );
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
            createAccount(),
            //signUp()
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

  Widget createAccount() {
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
              "Create account",
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            onPressed: _performLogin),
      ),
    );
  }
  
}
