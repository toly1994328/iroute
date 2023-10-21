import 'package:flutter/material.dart';
import '../app_router_delegate.dart';

class AppNavigationRail extends StatefulWidget {
  const AppNavigationRail({super.key});

  @override
  State<AppNavigationRail> createState() => _AppNavigationRailState();
}

class _AppNavigationRailState extends State<AppNavigationRail> {
  final List<NavigationRailDestination> destinations = const [
    NavigationRailDestination(icon: Icon(Icons.color_lens_outlined), label: Text("颜色板")),
    NavigationRailDestination(icon: Icon(Icons.add_chart), label: Text("计数器")),
    NavigationRailDestination(icon: Icon(Icons.person), label: Text("我的")),
    NavigationRailDestination(icon: Icon(Icons.settings), label: Text("设置")),
  ];

  @override
  void initState() {
    super.initState();
    router.addListener(_onRouterChange);
  }

  @override
  void dispose() {
    router.removeListener(_onRouterChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      labelType: NavigationRailLabelType.all,
      onDestinationSelected: _onDestinationSelected,
      destinations: destinations,
      selectedIndex: router.activeIndex,
    );
  }

  void _onDestinationSelected(int index) {
    router.path = kDestinationsPaths[index];
  }

  void _onRouterChange() {
    setState(() {

    });
  }
}