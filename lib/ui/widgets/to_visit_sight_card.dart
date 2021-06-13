import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/res/assets_uri.dart';
import 'package:places/ui/screen/res/button_styles.dart';

class ToVisitSightCard extends StatefulWidget {
  final Sight sight;
  final Function removeCard;
  ToVisitSightCard({Key key, this.sight, this.removeCard}) : super(key: key);

  String get sightName => sight.name;

  @override
  _ToVisitSightCardState createState() => _ToVisitSightCardState();
}

class _ToVisitSightCardState extends State<ToVisitSightCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color(0xffF5F5F5),
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
                    widget.sight.type.toLowerCase(),
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
                widget.sight.url,
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
              widget.sight.name,
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

  Widget _availableActions() {
    return Container(
      child: ConstrainedBox(
        constraints: BoxConstraints.tightFor(
          height: 24,
        ),
        child: Row(
          children: [
            _actionButton(iconCalendar, () {
              print('Button calendar pressed');
            }),
            SizedBox(
              width: 16,
            ),
            _actionButton(iconClose, () => widget.removeCard(widget.sight)),
          ],
        ),
      ),
    );
  }

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
}
