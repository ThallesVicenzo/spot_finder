import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTab {
  const AppTab(this.icon);
  final IconData icon;

  List<Object> get props => [icon];
}

const List<AppTab> allTabs = <AppTab>[
  AppTab(Icons.star),
  AppTab(CupertinoIcons.location_solid),
  AppTab(CupertinoIcons.person_solid),
];
