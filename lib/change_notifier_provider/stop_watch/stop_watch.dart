// main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'about_time.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AboutTime>(
      create: (BuildContext context) => AboutTime(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.lightBlue[800],
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: StopSwatch(),
      ),
    );
  }
}

class StopSwatch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AboutTime timer = Provider.of<AboutTime>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'StopWatch',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.amber,
        shadowColor: Colors.white,
        elevation: 10,
      ),
      body: _buildBody(context),
      bottomNavigationBar: const SizedBox(
        height: 60,
        child: BottomAppBar(),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "btn0",
        onPressed: () {
          if (!timer.isRunning) {
            timer.startTimer();
          } else {
            timer.pauseTimer();
          }
        },
        backgroundColor: Colors.deepOrange,
        child: Icon(
          timer.isRunning ? Icons.pause_sharp : Icons.arrow_right,
          size: 50,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildBody(BuildContext context) {
    AboutTime timer = Provider.of<AboutTime>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Stack(
        children: <Widget>[
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  SizedBox(
                    width: 180,
                    child: Text(
                      '${timer.seconds ~/ 100}',
                      style: const TextStyle(fontSize: 100),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    child: Text(
                      '${timer.seconds % 100}'.padLeft(2, '0'),
                      style: const TextStyle(fontSize: 30),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 300,
                width: 200,
                child: ListView(children: timer.laptimes.map((e) => ListTile(title: Text(e))).toList()),
              ),
            ],
          ),
          Positioned(
            left: 20,
            bottom: 20,
            child: FloatingActionButton(
              heroTag: "btn1",
              onPressed: () => timer.resetTimer(),
              child: const Icon(Icons.autorenew_rounded, size: 40),
            ),
          ),
          Positioned(
            right: 20,
            bottom: 20,
            child: FloatingActionButton(
              heroTag: "btn2",
              onPressed: () => timer.addLapTime(),
              child: const Icon(Icons.access_time, size: 40),
            ),
          ),
        ],
      ),
    );
  }
}
