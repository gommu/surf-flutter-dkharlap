import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  List<ToVisitSightCard> toVisitCards;
  bool _willAccept = false;

  @override
  void initState() {
    toVisitCards = toVisitSightsMocks
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
      toVisitSightsMocks.removeWhere((element) => element == sight);
    });
  }

  Widget _gestureWrapper(ToVisitSightCard child) {
    return LongPressDraggable<ToVisitSightCard>(
      axis: Axis.vertical,
      data: child,
      childWhenDragging: Container(),
      feedback: Container(
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
              decoration: BoxDecoration(
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
              removeSightToVisitAction(child.sight);
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

  DragTarget<ToVisitSightCard> _toVisitDragTarget(int positionIndex) {
    return DragTarget(
      builder: (BuildContext context, List<ToVisitSightCard> accepted,
          List<dynamic> rejected) {
        if (_willAccept) {
          return Container(
            width: 400,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
          );
        } else {
          return Container();
        }
      },
      onWillAccept: (data) {
        print(data);
        return true;
      },
      onAccept: (data) {
        setState(() {
          int currentIndex = toVisitCards.indexOf(data);
          ToVisitSightCard draggedCard = toVisitCards.removeAt(currentIndex);
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
      toVisitCards.forEach((element) {
        children.add(_gestureWrapper(element));
        children.add(_toVisitDragTarget(index++));
      });

      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: children,
          ),
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
}
