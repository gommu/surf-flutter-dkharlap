import 'package:flutter/material.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/text_styles.dart';

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
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _PlanButton(),
                    _AddToFavoriteButton(),
                  ],
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
    return Container(
      child: Row(
        children: [
          Icon(
            Icons.favorite_border,
          ),
          const SizedBox(
            width: 9,
          ),
          Text(
            'В Избранное',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}

class _PlanButton extends StatelessWidget {
  const _PlanButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Icon(
            Icons.calendar_today,
            color: iconDisabled,
          ),
          const SizedBox(
            width: 9,
          ),
          Text(
            'Запланировать',
            style: textRegular14Secondary,
          ),
        ],
      ),
    );
  }
}

class _BuildWaypointButton extends StatelessWidget {
  const _BuildWaypointButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: const BorderRadius.all(
          const Radius.circular(12),
        ),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.insights,
              // color: iconActive,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'ПОСТРОИТЬ МАРШРУТ',
              style: textButtonBoldActive,
            ),
          ],
        ),
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
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: const BorderRadius.all(
          const Radius.circular(10),
        ),
      ),
      child: Center(
        child: Icon(
          Icons.arrow_back_ios_rounded,
        ),
      ),
    );
  }
}
