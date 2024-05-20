import 'package:flutter/material.dart';

class ToDoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ToDoScreenState();
  }
}

class _ToDoScreenState extends State<ToDoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('To-Do List'),),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                  children: [
                    SizedBox(width: 30),
                    Text('2024. 05. 24. FRI', style: TextStyle(fontSize: 30)),
                    SizedBox(width: 25),
                    ElevatedButton(onPressed: (){}, child: Text('+', style: TextStyle(fontSize: 20)))
                ]
              ),
            ),
            //Divider() -> 얘는 아예 섹션 나눔
            Container(  //구분선
              margin: EdgeInsets.symmetric(vertical: 10.0),
              width: 350.0, // 구분선의 길이
              height: 1.5, // 구분선의 두께
              color: Colors.black, // 구분선의 색상
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildToDoList('소설 과제하기'),
                  _buildToDoList('장 보기'),
                  _buildToDoList('운동하기'),
                ],
              ),
            ),
          ],
        )
      )
    );
  }
}

Widget _buildToDoList(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 15.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(onPressed: (){}, icon: Icon(Icons.check_box_outline_blank)),
        Text(title, style: TextStyle(fontSize: 20)),
        ElevatedButton(onPressed: (){}, child: Text('-', style: TextStyle(fontSize: 30),),)
      ],
    )
  );
}