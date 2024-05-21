import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:todo_with_mypet/screens/todo_screen.dart';
import 'package:todo_with_mypet/screens/navigation_screen.dart';

class MyPetScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyPetScreenState();
  }
}

class _MyPetScreenState extends State<MyPetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationScreen(),
      appBar: AppBar(
        title: Text('My Pet'),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => ToDoScreen()));
              },
              child: Text('ToDo'))
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Text(
                      '배고픔',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: LinearProgressIndicator(
                        value: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Text(
                      '심심함',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: LinearProgressIndicator(
                        value: 0.7,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(80),
                child: Image.asset('assets/images/catImage.png'),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(100, 30, 100, 20),
                child: Row(
                  children: <Widget>[
                    Image.asset('assets/images/foodImage.png',
                        width: 40, height: 40, fit: BoxFit.cover),
                    SizedBox(width: 15),
                    Text(
                      '5',
                      style: TextStyle(fontSize: 25),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Image.asset('assets/images/toyImage.png',
                        width: 40, height: 40, fit: BoxFit.cover),
                    SizedBox(width: 15),
                    Text(
                      '7',
                      style: TextStyle(fontSize: 25),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(100, 20, 100, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        'assets/images/likeIcon.png',
                        width: 30,
                        height: 30,
                      ),
                      iconSize: 30,
                    ),
                    Text(
                      '12',
                      style: TextStyle(fontSize: 25),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    OutlinedButton(
                      onPressed: () {},
                      child: Text('먹이주기', style: TextStyle(fontSize: 25),),
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.grey, width: 2)),
                    ),
                    SizedBox(width: 20),
                    OutlinedButton(
                      onPressed: () {},
                      child: Text('놀아주기', style: TextStyle(fontSize: 25),),
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.grey, width: 2)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
