import 'package:flutter/material.dart';

class RootContent extends StatelessWidget {
  const RootContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Router(routerDelegate: RootContentDelegate());
  }
}

class RootContentDelegate extends RouterDelegate with ChangeNotifier,PopNavigatorRouterDelegateMixin{


  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [

      ],
      onPopPage: (route, result) {
        // appState.selectedBook = null;
        // notifyListeners();
        return route.didPop(result);
      },
    );
  }


  @override
  Future<void> setNewRoutePath(configuration) {
    // TODO: implement setNewRoutePath
    throw UnimplementedError();
  }



}