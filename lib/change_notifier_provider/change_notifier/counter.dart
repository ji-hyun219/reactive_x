import 'package:flutter/material.dart';

class Counter with ChangeNotifier {
  // ChangeNotifier가 믹스인(Mixin)된 Counter 클래스를 만들어준다.

  int _counter = 0;

  Counter(this._counter);

  // _counter 변수 값을 가져올 counter getter 메소드
  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners(); // 값이 변할 때마다 플러터 프레임워크에 알려줌.
  }

  void decrement() {
    _counter--;
    notifyListeners(); // 값이 변할 때마다 플러터 프레임워크에 알려줌.
  }

  void reset() {
    _counter = 0;
    notifyListeners();
  }
}
