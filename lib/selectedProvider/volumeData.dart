import 'package:flutter/cupertino.dart';

class VolumeData extends ChangeNotifier {
  int _volumeWhenLocked = 100;
  int _volumeWhenUnlocked = 20;

  int get volumeWhenLocked => _volumeWhenLocked;
  int get volumeWhenUnlocked => _volumeWhenUnlocked;

  void setVolumeWhenLocked(int x) {
    _volumeWhenLocked = x;
    notifyListeners();
  }

  void setVolumeWhenUnlocked(int x) {
    _volumeWhenUnlocked = x;
    notifyListeners();
  }
}
