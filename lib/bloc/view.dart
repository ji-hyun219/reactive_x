import 'package:flutter/material.dart';

import 'count_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final CounterBloC _counterBloC = CounterBloC(initialCount: 0);

// 이제 initialCount = 0 으로 CounterBloC 을 초기화합니다.
// 그런 다음 increment, decrement 메소드을 제거했습니다. 이러한 메소드 구현은 더 이상 UI의 책임이 아닙니다.
// 두 FloatingActionButton 을 클릭하면 CounterBloC 에서 해당 메소드를 호출합니다.
// 이제 StreamBuilder 를 사용하여 화면에 데이터를 표시합니다.
// CounterBloC 클래스의 counterObservable 를 StreamBuilder의 생성자로 사용했으며 Stream에서 가져온 데이터를 처리하고 적절한 Widget을 리턴하는 builder를 호출합니다.

  @override
  void dispose() {
    _counterBloC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('You have pushed the button this many times:'),
              StreamBuilder(
                  stream: _counterBloC.counterObservable,
                  builder: (context, AsyncSnapshot<int> snapshot) {
                    return Text('${snapshot.data}', style: Theme.of(context).textTheme.headline4);
                  })
            ],
          ),
        ),
        floatingActionButton: Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: FloatingActionButton(
                onPressed: _counterBloC.increment,
                tooltip: 'Increment',
                child: const Icon(Icons.add),
              )),
          FloatingActionButton(
            onPressed: _counterBloC.decrement,
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
        ]));
  }
}
