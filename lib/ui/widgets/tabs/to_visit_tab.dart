import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/model.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/res/assets_uri.dart';
import 'package:places/ui/widgets/to_visit_sight_card.dart';

class ToVisitTab extends StatefulWidget {
  const ToVisitTab({Key key}) : super(key: key);

  @override
  _ToVisitTabState createState() => _ToVisitTabState();
}

class _ToVisitTabState extends State<ToVisitTab> {
  List<ToVisitPlaceCard> toVisitCards;
  bool _willAccept = false;
  final placeInteractor = PlaceInteractor();

  @override
  void initState() {
    toVisitCards = placeInteractor.getFavoritePlaces()
        .map((e) => ToVisitPlaceCard(
              key: UniqueKey(),
              place: e,
              removeCard: removePlaceToVisitAction,
            ))
        .toList();

    super.initState();
  }

  void removePlaceToVisitAction(Place place) {
    debugPrint(place.toString());
    setState(() {
      toVisitCards.removeWhere((element) => element.place.id == place.id);
      placeInteractor.removeFromFavorites(place);
    });
  }

  Widget _gestureWrapper(ToVisitPlaceCard child) {
    return LongPressDraggable<ToVisitPlaceCard>(
      axis: Axis.vertical,
      data: child,
      childWhenDragging: Container(),
      feedback: SizedBox(
        child: Opacity(
          child: child,
          opacity: 0.7,
        ),
        width: MediaQuery.of(context).size.width,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 16.0,
          bottom: 16.0,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.red,
                  Colors.red,
                ]),
              ),
              child: child,
            ),
            background: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          iconBucket,
                          color: Colors.white,
                          height: 24.0,
                          width: 24.0,
                        ),
                        Text(
                          'Удалить',
                          style: Theme.of(context).textTheme.headline6.copyWith(
                                color: Colors.white,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            onDismissed: (direction) {
              removePlaceToVisitAction(child.place);
            },
          ),
        ),
      ),
      onDragStarted: () {
        setState(() {
          _willAccept = true;
        });
      },
      onDragCompleted: () {
        setState(() {
          _willAccept = false;
        });
      },
      onDragEnd: (details) {
        setState(() {
          _willAccept = false;
        });
      },
    );
  }

  DragTarget<ToVisitPlaceCard> _toVisitDragTarget(int positionIndex) {
    return DragTarget(
      builder: (BuildContext context, List<ToVisitPlaceCard> accepted,
          List<dynamic> rejected) {
        if (_willAccept) {
          return Container(
            width: 400,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: const BorderRadius.all(Radius.circular(16)),
            ),
          );
        } else {
          return Container();
        }
      },
      onWillAccept: (data) {
        return true;
      },
      onAccept: (data) {
        setState(() {
          int currentIndex = toVisitCards.indexOf(data);
          ToVisitPlaceCard draggedCard = toVisitCards.removeAt(currentIndex);
          toVisitCards.insert(positionIndex - 1, draggedCard);
          Sight sight = toVisitSightsMocks.removeAt(currentIndex);
          toVisitSightsMocks.insert(positionIndex - 1, sight);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    if (toVisitCards != null && toVisitCards.length > 0) {
      int index = 1;
      List<Widget> children = [];
      for (var element in toVisitCards) {
        children.add(_gestureWrapper(element));
        children.add(_toVisitDragTarget(index++));
      }

      return ListView.builder(
        itemCount: children.length,
        itemBuilder: (_, index) {
          return children[index];
        },
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
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
}
