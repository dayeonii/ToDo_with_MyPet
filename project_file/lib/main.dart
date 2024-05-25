import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:todo_pet/screen/login.dart';
import 'package:todo_pet/screen/register.dart';
import 'package:todo_pet/screen/todo.dart';
import 'package:todo_pet/screen/pet.dart';

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
        'mypet': (context) => MyPetScreen(),
      },
    );
  }
}
