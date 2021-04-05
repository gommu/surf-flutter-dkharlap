import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/text_styles.dart';

class BaseSightCard extends StatelessWidget {
  final Sight sight;
  final Widget photoWidget;
  final Widget descriptionWidget;

  BaseSightCard(this.sight)
      : photoWidget = _PlacePhotoMain(sight: sight),
        descriptionWidget = _PlaceDescriptionMain(sight: sight);

  BaseSightCard.toVisit(this.sight)
      : photoWidget = _ToVisitPlacePhoto(sight: sight),
        descriptionWidget = _ToVisitPlaceDescription(sight: sight);

  BaseSightCard.visited(this.sight)
      : photoWidget = _VisitedPlacePhoto(sight: sight),
        descriptionWidget = _VisitedPlaceDescription(sight: sight);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          photoWidget,
          descriptionWidget,
        ],
      ),
    );
  }
}

class _PlaceDescriptionMain extends StatelessWidget {
  const _PlaceDescriptionMain({
    Key key,
    @required this.sight,
  }) : super(key: key);

  final Sight sight;

  Widget descriptionSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 360,
            ),
            child: Text(
              sight.name,
              maxLines: 2,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffF5F5F5),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: descriptionSection(),
    );
  }
}

class _ToVisitPlaceDescription extends _PlaceDescriptionMain {
  const _ToVisitPlaceDescription({
    Key key,
    @required this.sight,
  }) : super(sight: sight, key: key);

  final Sight sight;

  @override
  Widget descriptionSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 360,
            ),
            child: Text(
              sight.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: textMedium16Primary,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
            child: Text(
              'Забронировано на 12.04.2021',
              style: textRegular14CardDescription,
            ),
          ),
          SizedBox(),
          Text(
            'закрыто до 09:00',
            style: textRegular14Primary,
          ),
        ],
      ),
    );
  }
}

class _VisitedPlaceDescription extends _PlaceDescriptionMain {
  const _VisitedPlaceDescription({
    Key key,
    @required this.sight,
  }) : super(sight: sight, key: key);

  final Sight sight;

  @override
  Widget descriptionSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 360,
            ),
            child: Text(
              sight.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: textMedium16Primary,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
            child: Text(
              'Цель достигнута 01.01.2021',
              style: textRegular14Primary,
            ),
          ),
          SizedBox(),
          Text(
            'закрыто до 09:00',
            style: textRegular14Primary,
          ),
        ],
      ),
    );
  }
}

class _PlacePhotoMain extends StatelessWidget {
  const _PlacePhotoMain({
    Key key,
    @required this.sight,
  }) : super(key: key);

  final Sight sight;

  Widget availableActions() {
    return Container(
      child: Row(
        children: [
          Icon(
            Icons.favorite_border,
            color: Colors.white,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96,
      child: Stack(
        children: [
          Container(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: const Radius.circular(16),
                topRight: const Radius.circular(16),
              ),
              child: Image.network(
                sight.url,
                fit: BoxFit.cover,
                width: double.infinity,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes
                          : null,
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  sight.type.toLowerCase(),
                  style: textBold14PrimaryWhite,
                ),
                availableActions(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ToVisitPlacePhoto extends _PlacePhotoMain {
  const _ToVisitPlacePhoto({
    Key key,
    @required this.sight,
  }) : super(sight: sight, key: key);

  final Sight sight;

  @override
  Widget availableActions() {
    return Container(
      child: Row(
        children: [
          Icon(
            Icons.calendar_today,
            color: Colors.white,
          ),
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.close,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

class _VisitedPlacePhoto extends _PlacePhotoMain {
  const _VisitedPlacePhoto({
    Key key,
    @required this.sight,
  }) : super(sight: sight, key: key);

  final Sight sight;

  @override
  Widget availableActions() {
    return Container(
      child: Row(
        children: [
          Icon(
            Icons.share,
            color: Colors.white,
          ),
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.close,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
