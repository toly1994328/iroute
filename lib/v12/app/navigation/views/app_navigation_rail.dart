import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iroute/components/components.dart';

class AppNavigationRail extends StatefulWidget {
  const AppNavigationRail({super.key});

  @override
  State<AppNavigationRail> createState() => _AppNavigationRailState();
}

class _AppNavigationRailState extends State<AppNavigationRail> {
  final List<MenuMeta> deskNavBarMenus = const [
    MenuMeta(label: '颜色板', icon: Icons.color_lens_outlined, path: '/color'),
    MenuMeta(label: '计数器', icon: Icons.add_chart, path: '/counter'),
    MenuMeta(label: '排序', icon: Icons.sort, path: '/sort'),
    MenuMeta(label: '我的', icon: Icons.person, path: '/user'),
    MenuMeta(label: '设置', icon: Icons.settings, path: '/settings'),
  ];


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
          child: Text(
            'V0.1.1',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        backgroundColor: const Color(0xff3975c6),
        onDestinationSelected: _onDestinationSelected,
        selectedIndex: activeIndex,
      ),
    );
  }

  final RegExp _segReg = RegExp(r'/\w+');

  int? get activeIndex {
    final String path = GoRouterState.of(context).uri.toString();
    RegExpMatch? match = _segReg.firstMatch(path);
    if (match == null) return null;
    String? target = match.group(0);
    int index = deskNavBarMenus.indexWhere((menu) => menu.path!.contains(target??''));
    if (index == -1) return null;
    return index;
  }

  void _onDestinationSelected(int index) {
    String path = deskNavBarMenus[index].path!;
    if(index==4){
      GoRouter.of(context).push(path);
    }else{
      GoRouter.of(context).go(path);
    }
  }
}
