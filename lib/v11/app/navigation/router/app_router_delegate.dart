import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'views/navigator_scope.dart';
import 'iroute.dart';
import 'iroute_config.dart';
import 'route_history_manager.dart';
import 'routes.dart';
import 'views/not_find_view.dart';

AppRouterDelegate router = AppRouterDelegate(node: rootRoute);

class AppRouterDelegate extends RouterDelegate<IRouteConfig>
    with ChangeNotifier {
  /// 核心数据，路由配置数据列表
  final List<IRouteConfig> _configs = [];

  String get path => current.uri.toString();

  IRouteConfig get current => _configs.last;

  final IRoutePageBuilder? notFindPageBuilder;

  final IRouteNode node;

  @override
  IRouteConfig? get currentConfiguration {
    if(_configs.isEmpty) return null;
    return current;
  }

  AppRouterDelegate({
    this.notFindPageBuilder,
    required this.node,
  });

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

  bool get canPop => _configs.where((e) => e.routeStyle == RouteStyle.push).isNotEmpty;

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

  void _handleChangeStyle(IRouteConfig config) {
    switch (config.routeStyle) {
      case RouteStyle.push:
        if (_configs.contains(config)) {
          _configs.remove(config);
        }
        _configs.add(config);
        break;
      case RouteStyle.replace:
        List<IRouteConfig> liveRoutes =
            _configs.where((e) => e.keepAlive && e != config).toList();
        _configs.clear();
        _configs.addAll([...liveRoutes, config]);
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
    return NavigatorScope(
      node: node,
      onPopPage: _onPopPage,
      configs: _configs,
      notFindPageBuilder: (notFindPageBuilder ?? _defaultNotFindPageBuilder),
    );
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
  Future<void> setNewRoutePath(IRouteConfig configuration) async{
    changeRoute(configuration);
  }

  @override
  Future<void> setInitialRoutePath(IRouteConfig configuration) {
    _configs.add(configuration);
    _historyManager.recode(configuration);
    return super.setInitialRoutePath(configuration);
  }
}
