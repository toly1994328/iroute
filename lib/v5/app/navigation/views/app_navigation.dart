import 'package:flutter/material.dart';
import 'package:iroute/v5/pages/sort/bloc/sort_config.dart';
import '../../../pages/sort/sort_setting.dart';
import '../router/app_router_delegate.dart';
import 'app_navigation_rail.dart';
import 'app_top_bar.dart';

class AppNavigation extends StatelessWidget {
  const AppNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    double px1 = 1/View.of(context).devicePixelRatio;
    return Scaffold(
      endDrawer: Drawer(
        child: SortSettings(config: sortConfig.value,),
      ),
      body: Row(
        children: [
          const AppNavigationRail(),
          Expanded(
            child: Column(
              children: [
                const AppTopBar(),
                Divider(height: px1,),
                Expanded(
                  child: Router(
                    routerDelegate: router,
                    backButtonDispatcher: RootBackButtonDispatcher(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
