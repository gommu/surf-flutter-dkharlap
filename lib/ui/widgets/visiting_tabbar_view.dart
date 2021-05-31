import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/res/assets_uri.dart';
import 'package:places/ui/widgets/to_visit_sight_card.dart';
import 'package:places/ui/widgets/visited_sight_card.dart';

class VisitingTabBarView extends StatefulWidget {
  final TabController _tabController;

  VisitingTabBarView(this._tabController, {Key key}) : super(key: key);

  @override
  _VisitingTabBarViewState createState() => _VisitingTabBarViewState();
}

class _VisitingTabBarViewState extends State<VisitingTabBarView> {
  List<VisitedSightCard> visitedCards;
  List<ToVisitSightCard> toVisitCards;

  @override
  void initState() {
    visitedCards = mocks
        .map((e) => VisitedSightCard(
              key: UniqueKey(),
              sight: e,
              removeCard: removeSightVisitedAction,
            ))
        .toList();
    toVisitCards = mocks
        .map((e) => ToVisitSightCard(
              key: UniqueKey(),
              sight: e,
              removeCard: removeSightToVisitAction,
            ))
        .toList();

    super.initState();
  }

  void removeSightToVisitAction(Sight sight) {
    debugPrint(sight.toString());
    setState(() {
      toVisitCards.removeWhere((element) => element.sightName == sight.name);
    });
  }

  void removeSightVisitedAction(Sight sight) {
    debugPrint(sight.toString());
    setState(() {
      visitedCards.removeWhere((element) => element.sightName == sight.name);
    });
  }

  Widget toVisitTab() {
    if (toVisitCards != null && toVisitCards.length > 0) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: toVisitCards,
        ),
      );
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconCard,
              height: 64.0,
              width: 64.0,
            ),
            SizedBox(
              height: 32,
            ),
            Text(
              'Пусто',
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(53, 8, 53, 0),
              child: Text(
                'Отмечайте понравившиеся места и они появиятся здесь.',
                textAlign: TextAlign.center,
                // style: textMedium18Secondary,
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget visitedTab() {
    if (visitedCards != null && visitedCards.length > 0) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: visitedCards,
        ),
      );
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconGO,
              height: 64.0,
              width: 64.0,
            ),
            SizedBox(
              height: 32,
            ),
            Text(
              'Пусто',
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(53, 8, 53, 0),
              child: Text(
                'Завершите маршрут, чтобы место попало сюда.',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Rebuild tabbarview');
    return TabBarView(
      controller: widget._tabController,
      children: [
        toVisitTab(),
        visitedTab(),
      ],
    );
  }
}
