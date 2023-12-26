import 'package:flutter/material.dart';
import '../page_a.dart';
import '../page_b.dart';
import '../page_c.dart';
import '../home_page.dart';

ValueNotifier<List<String>> router = ValueNotifier(['/']);

class AppNavigation extends StatefulWidget {
  const AppNavigation({super.key});

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {


  @override
  void dispose() {
    router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: router,
      builder: (_, List<String> value, __) => buildNavigatorByConfig(value),
    );
  }

  final Map<String, Page> _pageMap = const {
    '/': MaterialPage(child: HomePage()),
    'a': MaterialPage(child: PageA()),
    'b': MaterialPage(child: PageB()),
    'c': MaterialPage(child: PageC()),
  };

  Widget buildNavigatorByConfig(List<String> value) {
    return Navigator(
      onPopPage: _onPopPage,
      pages: router.value.map((e) => _pageMap[e]!).toList(),
    );
  }

  bool _onPopPage(Route route, result) {
    return route.didPop(result);
  }
}
