import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:todo_pet/screen/LoginScreen.dart';
import 'package:todo_pet/screen/RegisterScreen.dart';
import 'package:todo_pet/screen/ToDoScreen.dart';
import 'package:todo_pet/screen/PetScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Auth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/todo': (context) => ToDoScreen(),
        'mypet': (context) => PetScreen(),
      },
    );
  }
}
