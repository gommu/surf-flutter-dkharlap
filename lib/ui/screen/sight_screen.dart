import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/model.dart';
import 'package:places/ui/screen/res/assets_uri.dart';
import 'package:places/ui/widgets/base_sight_card.dart';
import 'package:places/ui/widgets/custom_bottom_navigation_bar.dart';
import 'package:places/ui/widgets/search_bar.dart';

class SightListScreen extends StatefulWidget {
  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  final controller = TextEditingController();
  final focusNode = FocusNode();
  final placeInteractor = PlaceInteractor();

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Place>>(
      future: placeInteractor.getPlaces(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        List<BasePlaceCard> children =
        snapshot.data.map((e) => BasePlaceCard(e)).toList();
        var childAspectRatio =
        MediaQuery.of(context).orientation == Orientation.portrait ? 1.8 : 1.95;
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            color: Colors.white,
            child: CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  delegate:
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? HeaderTitleDelegatePortrait()
                      : HeaderTitleDelegateLandscape(),
                  pinned: true,
                ),
                SliverPersistentHeader(
                  delegate: StickyHeaderAppBar(controller, focusNode),
                ),
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 500.0,
                    mainAxisSpacing: 1.0,
                    crossAxisSpacing: 1.0,
                    childAspectRatio: childAspectRatio,
                  ),
                  delegate: SliverChildBuilderDelegate(
                        (context, index) => children[index],
                    childCount: children.length,
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: CustomBottomNavigationBar(),
          floatingActionButton: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(
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
              onPressed: () {
                Navigator.pushNamed(context, '/add-sight');
              },
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
    );
  }
}

class HeaderTitleDelegatePortrait extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              Text(
                'Список интересных мест',
                maxLines: 2,
                style: Theme.of(context).appBarTheme.textTheme.headline6,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 85;

  @override
  double get minExtent => 85;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class HeaderTitleDelegateLandscape extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            children: [
              Text(
                'Список интересных мест',
                style: Theme.of(context).appBarTheme.textTheme.headline6,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 55;

  @override
  double get minExtent => 55;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class StickyHeaderAppBar extends SliverPersistentHeaderDelegate {
  final TextEditingController _controller;
  final FocusNode _focusNode;

  StickyHeaderAppBar(this._controller, this._focusNode);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SearchBar.withFilter(_controller, _focusNode),
    );
  }

  @override
  double get maxExtent => 70;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}
