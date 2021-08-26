import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      height: 96,
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
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
            constraints: const BoxConstraints(
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
          _actionButton(iconCalendar, () {
            bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
            if (isIOS) {
              _showDatePicker(context);
            } else {
              showDatePicker(
                context: context,
                locale: const Locale('ru'),
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              );
            }
          }),
          const SizedBox(
            width: 16,
          ),
          _actionButton(iconClose, () => widget.removeCard(widget.sight)),
        ],
      ),
    );
  }

  Widget _actionButton(String assetPath, Function handler) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 24),
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

  void _showDatePicker(ctx) {
    showCupertinoModalPopup(
      context: ctx,
      builder: (_) => Container(
        height: 300,
        color: const Color.fromARGB(255, 255, 255, 255),
        child: SizedBox(
          height: 300,
          child: CupertinoDatePicker(
            initialDateTime: DateTime.now(),
            onDateTimeChanged: (_) {},
          ),
        ),
      ),
    );
  }
}
