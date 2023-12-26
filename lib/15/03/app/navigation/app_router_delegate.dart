import 'package:flutter/material.dart';

import '../../pages/color/color_page.dart';
import '../../pages/empty/empty_page.dart';
import '../../pages/settings/settings_page.dart';
import '../../pages/counter/counter_page.dart';
import '../../pages/user/user_page.dart';
import '../../transition/fade_transition_page.dart';
import '../../transition/no_transition_page.dart';

const List<String> kDestinationsPaths = [
  '/color',
  '/counter',
  '/user',
  '/settings',
];

AppRouterDelegate router = AppRouterDelegate();

class AppRouterDelegate extends RouterDelegate<Object> with ChangeNotifier {
  String _path = '/color';

  String get path => _path;

  set path(String value) {
    if (_path == value) return;
    _path = value;
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onPopPage: _onPopPage,
      pages: _buildPageByPath(path),
    );
  }

  List<Page> _buildPageByPath(String path) {
    Widget? child;
    if (path == kDestinationsPaths[0]) {
      child = const ColorPage();
    }
    if (path == kDestinationsPaths[1]) {
      child = const CounterPage();
    }
    if (path == kDestinationsPaths[2]) {
      child = const UserPage();
    }
    if (path == kDestinationsPaths[3]) {
      child = const SettingPage();
    }
    return [
      FadeTransitionPage(
        key: ValueKey(path),
        child: child ?? const EmptyPage(),
      )
    ];
  }

  @override
  Future<bool> popRoute() async {
    print('=======popRoute=========');
    return true;
  }

  bool _onPopPage(Route route, result) {
    return route.didPop(result);
  }

  @override
  Future<void> setNewRoutePath(configuration) async {}
}

// class AppRouterDelegate extends RouterDelegate<String> with ChangeNotifier, PopNavigatorRouterDelegateMixin {
//
//   List<String> _value = ['/'];
//
//
//   List<String> get value => _value;
//
//   set value(List<String> value){
//     _value = value;
//     notifyListeners();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Navigator(
//       onPopPage: _onPopPage,
//       pages: _value.map((e) => _pageMap[e]!).toList(),
//     );
//   }
//
//   final Map<String, Page> _pageMap = const {
//     '/': MaterialPage(child: HomePage()),
//     'a': MaterialPage(child: PageA()),
//     'b': MaterialPage(child: PageB()),
//     'c': MaterialPage(child: PageC()),
//   };
//
//   bool _onPopPage(Route route, result) {
//     _value = List.of(_value)..removeLast();
//     notifyListeners();
//     return route.didPop(result);
//   }
//
//   @override
//   GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
//
//   @override
//   Future<void> setNewRoutePath(String configuration) async{
//   }
// }
