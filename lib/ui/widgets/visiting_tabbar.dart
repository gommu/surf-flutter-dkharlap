import 'package:flutter/material.dart';

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
          color: Theme.of(context).primaryColorDark,
          borderRadius: BorderRadius.circular(
            20.0,
          ),
        ),
        child: TabBar(
          controller: _tabController,
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
