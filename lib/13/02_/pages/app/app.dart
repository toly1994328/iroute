import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:toly_menu/toly_menu.dart';

import '../../menus.dart';
import '../../transition/fade_transition.dart';
import 'root_content.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {
              TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
              TargetPlatform.macOS: FadeUpwardsPageTransitionsBuilder(),
              TargetPlatform.windows: FadeTransitionsBuilder(),
            }
          ),

            appBarTheme: const AppBarTheme(
                elevation: 0,
                iconTheme: IconThemeData(color: Colors.black),
                backgroundColor: Colors.white,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ))),
        debugShowCheckedModeBanner: false,
        home: AppLayout());
  }
}

class AppLayout extends StatelessWidget {
  const AppLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Row(
        children: [
          SizedBox(
            width: 210,
            child: MenuPanel(),
          ),
          // Container()
          Expanded(child: RootContent())
        ],
      ),
      // appBar: AppToolBar(),
      // body: AppNavigation(),
    );
  }
}

class MenuPanel extends StatefulWidget {
  const MenuPanel({super.key});

  @override
  State<MenuPanel> createState() => _MenuPanelState();
}

class _MenuPanelState extends State<MenuPanel> {
  MenuState state = MenuState(expandMenus: ['/dashboard'], activeMenu: '/dashboard/data_analyse', items: menus);

  @override
  Widget build(BuildContext context) {
    return TolyMenu(state: state, onSelect: _onSelect);
  }

  void _onSelect(MenuData menu) {


    if(menu.isLeaf){
      state = state.copyWith(activeMenu: menu.path);
      print("menu.path：${menu.path}");
      goRouter.go(menu.path);
    }else{
      List<String> menus = [];
      String path = menu.path.substring(1);
      List<String> parts = path.split('/');

      if(parts.isNotEmpty){
        String path = '';
        for (String part in parts) {
          path+='/$part';
          menus.add(path);
        }
      }

      if(state.expandMenus.contains(menu.path)){
        menus.remove(menu.path);
      }

      state = state.copyWith(expandMenus: menus);

    }
    setState(() {

    });
  }
}
