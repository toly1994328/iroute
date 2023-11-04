import 'dart:async';
import 'package:flutter/material.dart';
import 'iroute.dart';
import 'iroute_config.dart';
import 'route_history_manager.dart';
import 'routes.dart';
import 'views/not_find_view.dart';

AppRouterDelegate router = AppRouterDelegate();

class AppRouterDelegate extends RouterDelegate<Object> with ChangeNotifier {
  String _path = '/color';

  String get path => _path;

  final IRoutePageBuilder? notFindPageBuilder;

  AppRouterDelegate({this.notFindPageBuilder}) {
    _historyManager.recode(IRouteConfig(uri: Uri.parse(path)));
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

  final Map<String, Completer<dynamic>> _completerMap = {};
  final Map<String, dynamic> _pathExtraMap = {};
  final List<String> keepAlivePath = [];

  FutureOr<dynamic> changeRoute(IRouteConfig config) {
    String value = config.uri.path;
    if (_path == value) null;
    if (config.forResult) {
      _completerMap[value] = Completer();
    }
    if (config.keepAlive) {
      if (keepAlivePath.contains(value)) {
        keepAlivePath.remove(value);
      }
      keepAlivePath.add(value);
    }
    if (config.extra != null) {
      _pathExtraMap[value] = config.extra;
    }

    if (config.recordHistory) {
      _historyManager.recode(config);
    }

    _path = value;
    notifyListeners();
    if (config.forResult) {
      return _completerMap[value]!.future;
    }
  }

  FutureOr<dynamic> changePath(
    String value, {
    bool forResult = false,
    Object? extra,
    bool keepAlive = false,
    bool recordHistory = true,
  }) {
    return changeRoute(IRouteConfig(
      uri: Uri.parse(value),
      forResult: forResult,
      extra: extra,
      keepAlive: keepAlive,
      recordHistory: recordHistory,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onPopPage: _onPopPage,
      pages: _buildPages(context, path),
    );
  }

  List<Page> _buildPages(BuildContext context, String path) {
    List<Page> pages = [];
    List<Page> topPages = _buildPageByPathFromTree(context, path);

    if (keepAlivePath.isNotEmpty) {
      for (String alivePath in keepAlivePath) {
        if (alivePath != path) {
          pages.addAll(_buildPageByPathFromTree(context, alivePath));
        }
      }

      /// 去除和 topPages 中重复的界面
      pages.removeWhere(
          (element) => topPages.map((e) => e.key).contains(element.key));
    }

    pages.addAll(topPages);
    return pages;
  }

  List<Page> _buildPageByPathFromTree(BuildContext context, String path) {
    List<Page> result = [];
    List<IRouteNode> iRoutes = rootRoute.find(path);
    if (iRoutes.isNotEmpty) {
      for (int i = 0; i < iRoutes.length; i++) {
        IRouteNode iroute = iRoutes[i];
        String path = iroute.path;
        Object? extra = _pathExtraMap[path];
        bool keepAlive = keepAlivePath.contains(path);
        bool forResult = _completerMap.containsKey(path);
        IRouteConfig config = IRouteConfig(
          uri: Uri.parse(path),
          extra: extra,
          keepAlive: keepAlive,
          forResult: forResult,
        );
        Page? page;
        if (iroute is NotFindNode) {
          page = (notFindPageBuilder ?? _defaultNotFindPageBuilder)(context, config);
        } else {
          page = iroute.createPage(context, config);
        }
        if (page != null) {
          result.add(page);
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

  bool _onPopPage(Route route, result) {
    if (_completerMap.containsKey(path)) {
      _completerMap[path]?.complete(result);
      _completerMap.remove(path);
    }
    changePath(backPath(path), recordHistory: false);
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
