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
    _histories.add(RouteHistory(path));
  }

  final List<RouteHistory> _histories = [];
  final List<RouteHistory> _backHistories = [];

  List<RouteHistory> get histories => _histories.reversed.toList();

  bool get hasHistory => _histories.length > 1;

  bool get hasBackHistory => _backHistories.isNotEmpty;

  /// 历史回退操作
  /// 将当前顶层移除，并加入 _backHistories 撤销列表
  /// 并转到前一路径
  void back() {
    if (!hasHistory) return;
    RouteHistory top = _histories.removeLast();
    _backHistories.add(top);
    if (_histories.isNotEmpty) {
      _path = _histories.last.path;
      if (_histories.last.extra != null) {
        _pathExtraMap[_path] = _histories.last.extra;
      }
      notifyListeners();
    }
  }

  void toHistory(RouteHistory history) {
    _path = history.path;
    if (history.extra != null) {
      _pathExtraMap[_path] = history.extra;
    }
    notifyListeners();
  }

  void closeHistory(int index) {
    _histories.removeAt(index);
    notifyListeners();
  }

  void clearHistory() {
    _histories.clear();
    notifyListeners();
  }

  /// 撤销回退操作
  /// 取出回退列表的最后元素，跳转到该路径
  void revocation() {
    RouteHistory target = _backHistories.removeLast();
    _path = target.path;
    if (target.extra != null) {
      _pathExtraMap[_path] = target.extra;
    }
    _histories.add(target);
    notifyListeners();
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

  void setPathKeepLive(String value) {
    if (keepAlivePath.contains(value)) {
      keepAlivePath.remove(value);
    }
    keepAlivePath.add(value);
    path = value;
  }

  void setPathForData(String value, dynamic data) {
    _pathExtraMap[value] = data;
    path = value;
  }

  Future<dynamic> changePathForResult(String value) async {
    Completer<dynamic> completer = Completer();
    _completerMap[value] = completer;
    path = value;
    return completer.future;
  }

  set path(String value) {
    if (_path == value) return;
    _path = value;
    /// 将路由加入历史列表
    _addPathToHistory(value,_pathExtraMap[path]);
    notifyListeners();
  }

  void _addPathToHistory(String value, Object? extra) {
    if (_histories.isNotEmpty && value == _histories.last.path) return;
    _histories.add(RouteHistory(
      value,
      extra: _pathExtraMap[path],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onPopPage: _onPopPage,
      pages: _buildPages(path),
    );
  }

  List<Page> _buildPages(path) {
    List<Page> pages = [];
    List<Page> topPages = _buildPageByPath(path);

    if (keepAlivePath.isNotEmpty) {
      for (String alivePath in keepAlivePath) {
        if (alivePath != path) {
          pages.addAll(_buildPageByPath(alivePath));
        }
      }

      /// 去除和 topPages 中重复的界面
      pages.removeWhere(
          (element) => topPages.map((e) => e.key).contains(element.key));
    }

    pages.addAll(topPages);
    return pages;
  }

  List<Page> _buildPageByPath(String path) {
    Widget? child;
    if (path.startsWith('/color')) {
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

  List<Page> buildColorPages(String path) {
    List<Page> result = [];
    Uri uri = Uri.parse(path);
    for (String segment in uri.pathSegments) {
      if (segment == 'color') {
        result.add(const FadeTransitionPage(
          key: ValueKey('/color'),
          child: ColorPage(),
        ));
      }
      if (segment == 'detail') {
        final Map<String, String> queryParams = uri.queryParameters;
        String? selectedColor = queryParams['color'];
        if (selectedColor != null) {
          Color color = Color(int.parse(selectedColor, radix: 16));
          result.add(FadeTransitionPage(
            key: const ValueKey('/color/detail'),
            child: ColorDetailPage(color: color),
          ));
        } else {
          Color? selectedColor = _pathExtraMap[path];
          if (selectedColor != null) {
            result.add(FadeTransitionPage(
              key: const ValueKey('/color/detail'),
              child: ColorDetailPage(color: selectedColor),
            ));
            _pathExtraMap.remove(path);
          }
        }
      }
      if (segment == 'add') {
        result.add(const FadeTransitionPage(
          key: ValueKey('/color/add'),
          child: ColorAddPage(),
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
