import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
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
  int _counter = 0;
  // StreamController 생성.
  final StreamController<int> _streamCtrlCount = StreamController<int>();
  // 0.2초마다 데이터가 생성되는 스트림
  final Stream<int> _streamAutoIncrement = Stream.periodic(const Duration(milliseconds: 200), (int x) => x);

  @override
  void dispose() {
    // 스트림 닫기
    _streamCtrlCount.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: [
                // 스트림빌더 생성
                StreamBuilder<int>(
                    // 어느 스트림을 사용할지 (자동으로 숫자가 올라가는 스트림 사용)
                    stream: _streamAutoIncrement,
                    builder:
                        // snapshot은 스트림의 스탭샷을 나타낸다. 그래서
                        // snapshot.data는 스트림의 최신값이 나온다.
                        (BuildContext context, AsyncSnapshot<int> snapshot) {
                      return Text(
                        'Auto increment: ${snapshot.data}',
                        style: const TextStyle(fontSize: 20),
                      );
                    }),
                Container(height: 30),
                const Text(
                  'You have pushed the button this many times:',
                ),
              ],
            ),
            // 스트림빌더 생성
            StreamBuilder<int>(
                // 버튼 클릭 시, 숫자가 올라가는 스트림 사용
                stream: _streamCtrlCount.stream,
                // 초기값 설정. 옵션 값이다.
                initialData: _counter,
                builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                  return Text(
                    '${snapshot.data}',
                    style: Theme.of(context).textTheme.headline4,
                  );
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 이벤트 발생
          _streamCtrlCount.sink.add(++_counter);
          // Returns a view of this object that only exposes the [StreamSink] interface.x
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
