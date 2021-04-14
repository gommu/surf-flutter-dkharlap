import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/widgets/base_sight_card.dart';
import 'package:places/ui/widgets/custom_bottom_navigation_bar.dart';

class SightListScreen extends StatefulWidget {
  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: false,
        toolbarHeight: 100,
        title: Container(
          height: 100,
          alignment: Alignment.bottomCenter,
          child: Text(
            'Список интересных мест',
            maxLines: 2,
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ...mocks.map((e) => BaseSightCard(e)).toList(),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}

class FavoritePlacesAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;

  FavoritePlacesAppBar(title, {Key key})
      : preferredSize = Size.fromHeight(150.0),
        title = title,
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: preferredSize.height,
      ),
      child: Center(
        child: Container(
          alignment: Alignment.bottomCenter,
          child: Text(
            title,
            style: textBold32PrimaryHeader,
          ),
        ),
      ),
    );
  }
}
