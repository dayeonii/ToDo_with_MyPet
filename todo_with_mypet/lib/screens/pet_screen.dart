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
          ElevatedButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ToDoScreen()));
          }, child: Text('ToDo'))
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(20,15,20,15),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('배고픔'),
                        LinearProgressIndicator(
                          //padding: EdgeInsets.zero,
                          value: 0.5,
                        ),
                        SizedBox(height: 10), // 이미지와 프로그레스 바 간격
                        Image.asset('assets/images/catImage.png', width: 50, height: 50), // 적절한 이미지 위치 및 크기 설정
                      ],
                    ),
                  ),
                  SizedBox(width: 10),  // 간격
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('심심함'),
                        LinearProgressIndicator(
                          //padding: EdgeInsets.zero,
                          value: 0.7,
                        ),
                        SizedBox(height: 10), // 이미지와 프로그레스 바 간격
                        Image.asset('assets/images/catImage.png', width: 50, height: 50), // 적절한 이미지 위치 및 크기 설정
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.all(15),
                child: Row(

                ),
            ),
          ],
        ),
      ),
    );
  }
}
