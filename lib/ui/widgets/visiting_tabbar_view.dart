import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/model.dart';
import 'package:places/ui/screen/res/assets_uri.dart';
import 'package:places/ui/widgets/tabs/to_visit_tab.dart';
import 'package:places/ui/widgets/visited_sight_card.dart';

class VisitingTabBarView extends StatefulWidget {
  final TabController _tabController;

  const VisitingTabBarView(this._tabController, {Key key}) : super(key: key);

  @override
  _VisitingTabBarViewState createState() => _VisitingTabBarViewState();
}

class _VisitingTabBarViewState extends State<VisitingTabBarView> {
  List<VisitedPlaceCard> visitedCards;
  final placeInteractor = PlaceInteractor();

  @override
  void initState() {
    visitedCards = placeInteractor.visitedPlacesRepository.visitedPlaces
        .map((e) => VisitedPlaceCard(
              key: UniqueKey(),
              place: e,
              removeCard: removeSightVisitedAction,
            ))
        .toList();

    super.initState();
  }

  void removeSightVisitedAction(Place place) {
    setState(() {
      visitedCards.removeWhere((element) => element.place.id == place.id);
    });
  }

  Widget visitedTab() {
    if (visitedCards != null && visitedCards.isNotEmpty) {
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
            const SizedBox(
              height: 32,
            ),
            Text(
              'Пусто',
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(53, 8, 53, 0),
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
    return TabBarView(
      controller: widget._tabController,
      children: [
        const ToVisitTab(),
        visitedTab(),
      ],
    );
  }
}
