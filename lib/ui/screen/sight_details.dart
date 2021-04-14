import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/res/button_styles.dart';

class SightDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 360,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://34travel.me/media/upload/images/2018/november/34dstpr/IMG_0249.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Align(
              alignment: Alignment(-0.87, -0.65),
              child: SizedBox(
                height: 32,
                width: 32,
                child: _BackButton(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Пряности и радости',
                  style: Theme.of(context).textTheme.headline5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'ресторан',
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
                  'Пряный вкус радостной жизни вместе с шеф-поваром Изо Дзандзава, благодаря которой у гостей ресторана есть возможность выбирать из двух направлений: европейского и восточного',
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
      },
      child: SvgPicture.asset(
        'res/images/icons/Arrow.svg',
        color: Colors.black,
        height: 24.0,
        width: 24.0,
      ),
      style: backButtonStyle,
    );
  }
}
