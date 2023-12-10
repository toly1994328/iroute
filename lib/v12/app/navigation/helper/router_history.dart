import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouterHistoryScope extends InheritedNotifier<RouterHistory> {
  const RouterHistoryScope({super.key, required super.child, super.notifier});

  static RouterHistory of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<RouterHistoryScope>()!
        .notifier!;
  }

  static RouterHistory read(BuildContext context) {
    return context
        .getInheritedWidgetOfExactType<RouterHistoryScope>()!
        .notifier!;
  }
}

class RouterHistory with ChangeNotifier {
  final List<String> exclusives;

  final GoRouterDelegate delegate;

  final List<RouteMatchList> _histories = [];
  final List<RouteMatchList> _backHistories = [];

  List<RouteMatchList> get histories => _histories;

  RouterHistory(this.delegate, {this.exclusives = const []}) {
    delegate.addListener(_onRouteChange);
  }

  /// 用于记录当前历史记录
  /// 清空历史之后，切换时，先记录 _current
  RouteMatchList? _current;

  void _onRouteChange() {
    /// 当没有历史，且 _current 非空
    if (_histories.isEmpty && _current != null) {
      _histories.add(_current!);
    }

    RouteMatchList matchList = delegate.currentConfiguration;
    if (_histories.isNotEmpty && matchList == _histories.last
    || matchList.isEmpty
    ) return;



    String uri = matchList.last.matchedLocation;
    if (exclusives.contains(uri)) {
      return;
    }
    _recode(matchList);
  }

  /// 将 [history] 加入历史记录
  void _recode(RouteMatchList history) {
    _current = history;
    _histories.add(history);
    if (hasHistory) {
      notifyListeners();
    }
  }

  bool get hasHistory => _histories.length > 1;

  bool get hasBackHistory => _backHistories.isNotEmpty;

  /// 历史回退操作
  /// 将当前顶层移除，并加入 [_backHistories] 撤销列表
  /// 并转到前一路径 [_histories.last]
  void back() {
    if (!hasHistory) {
      return;
    }
    RouteMatchList top = _histories.removeLast();
    _backHistories.add(top);
    if (_histories.isNotEmpty) {
      delegate.setNewRoutePath(_histories.last);
      notifyListeners();
    }
  }

  /// 撤销回退操作
  /// 取出回退列表的最后元素，跳转到该路径
  void revocation() {
    RouteMatchList target = _backHistories.removeLast();
    delegate.setNewRoutePath(target);
    notifyListeners();
  }

  void close(RouteMatchList history) {
    _histories.remove(history);
    notifyListeners();
  }

  void clear() {
    _histories.clear();
    notifyListeners();
  }

  void select(RouteMatchList history) {
    _histories.remove(history);
    delegate.setNewRoutePath(history);
  }
}
