import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/model/model.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/res/assets_uri.dart';
import 'package:places/ui/screen/res/button_styles.dart';

class VisitedPlaceCard extends StatefulWidget {
  final Place place;
  final Function removeCard;
  VisitedPlaceCard({Key key, this.place, this.removeCard}) : super(key: key);

  String get placeName => place.name;

  @override
  _VisitedPlaceCardState createState() => _VisitedPlaceCardState();
}

class _VisitedPlaceCardState extends State<VisitedPlaceCard> {
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
              photoSection(context),
              descriptionSection(context),
            ],
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                onTap: () {},
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
                    widget.place.placeType.toLowerCase(),
                    style: textBold14PrimaryWhite,
                  ),
                  _availableActions(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget photoSection(BuildContext context) {
    return SizedBox(
      height: 96,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Image.network(
              widget.place.urls[0],
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
        ],
      ),
    );
  }

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
              widget.place.name,
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
          const SizedBox(),
          Text(
            'закрыто до 09:00',
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    );
  }

  Widget _availableActions() {
    return ConstrainedBox(
      constraints: const BoxConstraints.tightFor(
        height: 24,
      ),
      child: Row(
        children: [
          _actionButton(iconShare, () {
            debugPrint('Button share pressed');
          }),
          const SizedBox(
            width: 16,
          ),
          _actionButton(iconClose, () => widget.removeCard(widget.place)),
        ],
      ),
    );
  }

  Widget _actionButton(String assetPath, Function handler) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 24),
      child: ElevatedButton(
        onPressed: handler,
        child: SvgPicture.asset(
          assetPath,
          color: Colors.white,
          height: 24.0,
          width: 24.0,
        ),
        style: cardActionStyle,
      ),
    );
  }
}
