import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iroute/common/pages/stl_color_page.dart';
import 'package:path_to_regexp/path_to_regexp.dart';
import '../pages/home_page.dart';
import '../pages/color_add_page.dart';
import 'parsed_route.dart';
import 'route_state.dart';

class AppRouteParser extends RouteInformationParser<ParsedRoute> {
  final List<String> allowPaths;
  final ParsedRoute initialRoute;

  AppRouteParser({
    required this.allowPaths,
    String initialRoute = '/',
  }):initialRoute = ParsedRoute(initialRoute, initialRoute, {}, {});

  @override
  Future<ParsedRoute> parseRouteInformation(
      RouteInformation routeInformation) async {
    print("=======parseRouteInformation:${routeInformation.uri.path}===================");

    final uri = routeInformation.uri;
    final path = uri.toString();
    final queryParams = uri.queryParameters;

    ParsedRoute parsedRoute = initialRoute;

    for (var pathTemplate in allowPaths) {
      final parameters = <String>[];
      var pathRegExp = pathToRegExp(pathTemplate, parameters: parameters);
      if (pathRegExp.hasMatch(path)) {
        final match = pathRegExp.matchAsPrefix(path);
        if (match == null) continue;
        final params = extract(parameters, match);
        parsedRoute = ParsedRoute(path, pathTemplate, params, queryParams);
      }
    }
    return parsedRoute;
  }

  @override
  RouteInformation? restoreRouteInformation(ParsedRoute configuration) {
    print("=======restoreRouteInformation:${configuration}===================");

    return RouteInformation(uri: Uri.parse(configuration.path));
  }
}

class RootRouterDelegate extends RouterDelegate<ParsedRoute>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {

  final RouteState routeState;


  RootRouterDelegate(this.routeState) {
    routeState.addListener(notifyListeners);
  }

  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  ParsedRoute get currentConfiguration {
    print("=======currentConfiguration:${routeState.route.path}===================");

    return routeState.route;
  }

  @override
  void dispose() {
    routeState.removeListener(notifyListeners);
    routeState.dispose();
    super.dispose();
  }
  final _addColorKey = const ValueKey('addColor');

  @override
  Widget build(BuildContext context) {
    final routeState = RouteStateScope.of(context);
    List<Page> pages =[];
    final String pathTemplate = routeState.route.pathTemplate;

    pages.add(MaterialPage(child: HomePage()));

    String? selectedColor;
    if (pathTemplate == '/color/detail/:colorHex') {
      selectedColor = routeState.route.parameters['colorHex'];
    }

    if(selectedColor!=null){
      pages.add(MaterialPage(child: StlColorPage(
        color: Colors.redAccent,
      )));
    }

    bool isAddPage = pathTemplate == '/color/add';
    if(isAddPage){
      pages.add(MaterialPage(
          key: _addColorKey,
          child: ColorAddPage()));
    }
    print("===build====================");
    return Navigator(
      key: navigatorKey,
      pages: pages,
      onPopPage: (route, result) {
        print(result);
        if (route.settings is Page &&
            (route.settings as Page).key == _addColorKey) {
          routeState.go('/color');
        }
        // appState.selectedBook = null;
        // notifyListeners();
        return route.didPop(result);
      },
    );
  }

  /// 格式: /a /b

  @override
  Future<void> setNewRoutePath(ParsedRoute configuration) async {
    print("===setNewRoutePath===${configuration}=================");
    routeState.route = configuration;
    return;
  }

// @override
// Future<void> setInitialRoutePath( configuration) async{
//   _pages = [_pageMap['/']!];
//   notifyListeners();
// }
}
