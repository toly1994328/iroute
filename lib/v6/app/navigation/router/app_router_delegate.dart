import 'dart:async';

import 'package:flutter/material.dart';

import 'iroute.dart';

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

  final Map<String, Completer<dynamic>> _completerMap = {};

  Completer<dynamic>? completer;

  final Map<String, dynamic> _pathExtraMap = {};

  final List<String> keepAlivePath = [];

  FutureOr<dynamic> changePath(String value,
      {bool forResult = false, Object? extra, bool keepAlive = false}) {
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

  List<Page> _buildPages(BuildContext context,String path) {
    List<Page> pages = [];
    List<Page> topPages = _buildPageByPath(context,path);

    if (keepAlivePath.isNotEmpty) {
      for (String alivePath in keepAlivePath) {
        if (alivePath != path) {
          pages.addAll(_buildPageByPath(context,alivePath));
        }
      }

      /// 去除和 topPages 中重复的界面
      pages.removeWhere(
          (element) => topPages.map((e) => e.key).contains(element.key));
    }

    pages.addAll(topPages);
    return pages;
  }

  Page? _buildPageByPathFromTree(BuildContext context, String path) {
    // 1. 根据 path 在 iroute 树中查询节点
    IRoute? iroute = root.match(path);
    Object? extra = _pathExtraMap[path];
    bool keepAlive = keepAlivePath.contains(path);
    bool forResult = _completerMap.containsKey(path);
    Page? page;
    if (iroute != null) {
      page = iroute.builder?.call(
        context,
        IRouteData(
          uri: Uri.parse(path),
          extra: extra,
          keepAlive: keepAlive,
          forResult: forResult,
        ),
      );
    }
    return page;
  }

  List<Page> _buildPageByPath(BuildContext context,String path) {
    List<Page> result = [];
    Uri uri = Uri.parse(path);
    String dist = '';
    for (String segment in uri.pathSegments) {
      dist += '/$segment';
      Page? page = _buildPageByPathFromTree(context,dist);
      if(page!=null){
        result.add(page);
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
