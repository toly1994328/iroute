import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import '../../../pages/color/color_detail_page.dart';
import '../../../pages/color/color_page.dart';
import '../../../pages/empty/empty_page.dart';
import '../../../pages/settings/settings_page.dart';
import '../../../pages/user/user_page.dart';
import '../../../pages/counter/counter_page.dart';
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

  AppRouterDelegate({String initial = '/'}){
    // changePath('/color',keepAlive: true);
  }

  String _path = '/color';

  String get path => _path;

  int? get activeIndex {
    if(path.startsWith('/color')) return 0;
    if(path.startsWith('/counter')) return 1;
    if(path.startsWith('/user')) return 2;
    if(path.startsWith('/settings')) return 3;
    return null;
  }

  final Map<String,Completer<dynamic>> _completerMap = {};

  Completer<dynamic>? completer;

  final Map<String,List<Page>> _alivePageMap = {};

  void setPathKeepLive(String value){
    _alivePageMap[value] = _buildPageByPath(value);
    path = value;
  }

  final Map<String,dynamic> _pathExtraMap = {};

  FutureOr<dynamic> changePath(String value,{bool forResult=false,Object? extra,bool keepAlive = false}){
    if(forResult){
      _completerMap[value] = Completer();
    }
    if(keepAlive){
      _alivePageMap[value] = _buildPageByPath(value);
    }
    if(extra!=null){
      _pathExtraMap[value] = extra;
    }
    path = value;
    if(forResult){
      return _completerMap[value]!.future;
    }
  }


  set path(String value) {
    if (_path == value) return;
    _path = value;
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    List<Page> pages = [];
    if(_alivePageMap.containsKey(path)){
      for (String key in _alivePageMap.keys) {
        if(path!=key){
          pages.addAll(_alivePageMap[key]!);
        }
      }
      pages.addAll(_alivePageMap[path]!) ;
    }else{
      for (var element in _alivePageMap.values) {
        pages.addAll(element);
      }
      List<Page> currentPages = _buildPageByPath(path);
      pages.removeWhere((element) {
        return currentPages.map((e) => e.key).contains(element.key);
      });
      // 移除 pages 中和 currentPages 具有相同key 的元素
      pages.addAll(_buildPageByPath(path));
    }
    return Navigator(
      onPopPage: _onPopPage,
      pages: pages,
    );
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
          result.add( FadeTransitionPage(
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
