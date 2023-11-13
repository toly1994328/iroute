import 'package:flutter/material.dart';
import 'package:iroute/components/components.dart';
import '../../../pages/login/login.dart';
import '../transition/no_transition_page.dart';
import '../../../pages/sort/views/player/sort_player.dart';
import 'iroute_config.dart';
import '../views/app_navigation.dart';
import 'iroute.dart';
import '../../../pages/color/color_add_page.dart';
import '../../../pages/color/color_detail_page.dart';
import '../../../pages/color/color_page.dart';
import '../../../pages/counter/counter_page.dart';
import '../../../pages/user/user_page.dart';
import '../../../pages/settings/settings_page.dart';
import '../../../pages/sort/views/sort_page/sort_page.dart';
import '../../../pages/sort/views/settings/sort_setting.dart';

CellIRoute appRoute = CellIRoute(
  cellBuilder: (_, __, navigator) => AppNavigation(
    navigator: navigator,
  ),
  path: '/app',
  children: [
     IRoute(
      path: '/app/color',
      widget: ColorPage(),
      children: [
        IRoute(path: '/app/color/detail', widgetBuilder: _buildColorDetail),
        IRoute(path: '/app/color/add', widget: ColorAddPage()),
      ],
    ),
    const IRoute(path: '/app/counter', widget: CounterPage()),
    CellIRoute(
      cellBuilder: (_, __, navigator) => SortNavigation(navigator: navigator),
      // pageBuilder: (_,config,child)=> NoTransitionPage(
      //   child: child,
      //   key: config.pageKey
      // ),
      path: '/app/sort',
      children: [
        const IRoute(
          path: '/app/sort/settings',
          widget: SortSettings(),
        ),
        const IRoute(
          path: '/app/sort/player',
          widget: SortPlayer(),
        ),
      ],
    ),
    const IRoute(path: '/app/user', widget: UserPage()),
    const IRoute(path: '/app/settings', widget: SettingPage()),
  ],
);

IRoute rootRoute = IRoute(path: '/', children: [
  appRoute,
  const IRoute(
    path: '/login',
    widget: LoginPage()
  )
]);

Widget? _buildColorDetail(BuildContext context, IRouteConfig data) {
  final Map<String, String> queryParams = data.uri.queryParameters;
  String? selectedColor = queryParams['color'];
  Color color = Colors.black;
  if (selectedColor != null) {
    color = Color(int.parse(selectedColor, radix: 16));
  } else if (data.extra is Color) {
    color = data.extra as Color;
  }
  return ColorDetailPage(color: color);
}

Map<String, String> kRouteLabelMap = {
  '/app': '',
  '/app/color': '颜色板',
  '/app/color/add': '添加颜色',
  '/app/color/detail': '颜色详情',
  '/app/counter': '计数器',
  '/app/sort': '排序算法',
  '/app/sort/player': '演示',
  '/app/sort/settings': '排序配置',
  '/app/user': '我的',
  '/app/settings': '系统设置',
};

const List<MenuMeta> deskNavBarMenus = [
  MenuMeta(label: '颜色板', icon: Icons.color_lens_outlined, path: '/app/color'),
  MenuMeta(label: '计数器', icon: Icons.add_chart, path: '/app/counter'),
  MenuMeta(label: '排序', icon: Icons.sort, path: '/app/sort/player'),
  MenuMeta(label: '我的', icon: Icons.person, path: '/app/user'),
  MenuMeta(label: '设置', icon: Icons.settings, path: '/app/settings'),
];
