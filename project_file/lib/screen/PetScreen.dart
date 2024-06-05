import 'package:flutter/material.dart';
import 'package:todo_pet/screen/ToDoScreen.dart';
import 'package:todo_pet/screen/NavigationScreen.dart';
import 'package:todo_pet/function/PetStatement.dart';

class MyPetScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyPetScreenState();
  }
}

class _MyPetScreenState extends State<MyPetScreen> {
  final PetStatement _petStatement = PetStatement('petID');
  double _hungryLevel = 0.0;
  double _boredLevel = 0.0;

  @override
  void initState()  {
    super.initState();
    _initializePet();
  }

  Future<void> _initializePet() async {
    await _petStatement.initPet();
    _updateLevels();
  }

  Future<void> _updateLevels() async {
    int hungryLevel = await _petStatement.getHungryLevel();
    int boredLevel = await _petStatement.getBoredLevel();
    setState(() {
      _hungryLevel = hungryLevel / 100;
      _boredLevel = boredLevel / 100;
    });
  }



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
                        value: _hungryLevel,
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
                        value: _boredLevel,
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