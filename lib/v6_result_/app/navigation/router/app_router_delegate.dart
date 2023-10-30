import 'dart:async';

import 'package:flutter/material.dart';

import 'iroute.dart';
import 'route_history.dart';

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

  AppRouterDelegate() {
    // keepAlivePath.add('/color');
  }

  int? get activeIndex {
    if (path.startsWith('/color')) return 0;
    if (path.startsWith('/counter')) return 1;
    if (path.startsWith('/user')) return 2;
    if (path.startsWith('/settings')) return 3;
    return null;
  }

  final List<RouteHistory> _histories = [];
  final List<RouteHistory> _backHistories = [];

  bool get hasHistory => _histories.length > 1;

  bool get hasBackHistory => _backHistories.isNotEmpty;

  final Map<String, Completer<dynamic>> _completerMap = {};

  Completer<dynamic>? completer;

  final Map<String, dynamic> _pathExtraMap = {};

  final List<String> keepAlivePath = [];

  /// 历史回退操作
  /// 将当前顶层移除，并加入 _backHistories 撤销列表
  /// 并转到前一路径
  void back() {
    if (!hasHistory) return;
    RouteHistory top = _histories.removeLast();
    _backHistories.add(top);
    if (_histories.isNotEmpty) {
      _path = _histories.last.path;
      if(_histories.last.extra!=null){
        _pathExtraMap[_path] = _histories.last.extra;
      }
      notifyListeners();
    }
  }

  /// 撤销回退操作
  /// 取出回退列表的最后元素，跳转到该路径
  void revocation() {
    RouteHistory target = _backHistories.removeLast();
    _path = target.path;
    if(target.extra!=null){
      _pathExtraMap[_path] = target.extra;
    }
    _histories.add(target);
    notifyListeners();
    // changePath(
    //   target.path,
    //   extra: target.extra,
    // );
  }

  FutureOr<dynamic> changePath(
    String value, {
    bool forResult = false,
    Object? extra,
    bool keepAlive = false,
    bool recordHistory = false,
  }) {
    if (forResult) {
      _completerMap[value] = Completer();
    }
    if (keepAlive) {
      if (keepAlivePath.contains(value)) {
        keepAlivePath.remove(value);
      }
      keepAlivePath.add(value);
    }
    if (extra != null) {
      _pathExtraMap[value] = extra;
    }

    if (recordHistory) {
      _histories.add(RouteHistory(
        value,
        extra: extra,
      ));
    }

    path = value;
    if (forResult) {
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
    List<IRoute> iRoutes = root.find(path);
    if (iRoutes.isNotEmpty) {
      for (int i = 0; i < iRoutes.length; i++) {
        IRoute iroute = iRoutes[i];
        String path = iroute.path;
        Object? extra = _pathExtraMap[path];
        bool keepAlive = keepAlivePath.contains(path);
        bool forResult = _completerMap.containsKey(path);
        Page? page = iroute.builder?.call(
          context,
          IRouteData(
            uri: Uri.parse(path),
            extra: extra,
            keepAlive: keepAlive,
            forResult: forResult,
          ),
        );
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

    path = backPath(path);
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
