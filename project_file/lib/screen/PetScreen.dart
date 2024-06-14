import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_pet/function/AppUser.dart';
import 'package:todo_pet/function/PetStatement.dart';
import 'package:todo_pet/function/GetItem.dart';
import 'package:todo_pet/function/InteractionPet.dart';
import 'package:todo_pet/screen/ToDoScreen.dart';
import 'package:todo_pet/screen/NavigationScreen.dart';
import 'package:todo_pet/function/CreatePet.dart';

class PetScreen extends StatefulWidget {
  final AppUser _appUser = AppUser();
  late final CreatePet _createPetInstance;

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
  bool _isPet = false;

  // 사용자가 선택한 펫 이미지로 설정
  String? petType;
  String petImage = 'assets/images/dogImage.png';

  @override
  void initState() {
    super.initState();
    _appUser = widget._appUser;
    _petStatement = PetStatement();
    _getItem = GetItem(_appUser.userID);
    _interactionPet = InteractionPet(_petStatement, _getItem);
    _checkPetStatus();
    _loadPetType();
  }

  Future<void> _loadPetType() async {
    DocumentSnapshot snapshot = await widget._appUser.petsCollectionRef.doc('petId').get();
    setState(() {
      petType = snapshot['type'];
      switch (petType) {
        case '고양이':
          petImage = 'assets/images/catImage.png';
          break;
        case '햄스터':
          petImage = 'assets/images/hamImage.png';
          break;
        case '강아지':
        default:
          petImage = 'assets/images/dogImage.png';
          break;
      }
    });
  }

  Future<void> _checkPetStatus() async {
    await _appUser.reloadUser();
    bool isPetCreated = await _petStatement.getIsPet();
    setState(() {
      _isPet = isPetCreated;
    });
    if (isPetCreated) {
      _initializePet();
      _initializeLikes();
      _initializeItem();
      _updateLevels();
    }
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
        child: _isPet ? _buildPetContent(context) : _buildCreatePetButton(context),
      ),
    );
  }

  Widget _buildPetContent(BuildContext context) {
    return Padding(
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
              child: Image.asset(petImage),
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
                    if (snapshot.connectionState == ConnectionState.waiting) {
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
                    if (snapshot.connectionState == ConnectionState.waiting) {
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
    );
  }

  // 펫 생성 안됐을때 화면
  Widget _buildCreatePetButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CreatePet(appUser: _appUser)),
        );
      },
      child: Text('펫 생성하기'),
    );
  }
}
