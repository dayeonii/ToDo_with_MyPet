import 'package:flutter/material.dart';

class PetStatement with ChangeNotifier {
  double _hunger = 0.5;
  double _boredom = 0.7;
  int _foodCount = 5;
  int _toyCount = 7;
  int _likeCount = 12;

  double get hunger => _hunger;
  double get boredom => _boredom;
  int get foodCount => _foodCount;
  int get toyCount => _toyCount;
  int get likeCount => _likeCount;

  set hunger(double value) {
    _hunger = value;
    notifyListeners();
  }

  set boredom(double value) {
    _boredom = value;
    notifyListeners();
  }

  set foodCount(int value) {
    _foodCount = value;
    notifyListeners();
  }

  set toyCount(int value) {
    _toyCount = value;
    notifyListeners();
  }

  set likeCount(int value) {
    _likeCount = value;
    notifyListeners();
  }
}
