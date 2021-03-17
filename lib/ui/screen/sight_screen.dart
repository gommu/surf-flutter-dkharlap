import 'package:flutter/material.dart';

class SightListScreen extends StatefulWidget {
  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Список интересных мест'),
      ),
      body: Center(
        child: Text(
          'Интересных мест не найдено :(',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}
