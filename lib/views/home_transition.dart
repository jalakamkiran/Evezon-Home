import 'package:flutter/material.dart';

class HomeTransition with ChangeNotifier {
  double _dotsize = 20.0;
  double _horizantalspacing = 40.0;

  get dotsize => _dotsize;

  double _totalwidth() {
    return (_dotsize * 2) + (_dotsize * 3) + _horizantalspacing;
  }

  double center(width) {
    return width / 2.0 - _totalwidth() / 2;
  }

  double spacing(width, i) {
    return _horizantalspacing * i - (i == 0 ? 0.0 : width - (_dotsize * 3));
  }

  double animation(i) {
    return _dotsize * (i == index ? 3.0 : 1.0);
  }

  int index = 0;
  double moveMiddle = 0.0;
  bool _istapped = false;

  void updateindex(i) {
    if (i == 2) {
      translatex(-_dotsize * 2);
    } else {
      translatex(0.0);
    }

    index = i;
    notifyListeners();
  }

  void translatex(double d) {
    moveMiddle = d;
    notifyListeners();
  }
}
