import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iroute/common/pages/stl_color_page.dart';
import 'package:path_to_regexp/path_to_regexp.dart';
import '../pages/app.dart';
import '../pages/home_page.dart';
import '../pages/color_add_page.dart';
import 'parsed_route.dart';
import 'route_state.dart';

class AppRouteParser extends RouteInformationParser<ParsedRoute> {
  @override
  Future<ParsedRoute> parseRouteInformation(
      RouteInformation routeInformation) async {
    print("=======parseRouteInformation:${routeInformation.uri.path}===================");

    final uri = routeInformation.uri;
    final path = uri.toString();
    final queryParams = uri.queryParameters;

    return ParsedRoute(path, queryParams);
  }

  @override
  RouteInformation? restoreRouteInformation(ParsedRoute configuration) {
    print("=======restoreRouteInformation:${configuration}===================");
    return RouteInformation(uri: Uri.parse(configuration.path));
  }
}

class AppRouterDelegate extends RouterDelegate<ParsedRoute>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {

  AppRouterDelegate({String initial = '/'}) {
    _routes.add(ParsedRoute(initial, {}));
  }

   final List<ParsedRoute> _routes = [];

  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  ParsedRoute get currentConfiguration {
    return _routes.last;
  }

  Future<void> go(String route) async {
    ParsedRoute _route = await parser.parseRouteInformation(RouteInformation(uri: Uri.parse(route)));
    if(_route!=_routes.last){
      _routes.add(_route);
    }
    notifyListeners();
  }

  final _addColorKey = const ValueKey('addColor');
  final _colorDetailKey = const ValueKey('ColorDetail');

  @override
  Widget build(BuildContext context) {
    List<Page> pages = [];

    for (ParsedRoute route in _routes) {
      Page? page = _buildPageByPath(route);
      if(page!=null){
        pages.add(page);
      }
    }

    return Navigator(
      key: navigatorKey,
      pages: pages,
      onPopPage: _onPagePop,
    );
  }

  Page? _buildPageByPath(ParsedRoute route) {
    if(route.path == '/'){
      return MaterialPage(child: HomePage());
    }

    if(route.path.startsWith('/color/detail')){
      String? selectedColor = route.queryParameters['color'];

      if (selectedColor != null) {
        Color color = Color(int.parse(selectedColor, radix: 16));
        return MaterialPage(key: _colorDetailKey, child: StlColorPage(color: color));
      }
    }

    if (route.path == '/color/add') {
     return MaterialPage(key: _addColorKey, child: ColorAddPage());
    }

    return null;
  }

  @override
  Future<void> setNewRoutePath(ParsedRoute configuration) async {
    print("===setNewRoutePath===${configuration}=================");
    if(configuration!=_routes.last){
      _routes.add(configuration);
    }
  }

  bool _onPagePop(Route route, result) {
    RouteSettings settings = route.settings;
    if(settings is Page){
      if(settings.key==_addColorKey){
        _routes.removeLast();
        notifyListeners();
      }
      if(settings.key==_colorDetailKey){
        _routes.removeLast();
        notifyListeners();
      }
    }
    return route.didPop(result);
  }


}
