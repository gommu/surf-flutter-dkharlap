import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch(index) {
        case 0: {
          Navigator.pushNamedAndRemoveUntil(context, '/sight-list', (r) => false);
        }
        break;
        case 1: {
          print('Route to map');
        }
        break;
        case 2: {
          Navigator.pushNamedAndRemoveUntil(context, '/visiting', (r) => false);
        }
        break;
        case 3: {
          Navigator.pushNamedAndRemoveUntil(context, '/settings', (r) => false);
        }
        break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Color iconColor =
        Theme.of(context).bottomNavigationBarTheme.unselectedItemColor;

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).dividerColor,
          ),
        ],
      ),
      child: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'res/images/icons/List.svg',
              height: 24.0,
              width: 24.0,
              color: iconColor,
            ),
            label: 'List',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'res/images/icons/Map.svg',
              height: 24.0,
              width: 24.0,
              color: iconColor,
            ),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'res/images/icons/Heart.svg',
              height: 24.0,
              width: 24.0,
              color: iconColor,
            ),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'res/images/icons/Settings.svg',
              height: 24.0,
              width: 24.0,
              color: iconColor,
            ),
            label: 'Settings',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
