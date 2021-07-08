import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future isInitialized;

  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  void _navigateToNext() {
    isInitialized = Future.delayed(const Duration(seconds: 2), () {
      // TODO Do init job here
      print('Initialize finished');
      return 'finished';
    }).then(
      // TODO Navigate to next page
      (value) => print('Moving to next page, init result: $value'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFFFCDD3D),
            Color(0xFF4CAF50),
          ],
        ),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
