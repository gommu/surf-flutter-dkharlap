import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/widgets/base_sight_card.dart';

class VisitingTabBarView extends StatelessWidget {
  final TabController _tabController;

  final List<Sight> toVisitSights;
  final List<Sight> visitedSights;

  VisitingTabBarView(this._tabController, {Key key})
      : toVisitSights = mocks,
        visitedSights = mocks,
        super(key: key);

  Widget toVisitTab() {
    if (toVisitSights != null) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ...toVisitSights.map((e) => BaseSightCard.toVisit(e)).toList(),
          ],
        ),
      );
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.camera,
              size: 50,
              color: iconDisabled,
            ),
            SizedBox(
              height: 32,
            ),
            Text(
              'Пусто',
              style: textMedium18Secondary,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(53, 8, 53, 0),
              child: Text(
                'Отмечайте понравившиеся места и они появиятся здесь.',
                textAlign: TextAlign.center,
                style: textMedium18Secondary,
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget visitedTab() {
    if (visitedSights != null) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ...visitedSights.map((e) => BaseSightCard.visited(e)).toList(),
          ],
        ),
      );
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.insights,
              size: 50,
              color: iconDisabled,
            ),
            SizedBox(
              height: 32,
            ),
            Text(
              'Пусто',
              style: textMedium18Secondary,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(53, 8, 53, 0),
              child: Text(
                'Завершите маршрут, чтобы место попало сюда.',
                textAlign: TextAlign.center,
                style: textMedium18Secondary,
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: _tabController,
      children: [
        toVisitTab(),
        visitedTab(),
      ],
    );
  }
}
