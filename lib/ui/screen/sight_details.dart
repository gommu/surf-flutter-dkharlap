import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/res/assets_uri.dart';
import 'package:places/ui/screen/res/button_styles.dart';

class SightDetails extends StatefulWidget {
  final Sight sight;
  SightDetails(this.sight);

  @override
  _SightDetailsState createState() => _SightDetailsState();
}

class _SightDetailsState extends State<SightDetails> {
  final List<String> _imageUrls = [
    'https://www.belta.by/images/storage/news/with_archive/2019/000024_1572452511_367584_big.jpg',
    'https://media-cdn.tripadvisor.com/media/photo-s/0c/f0/be/24/caption.jpg',
    'https://34travel.me/media/upload/images/2018/november/34dstpr/IMG_0249.jpg',
  ];

  PageController _pageController = PageController();
  int _currentPage = 0;

  Widget _indicator() {
    List<Widget> children = List.generate(_imageUrls.length, (index) {
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
    return Container(
      height: 8,
      child: Row(
        children: children,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 360,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                height: 360,
                child: Stack(
                  children: [
                    PageView(
                      controller: _pageController,
                      children: _imageUrls.map((url) {
                        return Container(
                          decoration: BoxDecoration(
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
                    Align(
                      alignment: Alignment(-0.87, -0.65),
                      child: SizedBox(
                        height: 32,
                        width: 32,
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
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.sight.name,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            widget.sight.type,
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
                      Text(
                        widget.sight.details,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      SizedBox(
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
                        constraints: BoxConstraints(
                          maxHeight: 32,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _PlanButton(),
                            _AddToFavoriteButton(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
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
      onPressed: () {
        print('Button to favorite pressed');
      },
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
      onPressed: () {
        print('Button build waypoint pressed');
      },
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
        print('Button back pressed');
        Navigator.of(context).pop();
      },
      child: SvgPicture.asset(
        iconLeftArrow,
        color: Colors.black,
        height: 24.0,
        width: 24.0,
      ),
      style: backButtonStyle,
    );
  }
}
