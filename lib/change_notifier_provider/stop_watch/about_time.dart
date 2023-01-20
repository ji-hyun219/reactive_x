// aboutTime.dart

import 'dart:async';

import 'package:flutter/material.dart';

class AboutTime with ChangeNotifier {
  bool _isRunning = false;
  int _secs = 0;
  Timer? _timer;
  final List<String> _laptime = <String>[];

  bool get isRunning => _isRunning;

  int get seconds => _secs;

  List<String> get laptimes => _laptime;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    _isRunning = true;
    _timer = Timer.periodic(const Duration(milliseconds: 10), (Timer timer) {
      _secs++;
      notifyListeners();
    });
  }

  void pauseTimer() {
    if (_isRunning) {
      _timer?.cancel();
      _isRunning = false;
    }
    notifyListeners();
  }

  void resetTimer() {
    _timer?.cancel();
    _secs = 0;
    _isRunning = false;
    _laptime.clear();
    notifyListeners();
  }

  void addLapTime() {
    _laptime.insert(0, '${_laptime.length + 1}등 ${_secs ~/ 100}:${_secs % 100}');
    notifyListeners();
  }
}
