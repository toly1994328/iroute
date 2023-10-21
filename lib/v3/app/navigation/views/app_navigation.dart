import 'package:flutter/material.dart';
import '../router/app_router_delegate.dart';
import 'app_navigation_rail.dart';
import 'background.dart';
import 'top_bar.dart';

class AppNavigation extends StatelessWidget {
  const AppNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // const Background(),
          Row(
            children: [
              const AppNavigationRail(),
              Expanded(
                child: Column(
                  children: [
                    TopBar(),
                    Divider(height: 1,),
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
        ],
      ),
    );
  }
}
