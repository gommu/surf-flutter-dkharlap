import 'package:flutter/material.dart';
import 'package:places/theme_switcher.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:places/ui/screen/settings_screen.dart';
import 'package:places/ui/screen/sight_details.dart';
import 'package:places/ui/screen/sight_screen.dart';
import 'package:places/ui/screen/visiting_screen.dart';
import 'package:places/ui/screen/filters_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeData _theme = lightTheme;
  final ThemeSwitcher _themeSwitcher = ThemeSwitcher();

  @override
  void initState() {
    _themeSwitcher.addListener(() {
      setState(() {
        _theme = _themeSwitcher.theme;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: _theme,
      // home: VisitingScreen(),
      // home: SightDetails(),
      // home: SightListScreen(),
      home: SettingsScreen(),
      // home: FiltersScreen(),
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
        actions: [
          IconButton(
            icon: Icon(Icons.alarm),
            onPressed: _incrementCounter,
          ),
        ],
        bottom: PreferredSize(
          child: Text('AppBar Bottom'),
          preferredSize: const Size.fromHeight(45),
        ),
      ),
      drawer: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
            ListTile(
              title: Text('Tile 1'),
            ),
            ListTile(
              title: Text('Tile 2'),
            ),
            ListTile(
              title: Text('Tile 3'),
            ),
            ListTile(
              title: Text('Tile 4'),
            ),
          ],
        ),
        color: Colors.greenAccent,
        width: 250,
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
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
