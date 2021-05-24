import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/res/assets_uri.dart';
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
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            colors: [Color(0xffFCDD3D), Color(0xff4CAF50)],
          ),
        ),
        width: 177,
        height: 48,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
          ),
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SvgPicture.asset(
                iconPlus,
                color: Colors.white,
                height: 24.0,
                width: 24.0,
              ),
              Text(
                'НОВОЕ МЕСТО',
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    .copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
