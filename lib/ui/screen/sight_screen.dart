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
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: false,
        toolbarHeight: 250,
        title: RichText(
          text: TextSpan(
            style: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
              fontSize: 32,
              color: Color(0xff252849),
            ),
            children: [
              TextSpan(
                children: [
                  TextSpan(
                    text: 'С',
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                  TextSpan(
                    text: 'писок \n',
                  ),
                ],
              ),
              TextSpan(
                children: [
                  TextSpan(
                    text: 'и',
                    style: TextStyle(
                      color: Colors.yellow,
                    ),
                  ),
                  TextSpan(
                    text: 'нтересных мест',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
