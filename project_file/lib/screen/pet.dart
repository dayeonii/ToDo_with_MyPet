import 'package:flutter/material.dart';
// import 'package:percent_indicator/percent_indicator.dart';
import 'package:todo_pet/screen/todo.dart';
import 'package:todo_pet/screen/navigation.dart';

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
        centerTitle: true,
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
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(60),
                  child: Image.asset('assets/images/catImage.png'),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/images/foodImage.png',
                        width: 40, height: 40, fit: BoxFit.cover),
                    SizedBox(width: 15),
                    Text(
                      '5',
                      style: TextStyle(fontSize: 25),
                    ),
                    SizedBox(width: 40), // 간격 조절을 위해 SizedBox 사용
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
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        'assets/images/likeIcon.png', width: 30, height: 30,),
                      iconSize: 30,
                    ),
                    Text(
                      '12',
                      style: TextStyle(fontSize: 25),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    OutlinedButton(
                      onPressed: () {},
                      child: Text('먹이주기', style: TextStyle(fontSize: 25)),
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.grey, width: 2)),
                    ),
                    SizedBox(width: 20),
                    OutlinedButton(
                      onPressed: () {},
                      child: Text('놀아주기', style: TextStyle(fontSize: 25)),
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