import 'package:flutter/material.dart';
import 'package:job_seek/AuthPage.dart';
import 'package:job_seek/TabItems/profilepicture.dart';
import 'package:job_seek/authe.dart';
import 'package:job_seek/bottomNavigation/bottom_bar.dart';
import 'package:job_seek/index_page.dart';
import 'TabItems/profilepage.dart';

class RootPage extends StatefulWidget {
  final BaseAuth auth;
  RootPage({this.auth});
  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

enum AuthStatus { notSignedIn, signedIn }

class _RootPageState extends State<RootPage> {
  AuthStatus _authStatus = AuthStatus.notSignedIn;

  @override
  void initState() {
    super.initState();
    widget.auth.currentUser().then((userId) {
      setState(() {
        _authStatus =
            userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    }).catchError((onError) {
      _authStatus = AuthStatus.notSignedIn;
    });
  }

  void _signedIn() {
    setState(() {
      _authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut() {
    setState(() {
      _authStatus = AuthStatus.notSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_authStatus) {
      case AuthStatus.notSignedIn:
        return new AuthPage(
          auth: widget.auth,
          onSignedIn: _signedIn,
        );

      case AuthStatus.signedIn:
        return new ProfilePage(auth: widget.auth, onSignedOut: _signedOut);
      //bottom_bar();
    }
  }
}
