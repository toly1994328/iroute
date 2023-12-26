import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../page_a.dart';
import '../page_b.dart';
import '../page_c.dart';
import '../home_page.dart';

class AppRouterDelegate extends RouterDelegate<Object> with ChangeNotifier{

  List<String> _value = ['/'];

  List<String> get value => _value;

  set value(List<String> value){
    _value = value;
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onPopPage: _onPopPage,
      pages: _value.map((e) => _pageMap[e]!).toList(),
    );
  }

  final Map<String, Page> _pageMap = const {
    '/': MaterialPage(child: HomePage()),
    'a': MaterialPage(child: PageA()),
    'b': MaterialPage(child: PageB()),
    'c': MaterialPage(child: PageC()),
  };

  @override
  Future<bool> popRoute() async{
    print('=======popRoute=========');
    return true;
  }

  bool _onPopPage(Route route, result) {
    return route.didPop(result);
  }

  @override
  Future<void> setNewRoutePath(configuration) async{

  }

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