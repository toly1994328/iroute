import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import '../../../pages/color/color_detail_page.dart';
import '../../../pages/color/color_page.dart';
import '../../../pages/empty/empty_page.dart';
import '../../../pages/settings/settings_page.dart';
import '../../../pages/counter/counter_page.dart';
import '../../../pages/user/user_page.dart';
import '../transition/fade_transition_page.dart';
import '../../../pages/color/color_add_page.dart';

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
  AppRouterDelegate(){
    // keepAlivePath.add('/color');
  }
  int? get activeIndex {
    if(path.startsWith('/color')) return 0;
    if(path.startsWith('/counter')) return 1;
    if(path.startsWith('/user')) return 2;
    if(path.startsWith('/settings')) return 3;
    return null;
  }

  final Map<String,Completer<dynamic>> _completerMap = {};

  Completer<dynamic>? completer;

  final Map<String,dynamic> _pathExtraMap = {};

  final List<String> keepAlivePath = [] ;

  void setPathKeepLive(String value){
    if(keepAlivePath.contains(value)){
      keepAlivePath.remove(value);
    }
    keepAlivePath.add(value);
    path = value;
  }

  void setPathForData(String value,dynamic data){
    _pathExtraMap[value] = data;
    path = value;
  }

  Future<dynamic> changePathForResult(String value) async{
    Completer<dynamic> completer = Completer();
    _completerMap[value] = completer;
    path = value;
    return completer.future;
  }

  set path(String value) {
    if (_path == value) return;
    _path = value;
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onPopPage: _onPopPage,
      pages: _buildPages(path),
    );
  }

  List<Page> _buildPages(path){
    List<Page> pages = [];
    List<Page> topPages = _buildPageByPath(path);

    if(keepAlivePath.isNotEmpty){
      for (String alivePath in keepAlivePath) {
        if(alivePath!=path){
          pages.addAll(_buildPageByPath(alivePath)) ;
        }
      }
      /// 去除和 topPages 中重复的界面
      pages.removeWhere((element) => topPages.map((e) => e.key).contains(element.key));
    }

    pages.addAll(topPages);
    return pages;
  }

  List<Page> _buildPageByPath(String path) {
    Widget? child;
    if(path.startsWith('/color')){
      return buildColorPages(path);
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

  List<Page> buildColorPages(String path){
    List<Page> result = [];
    Uri uri = Uri.parse(path);
    for (String segment in uri.pathSegments) {
      if(segment == 'color'){
        result.add( const FadeTransitionPage(
          key: ValueKey('/color'),
          child:ColorPage(),
        ));
      }
      if(segment =='detail'){
        final Map<String, String> queryParams = uri.queryParameters;
        String? selectedColor = queryParams['color'];
        if (selectedColor != null) {
          Color color = Color(int.parse(selectedColor, radix: 16));
          result.add(FadeTransitionPage(
            key: const ValueKey('/color/detail'),
            child:ColorDetailPage(color: color),
          ));
        }else{
          Color? selectedColor = _pathExtraMap[path];
          if (selectedColor != null) {
            result.add( FadeTransitionPage(
              key: const ValueKey('/color/detail'),
              child:ColorDetailPage(color: selectedColor),
            ));
            _pathExtraMap.remove(path);
          }
        }
      }
      if(segment == 'add'){
        result.add( const FadeTransitionPage(
          key:  ValueKey('/color/add'),
          child:ColorAddPage(),
        ));
      }

    }
    return result;
  }

  @override
  Future<bool> popRoute() async {
    print('=======popRoute=========');
    return true;
  }

  bool _onPopPage(Route route, result) {
    if(_completerMap.containsKey(path)){
      _completerMap[path]?.complete(result);
      _completerMap.remove(path);
    }

    path = backPath(path);
    return route.didPop(result);
  }

  String backPath(String path){
    Uri uri = Uri.parse(path);
    if(uri.pathSegments.length==1) return path;
    List<String> parts = List.of(uri.pathSegments)..removeLast();
    return '/${parts.join('/')}';
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
