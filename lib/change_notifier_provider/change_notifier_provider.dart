import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'change_notifier/counter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // ChangeNotifierProvider 위젯으로 감싸준다.
      home: ChangeNotifierProvider<Counter>(
        create: (context) => Counter(0), // 초기값 설정
        child: MyHomePage(),
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
            // Consumer 를 사용해서 실시간으로 반영할 수 있으나
            // 실제 Provider 를 사용하는 방법도 있다 (참고)
            // Provider.of<Counter>(context, listen: true).counter.toString(),
            // 즉, Consumer를 사용하면 해당 위젯을 감싸주어야하고, 그것이 아니라 Provider를 직접적으로 사용하려면 위와 같이 사용하면 된다.
          ],
        ),
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          Positioned(
            right: 10,
            bottom: 120,
            child: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                // setState() 메소드를 호출하지 않아도 화면이 업데이트된다.
                // 이 말인즉슨, stateless 클래스에서도 화면 갱신을 할 수 있다는 뜻이다.
                // listen 매개변수는 플러터 프레임워크에 변경된 것을 알릴지 설정하는
                // 매개변수이다. 헌데, 실제 변경되는것은 Counter.counter 변수이므로
                // listen을 false로 주었다.
                Provider.of<Counter>(context, listen: false).increment();
              },
            ),
          ),
          Positioned(
            right: 10,
            bottom: 40,
            child: FloatingActionButton(
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
