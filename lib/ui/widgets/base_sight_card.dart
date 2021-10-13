import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/model.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/res/button_styles.dart';
import 'package:places/ui/widgets/bottom_sheets/sight_detail_bottom_sheet.dart';


class BasePlaceCard extends StatelessWidget {
  final Place place;
  final _PlacePhotoMain photoWidget;
  final Widget descriptionWidget;

  BasePlaceCard(this.place)
      : photoWidget = _PlacePhotoMain(place: place),
        descriptionWidget = _PlaceDescriptionMain(place: place);

  BasePlaceCard.toVisit(this.place)
      : photoWidget = _ToVisitPlacePhoto(place: place),
        descriptionWidget = _ToVisitPlaceDescription(place: place);

  BasePlaceCard.visited(this.place)
      : photoWidget = _VisitedPlacePhoto(place: place),
        descriptionWidget = _VisitedPlaceDescription(place: place);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              photoWidget,
              descriptionWidget,
            ],
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (_) {
                      return PlaceDetailsBottomSheet(place);
                    },

                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    place.placeType.toLowerCase(),
                    style: textBold14PrimaryWhite,
                  ),
                  photoWidget.availableActions(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlaceDescriptionMain extends StatelessWidget {
  const _PlaceDescriptionMain({
    Key key,
    @required this.place,
  }) : super(key: key);

  final Place place;

  Widget descriptionSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 40,
              maxWidth: 360,
            ),
            child: Text(
              place.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Text(
            place.description,
            style: Theme.of(context).textTheme.subtitle1,
            maxLines: 1,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorDark,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: descriptionSection(context),
    );
  }
}

class _ToVisitPlaceDescription extends _PlaceDescriptionMain {
  const _ToVisitPlaceDescription({
    Key key,
    @required this.place,
  }) : super(place: place, key: key);

  final Place place;

  @override
  Widget descriptionSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 360,
            ),
            child: Text(
              place.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline6,
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
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}

class _VisitedPlaceDescription extends _PlaceDescriptionMain {
  const _VisitedPlaceDescription({
    Key key,
    @required this.place,
  }) : super(place: place, key: key);

  final Place place;

  @override
  Widget descriptionSection(BuildContext context) {
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
              place.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline6,
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
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}

class _PlacePhotoMain extends StatelessWidget {
  _PlacePhotoMain({
    Key key,
    @required this.place,
  }) : super(key: key);

  final Place place;
  final placeInteractor = PlaceInteractor();

  Widget _actionButton(String assetPath, Function handler) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 24),
      child: ElevatedButton(
        onPressed: handler,
        child: Container(
          child: SvgPicture.asset(
            assetPath,
            color: Colors.white,
            height: 24.0,
            width: 24.0,
          ),
        ),
        style: cardActionStyle,
      ),
    );
  }

  Widget availableActions() {
    return ConstrainedBox(
      constraints: const BoxConstraints.tightFor(
        height: 24,
      ),
      child: Row(
        children: [
          _actionButton('res/images/icons/Heart.svg', () {
            placeInteractor.addToFavorites(place);
          }),
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
                place.urls[0],
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
        ],
      ),
    );
  }
}

class _ToVisitPlacePhoto extends _PlacePhotoMain {
  _ToVisitPlacePhoto({
    Key key,
    @required this.place,
  }) : super(place: place, key: key);

  final Place place;

  @override
  Widget availableActions() {
    return ConstrainedBox(
      constraints: const BoxConstraints.tightFor(
        height: 24,
      ),
      child: Row(
        children: [
          _actionButton('res/images/icons/Calendar.svg', () {
            print('Button calendar pressed');
          }),
          const SizedBox(
            width: 16,
          ),
          _actionButton('res/images/icons/Close.svg', () {
            print('Button close pressed');
          }),
        ],
      ),
    );
  }
}

class _VisitedPlacePhoto extends _PlacePhotoMain {
  _VisitedPlacePhoto({
    Key key,
    @required this.place,
  }) : super(place: place, key: key);

  final Place place;

  @override
  Widget availableActions() {
    return ConstrainedBox(
      constraints: const BoxConstraints.tightFor(
        height: 24,
      ),
      child: Row(
        children: [
          _actionButton('res/images/icons/Share.svg', () {
            print('Button share pressed');
          }),
          const SizedBox(
            width: 16,
          ),
          _actionButton('res/images/icons/Close.svg', () {
            print('Button close pressed');
          }),
        ],
      ),
    );
  }
}
