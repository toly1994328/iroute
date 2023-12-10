import 'package:flutter/material.dart';
import 'app_navigation_rail.dart';
import 'app_top_bar/app_top_bar.dart';

class AppNavigation extends StatefulWidget {
  final Widget navigator;

  const AppNavigation({super.key,required this.navigator});

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {

  @override
  void initState() {
    print('======_AppNavigationState#initState==============');
    super.initState();
  }

  @override
  void dispose() {
    print('======_AppNavigationState#dispose==============');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double px1 = 1/View.of(context).devicePixelRatio;
    return Scaffold(
      body: Row(
        children: [
          const AppNavigationRail(),
          Expanded(
            child: Column(
              children: [
                const AppTopBar(),
                Divider(height: px1,),
                Expanded(
                  child: widget.navigator,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
