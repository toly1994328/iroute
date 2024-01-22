import 'package:flutter/material.dart';
import '../../../../15/03/transition/fade_transition_page.dart';
import '../../pages/detail_page.dart';
import '../../pages/home_list.dart';



final LeftRouterDelegate leftRouterDelegate = LeftRouterDelegate();

class LeftRouterDelegate extends RouterDelegate<Object> with ChangeNotifier {
  String _value = '/home';

  String get value => _value;

  set value(String value) {
    _value = value;
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onPopPage: _onPopPage,
      pages: _buildPageByPath(value),
    );
  }

  @override
  Future<bool> popRoute() async {
    print('=======popRoute=========');
    return true;
  }

  bool _onPopPage(Route route, result) {
    return route.didPop(result);
  }

  @override
  Future<void> setNewRoutePath(configuration) async {}

  List<Page> _buildPageByPath(String value) {
    Uri uri = Uri.parse(value);
    List<Page> page = [];
    if (uri.path == '/detail') {
      page.add(FadeTransitionPage(
          key: ValueKey(value),
          child: DetailPage(
            id: uri.queryParameters['id'] ?? '0',
          )));
    }
    if (uri.path == '/home') {
      page.add(FadeTransitionPage(
          key: ValueKey(value),
          child: HomeListPage(
          )));
    }
    return page;
  }
}
