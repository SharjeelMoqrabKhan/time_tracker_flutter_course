import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/home/tab_items.dart';

class CupertinoHomeScaffold extends StatelessWidget {
  const CupertinoHomeScaffold(
      {Key key, @required this.currentTab, @required this.onSelectedTab})
      : super(key: key);
  final TabItems currentTab;
  final ValueChanged<TabItems> onSelectedTab;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
