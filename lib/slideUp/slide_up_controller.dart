import 'package:flutter/material.dart';

class SlideUpController extends ChangeNotifier {
  double _minHeight = 100.0;
  double _maxHeight = 500.0;
  late double _currentHeight = _minHeight;
  bool _inMaxPosition = false;
  bool _inMinPosition = true;
  double get currentValue => _currentHeight;
  double get minHeight => _currentHeight;
  double get maxHeight => _maxHeight;
  bool get inMinPosition => _inMinPosition;
  bool get inMaxPosition => _inMaxPosition;
  goToMinPosition() {
    _currentHeight = _minHeight;
    notifyListeners();
  }

  goToMaxPosition() {
    _currentHeight = _maxHeight;
    notifyListeners();
  }

  setMinHeight(double height) {
    _minHeight = height;
  }

  setMaxHeight(double height) {
    _maxHeight = height;
  }

  setInitialHeight(double height) {
    _currentHeight = height;
    if (_currentHeight == _maxHeight) {
      _inMaxPosition = true;
      _inMinPosition = false;
    } else if (_currentHeight == _minHeight) {
      _inMaxPosition = false;
      _inMinPosition = true;
    }
  }
}
