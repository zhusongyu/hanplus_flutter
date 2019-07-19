import 'package:flutter/material.dart';

class NavigationIconView {

  NavigationIconView({
    Widget icon,
    Widget title,
    Widget activeIcon,

    TickerProvider vsync
  }):
    item = new BottomNavigationBarItem(
      icon: icon,
      title: title,
      activeIcon: activeIcon
    ),
    controller = new AnimationController(
      duration: kThemeAnimationDuration,
      vsync: vsync
    );

  final BottomNavigationBarItem item;
  final AnimationController controller;
}