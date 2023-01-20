import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'change_notifier/counter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ChangeNotifierProvider를 기존 MyHomePage 감싸주는 것을 더 상위 객체인 MaterialApp으로 옮겼다.
    // 이렇게하지 않으면 당연히 에러가 날 것이다.
    // 왜냐면 MyHomePage클래스와 Page2클래스는 위젯트리에서 동등한 레벨에 존재하기 때문이다.
    // 그리하여 MyHomePage에서 Provider를 감싸주면 Page2에서는 참조할 수 없다.
    // 그 이상의 존재를 Provider로 감싸주어야 두 클래스 모두 참조할 수 있는 객체가된다.
    return ChangeNotifierProvider<Counter>(
      create: (context) => Counter(0),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.lightBlue[800],
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider 테스트'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Count Number',
              style: Theme.of(context).textTheme.headline4,
            ),
            // Provider 값을 가져온다. Consumer를 사용했다.
            Consumer<Counter>(
              builder: (context, value, child) => Text(
                value.counter.toString(),
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
            ElevatedButton(
              child: const Text('다음 페이지'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Page2()));
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          Positioned(
            right: 10,
            bottom: 120,
            child: FloatingActionButton(
              heroTag: "btn1",
              child: const Icon(Icons.add),
              onPressed: () {
                Provider.of<Counter>(context, listen: false).increment();
              },
            ),
          ),
          Positioned(
            right: 10,
            bottom: 40,
            child: FloatingActionButton(
              heroTag: "btn2",
              child: const Icon(Icons.horizontal_split),
              onPressed: () {
                Provider.of<Counter>(context, listen: false).decrement();
              },
            ),
          ),
          Positioned(
            left: 40,
            bottom: 40,
            child: FloatingActionButton(
              backgroundColor: Colors.red,
              child: const Icon(Icons.repeat),
              onPressed: () {
                Provider.of<Counter>(context, listen: false).reset();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('page2'),
      ),
      body: Center(
        child: Text(
          Provider.of<Counter>(context).counter.toString(),
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
    );
  }
}
