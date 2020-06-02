import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_seek/authe.dart';
import 'services/userinfo.dart';

class AuthPage extends StatefulWidget {
  AuthPage({this.auth, this.onSignedIn});
  final VoidCallback onSignedIn;
  final BaseAuth auth;
  @override
  State<StatefulWidget> createState() => new _AuthPageState();
}

enum FormType { login, register }

class _AuthPageState extends State<AuthPage> {
  File profilepic;

  final formKey = new GlobalKey<FormState>();
  String _email;
  String _password;
  String _fullname;
  String _location;
  String _userId;

  FormType _formType = FormType.login;
  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if (_formType == FormType.login) {
          final String userId =
              await widget.auth.signInWithEmailAndPassword(_email, _password);
          print('Signed in: $userId');
        } else {
          final String userId = await widget.auth
              .createUserWithEmailAndPassword(_email, _password)
              .then((signedInUser) async {
            var userUpdateInfo = new UserUpdateInfo();
            userUpdateInfo.displayName = _fullname;
            userUpdateInfo.photoUrl =
                'https://cdn.mos.cms.futurecdn.net/QjuZKXnkLQgsYsL98uhL9X-1024-80.jpg';
            final user1 = await FirebaseAuth.instance.currentUser();

            user1.updateProfile(userUpdateInfo).then((user) {
              FirebaseAuth.instance.currentUser().then((user) {
                UserManagement().storeNewUser(user, context);
              }).catchError((e) {
                print(e);
              });
            }).catchError((e) {
              print(e);
            });
          }).catchError((e) {
            print(e);
          });

          print('Registered user: $userId');
        }
        widget.onSignedIn();
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
          padding: EdgeInsets.only(top: 50.0, left: 16.0, right: 16.0),
          child: new Form(
            key: formKey,
            child: new Column(children: buildInput() + buildSubmitButtons()),
          )),
    );
  }

  List<Widget> buildInput() {
    if (_formType == FormType.register) {
      return [
        SizedBox(height: 15),
        new Text(
          'REGISTER',
          style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 15),
        new TextFormField(
          //controller: emailController,

          decoration: new InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(color: Color(0xFF2C1CEA)),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xFF2C1CEA), width: 2.0)),
              icon: Icon(
                Icons.perm_identity,
                color: Color(0xFF2C1CEA),
              )),
          onChanged: (value) {
            this._email = value;
          },
          validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
          onSaved: (value) => _email = value,
        ),
        SizedBox(height: 25),
        new TextFormField(
          decoration: new InputDecoration(
              labelText: 'Password',
              labelStyle: TextStyle(color: Color(0xFF2C1CEA)),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xFF2C1CEA), width: 2.0)),
              icon: Icon(
                Icons.lock,
                color: Color(0xFF2C1CEA),
              )),
          onChanged: (value) {
            this._password = value;
          },
          obscureText: true,
          validator: (value) =>
              value.isEmpty ? 'Password can\'t be empty' : null,
          onSaved: (value) => _password = value,
        ),
        SizedBox(height: 25),
        new TextFormField(
          //controller: fullnameController,
          decoration: new InputDecoration(
              labelText: 'Fullname',
              labelStyle: TextStyle(color: Color(0xFF2C1CEA)),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xFF2C1CEA), width: 2.0)),
              icon: Icon(
                Icons.perm_identity,
                color: Color(0xFF2C1CEA),
              )),
          onChanged: (value) {
            this._fullname = value;
          },
          validator: (value) => value.isEmpty ? 'Name can\'t be empty' : null,
          onSaved: (value) => _fullname = value,
        ),
        SizedBox(height: 25),
        new TextFormField(
          //controller: locationController,
          decoration: new InputDecoration(
              labelText: 'Location',
              labelStyle: TextStyle(color: Color(0xFF2C1CEA)),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xFF2C1CEA), width: 2.0)),
              icon: Icon(
                Icons.location_on,
                color: Color(0xFF2C1CEA),
              )),
          onChanged: (value) {
            this._location = value;
          },
          validator: (value) =>
              value.isEmpty ? 'Location can\'t be empty' : null,
          onSaved: (value) => _location = value,
        ),
        SizedBox(height: 25),
      ];
    } else {
      return [
        SizedBox(height: 25),
        Text("LOGIN",
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.black,
                fontSize: 30.0,
                fontWeight: FontWeight.bold)),
        SizedBox(height: 5.0),
        Text("Search for your desired JOB:)",
            textAlign: TextAlign.left,
            style: TextStyle(color: Colors.black, fontSize: 15.0)),
        SizedBox(height: 75),
        new TextFormField(
          decoration: new InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(color: Color(0xFF2C1CEA)),
              border: OutlineInputBorder(),
              icon: Icon(Icons.perm_identity, color: Color(0xFF2C1CEA))),
          validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
          onSaved: (value) => _email = value,
        ),
        SizedBox(height: 35),
        new TextFormField(
          decoration: new InputDecoration(
              labelText: 'Password',
              labelStyle: TextStyle(color: Color(0xFF2C1CEA)),
              border: OutlineInputBorder(),
              icon: const Icon(
                Icons.lock,
                color: Color(0xFF2C1CEA),
              )),
          obscureText: true,
          validator: (value) =>
              value.isEmpty ? 'Password can\'t be empty' : null,
          onSaved: (value) => _password = value,
        ),
        SizedBox(height: 25),
      ];
    }
  }

  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.login) {
      return [
        SizedBox(height: 95),
        new SizedBox(
            width: 200.0,
            height: 50.0,
            child: new RaisedButton(
                child: new Text(
                  'Login',
                  style: new TextStyle(fontSize: 20.0),
                ),
                textColor: Colors.white,
                color: Color(0xFF2C1CEA),
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                ),
                onPressed: validateAndSubmit)),
        SizedBox(height: 45),
        new FlatButton(
            child: new Text('Create an Account',
                style: new TextStyle(fontSize: 20.0)),
            onPressed: moveToRegister),
      ];
    } else {
      return [
        SizedBox(height: 40),
        new SizedBox(
            width: 200.0,
            height: 50.0,
            child: new RaisedButton(
                child: new Text(
                  'Create an account',
                  style: new TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                textColor: Colors.white,
                color: Color(0xFF2C1CEA),
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                ),
                onPressed: validateAndSubmit)),
        SizedBox(height: 25),
        new FlatButton(
            child: new Text('Have an account ? Login',
                style: new TextStyle(fontSize: 20.0)),
            onPressed: moveToLogin),
      ];
    }
  }

  Future<bool> dialogTrigger(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Registered', style: TextStyle(fontSize: 15.0)),
            content: Text('Added'),
            actions: <Widget>[
              FlatButton(
                child: Text('Alright'),
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
