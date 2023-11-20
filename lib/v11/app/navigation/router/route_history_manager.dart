import 'iroute_config.dart';

typedef OnRouteChange = void Function(IRouteConfig config);

class RouteHistoryManager{
  final List<IRouteConfig> _histories = [];
  final List<IRouteConfig> _backHistories = [];

  List<IRouteConfig> get histories => _histories.reversed.toList();

  bool get hasHistory => _histories.length > 1;

  bool get hasBackHistory => _backHistories.isNotEmpty;

  /// 将 [config] 加入历史记录
  void recode(IRouteConfig config){
    if (_histories.isNotEmpty && config.path == _histories.last.path) return;
    _histories.add(config);
  }

  /// 历史回退操作
  /// 将当前顶层移除，并加入 [_backHistories] 撤销列表
  /// 并转到前一路径 [_histories.last]
  void back(OnRouteChange callback) {
    if (!hasHistory) return;
    IRouteConfig top = _histories.removeLast();
    _backHistories.add(top);
    if (_histories.isNotEmpty) {
      callback(_histories.last);
    }
  }

  /// 撤销回退操作
  /// 取出回退列表的最后元素，跳转到该路径
  void revocation(OnRouteChange callback) {
    IRouteConfig target = _backHistories.removeLast();
    callback(target);
  }

  void close(int index) {
    _histories.removeAt(index);
  }

  void clear() {
    _histories.clear();
  }
}