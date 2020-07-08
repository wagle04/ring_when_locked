import 'package:flutter/material.dart';

enum PhoneState { LOCKED, UNLOCKED }

class StateSelector extends ChangeNotifier {
  bool _lockedSelected;

  StateSelector() {
    _lockedSelected = true;
  }

  bool get getSelectedState => _lockedSelected;

  void changeSelectedState(PhoneState x) {
    _lockedSelected = x == PhoneState.LOCKED ? true : false;
    notifyListeners();
  }
}
