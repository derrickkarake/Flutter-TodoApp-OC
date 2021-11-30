import 'package:flutter/material.dart';
import '../services/auth.dart';

import '../services/my_controller.dart';
import '../utils/string_validator.dart';
import '../pages/home_page.dart';

class SignInAccountPage extends StatefulWidget {
  @override
  _SignInAccountPageState createState() => _SignInAccountPageState();
}

class _SignInAccountPageState extends State<SignInAccountPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _pwController = TextEditingController();

  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign In')),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: validateEmailAddress,
              decoration: const InputDecoration(
                labelText: 'Email Address',
              ),
            ),
            TextFormField(
              obscureText: true,
              controller: _pwController,
              keyboardType: TextInputType.visiblePassword,
              validator: validatePassword,
              decoration: const InputDecoration(
                labelText: 'Password',

              ),

            ),
            RaisedButton(
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  final result = await Auth.signInWithEmailAndPassword(email: _emailController.text, password: _pwController.text);
                  if (result == null) {
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => HomePage()), (route) => false);
                  }
                  else {
                    setState(() {
                      _errorMessage = result;
                    });

                  }
                }
              },
              child: Text('Sign In'),
            ),

          ],
        ),
      ),
    );
  }
}
