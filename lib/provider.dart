import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<int>.value(
      value: 11,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // primarySwatch: Colors.blue,
          brightness: Brightness.dark,
          primaryColor: Colors.lightBlue[800],
        ),
        home: const HomePage(
          title: '플러터 테스트',
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // provider 소비 코드
    var data = Provider.of<int>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('title'),
      ),
      body: Text(
        '$data',
        style: Theme.of(context).textTheme.headline3,
      ),
    );
  }
}
