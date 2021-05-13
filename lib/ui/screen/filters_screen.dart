import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/res/button_styles.dart';

import 'res/themes_styles.dart';

class FiltersScreen extends StatefulWidget {
  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _categories = <Map>[];
  var _startPosition = {'long': 27.55, 'lat': 53.90};

  List<Sight> _filteredPlaces(double distanceStart, double distanceEnd) {
    List<Sight> result = mocks.where((e) {
      var p = 0.017453292519943295;
      var a = 0.5 -
          cos((e.lat - _startPosition['lat']) * p) / 2 +
          cos(_startPosition['lat'] * p) *
              cos(e.lat * p) *
              (1 - cos((e.lon - _startPosition['long']) * p)) /
              2;
      double distance = 12742 * asin(sqrt(a)) * 1000;

      if (distance >= distanceStart && distance <= distanceEnd) {
        return true;
      } else {
        return false;
      }
    }).toList();

    return result;
  }

  RangeValues _currentRangeValues = const RangeValues(100, 10000);

  @override
  void initState() {
    _categories.add({
      'name': 'Отель',
      'isActive': false,
      'asset': 'res/images/icons/Hotel.svg'
    });
    _categories.add({
      'name': 'Ресторан',
      'isActive': false,
      'asset': 'res/images/icons/Restourant.svg'
    });
    _categories.add({
      'name': 'Особое место',
      'isActive': false,
      'asset': 'res/images/icons/Particular place.svg'
    });
    _categories.add({
      'name': 'Парк',
      'isActive': false,
      'asset': 'res/images/icons/Park.svg'
    });
    _categories.add({
      'name': 'Музей',
      'isActive': false,
      'asset': 'res/images/icons/Museum.svg'
    });
    _categories.add({
      'name': 'Кафе',
      'isActive': false,
      'asset': 'res/images/icons/Cafe.svg'
    });

    super.initState();
  }

  Widget _generateFilter(Map data) {
    return Container(
      child: Column(
        children: [
          Stack(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints.tightFor(
                  width: 64,
                  height: 64,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      data['isActive'] = !data['isActive'];
                    });
                  },
                  child: SvgPicture.asset(
                    data['asset'],
                    color: Colors.green,
                  ),
                  style: data['isActive'] == false
                      ? filterButtonStyle
                      : filterButtonStyle.copyWith(
                          backgroundColor: MaterialStateProperty.all(
                              Colors.green.withOpacity(0.08))),
                ),
              ),
              if (data['isActive'])
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: SvgPicture.asset('res/images/icons/Tick choice.svg'),
                  ),
                ),
            ],
          ),
          SizedBox(height: 12),
          ConstrainedBox(
            constraints: BoxConstraints.tightFor(
              width: 96,
              height: 16,
            ),
            child: Text(
              data['name'],
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: false,
        toolbarHeight: 56,
        title: Container(
          height: 56,
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _BackButton(),
              TextButton(
                onPressed: () {
                  setState(() {
                    _categories.forEach((element) {
                      element['isActive'] = false;
                    });
                  });
                },
                child: Text(
                  'Очистить',
                  style: lmTextHeadline6.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                style: appBarButtonStyle,
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
            child: Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'КАТЕГОРИИ',
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                              fontSize: 12,
                            ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ..._categories
                            .getRange(0, 3)
                            .map((e) => _generateFilter(e))
                            .toList(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ..._categories
                            .getRange(3, 6)
                            .map((e) => _generateFilter(e))
                            .toList(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Расстояние',
                        style: Theme.of(context)
                            .appBarTheme
                            .textTheme
                            .headline6
                            .copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      Text(
                        'От ${(_currentRangeValues.start / 1000).toStringAsFixed(1)} до '
                        '${(_currentRangeValues.end / 1000).toStringAsFixed(1)} км',
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                              fontSize: 16,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          RangeSlider(
            values: _currentRangeValues,
            min: 100,
            max: 10000,
            divisions: 100,
            onChanged: (RangeValues values) {
              setState(() {
                _currentRangeValues = values;
              });
            },
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                child: SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO Save filters and slider values
                      print('save filters and slider');
                    },
                    child: Text(
                        'ПОКАЗАТЬ (${_filteredPlaces(_currentRangeValues.start, _currentRangeValues.end).length})'),
                    style: primaryButtonStyle,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        print('Button back pressed');
      },
      child: SvgPicture.asset(
        'res/images/icons/Arrow Left.svg',
        color: Colors.black,
        height: 32.0,
        width: 32.0,
      ),
      style: backButtonStyle,
    );
  }
}