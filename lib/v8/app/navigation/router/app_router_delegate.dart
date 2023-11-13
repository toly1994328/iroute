import 'dart:async';
import 'package:flutter/material.dart';
import 'iroute.dart';
import 'iroute_config.dart';
import 'route_history_manager.dart';
import 'routes.dart';
import 'views/not_find_view.dart';

AppRouterDelegate router = AppRouterDelegate(
  initial: IRouteConfig(uri: Uri.parse('/color')),
);

class AppRouterDelegate extends RouterDelegate<Object> with ChangeNotifier {

  /// 核心数据，路由配置数据列表
  final List<IRouteConfig> _configs = [];

  String get path => current.uri.path;

  IRouteConfig get current => _configs.last;

  final IRoutePageBuilder? notFindPageBuilder;

  AppRouterDelegate({
    this.notFindPageBuilder,
    required IRouteConfig initial,
  }) {
    _configs.add(initial);
    _historyManager.recode(initial);
  }

  Page _defaultNotFindPageBuilder(_, __) => const MaterialPage(
        child: Material(child: NotFindPage()),
      );

  final RouteHistoryManager _historyManager = RouteHistoryManager();

  RouteHistoryManager get historyManager => _historyManager;

  /// 历史回退操作
  /// 详见: [RouteHistoryManager.back]
  void back() => _historyManager.back(changeRoute);

  /// 撤销回退操作
  /// 详见: [RouteHistoryManager.revocation]
  void revocation() => _historyManager.revocation(changeRoute);

  void closeHistory(int index) {
    _historyManager.close(index);
    notifyListeners();
  }

  void clearHistory() {
    _historyManager.clear();
    notifyListeners();
  }

  // final List<IRouteConfig> _pathStack = [];

  bool get canPop => _configs.where((e) => e.routeStyle==RouteStyle.push).isNotEmpty;

  final Map<String, Completer<dynamic>> _completerMap = {};

  FutureOr<dynamic> changeRoute(IRouteConfig config) {
    String value = config.uri.path;
    if (current == config) null;
    _handleChangeStyle(config);

    if (config.forResult) {
      _completerMap[value] = Completer();
    }

    if (config.recordHistory) {
      _historyManager.recode(config);
    }

    notifyListeners();
    if (config.forResult) {
      return _completerMap[value]!.future;
    }
  }

  void _handleChangeStyle(IRouteConfig config){
    switch (config.routeStyle) {
      case RouteStyle.push:
        if (_configs.contains(config)) {
          _configs.remove(config);
        }
        _configs.add(config);
        break;
      case RouteStyle.replace:
        List<IRouteConfig> liveRoutes = _configs.where((e) => e.keepAlive&&e!=config).toList();
        _configs.clear();
        _configs.addAll([...liveRoutes,config]);
        break;
    }
  }



  FutureOr<dynamic> changePath(
    String value, {
    bool forResult = false,
    Object? extra,
    bool keepAlive = false,
    bool recordHistory = false,
    RouteStyle style = RouteStyle.replace,
  }) {
    return changeRoute(IRouteConfig(
      uri: Uri.parse(value),
      forResult: forResult,
      extra: extra,
      routeStyle: style,
      keepAlive: keepAlive,
      recordHistory: recordHistory,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onPopPage: _onPopPage,
      pages: _buildPages(context, _configs),
    );
  }

  List<Page> _buildPages(BuildContext context, List<IRouteConfig> configs) {
    IRouteConfig top = configs.last;
    List<IRouteConfig> bottoms = _configs.sublist(0,_configs.length-1).toList();
    List<Page> pages = [];
    List<Page> topPages = _buildPageByPathFromTree(context, top);
    pages = _buildLivePageByPathList(context, bottoms, top, topPages);
    pages.addAll(topPages);
    return pages;
  }

  List<Page> _buildLivePageByPathList(
    BuildContext context,
    List<IRouteConfig> paths,
    IRouteConfig curConfig,
    List<Page> curPages,
  ) {
    List<Page> pages = [];
    if (paths.isNotEmpty) {
      for (IRouteConfig path in paths) {
        if (path != curConfig) {
          pages.addAll(_buildPageByPathFromTree(context, path));
        }
      }
      /// 去除和 curPages 中重复的界面
      pages.removeWhere((page) => curPages.map((e) => e.key).contains(page.key));
    }
    return pages;
  }

  List<Page> _buildPageByPathFromTree(
      BuildContext context, IRouteConfig config) {
    List<Page> result = [];
    List<IRouteNode> iRoutes = rootRoute.find(config.path);
    if (iRoutes.isNotEmpty) {
      for (int i = 0; i < iRoutes.length; i++) {
        IRouteNode iroute = iRoutes[i];
        IRouteConfig fixConfig = config;
        if(iroute.path!=config.uri.path){
          fixConfig = IRouteConfig(uri: Uri.parse(iroute.path));
        }
        Page? page;
        if (iroute is NotFindNode) {
          page = (notFindPageBuilder ?? _defaultNotFindPageBuilder)(context, config);
        } else {
          page = iroute.createPage(context, fixConfig);
        }
        if (page != null) {
          result.add(page);
        }
        if(iroute is CellIRoute){
          break;
        }
      }
    }
    return result;
  }

  @override
  Future<bool> popRoute() async {
    print('=======popRoute=========');
    return true;
  }

  void backStack() {
    if (_configs.isNotEmpty) {
      _configs.removeLast();
      if (_configs.isNotEmpty) {
        changeRoute(_configs.last);
      } else {
        changeRoute(current);
      }
    }
  }

  bool _onPopPage(Route route, result) {
    if (_completerMap.containsKey(path)) {
      _completerMap[path]?.complete(result);
      _completerMap.remove(path);
    }

    if (canPop) {
      _configs.removeLast();
      notifyListeners();
    } else {
      changePath(backPath(path), recordHistory: false);
    }
    return route.didPop(result);
  }

  String backPath(String path) {
    Uri uri = Uri.parse(path);
    if (uri.pathSegments.length == 1) return path;
    List<String> parts = List.of(uri.pathSegments)..removeLast();
    return '/${parts.join('/')}';
  }

  @override
  Future<void> setNewRoutePath(configuration) async {}
}
