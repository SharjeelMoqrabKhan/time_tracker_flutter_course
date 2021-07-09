import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/home/cupertino_home_scafold.dart';
import 'package:time_tracker_flutter_course/app/home/tab_items.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TabItems _currentTab = TabItems.jobs;
  @override
  Widget build(BuildContext context) {
    return CupertinoHomeScaffold(
      currentTab: _currentTab,
      onSelectedTab: (item) {},
    );
  }
}
