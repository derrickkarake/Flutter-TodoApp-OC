import 'package:flutter/material.dart';
import 'package:fluttertodo/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertodo/services/firestore_backend.dart';
import '../pages/opening_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
        theme: ThemeData(
        fontFamily: 'Poppins',
        brightness: Brightness.dark,
        primaryColor: Colors.orange[50],
        accentColor: Colors.orange[400],
        canvasColor: Colors.blue[700],),
      home: OpeningPage(),
    );
  }
  TextTheme _textTheme(Color color) => TextTheme(
    headline1: TextStyle(color: color),
    headline2: TextStyle(color: color),
    headline3: TextStyle(color: color),
    headline4: TextStyle(color: color),
    headline5: TextStyle(color: color),
    headline6: TextStyle(color: color, fontSize: 24.0),
    subtitle1: TextStyle(color: color, fontSize: 18.0),
    subtitle2: TextStyle(color: color),
    bodyText1: TextStyle(color: color),
    bodyText2: TextStyle(color: color, fontSize: 18.0),
    button: TextStyle(color: color),
    caption: TextStyle(color: color),
    overline: TextStyle(color: color),
  );
}
