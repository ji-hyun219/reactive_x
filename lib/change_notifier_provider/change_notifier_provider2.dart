import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'change_notifier/counter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ChangeNotifierProvider 위젯으로 감싸준다.
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
