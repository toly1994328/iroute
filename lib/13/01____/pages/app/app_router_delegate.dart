import 'package:flutter/material.dart';
import '../page_a.dart';
import '../page_b.dart';
import '../page_c.dart';
import '../home_page.dart';

class AppRouterDelegate extends RouterDelegate<String> with ChangeNotifier, PopNavigatorRouterDelegateMixin {

  AppRouterDelegate({String initial = '/'}):_path=initial;

  String _path;

  String get path=>  _path;

  void go(String path){
    _path = path;
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onPopPage: _onPopPage,
      pages: parserConfig(_path).map((e) => _pageMap[e]!).toList(),
    );
  }

  final Map<String, Page> _pageMap = const {
    '/': MaterialPage(child: HomePage()),
    'a': MaterialPage(child: PageA()),
    'b': MaterialPage(child: PageB()),
    'c': MaterialPage(child: PageC()),
  };

  Widget buildNavigatorByConfig(String path) {
    return Navigator(
      onPopPage: _onPopPage,
      pages: parserConfig(path).map((e) => _pageMap[e]!).toList(),
    );
  }

  bool _onPopPage(Route route, result) {
    if(path.length>1){
      int last = path.lastIndexOf('/');
      _path = path.substring(0,last);
      if(_path.isEmpty) _path = '/';
      notifyListeners();
    }
    return route.didPop(result);
  }

  @override
  GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();


  @override
  Future<void> setNewRoutePath(String configuration) async{
    _path = configuration;
  }

  List<String> parserConfig(String path){
    /// 例: /a/b/c  进栈 /,a,b,c 界面
    List<String> result = ['/'];
    if(path.startsWith('/')){
      path = path.substring(1);
      if(path.isNotEmpty){
        List<String> parts = path.split('/');
        result.addAll(parts);
      }
    }
    return result;
  }
}