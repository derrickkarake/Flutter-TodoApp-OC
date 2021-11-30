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
      title: 'Flutter Demo',
      home: OpeningPage(),
    );
  }
}
