import 'package:flutter/material.dart';
import 'package:todo_with_mypet/screens/pet_screen.dart';
import 'package:todo_with_mypet/screens/todo_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/todo_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/todo': (context) => ToDoScreen(),
        'mypet': (context) => MyPetScreen(),
      },
    );
  }
}
