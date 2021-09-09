import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/res/assets_uri.dart';
import 'package:places/ui/screen/res/button_styles.dart';
import 'package:places/ui/screen/res/utils.dart';

import 'res/themes_styles.dart';

class FiltersScreen extends StatefulWidget {
  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _categories = <Map>[];
  var _startPosition = {'long': 27.55, 'lat': 53.90};

  RangeValues _currentRangeValues = const RangeValues(100, 10000);

  @override
  void initState() {
    _categories.add({
      'name': 'Отель',
      'isActive': false,
      'asset': iconHotel,
    });
    _categories.add({
      'name': 'Ресторан',
      'isActive': false,
      'asset': iconRestourant,
    });
    _categories.add({
      'name': 'Особое место',
      'isActive': false,
      'asset': iconParticularPlace,
    });
    _categories.add({
      'name': 'Парк',
      'isActive': false,
      'asset': iconPark,
    });
    _categories.add({
      'name': 'Музей',
      'isActive': false,
      'asset': iconMuseum,
    });
    _categories.add({
      'name': 'Кафе',
      'isActive': false,
      'asset': iconCafe,
    });

    super.initState();
  }

  Widget _generateFilter(Map data) {
    return Column(
      children: [
        Stack(
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints.tightFor(
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
                  child: SvgPicture.asset(iconTickChoice),
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        ConstrainedBox(
          constraints: const BoxConstraints.tightFor(
            width: 96,
            height: 16,
          ),
          child: Text(
            data['name'],
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    var screenHeight = MediaQuery.of(context).size.height;

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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
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
        leading: const _BackButton(),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
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
                if(screenHeight > 800)
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
                const SizedBox(
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
              alignment: screenHeight > 800 ? Alignment.bottomCenter : Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 32, 16, 20),
                child: SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO Save filters and slider values
                    },
                    child: Text(
                        'ПОКАЗАТЬ (${filteredSights(_startPosition, _currentRangeValues.start, _currentRangeValues.end).length})'),
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
        Navigator.pop(context);
      },
      child: SvgPicture.asset(
        iconArrowLeft,
        color: Colors.black,
        height: 32.0,
        width: 32.0,
      ),
      style: backButtonStyle,
    );
  }
}
