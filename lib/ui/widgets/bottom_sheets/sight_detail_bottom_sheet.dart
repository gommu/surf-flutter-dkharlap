import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/model/model.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/res/assets_uri.dart';
import 'package:places/ui/screen/res/button_styles.dart';

class PlaceDetailsBottomSheet extends StatefulWidget {
  final Place place;

  PlaceDetailsBottomSheet(this.place);

  @override
  _PlaceDetailsBottomSheetState createState() =>
      _PlaceDetailsBottomSheetState();
}

class _PlaceDetailsBottomSheetState extends State<PlaceDetailsBottomSheet> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  Widget _indicator() {
    List<Widget> children = List.generate(widget.place.urls.length, (index) {
      if (index == _currentPage) {
        return Flexible(
          child: Container(
            // Использовал зеленый цвет для лучшего контраста
            color: Colors.green,
          ),
          flex: 1,
        );
      } else {
        return Flexible(
          child: Container(
            color: Colors.transparent,
          ),
          flex: 1,
        );
      }
    });
    return SizedBox(
      height: 8,
      child: Row(
        children: children,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      height: MediaQuery.of(context).size.height * 0.9,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 360,
              child: Stack(
                children: [
                  PageView(
                    controller: _pageController,
                    children: widget.place.urls.map((url) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                          color: Colors.transparent,
                          image: DecorationImage(
                            image: NetworkImage(
                              url,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }).toList(),
                    onPageChanged: (index) {
                      setState(() {
                        print(index);
                        _currentPage = index;
                      });
                    },
                  ),
                  const Align(
                    alignment: Alignment(0.87, -0.87),
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: _BackButton(),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: _indicator(),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.place.name,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.place.placeType,
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          'Закрыто до 9:00',
                          style: textRegular14Secondary,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Container(
                      constraints: const BoxConstraints(
                        minHeight: 200,
                        minWidth: double.infinity,
                      ),
                      child: Text(
                        widget.place.description,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const SizedBox(
                      height: 48,
                      width: double.infinity,
                      child: _BuildWaypointButton(),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const Divider(
                      thickness: 0.8,
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxHeight: 32,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          _PlanButton(),
                          _AddToFavoriteButton(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddToFavoriteButton extends StatelessWidget {
  const _AddToFavoriteButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {},
      icon: SvgPicture.asset(
        'res/images/icons/Heart.svg',
        color: iconDisabled,
        height: 24.0,
        width: 24.0,
      ),
      label: Text(
        'В Избранное',
        style: Theme.of(context).textTheme.bodyText1,
      ),
      style: placeActionButtonStyle,
    );
  }
}

class _PlanButton extends StatelessWidget {
  const _PlanButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        print('Button plan pressed');
      },
      icon: SvgPicture.asset(
        'res/images/icons/Calendar.svg',
        color: iconDisabled,
        height: 24.0,
        width: 24.0,
      ),
      label: Text(
        'Запланировать',
        style: textRegular14Secondary,
      ),
      style: placeActionButtonStyle,
    );
  }
}

class _BuildWaypointButton extends StatelessWidget {
  const _BuildWaypointButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: SvgPicture.asset(
        'res/images/icons/GO.svg',
        color: Colors.white,
        height: 24.0,
        width: 24.0,
      ),
      label: Text(
        'ПОСТРОИТЬ МАРШРУТ',
        style: textButtonBoldActive,
      ),
      style: primaryButtonStyle,
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
        Navigator.of(context).pop();
      },
      child: SvgPicture.asset(
        iconClose,
        color: Colors.black,
        height: 24.0,
        width: 24.0,
      ),
      style: closeBottomSheetButtonStyle,
    );
  }
}
