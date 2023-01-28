import 'package:rxdart/rxdart.dart';

class CounterBloC {
  int initialCount = 0; //if the data is not passed by paramether it initializes with 0
  late BehaviorSubject<int> _subjectCounter;

  CounterBloC({required this.initialCount}) {
    _subjectCounter = BehaviorSubject<int>.seeded(initialCount); //initializes the subject with element already
  }

  Stream<int> get counterObservable => _subjectCounter.stream;

  void increment() {
    initialCount++;
    _subjectCounter.sink.add(initialCount);
  }

  void decrement() {
    initialCount--;
    _subjectCounter.sink.add(initialCount);
  }

  void dispose() {
    _subjectCounter.close();
  }
}



// 이제 위의 코드를 설명하겠습니다.  
// 먼저 rxdart 라이브러리를 사용하는 CounterBloC 이라는 클래스를 만들었습니다. 
// 이 경우, 우리는 Count가 몇 번부터 시작해야 하는지 알 수 있는 Initial Count를 받아야 합니다.
// 이 예제에서는 BehaviorSubeject 를 선택한 다음 매개 변수가 전달한 데이터로 Subject를 초기화했습니다. 
// 즉, Widget이 Subject의 Listener가되면 Stream을 통해 전달 된 첫 번째 값은 CounterBloC 생성자에 설정된 initialCount가됩니다.