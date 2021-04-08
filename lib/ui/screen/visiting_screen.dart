import 'package:flutter/material.dart';
import 'package:places/ui/widgets/custom_bottom_navigation_bar.dart';
import 'package:places/ui/widgets/visiting_tabbar.dart';
import 'package:places/ui/widgets/visiting_tabbar_view.dart';

class VisitingScreen extends StatefulWidget {
  @override
  _VisitingScreenState createState() => _VisitingScreenState();
}

class _VisitingScreenState extends State<VisitingScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 125,
        // backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'Избранное',
          // style: textMedium18PrimaryHeader,
        ),
        bottom: VisitingTabBar(_tabController),
      ),
      body: VisitingTabBarView(_tabController),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
