import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Surf Flutter Cource App',
      home: MySecondWidget(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
      home: MyFirstWidget(),
      // home: MySecondWidget(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
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
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class MyFirstWidget extends StatelessWidget {
  var buildCounter = 0;

  @override
  Widget build(BuildContext context) {
    // print(contextType());
    buildCounter += 1;
    print('MyFirstWidget counter: $buildCounter');

    return Container(
      child: Center(
        child: Text('Hello Stateles!'),
      ),
    );
  }

  // Type contextType() {
  //   return context.runtimeType;
  // }
}

class MySecondWidget extends StatefulWidget {
  @override
  _MySecondWidgetState createState() => _MySecondWidgetState();
}

class _MySecondWidgetState extends State<MySecondWidget> {
  var buildCounter = 0;

  @override
  Widget build(BuildContext context) {
    print(contextType());
    buildCounter += 1;
    print('MyFirstWidget counter: $buildCounter');

    return Container(
      child: Center(
        child: Text('Hello Stateful!'),
      ),
    );
  }

  Type contextType() {
    return context.runtimeType;
  }
}
