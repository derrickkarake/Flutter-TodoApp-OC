import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../pages/home_page.dart';
import '../services/auth.dart';

import 'create_account_page.dart';
import 'sign_in_account_page.dart';

class OpeningPage extends StatefulWidget {
  @override
  _OpeningPageState createState() => _OpeningPageState();
}

class _OpeningPageState extends State<OpeningPage> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return _getScaffold();
          }
          return Container();
        },
        );


  }

  Widget building(BuildContext context) {
    return FutureBuilder(
      future: Auth.isSignedIn(),
      builder: (context, asyncSnapshot) {
        if(!asyncSnapshot.hasData) {
          return _getScaffold();
        }
        else {
        Future.sync(() => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => HomePage())));
        return Container();
        }

      },
    );


  }

  Widget _getScaffold() {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          RaisedButton(
              child: Text('Create Account'),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => CreateAccountPage()));
              }),

          TextButton(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Sign In'),
                ],
              ),
            ),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => SignInAccountPage()));
            },
          )
        ],
      ),
    );
  }
}
