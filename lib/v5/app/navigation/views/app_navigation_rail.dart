import 'package:flutter/material.dart';
import 'package:iroute/components/components.dart';
import '../router/app_router_delegate.dart';

class AppNavigationRail extends StatefulWidget {
  const AppNavigationRail({super.key});

  @override
  State<AppNavigationRail> createState() => _AppNavigationRailState();
}

class _AppNavigationRailState extends State<AppNavigationRail> {

  final List<MenuMeta> deskNavBarMenus = const [
    MenuMeta(label: '颜色板', icon: Icons.color_lens_outlined),
    MenuMeta(label: '计数器', icon: Icons.add_chart),
    MenuMeta(label: '我的', icon: Icons.person),
    MenuMeta(label: '设置', icon: Icons.settings),
  ];

  @override
  void initState() {
    super.initState();
    router.addListener(_onRouterChange);
  }

  @override
  void dispose() {
    router.removeListener(_onRouterChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DragToMoveWrap(
      child: TolyNavigationRail(
        items: deskNavBarMenus,
        leading: const Padding(
          padding: EdgeInsets.symmetric(vertical: 18.0),
          child: FlutterLogo(),
        ),
        tail: Padding(
          padding: const EdgeInsets.only(bottom: 6.0),
          child: Text('V0.0.5',style: TextStyle(color: Colors.white,fontSize: 12),),
        ),
        backgroundColor: const Color(0xff3975c6),
        onDestinationSelected: _onDestinationSelected,
        selectedIndex: router.activeIndex,
      ),
    );

  }

  void _onDestinationSelected(int index) {
    if(index==1){
      router.setPathKeepLive(kDestinationsPaths[index]);
    }else{
      router.path = kDestinationsPaths[index];
    }
  }

  void _onRouterChange() {
    setState(() {});
  }
}
