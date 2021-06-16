import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/res/assets_uri.dart';
import 'package:places/ui/screen/res/utils.dart';
import 'package:places/ui/screen/sight_details.dart';
import 'package:places/ui/widgets/custom_bottom_navigation_bar.dart';
import 'package:places/ui/widgets/search_bar.dart';

class SightSearchScreen extends StatefulWidget {
  const SightSearchScreen({Key key}) : super(key: key);

  @override
  _SightSearchScreenState createState() => _SightSearchScreenState();
}

class _SightSearchScreenState extends State<SightSearchScreen> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SearchBar searchBar = SearchBar.searchable(controller, focusNode);

    focusNode.addListener(() {
      setState(() {});
    });

    controller.addListener(() {
      setState(() {});
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: false,
        toolbarHeight: 100,
        title: Container(
          height: 100,
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Список интересных мест',
                maxLines: 2,
                style: Theme.of(context).appBarTheme.textTheme.headline6,
              ),
              searchBar,
            ],
          ),
        ),
      ),
      body: focusNode.hasFocus || controller.text.isEmpty != true
          ? _SearchResults(controller, focusNode)
          : _SearchHistory(),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}

class _SearchResults extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  _SearchResults(this.controller, this.focusNode);

  @override
  __SearchResultsState createState() => __SearchResultsState();
}

class __SearchResultsState extends State<_SearchResults> {
  final Map _currentPosition = {'long': 27.55, 'lat': 53.90};
  final double _distanceStart = 100.0;
  final double _distanceEnd = 900.0;
  // filtering sights by radius from current position
  List<Sight> _filteredSightsByRadius() {
    return filteredSights(_currentPosition, _distanceStart, _distanceEnd);
  }

  List<Widget> _filterResults(BuildContext context) {
    String inputString = widget.controller.text;
    List<Sight> sights = _filteredSightsByRadius();
    List<Widget> filteredSights = [];

    sights.forEach((e) {
      if (e.name.contains(inputString)) {
        int index = e.name.indexOf(inputString);
        List<String> strings = [
          e.name.substring(0, index),
          e.name.substring(index, index + inputString.length),
          e.name.substring(index + inputString.length, e.name.length),
        ];
        Widget s = GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => SightDetails(e)),
            );
          },
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(e.url),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),
                      RichText(
                        text: TextSpan(
                          // text: e.name,
                          style: Theme.of(context).textTheme.headline6,
                          children: [
                            ...strings.map((e) {
                              return TextSpan(
                                text: e,
                                style: e == inputString
                                    ? Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                        )
                                    : Theme.of(context).textTheme.headline6,
                              );
                            }),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(e.type),
                      SizedBox(height: 8),
                      if (sights.last != e) Divider(),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
        filteredSights.add(s);
      }
    });

    return filteredSights;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> filteredSights = _filterResults(context);

    if (filteredSights.isNotEmpty) {
      return ListView.builder(
        itemCount: filteredSights.length,
        itemBuilder: (_, index) {
          return filteredSights[index];
        },
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
      );
      // return Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: Column(
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: filteredSights),
      // );
    } else {
      return SafeArea(
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  iconSearch,
                  height: 64.0,
                  width: 64.0,
                ),
                SizedBox(height: 24),
                Text(
                  'Ничего не найдено',
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                ),
                SizedBox(height: 8),
                Text('Попробуйте изменить параметры поиска'),
              ],
            ),
          ),
        ),
      );
    }
  }
}

class _SearchHistory extends StatefulWidget {
  const _SearchHistory({Key key}) : super(key: key);

  @override
  __SearchHistoryState createState() => __SearchHistoryState();
}

class __SearchHistoryState extends State<_SearchHistory> {
  List<String> history = [
    'Кафе Гараж',
    'Церковь святого Павла',
    'Ресторан',
    'гос цирк'
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
            child: Text(
              'ВЫ ИСКАЛИ',
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    fontSize: 12,
                  ),
            ),
          ),
          ...history.map((e) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(e),
                    IconButton(
                      icon: SvgPicture.asset(
                        iconDelete,
                        height: 24.0,
                        width: 24.0,
                      ),
                      onPressed: () {
                        setState(() {
                          history.remove(e);
                        });
                      },
                    ),
                  ],
                ),
                if (history.last != e) Divider(),
              ],
            );
          }).toList(),
          TextButton(
            onPressed: () {
              setState(() {
                history.clear();
              });
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
            ),
            child: Text(
              'Очистить историю',
              style: Theme.of(context).textTheme.headline6.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
