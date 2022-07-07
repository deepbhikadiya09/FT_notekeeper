import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mynotekeeper/firebase.dart';
import 'package:mynotekeeper/screen/home_screen.dart';

Future main() async {
  WidgetsFlutterBinding();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'NotesApp',
    home: MainScreen(),
  );
}

