import 'package:flutter/material.dart';
import 'package:todo_pet/function/AppUser.dart';
import 'package:todo_pet/function/PetStatement.dart';
import 'package:todo_pet/function/GetItem.dart';
import 'package:todo_pet/function/InteractionPet.dart';
import 'package:todo_pet/screen/ToDoScreen.dart';
import 'package:todo_pet/screen/NavigationScreen.dart';

class PetScreen extends StatefulWidget {
  final AppUser _appUser = AppUser();

  @override
  _PetScreenState createState() => _PetScreenState();
}

class _PetScreenState extends State<PetScreen> {
  late final PetStatement _petStatement;
  late final InteractionPet _interactionPet;
  double _hungryLevel = 0.0;
  double _boredLevel = 0.0;
  int _totalLike = 0;

  late final GetItem _getItem;
  late final AppUser _appUser;

  @override
  void initState() {
    super.initState();
    _appUser = widget._appUser;
    _getItem = GetItem(_appUser.userID);
    _petStatement = PetStatement();
    _interactionPet = InteractionPet(_petStatement, _getItem);
    _initializePet();
    _initializeLikes();
    _initializeItem();
    _updateLevels();
  }

  Future<void> _initializePet() async {
    await _petStatement.initPet();
    _updateLevels();
  }

  Future<void> _initializeLikes() async {
    int totalLike = await _petStatement.getTotalLike();
    setState(() {
      _totalLike = totalLike;
    });
  }

  Future<void> _initializeItem() async {
    await _getItem.initItem();
    _updateLevels();
  }

  Future<void> _updateLevels() async {
    int hungryLevel = await _petStatement.getHungryLevel();
    int boredLevel = await _petStatement.getBoredLevel();
    int totalLike = await _petStatement.getTotalLike();
    setState(() {
      _hungryLevel = hungryLevel / 100;
      _boredLevel = boredLevel / 100;
      _totalLike = totalLike;
    });
  }

  Future<void> _feedPet(BuildContext context) async {
    await _interactionPet.feeding(context);
    _updateLevels();
  }

  Future<void> _playPet(BuildContext context) async {
    await _interactionPet.playing(context);
    _updateLevels();
  }

  Future<void> _pressLike() async {
    await _interactionPet.pressLike();
    _updateLevels();
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ToDoScreen()),
              );
            },
            child: Text('ToDo'),
          )
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
                      'Hungry',
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
                      'Bored',
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
                    FutureBuilder<int>(
                      future: _getItem.getFoodItem(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return Text(
                            '${snapshot.data}',
                            style: TextStyle(fontSize: 25),
                          );
                        }
                      },
                    ),
                    SizedBox(width: 40),
                    Image.asset('assets/images/toyImage.png',
                        width: 40, height: 40, fit: BoxFit.cover),
                    SizedBox(width: 15),
                    FutureBuilder<int>(
                      future: _getItem.getToyItem(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return Text(
                            '${snapshot.data}',
                            style: TextStyle(fontSize: 25),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton.icon(
                  onPressed: () => _pressLike(),
                  icon: Image.asset(
                    'assets/images/likeIcon.png',
                    width: 30,
                    height: 30,
                  ),
                  label: Text(
                    '$_totalLike', // 좋아요 수를 표시
                    style: TextStyle(fontSize: 25),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shadowColor: Colors.grey,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    OutlinedButton(
                      onPressed: () => _feedPet(context),
                      child: Text('Feed', style: TextStyle(fontSize: 25)),
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.grey, width: 2)),
                    ),
                    SizedBox(width: 20),
                    OutlinedButton(
                      onPressed: () => _playPet(context),
                      child: Text('Play', style: TextStyle(fontSize: 25)),
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
