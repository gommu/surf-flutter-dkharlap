import 'package:flutter/material.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/text_styles.dart';

class VisitingTabBar extends StatelessWidget implements PreferredSizeWidget {
  final TabController _tabController;

  VisitingTabBar(this._tabController, {Key key})
      : preferredSize = Size.fromHeight(40.0),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 42,
        decoration: BoxDecoration(
          color: tabBarBackgroundColor,
          borderRadius: BorderRadius.circular(
            20.0,
          ),
        ),
        child: TabBar(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          controller: _tabController,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(
              20.0,
            ),
            color: tabBarActiveTabColor,
          ),
          labelStyle: textBold14,
          unselectedLabelColor: tabBarTitleTextInactiveColor,
          tabs: [
            Tab(
              text: 'Хочу посетить',
            ),
            Tab(
              text: 'Посещенные места',
            ),
          ],
        ),
      ),
    );
  }
}
