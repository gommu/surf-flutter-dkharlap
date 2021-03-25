import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/text_styles.dart';

class SightCard extends StatelessWidget {
  final Sight sight;

  SightCard(this.sight);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: Container(
        // width: double.infinity,
        // height: 200,
        margin: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _PlacePhoto(sight: sight),
            SizedBox(
              height: 12,
            ),
            _PlaceDescription(sight: sight),
          ],
        ),
      ),
    );
  }
}

class _PlaceDescription extends StatelessWidget {
  const _PlaceDescription({
    Key key,
    @required this.sight,
  }) : super(key: key);

  final Sight sight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 92,
      decoration: BoxDecoration(
        color: Color(0xffF5F5F5),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 360,
                // maxWidth: 180, - половина карточки
              ),
              child: Text(
                sight.name,
                // maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: textMedium16Primary,
              ),
            ),
            Text(
              'краткое описание',
              style: textRegular14Primary,
            ),
          ],
        ),
      ),
    );
  }
}

class _PlacePhoto extends StatelessWidget {
  const _PlacePhoto({
    Key key,
    @required this.sight,
  }) : super(key: key);

  final Sight sight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96,
      decoration: BoxDecoration(
        color: Colors.purple,
        borderRadius: const BorderRadius.only(
          topLeft: const Radius.circular(16),
          topRight: const Radius.circular(16),
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  sight.type.toLowerCase(),
                  style: textBold14PrimaryWhite,
                ),
                Container(
                  child: Icon(
                    Icons.favorite_border,
                    color: Colors.white,
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
